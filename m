From: aishpant@gmail.com (Aishwarya Pant)
Date: Tue, 9 Jan 2018 17:49:11 +0530
Subject: [PATCH] drivers: firmware: xilinx: Add ZynqMP firmware driver
In-Reply-To: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
References: <1515449227-5096-1-git-send-email-jollys@xilinx.com>
Message-ID: <20180109121911.GA18770@mordor.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 02:07:07PM -0800, Jolly Shah wrote:
> This patch is adding communication layer with firmware.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate to
> PMUFW(Platform Management Unit). All requests go through ATF.
> Firmware-debug provides debugfs interface to all APIs.
> Firmware-ggs provides read/write interface to
> global storage registers.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   16 +
>  arch/arm64/Kconfig.platforms                       |    1 +
>  drivers/firmware/Kconfig                           |    1 +
>  drivers/firmware/Makefile                          |    1 +
>  drivers/firmware/xilinx/Kconfig                    |    4 +
>  drivers/firmware/xilinx/Makefile                   |    4 +
>  drivers/firmware/xilinx/zynqmp/Kconfig             |   23 +
>  drivers/firmware/xilinx/zynqmp/Makefile            |    5 +
>  drivers/firmware/xilinx/zynqmp/firmware-debug.c    |  540 +++++++++++
>  drivers/firmware/xilinx/zynqmp/firmware-ggs.c      |  298 ++++++
>  drivers/firmware/xilinx/zynqmp/firmware.c          | 1024 ++++++++++++++++++++
>  .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   32 +
>  include/linux/firmware/xilinx/zynqmp/firmware.h    |  573 +++++++++++
>  13 files changed, 2522 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>  create mode 100644 drivers/firmware/xilinx/Kconfig
>  create mode 100644 drivers/firmware/xilinx/Makefile
>  create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
>  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
>  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h
>  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> new file mode 100644
> index 0000000..ace111c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -0,0 +1,16 @@
> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> +
> +The zynqmp-firmware node describes the interface to platform firmware.
> +
> +Required properties:
> + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> + - method:	The method of calling the PM-API firmware layer.
> +		Permitted values are:
> +		 - "smc" : To be used in configurations without a hypervisor
> +		 - "hvc" : To be used when hypervisor is present
> +
> +Examples:
> +	firmware: firmware {
> +		compatible = "xlnx,zynqmp-firmware";
> +		method = "smc";
> +	};
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 2401373..3dd3ae9 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -273,6 +273,7 @@ config ARCH_ZX
>  
>  config ARCH_ZYNQMP
>  	bool "Xilinx ZynqMP Family"
> +	select ZYNQMP_FIRMWARE
>  	help
>  	  This enables support for Xilinx ZynqMP Family
>  
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index fa87a055..18fc2a8 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -249,5 +249,6 @@ source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
>  source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
> +source "drivers/firmware/xilinx/Kconfig"
>  
>  endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index feaa890..43a24b5 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>  obj-$(CONFIG_EFI)		+= efi/
>  obj-$(CONFIG_UEFI_CPER)		+= efi/
>  obj-y				+= tegra/
> +obj-y				+= xilinx/
> diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
> new file mode 100644
> index 0000000..dd3cddb
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Kconfig for Xilinx firmwares
> +
> +source "drivers/firmware/xilinx/zynqmp/Kconfig"
> diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
> new file mode 100644
> index 0000000..aba1f86
> --- /dev/null
> +++ b/drivers/firmware/xilinx/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Makefile for Xilinx firmwares
> +
> +obj-$(CONFIG_ARCH_ZYNQMP) += zynqmp/
> diff --git a/drivers/firmware/xilinx/zynqmp/Kconfig b/drivers/firmware/xilinx/zynqmp/Kconfig
> new file mode 100644
> index 0000000..1f815e0
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Kconfig for Xilinx zynqmp firmware
> +
> +menu "Zynq MPSoC Firmware Drivers"
> +	depends on ARCH_ZYNQMP
> +
> +config ZYNQMP_FIRMWARE
> +	bool "Enable Xilinx Zynq MPSoC firmware interface"
> +	help
> +	  Firmware interface driver is used by different to
> +	  communicate with the firmware for various platform
> +	  management services.
> +	  Say yes to enable zynqmp firmware interface driver.
> +	  In doubt, say N
> +
> +config ZYNQMP_FIRMWARE_DEBUG
> +	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
> +	depends on ARCH_ZYNQMP && DEBUG_FS
> +	help
> +	  Say yes to enable zynqmp firmware interface debug APIs.
> +	  In doubt, say N
> +
> +endmenu
> diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
> new file mode 100644
> index 0000000..97086b5
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Makefile for Xilinx firmwares
> +
> +obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
> +obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += firmware-debug.o
> diff --git a/drivers/firmware/xilinx/zynqmp/firmware-debug.c b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
> new file mode 100644
> index 0000000..83b1c45
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/firmware-debug.c
> @@ -0,0 +1,540 @@
> +/*
> + * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
> + *
> + *  Copyright (C) 2014-2017 Xilinx, Inc.
> + *
> + *  Michal Simek <michal.simek@xilinx.com>
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
> +
> +#define DRIVER_NAME	"zynqmp-firmware"
> +
> +/**
> + * zynqmp_pm_self_suspend - PM call for master to suspend itself
> + * @node:	Node ID of the master or subsystem
> + * @latency:	Requested maximum wakeup latency (not supported)
> + * @state:	Requested state (not supported)
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_self_suspend(const u32 node,
> +			   const u32 latency,
> +			   const u32 state)
> +{
> +	return invoke_pm_fn(SELF_SUSPEND, node, latency, state, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_abort_suspend - PM call to announce that a prior suspend request
> + *				is to be aborted.
> + * @reason:	Reason for the abort
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_abort_suspend(const enum zynqmp_pm_abort_reason reason)
> +{
> +	return invoke_pm_fn(ABORT_SUSPEND, reason, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_register_notifier - Register the PU to be notified of PM events
> + * @node:	Node ID of the slave
> + * @event:	The event to be notified about
> + * @wake:	Wake up on event
> + * @enable:	Enable or disable the notifier
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +				const u32 wake, const u32 enable)
> +{
> +	return invoke_pm_fn(REGISTER_NOTIFIER, node, event,
> +			    wake, enable, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_argument_value - Extract argument value from a PM-API request
> + * @arg:	Entered PM-API argument in string format
> + *
> + * Return:	Argument value in unsigned integer format on success
> + *		0 otherwise
> + */
> +static u64 zynqmp_pm_argument_value(char *arg)
> +{
> +	u64 value;
> +
> +	if (!arg)
> +		return 0;
> +
> +	if (!kstrtou64(arg, 0, &value))
> +		return value;
> +
> +	return 0;
> +}
> +
> +static struct dentry *zynqmp_pm_debugfs_dir;
> +static struct dentry *zynqmp_pm_debugfs_power;
> +static struct dentry *zynqmp_pm_debugfs_api_version;
> +
> +/**
> + * zynqmp_pm_debugfs_api_write - debugfs write function
> + * @file:	User file structure
> + * @ptr:	User entered PM-API string
> + * @len:	Length of the userspace buffer
> + * @off:	Offset within the file
> + *
> + * Return:	Number of bytes copied if PM-API request succeeds,
> + *		the corresponding error code otherwise
> + *
> + * Used for triggering pm api functions by writing
> + * echo <pm_api_id>    > /sys/kernel/debug/zynqmp_pm/power or
> + * echo <pm_api_name>  > /sys/kernel/debug/zynqmp_pm/power
> + */
> +static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
> +					   const char __user *ptr, size_t len,
> +					   loff_t *off)
> +{
> +	char *kern_buff, *tmp_buff;
> +	char *pm_api_req;
> +	u32 pm_id = 0;
> +	u64 pm_api_arg[4];
> +	/* Return values from PM APIs calls */
> +	u32 pm_api_ret[4] = {0, 0, 0, 0};
> +	u32 pm_api_version;
> +
> +	int ret;
> +	int i = 0;
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops)
> +		return -ENXIO;
> +
> +	if (*off != 0 || len <= 0)
> +		return -EINVAL;
> +
> +	kern_buff = kzalloc(len, GFP_KERNEL);
> +	if (!kern_buff)
> +		return -ENOMEM;
> +	tmp_buff = kern_buff;
> +
> +	while (i < ARRAY_SIZE(pm_api_arg))
> +		pm_api_arg[i++] = 0;
> +
> +	ret = strncpy_from_user(kern_buff, ptr, len);
> +	if (ret < 0) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	/* Read the API name from a user request */
> +	pm_api_req = strsep(&kern_buff, " ");
> +
> +	if (strncasecmp(pm_api_req, "REQUEST_SUSPEND", 15) == 0)
> +		pm_id = REQUEST_SUSPEND;
> +	else if (strncasecmp(pm_api_req, "SELF_SUSPEND", 12) == 0)
> +		pm_id = SELF_SUSPEND;
> +	else if (strncasecmp(pm_api_req, "FORCE_POWERDOWN", 15) == 0)
> +		pm_id = FORCE_POWERDOWN;
> +	else if (strncasecmp(pm_api_req, "ABORT_SUSPEND", 13) == 0)
> +		pm_id = ABORT_SUSPEND;
> +	else if (strncasecmp(pm_api_req, "REQUEST_WAKEUP", 14) == 0)
> +		pm_id = REQUEST_WAKEUP;
> +	else if (strncasecmp(pm_api_req, "SET_WAKEUP_SOURCE", 17) == 0)
> +		pm_id = SET_WAKEUP_SOURCE;
> +	else if (strncasecmp(pm_api_req, "SYSTEM_SHUTDOWN", 15) == 0)
> +		pm_id = SYSTEM_SHUTDOWN;
> +	else if (strncasecmp(pm_api_req, "REQUEST_NODE", 12) == 0)
> +		pm_id = REQUEST_NODE;
> +	else if (strncasecmp(pm_api_req, "RELEASE_NODE", 12) == 0)
> +		pm_id = RELEASE_NODE;
> +	else if (strncasecmp(pm_api_req, "SET_REQUIREMENT", 15) == 0)
> +		pm_id = SET_REQUIREMENT;
> +	else if (strncasecmp(pm_api_req, "SET_MAX_LATENCY", 15) == 0)
> +		pm_id = SET_MAX_LATENCY;
> +	else if (strncasecmp(pm_api_req, "GET_API_VERSION", 15) == 0)
> +		pm_id = GET_API_VERSION;
> +	else if (strncasecmp(pm_api_req, "SET_CONFIGURATION", 17) == 0)
> +		pm_id = SET_CONFIGURATION;
> +	else if (strncasecmp(pm_api_req, "GET_NODE_STATUS", 15) == 0)
> +		pm_id = GET_NODE_STATUS;
> +	else if (strncasecmp(pm_api_req,
> +			     "GET_OPERATING_CHARACTERISTIC", 28) == 0)
> +		pm_id = GET_OPERATING_CHARACTERISTIC;
> +	else if (strncasecmp(pm_api_req, "REGISTER_NOTIFIER", 17) == 0)
> +		pm_id = REGISTER_NOTIFIER;
> +	else if (strncasecmp(pm_api_req, "RESET_ASSERT", 12) == 0)
> +		pm_id = RESET_ASSERT;
> +	else if (strncasecmp(pm_api_req, "RESET_GET_STATUS", 16) == 0)
> +		pm_id = RESET_GET_STATUS;
> +	else if (strncasecmp(pm_api_req, "MMIO_READ", 9) == 0)
> +		pm_id = MMIO_READ;
> +	else if (strncasecmp(pm_api_req, "MMIO_WRITE", 10) == 0)
> +		pm_id = MMIO_WRITE;
> +	else if (strncasecmp(pm_api_req, "GET_CHIPID", 9) == 0)
> +		pm_id = GET_CHIPID;
> +	else if (strncasecmp(pm_api_req, "PINCTRL_GET_FUNCTION", 21) == 0)
> +		pm_id = PINCTRL_GET_FUNCTION;
> +	else if (strncasecmp(pm_api_req, "PINCTRL_SET_FUNCTION", 21) == 0)
> +		pm_id = PINCTRL_SET_FUNCTION;
> +	else if (strncasecmp(pm_api_req,
> +			     "PINCTRL_CONFIG_PARAM_GET", 25) == 0)
> +		pm_id = PINCTRL_CONFIG_PARAM_GET;
> +	else if (strncasecmp(pm_api_req,
> +			     "PINCTRL_CONFIG_PARAM_SET", 25) == 0)
> +		pm_id = PINCTRL_CONFIG_PARAM_SET;
> +	else if (strncasecmp(pm_api_req, "IOCTL", 6) == 0)
> +		pm_id = IOCTL;
> +	else if (strncasecmp(pm_api_req, "CLOCK_ENABLE", 12) == 0)
> +		pm_id = CLOCK_ENABLE;
> +	else if (strncasecmp(pm_api_req, "CLOCK_DISABLE", 13) == 0)
> +		pm_id = CLOCK_DISABLE;
> +	else if (strncasecmp(pm_api_req, "CLOCK_GETSTATE", 14) == 0)
> +		pm_id = CLOCK_GETSTATE;
> +	else if (strncasecmp(pm_api_req, "CLOCK_SETDIVIDER", 16) == 0)
> +		pm_id = CLOCK_SETDIVIDER;
> +	else if (strncasecmp(pm_api_req, "CLOCK_GETDIVIDER", 16) == 0)
> +		pm_id = CLOCK_GETDIVIDER;
> +	else if (strncasecmp(pm_api_req, "CLOCK_SETRATE", 13) == 0)
> +		pm_id = CLOCK_SETRATE;
> +	else if (strncasecmp(pm_api_req, "CLOCK_GETRATE", 13) == 0)
> +		pm_id = CLOCK_GETRATE;
> +	else if (strncasecmp(pm_api_req, "CLOCK_SETPARENT", 15) == 0)
> +		pm_id = CLOCK_SETPARENT;
> +	else if (strncasecmp(pm_api_req, "CLOCK_GETPARENT", 15) == 0)
> +		pm_id = CLOCK_GETPARENT;
> +	else if (strncasecmp(pm_api_req, "QUERY_DATA", 22) == 0)
> +		pm_id = QUERY_DATA;
> +
> +	/* If no name was entered look for PM-API ID instead */
> +	else if (kstrtouint(pm_api_req, 10, &pm_id))
> +		ret = -EINVAL;
> +
> +	/* Read node_id and arguments from the PM-API request */
> +	i = 0;
> +	pm_api_req = strsep(&kern_buff, " ");
> +	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
> +		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
> +		pm_api_req = strsep(&kern_buff, " ");
> +	}
> +
> +	switch (pm_id) {
> +	case GET_API_VERSION:
> +		eemi_ops->get_api_version(&pm_api_version);
> +		pr_info("%s PM-API Version = %d.%d\n", __func__,
> +			pm_api_version >> 16, pm_api_version & 0xffff);
> +		break;
> +	case REQUEST_SUSPEND:
> +		ret = eemi_ops->request_suspend(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_REQUEST_ACK_NO,
> +						pm_api_arg[2] ? pm_api_arg[2] :
> +						ZYNQMP_PM_MAX_LATENCY, 0);
> +		break;
> +	case SELF_SUSPEND:
> +		ret = zynqmp_pm_self_suspend(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_MAX_LATENCY, 0);
> +		break;
> +	case FORCE_POWERDOWN:
> +		ret = eemi_ops->force_powerdown(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case ABORT_SUSPEND:
> +		ret = zynqmp_pm_abort_suspend(pm_api_arg[0] ? pm_api_arg[0] :
> +					      ZYNQMP_PM_ABORT_REASON_UNKNOWN);
> +		break;
> +	case REQUEST_WAKEUP:
> +		ret = eemi_ops->request_wakeup(pm_api_arg[0],
> +					       pm_api_arg[1], pm_api_arg[2],
> +					       pm_api_arg[3] ? pm_api_arg[3] :
> +					       ZYNQMP_PM_REQUEST_ACK_NO);
> +		break;
> +	case SET_WAKEUP_SOURCE:
> +		ret = eemi_ops->set_wakeup_source(pm_api_arg[0], pm_api_arg[1],
> +						  pm_api_arg[2]);
> +		break;
> +	case SYSTEM_SHUTDOWN:
> +		ret = eemi_ops->system_shutdown(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case REQUEST_NODE:
> +		ret = eemi_ops->request_node(pm_api_arg[0],
> +					     pm_api_arg[1] ? pm_api_arg[1] :
> +					     ZYNQMP_PM_CAPABILITY_ACCESS,
> +					     pm_api_arg[2] ? pm_api_arg[2] : 0,
> +					     pm_api_arg[3] ? pm_api_arg[3] :
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case RELEASE_NODE:
> +		ret = eemi_ops->release_node(pm_api_arg[0]);
> +		break;
> +	case SET_REQUIREMENT:
> +		ret = eemi_ops->set_requirement(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_CAPABILITY_CONTEXT,
> +						pm_api_arg[2] ?
> +						pm_api_arg[2] : 0,
> +						pm_api_arg[3] ? pm_api_arg[3] :
> +						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		break;
> +	case SET_MAX_LATENCY:
> +		ret = eemi_ops->set_max_latency(pm_api_arg[0],
> +						pm_api_arg[1] ? pm_api_arg[1] :
> +						ZYNQMP_PM_MAX_LATENCY);
> +		break;
> +	case SET_CONFIGURATION:
> +		ret = eemi_ops->set_configuration(pm_api_arg[0]);
> +		break;
> +	case GET_NODE_STATUS:
> +		ret = eemi_ops->get_node_status(pm_api_arg[0],
> +						&pm_api_ret[0],
> +						&pm_api_ret[1],
> +						&pm_api_ret[2]);
> +		if (!ret)
> +			pr_info("GET_NODE_STATUS:\n\tNodeId: %llu\n\tStatus: %u\n\tRequirements: %u\n\tUsage: %u\n",
> +				pm_api_arg[0], pm_api_ret[0],
> +				pm_api_ret[1], pm_api_ret[2]);
> +		break;
> +	case GET_OPERATING_CHARACTERISTIC:
> +		ret = eemi_ops->get_operating_characteristic(pm_api_arg[0],
> +				pm_api_arg[1] ? pm_api_arg[1] :
> +				ZYNQMP_PM_OPERATING_CHARACTERISTIC_POWER,
> +				&pm_api_ret[0]);
> +		if (!ret)
> +			pr_info("GET_OPERATING_CHARACTERISTIC:\n\tNodeId: %llu\n\tType: %llu\n\tResult: %u\n",
> +				pm_api_arg[0], pm_api_arg[1], pm_api_ret[0]);
> +		break;
> +	case REGISTER_NOTIFIER:
> +		ret = zynqmp_pm_register_notifier(pm_api_arg[0],
> +						  pm_api_arg[1] ?
> +						  pm_api_arg[1] : 0,
> +						  pm_api_arg[2] ?
> +						  pm_api_arg[2] : 0,
> +						  pm_api_arg[3] ?
> +						  pm_api_arg[3] : 0);
> +		break;
> +	case RESET_ASSERT:
> +		ret = eemi_ops->reset_assert(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case RESET_GET_STATUS:
> +		ret = eemi_ops->reset_get_status(pm_api_arg[0], &pm_api_ret[0]);
> +		pr_info("%s Reset status: %u\n", __func__, pm_api_ret[0]);
> +		break;
> +	case GET_CHIPID:
> +		ret = eemi_ops->get_chipid(&pm_api_ret[0], &pm_api_ret[1]);
> +		pr_info("%s idcode: %#x, version:%#x\n",
> +			__func__, pm_api_ret[0], pm_api_ret[1]);
> +		break;
> +	case PINCTRL_GET_FUNCTION:
> +		ret = eemi_ops->pinctrl_get_function(pm_api_arg[0],
> +						     &pm_api_ret[0]);
> +		pr_info("%s Current set function for the pin: %u\n",
> +			__func__, pm_api_ret[0]);
> +		break;
> +	case PINCTRL_SET_FUNCTION:
> +		ret = eemi_ops->pinctrl_set_function(pm_api_arg[0],
> +						     pm_api_arg[1]);
> +		break;
> +	case PINCTRL_CONFIG_PARAM_GET:
> +		ret = eemi_ops->pinctrl_get_config(pm_api_arg[0], pm_api_arg[1],
> +						   &pm_api_ret[0]);
> +		pr_info("%s pin: %llu, param: %llu, value: %u\n",
> +			__func__, pm_api_arg[0], pm_api_arg[1],
> +			pm_api_ret[0]);
> +		break;
> +	case PINCTRL_CONFIG_PARAM_SET:
> +		ret = eemi_ops->pinctrl_set_config(pm_api_arg[0],
> +						   pm_api_arg[1],
> +						   pm_api_arg[2]);
> +		break;
> +	case IOCTL:
> +		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
> +				      pm_api_arg[2], pm_api_arg[3],
> +				      &pm_api_ret[0]);
> +		if (pm_api_arg[1] == IOCTL_GET_RPU_OPER_MODE ||
> +		    pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
> +		    pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA ||
> +		    pm_api_arg[1] == IOCTL_READ_GGS ||
> +		    pm_api_arg[1] == IOCTL_READ_PGGS)
> +			pr_info("%s Value: %u\n",
> +				__func__, pm_api_ret[1]);
> +		break;
> +	case CLOCK_ENABLE:
> +		ret = eemi_ops->clock_enable(pm_api_arg[0]);
> +		break;
> +	case CLOCK_DISABLE:
> +		ret = eemi_ops->clock_disable(pm_api_arg[0]);
> +		break;
> +	case CLOCK_GETSTATE:
> +		ret = eemi_ops->clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
> +		pr_info("%s state: %u\n", __func__, pm_api_ret[0]);
> +		break;
> +	case CLOCK_SETDIVIDER:
> +		ret = eemi_ops->clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case CLOCK_GETDIVIDER:
> +		ret = eemi_ops->clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
> +		pr_info("%s Divider Value: %d\n", __func__, pm_api_ret[0]);
> +		break;
> +	case CLOCK_SETRATE:
> +		ret = eemi_ops->clock_setrate(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case CLOCK_GETRATE:
> +		ret = eemi_ops->clock_getrate(pm_api_arg[0], &pm_api_ret[0]);
> +		pr_info("%s Rate Value: %u\n", __func__, pm_api_ret[0]);
> +		break;
> +	case CLOCK_SETPARENT:
> +		ret = eemi_ops->clock_setparent(pm_api_arg[0], pm_api_arg[1]);
> +		break;
> +	case CLOCK_GETPARENT:
> +		ret = eemi_ops->clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
> +		pr_info("%s Parent Index: %u\n", __func__, pm_api_ret[0]);
> +		break;
> +	case QUERY_DATA:
> +	{
> +		struct zynqmp_pm_query_data qdata = {0};
> +
> +		qdata.qid = pm_api_arg[0];
> +		qdata.arg1 = pm_api_arg[1];
> +		qdata.arg2 = pm_api_arg[2];
> +		qdata.arg3 = pm_api_arg[3];
> +
> +		ret = eemi_ops->query_data(qdata, pm_api_ret);
> +
> +		pr_info("%s: data[0] = 0x%08x\n", __func__, pm_api_ret[0]);
> +		pr_info("%s: data[1] = 0x%08x\n", __func__, pm_api_ret[1]);
> +		pr_info("%s: data[2] = 0x%08x\n", __func__, pm_api_ret[2]);
> +		pr_info("%s: data[3] = 0x%08x\n", __func__, pm_api_ret[3]);
> +		break;
> +	}
> +	default:
> +		pr_err("%s Unsupported PM-API request\n", __func__);
> +		ret = -EINVAL;
> +	}
> +
> +err:
> +	kfree(tmp_buff);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +/**
> + * zynqmp_pm_debugfs_api_version_read - debugfs read function
> + * @file:	User file structure
> + * @ptr:	Requested pm_api_version string
> + * @len:	Length of the userspace buffer
> + * @off:	Offset within the file
> + *
> + * Return:	Length of the version string on success
> + *		-EFAULT otherwise
> + *
> + * Used to display the pm api version.
> + * cat /sys/kernel/debug/zynqmp_pm/pm_api_version
> + */
> +static ssize_t zynqmp_pm_debugfs_api_version_read(struct file *file,
> +						  char __user *ptr, size_t len,
> +						  loff_t *off)
> +{
> +	char *kern_buff;
> +	int ret;
> +	int kern_buff_len;
> +	u32 pm_api_version;
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_api_version)
> +		return -ENXIO;
> +
> +	if (len <= 0)
> +		return -EINVAL;
> +
> +	if (*off != 0)
> +		return 0;
> +
> +	kern_buff = kzalloc(len, GFP_KERNEL);
> +	if (!kern_buff)
> +		return -ENOMEM;
> +
> +	eemi_ops->get_api_version(&pm_api_version);
> +	sprintf(kern_buff, "PM-API Version = %d.%d\n",
> +		pm_api_version >> 16, pm_api_version & 0xffff);
> +	kern_buff_len = strlen(kern_buff) + 1;
> +
> +	if (len > kern_buff_len)
> +		len = kern_buff_len;
> +	ret = copy_to_user(ptr, kern_buff, len);
> +
> +	kfree(kern_buff);
> +	if (ret)
> +		return -EFAULT;
> +
> +	*off = len + 1;
> +
> +	return len;
> +}
> +
> +/* Setup debugfs fops */
> +static const struct file_operations fops_zynqmp_pm_dbgfs = {
> +	.owner  =	THIS_MODULE,
> +	.write  =	zynqmp_pm_debugfs_api_write,
> +	.read   =	zynqmp_pm_debugfs_api_version_read,
> +};
> +
> +/**
> + * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
> + *
> + * Return:      Returns 0 on success
> + *		Corresponding error code otherwise
> + */
> +int zynqmp_pm_api_debugfs_init(void)
> +{
> +	int err;
> +
> +	/* Initialize debugfs interface */
> +	zynqmp_pm_debugfs_dir = debugfs_create_dir(DRIVER_NAME, NULL);
> +	if (!zynqmp_pm_debugfs_dir) {
> +		pr_err("debugfs_create_dir failed\n");
> +		return -ENODEV;
> +	}
> +
> +	zynqmp_pm_debugfs_power =
> +		debugfs_create_file("pm", 0220,
> +				    zynqmp_pm_debugfs_dir, NULL,
> +				    &fops_zynqmp_pm_dbgfs);
> +	if (!zynqmp_pm_debugfs_power) {
> +		pr_err("debugfs_create_file power failed\n");
> +		err = -ENODEV;
> +		goto err_dbgfs;
> +	}
> +
> +	zynqmp_pm_debugfs_api_version =
> +		debugfs_create_file("api_version", 0444,
> +				    zynqmp_pm_debugfs_dir, NULL,
> +				    &fops_zynqmp_pm_dbgfs);
> +	if (!zynqmp_pm_debugfs_api_version) {
> +		pr_err("debugfs_create_file api_version failed\n");
> +		err = -ENODEV;
> +		goto err_dbgfs;
> +	}
> +
> +	return 0;
> +
> +err_dbgfs:
> +	debugfs_remove_recursive(zynqmp_pm_debugfs_dir);
> +	zynqmp_pm_debugfs_dir = NULL;
> +
> +	return err;
> +}
> diff --git a/drivers/firmware/xilinx/zynqmp/firmware-ggs.c b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> new file mode 100644
> index 0000000..feb6148
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> @@ -0,0 +1,298 @@
> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2017 Xilinx, Inc.
> + *
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->ioctl)
> +		return 0;
> +
> +	ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> +	if (ret)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "0x%x\n", ret_payload[1]);
> +}
> +
> +static ssize_t write_register(const char *buf, size_t count,
> +			      u32 ioctl_id, u32 reg)
> +{
> +	char *kern_buff;
> +	char *inbuf;
> +	char *tok;
> +	long mask;
> +	long value;
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->ioctl)
> +		return -EFAULT;
> +
> +	kern_buff = kzalloc(count, GFP_KERNEL);
> +	if (!kern_buff)
> +		return -ENOMEM;
> +
> +	ret = strlcpy(kern_buff, buf, count);
> +	if (ret < 0) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	inbuf = kern_buff;
> +
> +	/* Read the write mask */
> +	tok = strsep(&inbuf, " ");
> +	if (!tok) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &mask);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	/* Read the write value */
> +	tok = strsep(&inbuf, " ");
> +	if (!tok) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &value);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +	ret_payload[1] &= ~mask;
> +	value &= mask;
> +	value |= ret_payload[1];
> +
> +	ret = eemi_ops->ioctl(0, ioctl_id, reg, value, NULL);
> +	if (ret)
> +		ret = -EFAULT;
> +
> +err:
> +	kfree(kern_buff);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * ggs_show - Show global general storage (ggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: Requested available shutdown_scope attributes string
> + * @reg: Register number
> + *
> + * Return:Number of bytes printed into the buffer.
> + *
> + * Helper function for viewing a ggs register value.
> + *
> + * User-space interface for viewing the content of the ggs0 register.
> + * cat /sys/devices/platform/firmware/ggs0
> + */
> +static ssize_t ggs_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf,
> +			u32 reg)
> +{
> +	return read_register(buf, IOCTL_READ_GGS, reg);
> +}
> +
> +/**
> + * ggs_store - Store global general storage (ggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a ggs register value.
> + *
> + * For example, the user-space interface for storing a value to the
> + * ggs0 register:
> + * echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware/ggs0
> + */
> +static ssize_t ggs_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf,
> +			 size_t count,
> +			 u32 reg)
> +{
> +	if (!dev || !attr || !buf || !count || reg >= GSS_NUM_REGS)
> +		return -EINVAL;
> +
> +	return write_register(buf, count, IOCTL_WRITE_GGS, reg);
> +}
> +
> +/* GGS register show functions */
> +#define GGS0_SHOW(N) \
> +	ssize_t ggs##N##_show(struct device *dev, \
> +			 struct device_attribute *attr, \
> +			 char *buf) \
> +	{ \
> +		return ggs_show(dev, attr, buf, N); \
> +	}
> +
> +static GGS0_SHOW(0);
> +static GGS0_SHOW(1);
> +static GGS0_SHOW(2);
> +static GGS0_SHOW(3);
> +
> +/* GGS register store function */
> +#define GGS0_STORE(N) \
> +	ssize_t ggs##N##_store(struct device *dev, \
> +				   struct device_attribute *attr, \
> +				   const char *buf, \
> +				   size_t count) \
> +	{ \
> +		return ggs_store(dev, attr, buf, count, N); \
> +	}
> +
> +static GGS0_STORE(0);
> +static GGS0_STORE(1);
> +static GGS0_STORE(2);
> +static GGS0_STORE(3);
> +
> +/* GGS register device attributes */
> +static DEVICE_ATTR_RW(ggs0);
> +static DEVICE_ATTR_RW(ggs1);
> +static DEVICE_ATTR_RW(ggs2);
> +static DEVICE_ATTR_RW(ggs3);

Hi

You added some files to the sysfs ABI. These interfaces should be documented in
Documentation/ABI.

> +
> +#define CREATE_GGS_DEVICE(dev, N) \
> +do { \
> +	if (device_create_file(dev, &dev_attr_ggs##N)) \
> +		dev_err(dev, "unable to create ggs%d attribute\n", N); \
> +} while (0)
> +
> +/**
> + * pggs_show - Show persistent global general storage (pggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: Requested available shutdown_scope attributes string
> + * @reg: Register number
> + *
> + * Return:Number of bytes printed into the buffer.
> + *
> + * Helper function for viewing a pggs register value.
> + */
> +static ssize_t pggs_show(struct device *dev,
> +			 struct device_attribute *attr,
> +			 char *buf,
> +			 u32 reg)
> +{
> +	return read_register(buf, IOCTL_READ_GGS, reg);
> +}
> +
> +/**
> + * pggs_store - Store persistent global general storage (pggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a pggs register value.
> + */
> +static ssize_t pggs_store(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf,
> +			  size_t count,
> +			  u32 reg)
> +{
> +	return write_register(buf, count, IOCTL_WRITE_PGGS, reg);
> +}
> +
> +#define PGGS0_SHOW(N) \
> +	ssize_t pggs##N##_show(struct device *dev, \
> +			 struct device_attribute *attr, \
> +			 char *buf) \
> +	{ \
> +		return pggs_show(dev, attr, buf, N); \
> +	}
> +
> +/* PGGS register show functions */
> +static PGGS0_SHOW(0);
> +static PGGS0_SHOW(1);
> +static PGGS0_SHOW(2);
> +static PGGS0_SHOW(3);
> +
> +#define PGGS0_STORE(N) \
> +	ssize_t pggs##N##_store(struct device *dev, \
> +				   struct device_attribute *attr, \
> +				   const char *buf, \
> +				   size_t count) \
> +	{ \
> +		return pggs_store(dev, attr, buf, count, N); \
> +	}
> +
> +/* PGGS register store functions */
> +static PGGS0_STORE(0);
> +static PGGS0_STORE(1);
> +static PGGS0_STORE(2);
> +static PGGS0_STORE(3);
> +
> +/* PGGS register device attributes */
> +static DEVICE_ATTR_RW(pggs0);
> +static DEVICE_ATTR_RW(pggs1);
> +static DEVICE_ATTR_RW(pggs2);
> +static DEVICE_ATTR_RW(pggs3);
> +
> +#define CREATE_PGGS_DEVICE(dev, N) \
> +do { \
> +	if (device_create_file(dev, &dev_attr_pggs##N)) \
> +		dev_err(dev, "unable to create pggs%d attribute\n", N); \
> +} while (0)
> +
> +void zynqmp_pm_ggs_init(struct device *dev)
> +{
> +	/* Create Global General Storage register. */
> +	CREATE_GGS_DEVICE(dev, 0);
> +	CREATE_GGS_DEVICE(dev, 1);
> +	CREATE_GGS_DEVICE(dev, 2);
> +	CREATE_GGS_DEVICE(dev, 3);
> +
> +	/* Create Persistent Global General Storage register. */
> +	CREATE_PGGS_DEVICE(dev, 0);
> +	CREATE_PGGS_DEVICE(dev, 1);
> +	CREATE_PGGS_DEVICE(dev, 2);
> +	CREATE_PGGS_DEVICE(dev, 3);
> +}
> diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
> new file mode 100644
> index 0000000..edce5eb
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/firmware.c
> @@ -0,0 +1,1024 @@
> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2017 Xilinx, Inc.
> + *
> + *  Michal Simek <michal.simek@xilinx.com>
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/uaccess.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware-debug.h>
> +
> +#define DRIVER_NAME	"zynqmp_firmware"
> +
> +/**
> + * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
> + * @ret_status:		PMUFW return code
> + *
> + * Return:		corresponding Linux error code
> + */
> +int zynqmp_pm_ret_code(u32 ret_status)
> +{
> +	switch (ret_status) {
> +	case XST_PM_SUCCESS:
> +	case XST_PM_DOUBLE_REQ:
> +		return 0;
> +	case XST_PM_NO_ACCESS:
> +		return -EACCES;
> +	case XST_PM_ABORT_SUSPEND:
> +		return -ECANCELED;
> +	case XST_PM_INTERNAL:
> +	case XST_PM_CONFLICT:
> +	case XST_PM_INVALID_NODE:
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
> +				    u32 *ret_payload)
> +{
> +	return -ENODEV;
> +}
> +
> +/*
> + * PM function call wrapper
> + * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
> + */
> +static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
> +
> +/**
> + * do_fw_call_smc - Call system-level power management layer (SMC)
> + * @arg0:		Argument 0 to SMC call
> + * @arg1:		Argument 1 to SMC call
> + * @arg2:		Argument 2 to SMC call
> + * @ret_payload:	Returned value array
> + *
> + * Return:		Returns status, either success or error+reason
> + *
> + * Invoke power management function via SMC call (no hypervisor present)
> + */
> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
> +				   u32 *ret_payload)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
> +
> +	if (ret_payload) {
> +		ret_payload[0] = lower_32_bits(res.a0);
> +		ret_payload[1] = upper_32_bits(res.a0);
> +		ret_payload[2] = lower_32_bits(res.a1);
> +		ret_payload[3] = upper_32_bits(res.a1);
> +		ret_payload[4] = lower_32_bits(res.a2);
> +	}
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
> +}
> +
> +/**
> + * do_fw_call_hvc - Call system-level power management layer (HVC)
> + * @arg0:		Argument 0 to HVC call
> + * @arg1:		Argument 1 to HVC call
> + * @arg2:		Argument 2 to HVC call
> + * @ret_payload:	Returned value array
> + *
> + * Return:		Returns status, either success or error+reason
> + *
> + * Invoke power management function via HVC
> + * HVC-based for communication through hypervisor
> + * (no direct communication with ATF)
> + */
> +static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
> +				   u32 *ret_payload)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
> +
> +	if (ret_payload) {
> +		ret_payload[0] = lower_32_bits(res.a0);
> +		ret_payload[1] = upper_32_bits(res.a0);
> +		ret_payload[2] = lower_32_bits(res.a1);
> +		ret_payload[3] = upper_32_bits(res.a1);
> +		ret_payload[4] = lower_32_bits(res.a2);
> +	}
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
> +}
> +
> +/**
> + * invoke_pm_fn - Invoke the system-level power management layer caller
> + *			function depending on the configuration
> + * @pm_api_id:         Requested PM-API call
> + * @arg0:              Argument 0 to requested PM-API call
> + * @arg1:              Argument 1 to requested PM-API call
> + * @arg2:              Argument 2 to requested PM-API call
> + * @arg3:              Argument 3 to requested PM-API call
> + * @ret_payload:       Returned value array
> + *
> + * Return:             Returns status, either success or error+reason
> + *
> + * Invoke power management function for SMC or HVC call, depending on
> + * configuration
> + * Following SMC Calling Convention (SMCCC) for SMC64:
> + * Pm Function Identifier,
> + * PM_SIP_SVC + PM_API_ID =
> + *     ((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
> + *     ((SMC_64) << FUNCID_CC_SHIFT)
> + *     ((SIP_START) << FUNCID_OEN_SHIFT)
> + *     ((PM_API_ID) & FUNCID_NUM_MASK))
> + *
> + * PM_SIP_SVC  - Registered ZynqMP SIP Service Call
> + * PM_API_ID   - Power Management API ID
> + */
> +int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
> +		 u32 *ret_payload)
> +{
> +	/*
> +	 * Added SIP service call Function Identifier
> +	 * Make sure to stay in x0 register
> +	 */
> +	u64 smc_arg[4];
> +
> +	smc_arg[0] = PM_SIP_SVC | pm_api_id;
> +	smc_arg[1] = ((u64)arg1 << 32) | arg0;
> +	smc_arg[2] = ((u64)arg3 << 32) | arg2;
> +
> +	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
> +}
> +
> +static u32 pm_api_version;
> +
> +/**
> + * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
> + * @version:	Returned version value
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_api_version(u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!version)
> +		return zynqmp_pm_ret_code(XST_PM_CONFLICT);
> +
> +	/* Check is PM API version already verified */
> +	if (pm_api_version > 0) {
> +		*version = pm_api_version;
> +		return XST_PM_SUCCESS;
> +	}
> +	invoke_pm_fn(GET_API_VERSION, 0, 0, 0, 0, ret_payload);
> +	*version = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_get_chipid - Get silicon ID registers
> + * @idcode:	IDCODE register
> + * @version:	version register
> + *
> + * Return:	Returns the status of the operation and the idcode and version
> + *		registers in @idcode and @version.
> + */
> +static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * get_set_conduit_method - Choose SMC or HVC based communication
> + * @np:	Pointer to the device_node structure
> + *
> + * Use SMC or HVC-based functions to communicate with EL2/EL3
> + */
> +static int get_set_conduit_method(struct device_node *np)
> +{
> +	const char *method;
> +
> +	if (of_property_read_string(np, "method", &method)) {
> +		pr_warn("%s missing \"method\" property\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	if (!strcmp("hvc", method)) {
> +		do_fw_call = do_fw_call_hvc;
> +	} else if (!strcmp("smc", method)) {
> +		do_fw_call = do_fw_call_smc;
> +	} else {
> +		pr_warn("%s Invalid \"method\" property: %s\n",
> +			__func__, method);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
> + * @reset:		Reset to be configured
> + * @assert_flag:	Flag stating should reset be asserted (1) or
> + *			released (0)
> + *
> + * Return:		Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +			   const enum zynqmp_pm_reset_action assert_flag)
> +{
> +	return invoke_pm_fn(RESET_ASSERT, reset, assert_flag, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_reset_get_status - Get status of the reset
> + * @reset:	Reset whose status should be returned
> + * @status:	Returned status
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
> +				      u32 *status)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!status)
> +		return zynqmp_pm_ret_code(XST_PM_CONFLICT);
> +
> +	invoke_pm_fn(RESET_GET_STATUS, reset, 0, 0, 0, ret_payload);
> +	*status = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_fpga_load - Perform the fpga load
> + * @address:    Address to write to
> + * @size:       pl bitstream size
> + * @flags:
> + *	BIT(0) - Bit-stream type.
> + *		 0 - Full Bit-stream.
> + *		 1 - Partial Bit-stream.
> + *	BIT(1) - Authentication.
> + *		 1 - Enable.
> + *		 0 - Disable.
> + *	BIT(2) - Encryption.
> + *		 1 - Enable.
> + *		 0 - Disable.
> + * NOTE -
> + *	The current implementation supports only Full Bit-stream.
> + *
> + * This function provides access to xilfpga library to transfer
> + * the required bitstream into PL.
> + *
> + * Return:      Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
> +			       const u32 flags)
> +{
> +	return invoke_pm_fn(FPGA_LOAD, (u32)address,
> +			    ((u32)(address >> 32)), size, flags, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
> + * @value:      Value to read
> + *
> + *This function provides access to the xilfpga library to get
> + *the PCAP status
> + *
> + * Return:      Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_fpga_get_status(u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
> +	*value = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_request_suspend - PM call to request for another PU or subsystem to
> + *					be suspended gracefully.
> + * @node:	Node ID of the targeted PU or subsystem
> + * @ack:	Flag to specify whether acknowledge is requested
> + * @latency:	Requested wakeup latency (not supported)
> + * @state:	Requested state (not supported)
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_request_suspend(const u32 node,
> +			      const enum zynqmp_pm_request_ack ack,
> +			      const u32 latency,
> +			      const u32 state)
> +{
> +	return invoke_pm_fn(REQUEST_SUSPEND, node, ack,
> +			    latency, state, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
> + *				be powered down forcefully
> + * @target:	Node ID of the targeted PU or subsystem
> + * @ack:	Flag to specify whether acknowledge is requested
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_force_powerdown(const u32 target,
> +				     const enum zynqmp_pm_request_ack ack)
> +{
> +	return invoke_pm_fn(FORCE_POWERDOWN, target, ack, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
> + * @node:	Node ID of the master or subsystem
> + * @set_addr:	Specifies whether the address argument is relevant
> + * @address:	Address from which to resume when woken up
> + * @ack:	Flag to specify whether acknowledge requested
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_request_wakeup(const u32 node,
> +				    const bool set_addr,
> +				    const u64 address,
> +				    const enum zynqmp_pm_request_ack ack)
> +{
> +	/* set_addr flag is encoded into 1st bit of address */
> +	return invoke_pm_fn(REQUEST_WAKEUP, node, address | set_addr,
> +			    address >> 32, ack, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
> + *					while suspended
> + * @target:	Node ID of the targeted PU or subsystem
> + * @wakeup_node:Node ID of the wakeup peripheral
> + * @enable:	Enable or disable the specified peripheral as wake source
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_wakeup_source(const u32 target,
> +				       const u32 wakeup_node,
> +				       const u32 enable)
> +{
> +	return invoke_pm_fn(SET_WAKEUP_SOURCE, target,
> +			    wakeup_node, enable, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
> + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> + * @subtype:	Specifies which system should be restarted or shut down
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
> +{
> +	return invoke_pm_fn(SYSTEM_SHUTDOWN, type, subtype, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_request_node - PM call to request a node with specific capabilities
> + * @node:		Node ID of the slave
> + * @capabilities:	Requested capabilities of the slave
> + * @qos:		Quality of service (not supported)
> + * @ack:		Flag to specify whether acknowledge is requested
> + *
> + * Return:		Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
> +				  const u32 qos,
> +				  const enum zynqmp_pm_request_ack ack)
> +{
> +	return invoke_pm_fn(REQUEST_NODE, node, capabilities,
> +			    qos, ack, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_release_node - PM call to release a node
> + * @node:	Node ID of the slave
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_release_node(const u32 node)
> +{
> +	return invoke_pm_fn(RELEASE_NODE, node, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_set_requirement - PM call to set requirement for PM slaves
> + * @node:		Node ID of the slave
> + * @capabilities:	Requested capabilities of the slave
> + * @qos:		Quality of service (not supported)
> + * @ack:		Flag to specify whether acknowledge is requested
> + *
> + * This API function is to be used for slaves a PU already has requested
> + *
> + * Return:		Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
> +				     const u32 qos,
> +				     const enum zynqmp_pm_request_ack ack)
> +{
> +	return invoke_pm_fn(SET_REQUIREMENT, node, capabilities,
> +			    qos, ack, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_set_max_latency - PM call to set wakeup latency requirements
> + * @node:	Node ID of the slave
> + * @latency:	Requested maximum wakeup latency
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_max_latency(const u32 node, const u32 latency)
> +{
> +	return invoke_pm_fn(SET_MAX_LATENCY, node, latency, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_set_configuration - PM call to set system configuration
> + * @physical_addr:	Physical 32-bit address of data structure in memory
> + *
> + * Return:		Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_configuration(const u32 physical_addr)
> +{
> +	return invoke_pm_fn(SET_CONFIGURATION, physical_addr, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_get_node_status - PM call to request a node's current power state
> + * @node:		ID of the component or sub-system in question
> + * @status:		Current operating state of the requested node
> + * @requirements:	Current requirements asserted on the node,
> + *			used for slave nodes only.
> + * @usage:		Usage information, used for slave nodes only:
> + *			0 - No master is currently using the node
> + *			1 - Only requesting master is currently using the node
> + *			2 - Only other masters are currently using the node
> + *			3 - Both the current and at least one other master
> + *			is currently using the node
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
> +				     u32 *const requirements, u32 *const usage)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(GET_NODE_STATUS, node, 0, 0, 0, ret_payload);
> +	if (ret_payload[0] == XST_PM_SUCCESS) {
> +		*status = ret_payload[1];
> +		if (requirements)
> +			*requirements = ret_payload[2];
> +		if (usage)
> +			*usage = ret_payload[3];
> +	}
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_get_operating_characteristic - PM call to request operating
> + *						characteristic information
> + * @node:	Node ID of the slave
> + * @type:	Type of the operating characteristic requested
> + * @result:	Used to return the requsted operating characteristic
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_operating_characteristic(const u32 node,
> +						const enum zynqmp_pm_opchar_type
> +						type, u32 *const result)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!result)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(GET_OPERATING_CHARACTERISTIC,
> +		     node, type, 0, 0, ret_payload);
> +	if (ret_payload[0] == XST_PM_SUCCESS)
> +		*result = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_init_finalize - PM call to informi firmware that the caller master
> + *				has initialized its own power management
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_init_finalize(void)
> +{
> +	return invoke_pm_fn(PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_get_callback_data - Get callback data from firmware
> + * @buf:	Buffer to store payload data
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_get_callback_data(u32 *buf)
> +{
> +	return invoke_pm_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> +}
> +
> +/**
> + * zynqmp_pm_set_suspend_mode	- Set system suspend mode
> + *
> + * @mode:	Mode to set for system suspend
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_suspend_mode(u32 mode)
> +{
> +	return invoke_pm_fn(SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
> + * @address:	Address of the data/ Address of output buffer where
> + *		hash should be stored.
> + * @size:	Size of the data.
> + * @flags:
> + *	BIT(0) - Sha3 init (Here address and size inputs can be NULL)
> + *	BIT(1) - Sha3 update (address should holds the )
> + *	BIT(2) - Sha3 final (address should hold the address of
> + *		 buffer to store hash)
> + *
> + * Return:	Returns status, either success or error code.
> + */
> +static int zynqmp_pm_sha_hash(const u64 address, const u32 size,
> +			      const u32 flags)
> +{
> +	u32 lower_32_bits = (u32)address;
> +	u32 upper_32_bits = (u32)(address >> 32);
> +
> +	return invoke_pm_fn(SECURE_SHA, upper_32_bits, lower_32_bits,
> +			    size, flags, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_rsa - Access RSA hardware to encrypt/decrypt the data with RSA.
> + * @address:	Address of the data
> + * @size:	Size of the data.
> + * @flags:
> + *		BIT(0) - Encryption/Decryption
> + *			 0 - RSA decryption with private key
> + *			 1 - RSA encryption with public key.
> + *
> + * Return:	Returns status, either success or error code.
> + */
> +static int zynqmp_pm_rsa(const u64 address, const u32 size, const u32 flags)
> +{
> +	u32 lower_32_bits = (u32)address;
> +	u32 upper_32_bits = (u32)(address >> 32);
> +
> +	return invoke_pm_fn(SECURE_RSA, upper_32_bits, lower_32_bits,
> +			    size, flags, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> + * @pin:	Pin number to request
> + *
> + * This function requests pin from firmware.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_pinctrl_request(const u32 pin)
> +{
> +	return invoke_pm_fn(PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_release - Inform firmware that Pin control is released
> + * @pin:	Pin number to release
> + *
> + * This function release pin from firmware.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_pinctrl_release(const u32 pin)
> +{
> +	return invoke_pm_fn(PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_get_function() - Read function id set for the given pin
> + * @pin:	Pin number
> + * @node:	Buffer to store node ID matching current function
> + *
> + * This function provides the function currently set for the given pin.
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *node)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(PINCTRL_GET_FUNCTION, pin, 0, 0, 0, ret_payload);
> +	*node = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_set_function - Set requested function for the pin
> + * @pin:	Pin number
> + * @node:	Node ID mapped with the requested function
> + *
> + * This function sets requested function for the given pin.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 node)
> +{
> +	return invoke_pm_fn(PINCTRL_SET_FUNCTION, pin, node, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_get_config - Get configuration parameter for the pin
> + * @pin:	Pin number
> + * @param:	Parameter to get
> + * @value:	Buffer to store parameter value
> + *
> + * This function gets requested configuration parameter for the given pin.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
> +					u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(PINCTRL_CONFIG_PARAM_GET, pin,
> +		     param, 0, 0, ret_payload);
> +	*value = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_pinctrl_set_config - Set configuration parameter for the pin
> + * @pin:	Pin number
> + * @param:	Parameter to set
> + * @value:	Parameter value to set
> + *
> + * This function sets requested configuration parameter for the given pin.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
> +					u32 value)
> +{
> +	return invoke_pm_fn(PINCTRL_CONFIG_PARAM_SET, pin,
> +			    param, value, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_ioctl - PM IOCTL API for device control and configs
> + * @node_id:	Node ID of the device
> + * @ioctl_id:	ID of the requested IOCTL
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * This function calls IOCTL to firmware for device control and configuration.
> + */
> +static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> +			   u32 *out)
> +{
> +	return invoke_pm_fn(IOCTL, node_id, ioctl_id, arg1, arg2, out);
> +}
> +
> +static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
> +{
> +	return invoke_pm_fn(QUERY_DATA, qdata.qid, qdata.arg1,
> +			    qdata.arg2, qdata.arg3, out);
> +}
> +
> +/**
> + * zynqmp_pm_clock_enable - Enable the clock for given id
> + * @clock_id:	ID of the clock to be enabled
> + *
> + * This function is used by master to enable the clock
> + * including peripherals and PLL clocks.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_enable(u32 clock_id)
> +{
> +	return invoke_pm_fn(CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_clock_disable - Disable the clock for given id
> + * @clock_id:	ID of the clock to be disable
> + *
> + * This function is used by master to disable the clock
> + * including peripherals and PLL clocks.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_disable(u32 clock_id)
> +{
> +	return invoke_pm_fn(CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_clock_getstate - Get the clock state for given id
> + * @clock_id:	ID of the clock to be queried
> + * @state:	1/0 (Enabled/Disabled)
> + *
> + * This function is used by master to get the state of clock
> + * including peripherals and PLL clocks.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	invoke_pm_fn(CLOCK_GETSTATE, clock_id, 0, 0, 0, ret_payload);
> +	*state = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_clock_setdivider - Set the clock divider for given id
> + * @clock_id:	ID of the clock
> + * @div_type:	TYPE_DIV1: div1
> + *		TYPE_DIV2: div2
> + * @divider:	divider value.
> + *
> + * This function is used by master to set divider for any clock
> + * to achieve desired rate.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
> +{
> +	return invoke_pm_fn(CLOCK_SETDIVIDER, clock_id, divider, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_clock_getdivider - Get the clock divider for given id
> + * @clock_id:	ID of the clock
> + * @div_type:	TYPE_DIV1: div1
> + *		TYPE_DIV2: div2
> + * @divider:	divider value.
> + *
> + * This function is used by master to get divider values
> + * for any clock.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	invoke_pm_fn(CLOCK_GETDIVIDER, clock_id, 0, 0, 0, ret_payload);
> +	*divider = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_clock_setrate - Set the clock rate for given id
> + * @clock_id:	ID of the clock
> + * @rate:	rate value in hz
> + *
> + * This function is used by master to set rate for any clock.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_setrate(u32 clock_id, u32 rate)
> +{
> +	return invoke_pm_fn(CLOCK_SETRATE, clock_id, rate, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_clock_getrate - Get the clock rate for given id
> + * @clock_id:	ID of the clock
> + * @rate:	rate value in hz
> + *
> + * This function is used by master to get rate
> + * for any clock.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_getrate(u32 clock_id, u32 *rate)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	invoke_pm_fn(CLOCK_GETRATE, clock_id, 0, 0, 0, ret_payload);
> +	*rate = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +/**
> + * zynqmp_pm_clock_setparent - Set the clock parent for given id
> + * @clock_id:	ID of the clock
> + * @parent_id:	parent id
> + *
> + * This function is used by master to set parent for any clock.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
> +{
> +	return invoke_pm_fn(CLOCK_SETPARENT, clock_id, parent_id, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_clock_getparent - Get the clock parent for given id
> + * @clock_id:	ID of the clock
> + * @parent_id:	parent id
> + *
> + * This function is used by master to get parent index
> + * for any clock.
> + *
> + * Return:	Returns status, either success or error+reason.
> + */
> +static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	invoke_pm_fn(CLOCK_GETPARENT, clock_id, 0, 0, 0, ret_payload);
> +	*parent_id = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +
> +static const struct zynqmp_eemi_ops eemi_ops  = {
> +	.get_api_version = zynqmp_pm_get_api_version,
> +	.get_chipid = zynqmp_pm_get_chipid,
> +	.reset_assert = zynqmp_pm_reset_assert,
> +	.reset_get_status = zynqmp_pm_reset_get_status,
> +	.fpga_load = zynqmp_pm_fpga_load,
> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
> +	.sha_hash = zynqmp_pm_sha_hash,
> +	.rsa = zynqmp_pm_rsa,
> +	.request_suspend = zynqmp_pm_request_suspend,
> +	.force_powerdown = zynqmp_pm_force_powerdown,
> +	.request_wakeup = zynqmp_pm_request_wakeup,
> +	.set_wakeup_source = zynqmp_pm_set_wakeup_source,
> +	.system_shutdown = zynqmp_pm_system_shutdown,
> +	.request_node = zynqmp_pm_request_node,
> +	.release_node = zynqmp_pm_release_node,
> +	.set_requirement = zynqmp_pm_set_requirement,
> +	.set_max_latency = zynqmp_pm_set_max_latency,
> +	.set_configuration = zynqmp_pm_set_configuration,
> +	.get_node_status = zynqmp_pm_get_node_status,
> +	.get_operating_characteristic = zynqmp_pm_get_operating_characteristic,
> +	.init_finalize = zynqmp_pm_init_finalize,
> +	.get_callback_data = zynqmp_pm_get_callback_data,
> +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
> +	.ioctl = zynqmp_pm_ioctl,
> +	.query_data = zynqmp_pm_query_data,
> +	.pinctrl_request = zynqmp_pm_pinctrl_request,
> +	.pinctrl_release = zynqmp_pm_pinctrl_release,
> +	.pinctrl_get_function = zynqmp_pm_pinctrl_get_function,
> +	.pinctrl_set_function = zynqmp_pm_pinctrl_set_function,
> +	.pinctrl_get_config = zynqmp_pm_pinctrl_get_config,
> +	.pinctrl_set_config = zynqmp_pm_pinctrl_set_config,
> +	.clock_enable = zynqmp_pm_clock_enable,
> +	.clock_disable = zynqmp_pm_clock_disable,
> +	.clock_getstate = zynqmp_pm_clock_getstate,
> +	.clock_setdivider = zynqmp_pm_clock_setdivider,
> +	.clock_getdivider = zynqmp_pm_clock_getdivider,
> +	.clock_setrate = zynqmp_pm_clock_setrate,
> +	.clock_getrate = zynqmp_pm_clock_getrate,
> +	.clock_setparent = zynqmp_pm_clock_setparent,
> +	.clock_getparent = zynqmp_pm_clock_getparent,
> +};
> +
> +/**
> + * get_eemi_ops	- Get eemi ops functions
> + *
> + * Return:	- pointer of eemi_ops structure
> + */
> +const struct zynqmp_eemi_ops *get_eemi_ops(void)
> +{
> +	return &eemi_ops;
> +}
> +EXPORT_SYMBOL_GPL(get_eemi_ops);
> +
> +static int __init zynqmp_plat_init(void)
> +{
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> +	if (!np)
> +		return 0;
> +	of_node_put(np);
> +
> +	/* We're running on a ZynqMP machine, the PM node is mandatory. */
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
> +	if (!np) {
> +		pr_warn("%s: pm node not found\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	ret = get_set_conduit_method(np);
> +	if (ret) {
> +		of_node_put(np);
> +		return ret;
> +	}
> +
> +	/* Check PM API version number */
> +	zynqmp_pm_get_api_version(&pm_api_version);
> +	if (pm_api_version != ZYNQMP_PM_VERSION) {
> +		panic("%s power management API version error. Expected: v%d.%d - Found: v%d.%d\n",
> +		      __func__,
> +		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
> +		      pm_api_version >> 16, pm_api_version & 0xffff);
> +	}
> +
> +	pr_info("%s Power management API v%d.%d\n", __func__,
> +		ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR);
> +
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id firmware_of_match[] = {
> +	{ .compatible = "xlnx,zynqmp-firmware", },
> +	{ /* end of table */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, firmware_of_match);
> +
> +static int zynqmp_firmware_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = zynqmp_pm_api_debugfs_init();
> +	if (ret) {
> +		pr_err("%s() debugfs init fail with error %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	zynqmp_pm_ggs_init(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver zynqmp_firmware_platform_driver = {
> +	.probe   = zynqmp_firmware_probe,
> +	.driver  = {
> +			.name             = DRIVER_NAME,
> +			.of_match_table   = firmware_of_match,
> +		   },
> +};
> +builtin_platform_driver(zynqmp_firmware_platform_driver);
> +
> +early_initcall(zynqmp_plat_init);
> diff --git a/include/linux/firmware/xilinx/zynqmp/firmware-debug.h b/include/linux/firmware/xilinx/zynqmp/firmware-debug.h
> new file mode 100644
> index 0000000..a388621
> --- /dev/null
> +++ b/include/linux/firmware/xilinx/zynqmp/firmware-debug.h
> @@ -0,0 +1,32 @@
> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2017 Xilinx
> + *
> + *  Michal Simek <michal.simek@xilinx.com>
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#ifndef __SOC_ZYNQMP_FIRMWARE_DEBUG_H__
> +#define __SOC_ZYNQMP_FIRMWARE_DEBUG_H__
> +
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +int zynqmp_pm_self_suspend(const u32 node,
> +			   const u32 latency,
> +			   const u32 state);
> +int zynqmp_pm_abort_suspend(const enum zynqmp_pm_abort_reason reason);
> +int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +				const u32 wake, const u32 enable);
> +
> +#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
> +int zynqmp_pm_api_debugfs_init(void);
> +#else
> +static inline int zynqmp_pm_api_debugfs_init(void) { return 0; }
> +#endif
> +
> +#endif /* __SOC_ZYNQMP_FIRMWARE_DEBUG_H__ */
> diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
> new file mode 100644
> index 0000000..2088b15
> --- /dev/null
> +++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
> @@ -0,0 +1,573 @@
> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2017 Xilinx
> + *
> + *  Michal Simek <michal.simek@xilinx.com>
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#ifndef __SOC_ZYNQMP_FIRMWARE_H__
> +#define __SOC_ZYNQMP_FIRMWARE_H__
> +
> +#include <linux/device.h>
> +
> +#define ZYNQMP_PM_VERSION_MAJOR	1
> +#define ZYNQMP_PM_VERSION_MINOR	0
> +
> +#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
> +					ZYNQMP_PM_VERSION_MINOR)
> +
> +#define ZYNQMP_PM_MAX_LATENCY	(~0U)
> +#define ZYNQMP_PM_MAX_QOS	100U
> +
> +/* SMC SIP service Call Function Identifier Prefix */
> +#define PM_SIP_SVC	0xC2000000
> +#define GET_CALLBACK_DATA 0xa01
> +#define SET_SUSPEND_MODE  0xa02
> +
> +/* Number of 32bits values in payload */
> +#define PAYLOAD_ARG_CNT	5U
> +
> +/* Number of arguments for a callback */
> +#define CB_ARG_CNT	4
> +
> +/* Payload size (consists of callback API ID + arguments) */
> +#define CB_PAYLOAD_SIZE	(CB_ARG_CNT + 1)
> +
> +/* Global general storage register base address */
> +#define GGS_BASEADDR	(0xFFD80030U)
> +#define GSS_NUM_REGS	(4)
> +
> +/* Persistent global general storage register base address */
> +#define PGGS_BASEADDR	(0xFFD80050U)
> +#define PGSS_NUM_REGS	(4)
> +
> +/* Capabilities for RAM */
> +#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
> +#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
> +#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
> +#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
> +
> +/* Clock APIs payload parameters */
> +#define CLK_GET_NAME_RESP_LEN				16
> +#define CLK_GET_TOPOLOGY_RESP_WORDS			3
> +#define CLK_GET_FIXEDFACTOR_RESP_WORDS			2
> +#define CLK_GET_PARENTS_RESP_WORDS			3
> +#define CLK_GET_ATTR_RESP_WORDS				1
> +
> +enum pm_api_id {
> +	/* Miscellaneous API functions: */
> +	GET_API_VERSION = 1,
> +	SET_CONFIGURATION,
> +	GET_NODE_STATUS,
> +	GET_OPERATING_CHARACTERISTIC,
> +	REGISTER_NOTIFIER,
> +	/* API for suspending of PUs: */
> +	REQUEST_SUSPEND,
> +	SELF_SUSPEND,
> +	FORCE_POWERDOWN,
> +	ABORT_SUSPEND,
> +	REQUEST_WAKEUP,
> +	SET_WAKEUP_SOURCE,
> +	SYSTEM_SHUTDOWN,
> +	/* API for managing PM slaves: */
> +	REQUEST_NODE,
> +	RELEASE_NODE,
> +	SET_REQUIREMENT,
> +	SET_MAX_LATENCY,
> +	/* Direct control API functions: */
> +	RESET_ASSERT,
> +	RESET_GET_STATUS,
> +	MMIO_WRITE,
> +	MMIO_READ,
> +	PM_INIT_FINALIZE,
> +	FPGA_LOAD,
> +	FPGA_GET_STATUS,
> +	GET_CHIPID,
> +	/* ID 25 is been used by U-boot to process secure boot images */
> +	/* Secure library generic API functions */
> +	SECURE_SHA = 26,
> +	SECURE_RSA,
> +	/* Pin control API functions */
> +	PINCTRL_REQUEST,
> +	PINCTRL_RELEASE,
> +	PINCTRL_GET_FUNCTION,
> +	PINCTRL_SET_FUNCTION,
> +	PINCTRL_CONFIG_PARAM_GET,
> +	PINCTRL_CONFIG_PARAM_SET,
> +	/* PM IOCTL API */
> +	IOCTL,
> +	/* API to query information from firmware */
> +	QUERY_DATA,
> +	/* Clock control API functions */
> +	CLOCK_ENABLE,
> +	CLOCK_DISABLE,
> +	CLOCK_GETSTATE,
> +	CLOCK_SETDIVIDER,
> +	CLOCK_GETDIVIDER,
> +	CLOCK_SETRATE,
> +	CLOCK_GETRATE,
> +	CLOCK_SETPARENT,
> +	CLOCK_GETPARENT,
> +};
> +
> +/* PMU-FW return status codes */
> +enum pm_ret_status {
> +	XST_PM_SUCCESS = 0,
> +	XST_PM_INTERNAL	= 2000,
> +	XST_PM_CONFLICT,
> +	XST_PM_NO_ACCESS,
> +	XST_PM_INVALID_NODE,
> +	XST_PM_DOUBLE_REQ,
> +	XST_PM_ABORT_SUSPEND,
> +};
> +
> +enum zynqmp_pm_reset_action {
> +	PM_RESET_ACTION_RELEASE,
> +	PM_RESET_ACTION_ASSERT,
> +	PM_RESET_ACTION_PULSE,
> +};
> +
> +enum zynqmp_pm_reset {
> +	ZYNQMP_PM_RESET_START = 999,
> +	ZYNQMP_PM_RESET_PCIE_CFG,
> +	ZYNQMP_PM_RESET_PCIE_BRIDGE,
> +	ZYNQMP_PM_RESET_PCIE_CTRL,
> +	ZYNQMP_PM_RESET_DP,
> +	ZYNQMP_PM_RESET_SWDT_CRF,
> +	ZYNQMP_PM_RESET_AFI_FM5,
> +	ZYNQMP_PM_RESET_AFI_FM4,
> +	ZYNQMP_PM_RESET_AFI_FM3,
> +	ZYNQMP_PM_RESET_AFI_FM2,
> +	ZYNQMP_PM_RESET_AFI_FM1,
> +	ZYNQMP_PM_RESET_AFI_FM0,
> +	ZYNQMP_PM_RESET_GDMA,
> +	ZYNQMP_PM_RESET_GPU_PP1,
> +	ZYNQMP_PM_RESET_GPU_PP0,
> +	ZYNQMP_PM_RESET_GPU,
> +	ZYNQMP_PM_RESET_GT,
> +	ZYNQMP_PM_RESET_SATA,
> +	ZYNQMP_PM_RESET_ACPU3_PWRON,
> +	ZYNQMP_PM_RESET_ACPU2_PWRON,
> +	ZYNQMP_PM_RESET_ACPU1_PWRON,
> +	ZYNQMP_PM_RESET_ACPU0_PWRON,
> +	ZYNQMP_PM_RESET_APU_L2,
> +	ZYNQMP_PM_RESET_ACPU3,
> +	ZYNQMP_PM_RESET_ACPU2,
> +	ZYNQMP_PM_RESET_ACPU1,
> +	ZYNQMP_PM_RESET_ACPU0,
> +	ZYNQMP_PM_RESET_DDR,
> +	ZYNQMP_PM_RESET_APM_FPD,
> +	ZYNQMP_PM_RESET_SOFT,
> +	ZYNQMP_PM_RESET_GEM0,
> +	ZYNQMP_PM_RESET_GEM1,
> +	ZYNQMP_PM_RESET_GEM2,
> +	ZYNQMP_PM_RESET_GEM3,
> +	ZYNQMP_PM_RESET_QSPI,
> +	ZYNQMP_PM_RESET_UART0,
> +	ZYNQMP_PM_RESET_UART1,
> +	ZYNQMP_PM_RESET_SPI0,
> +	ZYNQMP_PM_RESET_SPI1,
> +	ZYNQMP_PM_RESET_SDIO0,
> +	ZYNQMP_PM_RESET_SDIO1,
> +	ZYNQMP_PM_RESET_CAN0,
> +	ZYNQMP_PM_RESET_CAN1,
> +	ZYNQMP_PM_RESET_I2C0,
> +	ZYNQMP_PM_RESET_I2C1,
> +	ZYNQMP_PM_RESET_TTC0,
> +	ZYNQMP_PM_RESET_TTC1,
> +	ZYNQMP_PM_RESET_TTC2,
> +	ZYNQMP_PM_RESET_TTC3,
> +	ZYNQMP_PM_RESET_SWDT_CRL,
> +	ZYNQMP_PM_RESET_NAND,
> +	ZYNQMP_PM_RESET_ADMA,
> +	ZYNQMP_PM_RESET_GPIO,
> +	ZYNQMP_PM_RESET_IOU_CC,
> +	ZYNQMP_PM_RESET_TIMESTAMP,
> +	ZYNQMP_PM_RESET_RPU_R50,
> +	ZYNQMP_PM_RESET_RPU_R51,
> +	ZYNQMP_PM_RESET_RPU_AMBA,
> +	ZYNQMP_PM_RESET_OCM,
> +	ZYNQMP_PM_RESET_RPU_PGE,
> +	ZYNQMP_PM_RESET_USB0_CORERESET,
> +	ZYNQMP_PM_RESET_USB1_CORERESET,
> +	ZYNQMP_PM_RESET_USB0_HIBERRESET,
> +	ZYNQMP_PM_RESET_USB1_HIBERRESET,
> +	ZYNQMP_PM_RESET_USB0_APB,
> +	ZYNQMP_PM_RESET_USB1_APB,
> +	ZYNQMP_PM_RESET_IPI,
> +	ZYNQMP_PM_RESET_APM_LPD,
> +	ZYNQMP_PM_RESET_RTC,
> +	ZYNQMP_PM_RESET_SYSMON,
> +	ZYNQMP_PM_RESET_AFI_FM6,
> +	ZYNQMP_PM_RESET_LPD_SWDT,
> +	ZYNQMP_PM_RESET_FPD,
> +	ZYNQMP_PM_RESET_RPU_DBG1,
> +	ZYNQMP_PM_RESET_RPU_DBG0,
> +	ZYNQMP_PM_RESET_DBG_LPD,
> +	ZYNQMP_PM_RESET_DBG_FPD,
> +	ZYNQMP_PM_RESET_APLL,
> +	ZYNQMP_PM_RESET_DPLL,
> +	ZYNQMP_PM_RESET_VPLL,
> +	ZYNQMP_PM_RESET_IOPLL,
> +	ZYNQMP_PM_RESET_RPLL,
> +	ZYNQMP_PM_RESET_GPO3_PL_0,
> +	ZYNQMP_PM_RESET_GPO3_PL_1,
> +	ZYNQMP_PM_RESET_GPO3_PL_2,
> +	ZYNQMP_PM_RESET_GPO3_PL_3,
> +	ZYNQMP_PM_RESET_GPO3_PL_4,
> +	ZYNQMP_PM_RESET_GPO3_PL_5,
> +	ZYNQMP_PM_RESET_GPO3_PL_6,
> +	ZYNQMP_PM_RESET_GPO3_PL_7,
> +	ZYNQMP_PM_RESET_GPO3_PL_8,
> +	ZYNQMP_PM_RESET_GPO3_PL_9,
> +	ZYNQMP_PM_RESET_GPO3_PL_10,
> +	ZYNQMP_PM_RESET_GPO3_PL_11,
> +	ZYNQMP_PM_RESET_GPO3_PL_12,
> +	ZYNQMP_PM_RESET_GPO3_PL_13,
> +	ZYNQMP_PM_RESET_GPO3_PL_14,
> +	ZYNQMP_PM_RESET_GPO3_PL_15,
> +	ZYNQMP_PM_RESET_GPO3_PL_16,
> +	ZYNQMP_PM_RESET_GPO3_PL_17,
> +	ZYNQMP_PM_RESET_GPO3_PL_18,
> +	ZYNQMP_PM_RESET_GPO3_PL_19,
> +	ZYNQMP_PM_RESET_GPO3_PL_20,
> +	ZYNQMP_PM_RESET_GPO3_PL_21,
> +	ZYNQMP_PM_RESET_GPO3_PL_22,
> +	ZYNQMP_PM_RESET_GPO3_PL_23,
> +	ZYNQMP_PM_RESET_GPO3_PL_24,
> +	ZYNQMP_PM_RESET_GPO3_PL_25,
> +	ZYNQMP_PM_RESET_GPO3_PL_26,
> +	ZYNQMP_PM_RESET_GPO3_PL_27,
> +	ZYNQMP_PM_RESET_GPO3_PL_28,
> +	ZYNQMP_PM_RESET_GPO3_PL_29,
> +	ZYNQMP_PM_RESET_GPO3_PL_30,
> +	ZYNQMP_PM_RESET_GPO3_PL_31,
> +	ZYNQMP_PM_RESET_RPU_LS,
> +	ZYNQMP_PM_RESET_PS_ONLY,
> +	ZYNQMP_PM_RESET_PL,
> +	ZYNQMP_PM_RESET_END
> +};
> +
> +enum zynqmp_pm_request_ack {
> +	ZYNQMP_PM_REQUEST_ACK_NO = 1,
> +	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
> +	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
> +};
> +
> +enum zynqmp_pm_abort_reason {
> +	ZYNQMP_PM_ABORT_REASON_WAKEUP_EVENT = 100,
> +	ZYNQMP_PM_ABORT_REASON_POWER_UNIT_BUSY,
> +	ZYNQMP_PM_ABORT_REASON_NO_POWERDOWN,
> +	ZYNQMP_PM_ABORT_REASON_UNKNOWN,
> +};
> +
> +enum zynqmp_pm_suspend_reason {
> +	ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST = 201,
> +	ZYNQMP_PM_SUSPEND_REASON_ALERT,
> +	ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN,
> +};
> +
> +enum zynqmp_pm_ram_state {
> +	ZYNQMP_PM_RAM_STATE_OFF = 1,
> +	ZYNQMP_PM_RAM_STATE_RETENTION,
> +	ZYNQMP_PM_RAM_STATE_ON,
> +};
> +
> +enum zynqmp_pm_opchar_type {
> +	ZYNQMP_PM_OPERATING_CHARACTERISTIC_POWER = 1,
> +	ZYNQMP_PM_OPERATING_CHARACTERISTIC_ENERGY,
> +	ZYNQMP_PM_OPERATING_CHARACTERISTIC_TEMPERATURE,
> +};
> +
> +enum pm_node_id {
> +	NODE_UNKNOWN = 0,
> +	NODE_APU,
> +	NODE_APU_0,
> +	NODE_APU_1,
> +	NODE_APU_2,
> +	NODE_APU_3,
> +	NODE_RPU,
> +	NODE_RPU_0,
> +	NODE_RPU_1,
> +	NODE_PLD,
> +	NODE_FPD,
> +	NODE_OCM_BANK_0,
> +	NODE_OCM_BANK_1,
> +	NODE_OCM_BANK_2,
> +	NODE_OCM_BANK_3,
> +	NODE_TCM_0_A,
> +	NODE_TCM_0_B,
> +	NODE_TCM_1_A,
> +	NODE_TCM_1_B,
> +	NODE_L2,
> +	NODE_GPU_PP_0,
> +	NODE_GPU_PP_1,
> +	NODE_USB_0,
> +	NODE_USB_1,
> +	NODE_TTC_0,
> +	NODE_TTC_1,
> +	NODE_TTC_2,
> +	NODE_TTC_3,
> +	NODE_SATA,
> +	NODE_ETH_0,
> +	NODE_ETH_1,
> +	NODE_ETH_2,
> +	NODE_ETH_3,
> +	NODE_UART_0,
> +	NODE_UART_1,
> +	NODE_SPI_0,
> +	NODE_SPI_1,
> +	NODE_I2C_0,
> +	NODE_I2C_1,
> +	NODE_SD_0,
> +	NODE_SD_1,
> +	NODE_DP,
> +	NODE_GDMA,
> +	NODE_ADMA,
> +	NODE_NAND,
> +	NODE_QSPI,
> +	NODE_GPIO,
> +	NODE_CAN_0,
> +	NODE_CAN_1,
> +	NODE_EXTERN,
> +	NODE_APLL,
> +	NODE_VPLL,
> +	NODE_DPLL,
> +	NODE_RPLL,
> +	NODE_IOPLL,
> +	NODE_DDR,
> +	NODE_IPI_APU,
> +	NODE_IPI_RPU_0,
> +	NODE_GPU,
> +	NODE_PCIE,
> +	NODE_PCAP,
> +	NODE_RTC,
> +	NODE_LPD,
> +	NODE_VCU,
> +	NODE_IPI_RPU_1,
> +	NODE_IPI_PL_0,
> +	NODE_IPI_PL_1,
> +	NODE_IPI_PL_2,
> +	NODE_IPI_PL_3,
> +	NODE_PL,
> +	NODE_GEM_TSU,
> +	NODE_SWDT_0,
> +	NODE_SWDT_1,
> +	NODE_CSU,
> +	NODE_PJTAG,
> +	NODE_TRACE,
> +	NODE_TESTSCAN,
> +	NODE_PMU,
> +	NODE_MAX,
> +};
> +
> +enum pm_pinctrl_config_param {
> +	PM_PINCTRL_CONFIG_SLEW_RATE,
> +	PM_PINCTRL_CONFIG_BIAS_STATUS,
> +	PM_PINCTRL_CONFIG_PULL_CTRL,
> +	PM_PINCTRL_CONFIG_SCHMITT_CMOS,
> +	PM_PINCTRL_CONFIG_DRIVE_STRENGTH,
> +	PM_PINCTRL_CONFIG_VOLTAGE_STATUS,
> +	PM_PINCTRL_CONFIG_MAX,
> +};
> +
> +enum pm_pinctrl_slew_rate {
> +	PM_PINCTRL_SLEW_RATE_FAST,
> +	PM_PINCTRL_SLEW_RATE_SLOW,
> +};
> +
> +enum pm_pinctrl_bias_status {
> +	PM_PINCTRL_BIAS_DISABLE,
> +	PM_PINCTRL_BIAS_ENABLE,
> +};
> +
> +enum pm_pinctrl_pull_ctrl {
> +	PM_PINCTRL_BIAS_PULL_DOWN,
> +	PM_PINCTRL_BIAS_PULL_UP,
> +};
> +
> +enum pm_pinctrl_schmitt_cmos {
> +	PM_PINCTRL_INPUT_TYPE_CMOS,
> +	PM_PINCTRL_INPUT_TYPE_SCHMITT,
> +};
> +
> +enum pm_pinctrl_drive_strength {
> +	PM_PINCTRL_DRIVE_STRENGTH_2MA,
> +	PM_PINCTRL_DRIVE_STRENGTH_4MA,
> +	PM_PINCTRL_DRIVE_STRENGTH_8MA,
> +	PM_PINCTRL_DRIVE_STRENGTH_12MA,
> +};
> +
> +enum pm_ioctl_id {
> +	IOCTL_GET_RPU_OPER_MODE,
> +	IOCTL_SET_RPU_OPER_MODE,
> +	IOCTL_RPU_BOOT_ADDR_CONFIG,
> +	IOCTL_TCM_COMB_CONFIG,
> +	IOCTL_SET_TAPDELAY_BYPASS,
> +	IOCTL_SET_SGMII_MODE,
> +	IOCTL_SD_DLL_RESET,
> +	IOCTL_SET_SD_TAPDELAY,
> +	/* Ioctl for clock driver */
> +	IOCTL_SET_PLL_FRAC_MODE,
> +	IOCTL_GET_PLL_FRAC_MODE,
> +	IOCTL_SET_PLL_FRAC_DATA,
> +	IOCTL_GET_PLL_FRAC_DATA,
> +	IOCTL_WRITE_GGS,
> +	IOCTL_READ_GGS,
> +	IOCTL_WRITE_PGGS,
> +	IOCTL_READ_PGGS,
> +};
> +
> +enum rpu_oper_mode {
> +	PM_RPU_MODE_LOCKSTEP,
> +	PM_RPU_MODE_SPLIT,
> +};
> +
> +enum rpu_boot_mem {
> +	PM_RPU_BOOTMEM_LOVEC,
> +	PM_RPU_BOOTMEM_HIVEC,
> +};
> +
> +enum rpu_tcm_comb {
> +	PM_RPU_TCM_SPLIT,
> +	PM_RPU_TCM_COMB,
> +};
> +
> +enum tap_delay_signal_type {
> +	PM_TAPDELAY_NAND_DQS_IN,
> +	PM_TAPDELAY_NAND_DQS_OUT,
> +	PM_TAPDELAY_QSPI,
> +	PM_TAPDELAY_MAX,
> +};
> +
> +enum tap_delay_bypass_ctrl {
> +	PM_TAPDELAY_BYPASS_DISABLE,
> +	PM_TAPDELAY_BYPASS_ENABLE,
> +};
> +
> +enum sgmii_mode {
> +	PM_SGMII_DISABLE,
> +	PM_SGMII_ENABLE,
> +};
> +
> +enum tap_delay_type {
> +	PM_TAPDELAY_INPUT,
> +	PM_TAPDELAY_OUTPUT,
> +};
> +
> +enum dll_reset_type {
> +	PM_DLL_RESET_ASSERT,
> +	PM_DLL_RESET_RELEASE,
> +	PM_DLL_RESET_PULSE,
> +};
> +
> +enum topology_type {
> +	TYPE_INVALID,
> +	TYPE_MUX,
> +	TYPE_PLL,
> +	TYPE_FIXEDFACTOR,
> +	TYPE_DIV1,
> +	TYPE_DIV2,
> +	TYPE_GATE,
> +};
> +
> +enum pm_query_id {
> +	PM_QID_INVALID,
> +	PM_QID_CLOCK_GET_NAME,
> +	PM_QID_CLOCK_GET_TOPOLOGY,
> +	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
> +	PM_QID_CLOCK_GET_PARENTS,
> +	PM_QID_CLOCK_GET_ATTRIBUTES,
> +};
> +
> +struct zynqmp_pm_query_data {
> +	u32 qid;
> +	u32 arg1;
> +	u32 arg2;
> +	u32 arg3;
> +};
> +
> +struct zynqmp_eemi_ops {
> +	int (*get_api_version)(u32 *version);
> +	int (*get_chipid)(u32 *idcode, u32 *version);
> +	int (*reset_assert)(const enum zynqmp_pm_reset reset,
> +			    const enum zynqmp_pm_reset_action assert_flag);
> +	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
> +	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
> +	int (*fpga_get_status)(u32 *value);
> +	int (*sha_hash)(const u64 address, const u32 size, const u32 flags);
> +	int (*rsa)(const u64 address, const u32 size, const u32 flags);
> +	int (*request_suspend)(const u32 node,
> +			       const enum zynqmp_pm_request_ack ack,
> +			       const u32 latency,
> +			       const u32 state);
> +	int (*force_powerdown)(const u32 target,
> +			       const enum zynqmp_pm_request_ack ack);
> +	int (*request_wakeup)(const u32 node,
> +			      const bool set_addr,
> +			      const u64 address,
> +			      const enum zynqmp_pm_request_ack ack);
> +	int (*set_wakeup_source)(const u32 target,
> +				 const u32 wakeup_node,
> +				 const u32 enable);
> +	int (*system_shutdown)(const u32 type, const u32 subtype);
> +	int (*request_node)(const u32 node,
> +			    const u32 capabilities,
> +			    const u32 qos,
> +			    const enum zynqmp_pm_request_ack ack);
> +	int (*release_node)(const u32 node);
> +	int (*set_requirement)(const u32 node,
> +			       const u32 capabilities,
> +			       const u32 qos,
> +			       const enum zynqmp_pm_request_ack ack);
> +	int (*set_max_latency)(const u32 node, const u32 latency);
> +	int (*set_configuration)(const u32 physical_addr);
> +	int (*get_node_status)(const u32 node, u32 *const status,
> +			       u32 *const requirements, u32 *const usage);
> +	int (*get_operating_characteristic)(const u32 node,
> +					    const enum zynqmp_pm_opchar_type
> +					    type, u32 *const result);
> +	int (*init_finalize)(void);
> +	int (*get_callback_data)(u32 *buf);
> +	int (*set_suspend_mode)(u32 mode);
> +	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
> +	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
> +	int (*pinctrl_request)(const u32 pin);
> +	int (*pinctrl_release)(const u32 pin);
> +	int (*pinctrl_get_function)(const u32 pin, u32 *node);
> +	int (*pinctrl_set_function)(const u32 pin, const u32 node);
> +	int (*pinctrl_get_config)(const u32 pin, const u32 param, u32 *value);
> +	int (*pinctrl_set_config)(const u32 pin, const u32 param, u32 value);
> +	int (*clock_enable)(u32 clock_id);
> +	int (*clock_disable)(u32 clock_id);
> +	int (*clock_getstate)(u32 clock_id, u32 *state);
> +	int (*clock_setdivider)(u32 clock_id, u32 divider);
> +	int (*clock_getdivider)(u32 clock_id, u32 *divider);
> +	int (*clock_setrate)(u32 clock_id, u32 rate);
> +	int (*clock_getrate)(u32 clock_id, u32 *rate);
> +	int (*clock_setparent)(u32 clock_id, u32 parent_id);
> +	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
> +};
> +
> +/*
> + * Internal functions
> + */
> +int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
> +		 u32 *ret_payload);
> +int zynqmp_pm_ret_code(u32 ret_status);
> +
> +void zynqmp_pm_ggs_init(struct device *dev);
> +
> +#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
> +const struct zynqmp_eemi_ops *get_eemi_ops(void);
> +#else
> +static inline struct zynqmp_eemi_ops *get_eemi_ops(void) { return NULL; }
> +#endif
> +
> +#endif /* __SOC_ZYNQMP_FIRMWARE_H__ */
> -- 
> 2.7.4
> 
