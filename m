From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 14:24:58 +0200
Subject: [PATCHv2 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <cover.1502886277.git.michal.simek@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
Message-ID: <57156284c0a96dc710c660ec22c15563808cb760.1502886277.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is adding communication layer with firmware.
The most of request are coming thought ATF to PMUFW (platform management
unit).

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Make zynqmp_pm_ret_code, invoke_pm_fn static
  Reported by Arnd
- Remove pm_api_version function - no need for interface
- Move driver to drivers/firmware/
  Reported by Arnd and Rob

 drivers/firmware/Kconfig                        |   1 +
 drivers/firmware/Makefile                       |   1 +
 drivers/firmware/xilinx/Kconfig                 |   6 +
 drivers/firmware/xilinx/Makefile                |   1 +
 drivers/firmware/xilinx/zynqmp/firmware.c       | 382 ++++++++++++++++++++++++
 include/linux/firmware/xilinx/zynqmp/firmware.h | 232 ++++++++++++++
 6 files changed, 623 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e4ed5a9c6fd..ebdf3c341899 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -238,5 +238,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index a37f12e8d137..ebdce418dca0 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 000000000000..3bda5377f5e6
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,6 @@
+#
+# Xilinx ZYNQ MPSoC configuration
+#
+menuconfig SOC_XILINX_ZYNQMP
+	bool "Xilinx Zynq MPSoC Firmware driver support"
+	depends on ARCH_ZYNQMP
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 000000000000..954696bf9aec
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_XILINX_ZYNQMP) += zynqmp/firmware.o
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
new file mode 100644
index 000000000000..af30f78b5653
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -0,0 +1,382 @@
+/*
+ * Xilinx Zynq MPSoC Firware layer
+ *
+ *  Copyright (C) 2014-2017 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/compiler.h>
+#include <linux/arm-smccc.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/uaccess.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+/**
+ * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return:		corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc - Call system-level power management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Return:		Returns status, either success or error+reason
+ *
+ * Invoke power management function via SMC call (no hypervisor present)
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = (u32)res.a0;
+		ret_payload[1] = (u32)(res.a0 >> 32);
+		ret_payload[2] = (u32)res.a1;
+		ret_payload[3] = (u32)(res.a1 >> 32);
+		ret_payload[4] = (u32)res.a2;
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc - Call system-level power management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Return:		Returns status, either success or error+reason
+ *
+ * Invoke power management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF)
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = (u32)res.a0;
+		ret_payload[1] = (u32)(res.a0 >> 32);
+		ret_payload[2] = (u32)res.a1;
+		ret_payload[3] = (u32)(res.a1 >> 32);
+		ret_payload[4] = (u32)res.a2;
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * invoke_pm_fn - Invoke the system-level power management layer caller
+ *			function depending on the configuration
+ * @pm_api_id:         Requested PM-API call
+ * @arg0:              Argument 0 to requested PM-API call
+ * @arg1:              Argument 1 to requested PM-API call
+ * @arg2:              Argument 2 to requested PM-API call
+ * @arg3:              Argument 3 to requested PM-API call
+ * @ret_payload:       Returned value array
+ *
+ * Return:             Returns status, either success or error+reason
+ *
+ * Invoke power management function for SMC or HVC call, depending on
+ * configuration
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *     ((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *     ((SMC_64) << FUNCID_CC_SHIFT)
+ *     ((SIP_START) << FUNCID_OEN_SHIFT)
+ *     ((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC  - Registered ZynqMP SIP Service Call
+ * PM_API_ID   - Power Management API ID
+ */
+static int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
+			u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+/**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:	IDCODE register
+ * @version:	version register
+ *
+ * Return:	Returns the status of the operation and the idcode and version
+ *		registers in @idcode and @version.
+ */
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	invoke_pm_fn(GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
+
+/**
+ * get_set_conduit_method - Choose SMC or HVC based communication
+ * @np:	Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3
+ */
+static void get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+	struct device *dev;
+
+	dev = container_of(&np, struct device, of_node);
+
+	if (of_property_read_string(np, "method", &method)) {
+		dev_warn(dev, "%s Missing \"method\" property - defaulting to smc\n",
+			 __func__);
+		do_fw_call = do_fw_call_smc;
+		return;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		dev_warn(dev, "%s Invalid \"method\" property: %s - defaulting to smc\n",
+			 __func__, method);
+		do_fw_call = do_fw_call_smc;
+	}
+}
+
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+			   const enum zynqmp_pm_reset_action assert_flag)
+{
+	return invoke_pm_fn(RESET_ASSERT, reset, assert_flag, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:	Reset whose status should be returned
+ * @status:	Returned status
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!status)
+		return zynqmp_pm_ret_code(XST_PM_CONFLICT);
+
+	invoke_pm_fn(RESET_GET_STATUS, reset, 0, 0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
+
+/**
+ * zynqmp_pm_mmio_write - Perform write to protected mmio
+ * @address:	Address to write to
+ * @mask:	Mask to apply
+ * @value:	Value to write
+ *
+ * This function provides access to PM-related control registers
+ * that may not be directly accessible by a particular PU.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_mmio_write(const u32 address,
+			 const u32 mask,
+				     const u32 value)
+{
+	return invoke_pm_fn(MMIO_WRITE, address, mask, value, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_mmio_write);
+
+/**
+ * zynqmp_pm_mmio_read - Read value from protected mmio
+ * @address:	Address to write to
+ * @value:	Value to read
+ *
+ * This function provides access to PM-related control registers
+ * that may not be directly accessible by a particular PU.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_mmio_read(const u32 address, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!value)
+		return -EINVAL;
+
+	invoke_pm_fn(MMIO_READ, address, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_mmio_read);
+
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:    Address to write to
+ * @size:       pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bit-stream.
+ *		 1 - Partial Bit-stream.
+ *	BIT(1) - Authentication.
+ *		 1 - Enable.
+ *		 0 - Disable.
+ *	BIT(2) - Encryption.
+ *		 1 - Enable.
+ *		 0 - Disable.
+ * NOTE -
+ *	The current implementation supports only Full Bit-stream.
+ *
+ * This function provides access to xilfpga library to transfer
+ * the required bitstream into PL.
+ *
+ * Return:      Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
+{
+	return invoke_pm_fn(FPGA_LOAD, (u32)address,
+			((u32)(address >> 32)), size, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value:      Value to read
+ *
+ *This function provides access to the xilfpga library to get
+ *the PCAP status
+ *
+ * Return:      Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (!value)
+		return -EINVAL;
+
+	invoke_pm_fn(FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
+
+static int __init zynqmp_plat_init(void)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/* We're running on a ZynqMP machine, the PM node is mandatory. */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-pm");
+	if (!np)
+		panic("%s: pm node not found\n", __func__);
+
+	get_set_conduit_method(np);
+
+	pr_info("%s ZynqMP firmware interface up\n", __func__);
+
+	of_node_put(np);
+	return ret;
+}
+
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
new file mode 100644
index 000000000000..b6f941fc5f91
--- /dev/null
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -0,0 +1,232 @@
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2017 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __SOC_ZYNQMP_FIRMWARE_H__
+#define __SOC_ZYNQMP_FIRMWARE_H__
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC	0xC2000000
+#define GET_CALLBACK_DATA 0xa01
+#define SET_SUSPEND_MODE  0xa02
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	5U
+
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE	(CB_ARG_CNT + 1)
+
+/* Global general storage register base address */
+#define GGS_BASEADDR	(0xFFD80030U)
+#define GSS_NUM_REGS	(4)
+
+/* Persistent global general storage register base address */
+#define PGGS_BASEADDR	(0xFFD80050U)
+#define PGSS_NUM_REGS	(4)
+
+enum pm_api_id {
+	/* Miscellaneous API functions: */
+	GET_API_VERSION = 1,
+	SET_CONFIGURATION,
+	GET_NODE_STATUS,
+	GET_OPERATING_CHARACTERISTIC,
+	REGISTER_NOTIFIER,
+	/* API for suspending of PUs: */
+	REQUEST_SUSPEND,
+	SELF_SUSPEND,
+	FORCE_POWERDOWN,
+	ABORT_SUSPEND,
+	REQUEST_WAKEUP,
+	SET_WAKEUP_SOURCE,
+	SYSTEM_SHUTDOWN,
+	/* API for managing PM slaves: */
+	REQUEST_NODE,
+	RELEASE_NODE,
+	SET_REQUIREMENT,
+	SET_MAX_LATENCY,
+	/* Direct control API functions: */
+	RESET_ASSERT,
+	RESET_GET_STATUS,
+	MMIO_WRITE,
+	MMIO_READ,
+	PM_INIT_FINALIZE,
+	FPGA_LOAD,
+	FPGA_GET_STATUS,
+	GET_CHIPID,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL	= 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZYNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_END
+};
+
+/* Miscellaneous API functions */
+int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+
+/* Direct-Control API functions */
+int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				const enum zynqmp_pm_reset_action assert_flag);
+int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+					u32 *status);
+int zynqmp_pm_mmio_write(const u32 address,
+				     const u32 mask,
+				     const u32 value);
+int zynqmp_pm_mmio_read(const u32 address, u32 *value);
+int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
+int zynqmp_pm_fpga_get_status(u32 *value);
+
+#endif /* __SOC_ZYNQMP_FIRMWARE_H__ */
-- 
1.9.1
