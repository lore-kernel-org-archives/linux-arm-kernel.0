From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 16 Jun 2017 14:37:01 -0700
Subject: [PATCH 3/5] soc: bcm: brcmstb: Add support for S2/S3/S5 suspend
 states (ARM)
In-Reply-To: <20170616213703.21487-1-f.fainelli@gmail.com>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
Message-ID: <20170616213703.21487-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Norris <computersforpeace@gmail.com>

This commit adds support for the Broadcom STB S2/S3/S5 suspend states on
ARM based SoCs.

This requires quite a lot of code in order to deal with the different HW
blocks that need to be quiesced during suspend:

- DDR PHY SHIM
- DDR memory controller and sequencer
- control processor

The final steps of the suspend execute in an on-chip SRAM and there is a
little bit of assembly code in order to shut down the DDR PHY PLL and
then go into a wfi loop until a wake-up even occurs. Conversely the
resume part involves waiting for the DDR PHY PLL to come back up and
resume executions where we left.

For S3, because of our memory hashing (actual hashing code not included
for simplicity, and is bypassed) we need to relocate the writable
variables (stack) into SRAM shortly before suspending in order to leave
the DRAM untouched and create a reliable hash of its contents.

This code has been contributed by Brian Norris initially and has been
incrementally fixed and updated to support new chips by a lot of people.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Gareth Powell <gpowell@broadcom.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/Kconfig       |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile   |   1 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h | 113 +++++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c   | 836 ++++++++++++++++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h       |  78 ++++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S   |  76 ++++
 6 files changed, 1105 insertions(+)
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S

diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
index 996a75db015e..246fc0f30515 100644
--- a/drivers/soc/bcm/brcmstb/Kconfig
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -3,6 +3,7 @@ if SOC_BRCMSTB
 config BRCMSTB_PM
         bool "Support suspend/resume for STB platforms"
         default y
+	depends on ARM
         depends on PM
 
 endif # SOC_BRCMSTB
diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
new file mode 100644
index 000000000000..66a4f7e43ad5
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
diff --git a/drivers/soc/bcm/brcmstb/pm/aon_defs.h b/drivers/soc/bcm/brcmstb/pm/aon_defs.h
new file mode 100644
index 000000000000..fb936abd847d
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/aon_defs.h
@@ -0,0 +1,113 @@
+/*
+ * Always ON (AON) register interface between bootloader and Linux
+ *
+ * Copyright ? 2014-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __BRCMSTB_AON_DEFS_H__
+#define __BRCMSTB_AON_DEFS_H__
+
+#include <linux/compiler.h>
+
+/* Magic number in upper 16-bits */
+#define BRCMSTB_S3_MAGIC_MASK                   0xffff0000
+#define BRCMSTB_S3_MAGIC_SHORT                  0x5AFE0000
+
+enum {
+	/* Restore random key for AES memory verification (off = fixed key) */
+	S3_FLAG_LOAD_RANDKEY		= (1 << 0),
+
+	/* Scratch buffer page table is present */
+	S3_FLAG_SCRATCH_BUFFER_TABLE	= (1 << 1),
+
+	/* Skip all memory verification */
+	S3_FLAG_NO_MEM_VERIFY		= (1 << 2),
+
+	/*
+	 * Modification of this bit reserved for bootloader only.
+	 * 1=PSCI started Linux, 0=Direct jump to Linux.
+	 */
+	S3_FLAG_PSCI_BOOT		= (1 << 3),
+
+	/*
+	 * Modification of this bit reserved for bootloader only.
+	 * 1=64 bit boot, 0=32 bit boot.
+	 */
+	S3_FLAG_BOOTED64		= (1 << 4),
+};
+
+#define BRCMSTB_HASH_LEN			(128 / 8) /* 128-bit hash */
+
+#define AON_REG_MAGIC_FLAGS			0x00
+#define AON_REG_CONTROL_LOW			0x04
+#define AON_REG_CONTROL_HIGH			0x08
+#define AON_REG_S3_HASH				0x0c /* hash of S3 params */
+#define AON_REG_CONTROL_HASH_LEN		0x1c
+#define AON_REG_PANIC				0x20
+
+#define BRCMSTB_S3_MAGIC		0x5AFEB007
+#define BRCMSTB_PANIC_MAGIC		0x512E115E
+#define BOOTLOADER_SCRATCH_SIZE		64
+#define BRCMSTB_DTU_STATE_MAP_ENTRIES	(8*1024)
+#define BRCMSTB_DTU_CONFIG_ENTRIES	(512)
+#define BRCMSTB_DTU_COUNT		(2)
+
+#define IMAGE_DESCRIPTORS_BUFSIZE	(2 * 1024)
+#define S3_BOOTLOADER_RESERVED		(S3_FLAG_PSCI_BOOT | S3_FLAG_BOOTED64)
+
+struct brcmstb_bootloader_dtu_table {
+	uint32_t	dtu_state_map[BRCMSTB_DTU_STATE_MAP_ENTRIES];
+	uint32_t	dtu_config[BRCMSTB_DTU_CONFIG_ENTRIES];
+};
+
+/*
+ * Bootloader utilizes a custom parameter block left in DRAM for handling S3
+ * warm resume
+ */
+struct brcmstb_s3_params {
+	/* scratch memory for bootloader */
+	uint8_t scratch[BOOTLOADER_SCRATCH_SIZE];
+
+	uint32_t magic; /* BRCMSTB_S3_MAGIC */
+	uint64_t reentry; /* PA */
+
+	/* descriptors */
+	uint32_t hash[BRCMSTB_HASH_LEN / 4];
+
+	/*
+	 * If 0, then ignore this parameter (there is only one set of
+	 *   descriptors)
+	 *
+	 * If non-0, then a second set of descriptors is stored at:
+	 *
+	 *   descriptors + desc_offset_2
+	 *
+	 * The MAC result of both descriptors is XOR'd and stored in @hash
+	 */
+	uint32_t desc_offset_2;
+
+	/*
+	 * (Physical) address of a brcmstb_bootloader_scratch_table, for
+	 * providing a large DRAM buffer to the bootloader
+	 */
+	uint64_t buffer_table;
+
+	uint32_t spare[70];
+
+	uint8_t descriptors[IMAGE_DESCRIPTORS_BUFSIZE];
+	/*
+	 * Must be last member of struct. See brcmstb_pm_s3_finish() for reason.
+	 */
+	struct brcmstb_bootloader_dtu_table dtu[BRCMSTB_DTU_COUNT];
+} __packed;
+
+#endif /* __BRCMSTB_AON_DEFS_H__ */
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
new file mode 100644
index 000000000000..4b7e6c297b23
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -0,0 +1,836 @@
+/*
+ * ARM-specific support for Broadcom STB S2/S3/S5 power management
+ *
+ * S2: clock gate CPUs and as many peripherals as possible
+ * S3: power off all of the chip except the Always ON (AON) island; keep DDR is
+ *     self-refresh
+ * S5: (a.k.a. S3 cold boot) much like S3, except DDR is powered down, so we
+ *     treat this mode like a soft power-off, with wakeup allowed from AON
+ *
+ * Copyright ? 2014-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "brcmstb-pm: " fmt
+
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kconfig.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/suspend.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/soc/brcmstb/brcmstb.h>
+
+#include <asm/fncpy.h>
+#include <asm/setup.h>
+#include <asm/suspend.h>
+
+#include "pm.h"
+#include "aon_defs.h"
+
+#define SHIMPHY_DDR_PAD_CNTRL		0x8c
+
+/* Method #0 */
+#define SHIMPHY_PAD_PLL_SEQUENCE	BIT(8)
+#define SHIMPHY_PAD_GATE_PLL_S3		BIT(9)
+
+/* Method #1 */
+#define PWRDWN_SEQ_NO_SEQUENCING	0
+#define PWRDWN_SEQ_HOLD_CHANNEL		1
+#define	PWRDWN_SEQ_RESET_PLL		2
+#define PWRDWN_SEQ_POWERDOWN_PLL	3
+
+#define SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK	0x00f00000
+#define SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT	20
+
+#define	DDR_FORCE_CKE_RST_N		BIT(3)
+#define	DDR_PHY_RST_N			BIT(2)
+#define	DDR_PHY_CKE			BIT(1)
+
+#define	DDR_PHY_NO_CHANNEL		0xffffffff
+
+#define MAX_NUM_MEMC			3
+
+struct brcmstb_memc {
+	void __iomem *ddr_phy_base;
+	void __iomem *ddr_shimphy_base;
+	void __iomem *ddr_ctrl;
+};
+
+struct brcmstb_pm_control {
+	void __iomem *aon_ctrl_base;
+	void __iomem *aon_sram;
+	struct brcmstb_memc memcs[MAX_NUM_MEMC];
+
+	void __iomem *boot_sram;
+	size_t boot_sram_len;
+
+	bool support_warm_boot;
+	size_t pll_status_offset;
+	int num_memc;
+
+	struct brcmstb_s3_params *s3_params;
+	dma_addr_t s3_params_pa;
+	int s3entry_method;
+	u32 warm_boot_offset;
+	u32 phy_a_standby_ctrl_offs;
+	u32 phy_b_standby_ctrl_offs;
+	bool needs_ddr_pad;
+	struct platform_device *pdev;
+};
+
+enum bsp_initiate_command {
+	BSP_CLOCK_STOP		= 0x00,
+	BSP_GEN_RANDOM_KEY	= 0x4A,
+	BSP_RESTORE_RANDOM_KEY	= 0x55,
+	BSP_GEN_FIXED_KEY	= 0x63,
+};
+
+#define PM_INITIATE		0x01
+#define PM_INITIATE_SUCCESS	0x00
+#define PM_INITIATE_FAIL	0xfe
+
+static struct brcmstb_pm_control ctrl;
+
+static int (*brcmstb_pm_do_s2_sram)(void __iomem *aon_ctrl_base,
+		void __iomem *ddr_phy_pll_status);
+
+static int brcmstb_init_sram(struct device_node *dn)
+{
+	void __iomem *sram;
+	struct resource res;
+	int ret;
+
+	ret = of_address_to_resource(dn, 0, &res);
+	if (ret)
+		return ret;
+
+	/* Cached, executable remapping of SRAM */
+#ifdef CONFIG_ARM
+	sram = __arm_ioremap_exec(res.start, resource_size(&res), true);
+#else
+	sram = __ioremap(res.start, resource_size(&res), PAGE_KERNEL_EXEC);
+#endif
+	if (!sram)
+		return -ENOMEM;
+
+	ctrl.boot_sram = sram;
+	ctrl.boot_sram_len = resource_size(&res);
+
+	return 0;
+}
+
+static const struct of_device_id sram_dt_ids[] = {
+	{ .compatible = "mmio-sram" },
+	{ /* sentinel */ }
+};
+
+static int do_bsp_initiate_command(enum bsp_initiate_command cmd)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+	int ret;
+	int timeo = 1000 * 1000; /* 1 second */
+
+	writel_relaxed(0, base + AON_CTRL_PM_INITIATE);
+	(void)readl_relaxed(base + AON_CTRL_PM_INITIATE);
+
+	/* Go! */
+	writel_relaxed((cmd << 1) | PM_INITIATE, base + AON_CTRL_PM_INITIATE);
+
+	/*
+	 * If firmware doesn't support the 'ack', then just assume it's done
+	 * after 10ms. Note that this only works for command 0, BSP_CLOCK_STOP
+	 */
+	if (of_machine_is_compatible("brcm,bcm74371a0")) {
+		(void)readl_relaxed(base + AON_CTRL_PM_INITIATE);
+		mdelay(10);
+		return 0;
+	}
+
+	for (;;) {
+		ret = readl_relaxed(base + AON_CTRL_PM_INITIATE);
+		if (!(ret & PM_INITIATE))
+			break;
+		if (timeo <= 0) {
+			pr_err("error: timeout waiting for BSP (%x)\n", ret);
+			break;
+		}
+		timeo -= 50;
+		udelay(50);
+	}
+
+	return (ret & 0xff) != PM_INITIATE_SUCCESS;
+}
+
+static int brcmstb_pm_handshake(void)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+	u32 tmp;
+	int ret;
+
+	/* BSP power handshake, v1 */
+	tmp = readl_relaxed(base + AON_CTRL_HOST_MISC_CMDS);
+	tmp &= ~1UL;
+	writel_relaxed(tmp, base + AON_CTRL_HOST_MISC_CMDS);
+	(void)readl_relaxed(base + AON_CTRL_HOST_MISC_CMDS);
+
+	ret = do_bsp_initiate_command(BSP_CLOCK_STOP);
+	if (ret)
+		pr_err("BSP handshake failed\n");
+
+	/*
+	 * HACK: BSP may have internal race on the CLOCK_STOP command.
+	 * Avoid touching the BSP for a few milliseconds.
+	 */
+	mdelay(3);
+
+	return ret;
+}
+
+static inline void shimphy_set(u32 value, u32 mask)
+{
+	int i;
+
+	if (!ctrl.needs_ddr_pad)
+		return;
+
+	for (i = 0; i < ctrl.num_memc; i++) {
+		u32 tmp;
+
+		tmp = readl_relaxed(ctrl.memcs[i].ddr_shimphy_base +
+			SHIMPHY_DDR_PAD_CNTRL);
+		tmp = value | (tmp & mask);
+		writel_relaxed(tmp, ctrl.memcs[i].ddr_shimphy_base +
+			SHIMPHY_DDR_PAD_CNTRL);
+	}
+	wmb(); /* Complete sequence in order. */
+}
+
+static inline void ddr_ctrl_set(bool warmboot)
+{
+	int i;
+
+	for (i = 0; i < ctrl.num_memc; i++) {
+		u32 tmp;
+
+		tmp = readl_relaxed(ctrl.memcs[i].ddr_ctrl +
+				ctrl.warm_boot_offset);
+		if (warmboot)
+			tmp |= 1;
+		else
+			tmp &= ~1; /* Cold boot */
+		writel_relaxed(tmp, ctrl.memcs[i].ddr_ctrl +
+				ctrl.warm_boot_offset);
+	}
+	/* Complete sequence in order */
+	wmb();
+}
+
+static inline void s3entry_method0(void)
+{
+	shimphy_set(SHIMPHY_PAD_GATE_PLL_S3 | SHIMPHY_PAD_PLL_SEQUENCE,
+		    0xffffffff);
+}
+
+static inline void s3entry_method1(void)
+{
+	/*
+	 * S3 Entry Sequence
+	 * -----------------
+	 * Step 1: SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL [ S3_PWRDWN_SEQ ] = 3
+	 * Step 2: MEMC_DDR_0_WARM_BOOT [ WARM_BOOT ] = 1
+	 */
+	shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
+		    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
+		    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
+
+	ddr_ctrl_set(true);
+}
+
+static inline void s5entry_method1(void)
+{
+	int i;
+
+	/*
+	 * S5 Entry Sequence
+	 * -----------------
+	 * Step 1: SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL [ S3_PWRDWN_SEQ ] = 3
+	 * Step 2: MEMC_DDR_0_WARM_BOOT [ WARM_BOOT ] = 0
+	 * Step 3: DDR_PHY_CONTROL_REGS_[AB]_0_STANDBY_CONTROL[ CKE ] = 0
+	 *	   DDR_PHY_CONTROL_REGS_[AB]_0_STANDBY_CONTROL[ RST_N ] = 0
+	 */
+	shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
+		    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
+		    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
+
+	ddr_ctrl_set(false);
+
+	for (i = 0; i < ctrl.num_memc; i++) {
+		u32 tmp;
+
+		/* Step 3: Channel A (RST_N = CKE = 0) */
+		tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
+				  ctrl.phy_a_standby_ctrl_offs);
+		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
+		writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
+			     ctrl.phy_a_standby_ctrl_offs);
+
+		/* Step 3: Channel B? */
+		if (ctrl.phy_b_standby_ctrl_offs != DDR_PHY_NO_CHANNEL) {
+			tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
+					  ctrl.phy_b_standby_ctrl_offs);
+			tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
+			writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
+				     ctrl.phy_b_standby_ctrl_offs);
+		}
+	}
+	/* Must complete */
+	wmb();
+}
+
+/*
+ * Run a Power Management State Machine (PMSM) shutdown command and put the CPU
+ * into a low-power mode
+ */
+static void brcmstb_do_pmsm_power_down(unsigned long base_cmd, bool onewrite)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+
+	if ((ctrl.s3entry_method == 1) && (base_cmd == PM_COLD_CONFIG))
+		s5entry_method1();
+
+	/* pm_start_pwrdn transition 0->1 */
+	writel_relaxed(base_cmd, base + AON_CTRL_PM_CTRL);
+
+	if (!onewrite) {
+		(void)readl_relaxed(base + AON_CTRL_PM_CTRL);
+
+		writel_relaxed(base_cmd | PM_PWR_DOWN, base + AON_CTRL_PM_CTRL);
+		(void)readl_relaxed(base + AON_CTRL_PM_CTRL);
+	}
+	wfi();
+}
+
+/* Support S5 cold boot out of "poweroff" */
+static void brcmstb_pm_poweroff(void)
+{
+	brcmstb_pm_handshake();
+
+	/* Clear magic S3 warm-boot value */
+	writel_relaxed(0, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+	(void)readl_relaxed(ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+
+	/* Skip wait-for-interrupt signal; just use a countdown */
+	writel_relaxed(0x10, ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
+	(void)readl_relaxed(ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
+
+	if (ctrl.s3entry_method == 1) {
+		shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
+			     SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
+			     ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
+		ddr_ctrl_set(false);
+		brcmstb_do_pmsm_power_down(M1_PM_COLD_CONFIG, true);
+		return; /* We should never actually get here */
+	}
+
+	brcmstb_do_pmsm_power_down(PM_COLD_CONFIG, false);
+}
+
+static void *brcmstb_pm_copy_to_sram(void *fn, size_t len)
+{
+	unsigned int size = ALIGN(len, FNCPY_ALIGN);
+
+	if (ctrl.boot_sram_len < size) {
+		pr_err("standby code will not fit in SRAM\n");
+		return NULL;
+	}
+
+	return fncpy(ctrl.boot_sram, fn, size);
+}
+
+/*
+ * S2 suspend/resume picks up where we left off, so we must execute carefully
+ * from SRAM, in order to allow DDR to come back up safely before we continue.
+ */
+static int brcmstb_pm_s2(void)
+{
+	/* A previous S3 can set a value hazardous to S2, so make sure. */
+	if (ctrl.s3entry_method == 1) {
+		shimphy_set((PWRDWN_SEQ_NO_SEQUENCING <<
+			    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
+			    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
+		ddr_ctrl_set(false);
+	}
+
+	brcmstb_pm_do_s2_sram = brcmstb_pm_copy_to_sram(&brcmstb_pm_do_s2,
+			brcmstb_pm_do_s2_sz);
+	if (!brcmstb_pm_do_s2_sram)
+		return -EINVAL;
+
+	return brcmstb_pm_do_s2_sram(ctrl.aon_ctrl_base,
+			ctrl.memcs[0].ddr_phy_base +
+			ctrl.pll_status_offset);
+}
+
+/*
+ * This function is called on a new stack, so don't allow inlining (which will
+ * generate stack references on the old stack)
+ */
+static noinline int brcmstb_pm_s3_finish(void)
+{
+	struct brcmstb_s3_params *params = ctrl.s3_params;
+	dma_addr_t params_pa = ctrl.s3_params_pa;
+	phys_addr_t reentry = virt_to_phys(&cpu_resume);
+	enum bsp_initiate_command cmd;
+	u32 flags;
+
+	/*
+	 * Clear parameter structure, but not DTU area, which has already been
+	 * filled in. We know DTU is a the end, so we can just subtract its
+	 * size.
+	 */
+	memset(params, 0, sizeof(*params) - sizeof(params->dtu));
+
+	flags = readl_relaxed(ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+
+	flags &= S3_BOOTLOADER_RESERVED;
+	flags |= S3_FLAG_NO_MEM_VERIFY;
+	flags |= S3_FLAG_LOAD_RANDKEY;
+
+	/* Load random / fixed key */
+	if (flags & S3_FLAG_LOAD_RANDKEY)
+		cmd = BSP_GEN_RANDOM_KEY;
+	else
+		cmd = BSP_GEN_FIXED_KEY;
+	if (do_bsp_initiate_command(cmd)) {
+		pr_info("key loading failed\n");
+		return -EIO;
+	}
+
+	params->magic = BRCMSTB_S3_MAGIC;
+	params->reentry = reentry;
+
+	/* No more writes to DRAM */
+	flush_cache_all();
+
+	flags |= BRCMSTB_S3_MAGIC_SHORT;
+
+	writel_relaxed(flags, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+	writel_relaxed(lower_32_bits(params_pa),
+		       ctrl.aon_sram + AON_REG_CONTROL_LOW);
+	writel_relaxed(upper_32_bits(params_pa),
+		       ctrl.aon_sram + AON_REG_CONTROL_HIGH);
+
+	switch (ctrl.s3entry_method) {
+	case 0:
+		s3entry_method0();
+		brcmstb_do_pmsm_power_down(PM_WARM_CONFIG, false);
+		break;
+	case 1:
+		s3entry_method1();
+		brcmstb_do_pmsm_power_down(M1_PM_WARM_CONFIG, true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Must have been interrupted from wfi()? */
+	return -EINTR;
+}
+
+#define SWAP_STACK(new_sp, saved_sp) \
+	__asm__ __volatile__ ( \
+		 "mov	%[save], sp\n" \
+		 "mov	sp, %[new]\n" \
+		 : [save] "=&r" (saved_sp) \
+		 : [new] "r" (new_sp) \
+		)
+
+/*
+ * S3 mode resume to the bootloader before jumping back to Linux, so we can be
+ * a little less careful about running from DRAM.
+ */
+static int brcmstb_pm_do_s3(unsigned long sp)
+{
+	unsigned long save_sp;
+	int ret;
+
+	/* Move to a new stack */
+	SWAP_STACK(sp, save_sp);
+
+	/* should not return */
+	ret = brcmstb_pm_s3_finish();
+
+	SWAP_STACK(save_sp, sp);
+
+	pr_err("Could not enter S3\n");
+
+	return ret;
+}
+
+static int brcmstb_pm_s3(void)
+{
+	void __iomem *sp = ctrl.boot_sram + ctrl.boot_sram_len;
+
+	return cpu_suspend((unsigned long)sp, brcmstb_pm_do_s3);
+}
+
+static int brcmstb_pm_standby(bool deep_standby)
+{
+	int ret;
+
+	if (brcmstb_pm_handshake())
+		return -EIO;
+
+	if (deep_standby)
+		ret = brcmstb_pm_s3();
+	else
+		ret = brcmstb_pm_s2();
+	if (ret)
+		pr_err("%s: standby failed\n", __func__);
+
+	return ret;
+}
+
+static int brcmstb_pm_enter(suspend_state_t state)
+{
+	int ret = -EINVAL;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		ret = brcmstb_pm_standby(false);
+		break;
+	case PM_SUSPEND_MEM:
+		ret = brcmstb_pm_standby(true);
+		break;
+	}
+
+	return ret;
+}
+
+static int brcmstb_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return true;
+	case PM_SUSPEND_MEM:
+		return ctrl.support_warm_boot;
+	default:
+		return false;
+	}
+}
+
+static const struct platform_suspend_ops brcmstb_pm_ops = {
+	.enter		= brcmstb_pm_enter,
+	.valid		= brcmstb_pm_valid,
+};
+
+static const struct of_device_id aon_ctrl_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-aon-ctrl" },
+	{}
+};
+
+struct ddr_phy_ofdata {
+	bool supports_warm_boot;
+	size_t pll_status_offset;
+	int s3entry_method;
+	u32 warm_boot_offset;
+	u32 phy_a_standby_ctrl_offs;
+	u32 phy_b_standby_ctrl_offs;
+};
+
+static struct ddr_phy_ofdata ddr_phy_71_1 = {
+	.supports_warm_boot = true,
+	.pll_status_offset = 0x0c,
+	.s3entry_method = 1,
+	.warm_boot_offset = 0x2c,
+	.phy_a_standby_ctrl_offs = 0x198,
+	.phy_b_standby_ctrl_offs = DDR_PHY_NO_CHANNEL
+};
+
+static struct ddr_phy_ofdata ddr_phy_72_0 = {
+	.supports_warm_boot = true,
+	.pll_status_offset = 0x10,
+	.s3entry_method = 1,
+	.warm_boot_offset = 0x40,
+	.phy_a_standby_ctrl_offs = 0x2a4,
+	.phy_b_standby_ctrl_offs = 0x8a4
+};
+
+static struct ddr_phy_ofdata ddr_phy_225_1 = {
+	.supports_warm_boot = false,
+	.pll_status_offset = 0x4,
+	.s3entry_method = 0
+};
+
+static struct ddr_phy_ofdata ddr_phy_240_1 = {
+	.supports_warm_boot = true,
+	.pll_status_offset = 0x4,
+	.s3entry_method = 0
+};
+
+static const struct of_device_id ddr_phy_dt_ids[] = {
+	{
+		.compatible = "brcm,brcmstb-ddr-phy-v71.1",
+		.data = &ddr_phy_71_1,
+	},
+	{
+		.compatible = "brcm,brcmstb-ddr-phy-v72.0",
+		.data = &ddr_phy_72_0,
+	},
+	{
+		.compatible = "brcm,brcmstb-ddr-phy-v225.1",
+		.data = &ddr_phy_225_1,
+	},
+	{
+		.compatible = "brcm,brcmstb-ddr-phy-v240.1",
+		.data = &ddr_phy_240_1,
+	},
+	{
+		/* Same as v240.1, for the registers we care about */
+		.compatible = "brcm,brcmstb-ddr-phy-v240.2",
+		.data = &ddr_phy_240_1,
+	},
+	{}
+};
+
+struct ddr_seq_ofdata {
+	bool needs_ddr_pad;
+	u32 warm_boot_offset;
+};
+
+static const struct ddr_seq_ofdata ddr_seq_b22 = {
+	.needs_ddr_pad = false,
+	.warm_boot_offset = 0x2c,
+};
+
+static const struct ddr_seq_ofdata ddr_seq = {
+	.needs_ddr_pad = true,
+};
+
+static const struct of_device_id ddr_shimphy_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-ddr-shimphy-v1.0" },
+	{}
+};
+
+static const struct of_device_id brcmstb_memc_of_match[] = {
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.2",
+		.data = &ddr_seq_b22,
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr",
+		.data = &ddr_seq,
+	},
+	{},
+};
+
+static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
+					   int index, const void **ofdata)
+{
+	struct device_node *dn;
+	const struct of_device_id *match;
+
+	dn = of_find_matching_node_and_match(NULL, matches, &match);
+	if (!dn)
+		return ERR_PTR(-EINVAL);
+
+	if (ofdata)
+		*ofdata = match->data;
+
+	return of_io_request_and_map(dn, index, dn->full_name);
+}
+
+static int brcmstb_pm_panic_notify(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block brcmstb_pm_panic_nb = {
+	.notifier_call = brcmstb_pm_panic_notify,
+};
+
+static int brcmstb_pm_probe(struct platform_device *pdev)
+{
+	const struct ddr_phy_ofdata *ddr_phy_data;
+	const struct ddr_seq_ofdata *ddr_seq_data;
+	const struct of_device_id *of_id = NULL;
+	struct device_node *dn;
+	void __iomem *base;
+	int ret, i;
+
+	/* AON ctrl registers */
+	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("error mapping AON_CTRL\n");
+		return PTR_ERR(base);
+	}
+	ctrl.aon_ctrl_base = base;
+
+	/* AON SRAM registers */
+	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 1, NULL);
+	if (IS_ERR(base)) {
+		/* Assume standard offset */
+		ctrl.aon_sram = ctrl.aon_ctrl_base +
+				     AON_CTRL_SYSTEM_DATA_RAM_OFS;
+	} else {
+		ctrl.aon_sram = base;
+	}
+
+	writel_relaxed(0, ctrl.aon_sram + AON_REG_PANIC);
+
+	/* DDR PHY registers */
+	base = brcmstb_ioremap_match(ddr_phy_dt_ids, 0,
+				     (const void **)&ddr_phy_data);
+	if (IS_ERR(base)) {
+		pr_err("error mapping DDR PHY\n");
+		return PTR_ERR(base);
+	}
+	ctrl.support_warm_boot = ddr_phy_data->supports_warm_boot;
+	ctrl.pll_status_offset = ddr_phy_data->pll_status_offset;
+	/* Only need DDR PHY 0 for now? */
+	ctrl.memcs[0].ddr_phy_base = base;
+	ctrl.s3entry_method = ddr_phy_data->s3entry_method;
+	ctrl.phy_a_standby_ctrl_offs = ddr_phy_data->phy_a_standby_ctrl_offs;
+	ctrl.phy_b_standby_ctrl_offs = ddr_phy_data->phy_b_standby_ctrl_offs;
+	/*
+	 * Slightly grosss to use the phy ver to get a memc,
+	 * offset but that is the only versioned things so far
+	 * we can test for.
+	 */
+	ctrl.warm_boot_offset = ddr_phy_data->warm_boot_offset;
+
+	/* DDR SHIM-PHY registers */
+	for_each_matching_node(dn, ddr_shimphy_dt_ids) {
+		i = ctrl.num_memc;
+		if (i >= MAX_NUM_MEMC) {
+			pr_warn("too many MEMCs (max %d)\n", MAX_NUM_MEMC);
+			break;
+		}
+
+		base = of_io_request_and_map(dn, 0, dn->full_name);
+		if (IS_ERR(base)) {
+			if (!ctrl.support_warm_boot)
+				break;
+
+			pr_err("error mapping DDR SHIMPHY %d\n", i);
+			return PTR_ERR(base);
+		}
+		ctrl.memcs[i].ddr_shimphy_base = base;
+		ctrl.num_memc++;
+	}
+
+	/* Sequencer DRAM Param and Control Registers */
+	i = 0;
+	for_each_matching_node(dn, brcmstb_memc_of_match) {
+		base = of_iomap(dn, 0);
+		if (!base) {
+			pr_err("error mapping DDR Sequencer %d\n", i);
+			return -ENOMEM;
+		}
+
+		of_id = of_match_node(brcmstb_memc_of_match, dn);
+		if (!of_id) {
+			iounmap(base);
+			return -EINVAL;
+		}
+
+		ddr_seq_data = of_id->data;
+		ctrl.needs_ddr_pad = ddr_seq_data->needs_ddr_pad;
+		/* Adjust warm boot offset based on the DDR sequencer */
+		if (ddr_seq_data->warm_boot_offset)
+			ctrl.warm_boot_offset = ddr_seq_data->warm_boot_offset;
+
+		ctrl.memcs[i].ddr_ctrl = base;
+		i++;
+	}
+
+	pr_debug("PM: supports warm boot:%d, method:%d, wboffs:%x\n",
+		ctrl.support_warm_boot, ctrl.s3entry_method,
+		ctrl.warm_boot_offset);
+
+	dn = of_find_matching_node(NULL, sram_dt_ids);
+	if (!dn) {
+		pr_err("SRAM not found\n");
+		return -EINVAL;
+	}
+
+	ret = brcmstb_init_sram(dn);
+	if (ret) {
+		pr_err("error setting up SRAM for PM\n");
+		return ret;
+	}
+
+	ctrl.pdev = pdev;
+
+	ctrl.s3_params = kmalloc(sizeof(*ctrl.s3_params), GFP_KERNEL);
+	if (!ctrl.s3_params)
+		return -ENOMEM;
+	ctrl.s3_params_pa = dma_map_single(&pdev->dev, ctrl.s3_params,
+					   sizeof(*ctrl.s3_params),
+					   DMA_TO_DEVICE);
+	if (dma_mapping_error(&pdev->dev, ctrl.s3_params_pa)) {
+		pr_err("error mapping DMA memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &brcmstb_pm_panic_nb);
+
+	pm_power_off = brcmstb_pm_poweroff;
+	suspend_set_ops(&brcmstb_pm_ops);
+
+	return 0;
+
+out:
+	kfree(ctrl.s3_params);
+
+	pr_warn("PM: initialization failed with code %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver brcmstb_pm_driver = {
+	.driver = {
+		.name	= "brcmstb-pm",
+		.of_match_table = aon_ctrl_dt_ids,
+	},
+};
+
+static int __init brcmstb_pm_init(void)
+{
+	return platform_driver_probe(&brcmstb_pm_driver,
+				     brcmstb_pm_probe);
+}
+module_init(brcmstb_pm_init);
diff --git a/drivers/soc/bcm/brcmstb/pm/pm.h b/drivers/soc/bcm/brcmstb/pm/pm.h
new file mode 100644
index 000000000000..142519fdb8f8
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/pm.h
@@ -0,0 +1,78 @@
+/*
+ * Definitions for Broadcom STB power management / Always ON (AON) block
+ *
+ * Copyright ? 2016-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __BRCMSTB_PM_H__
+#define __BRCMSTB_PM_H__
+
+#define AON_CTRL_RESET_CTRL		0x00
+#define AON_CTRL_PM_CTRL		0x04
+#define AON_CTRL_PM_STATUS		0x08
+#define AON_CTRL_PM_CPU_WAIT_COUNT	0x10
+#define AON_CTRL_PM_INITIATE		0x88
+#define AON_CTRL_HOST_MISC_CMDS		0x8c
+#define AON_CTRL_SYSTEM_DATA_RAM_OFS	0x200
+
+/* MIPS PM constants */
+/* MEMC0 offsets */
+#define DDR40_PHY_CONTROL_REGS_0_PLL_STATUS	0x10
+#define DDR40_PHY_CONTROL_REGS_0_STANDBY_CTRL	0xa4
+
+/* TIMER offsets */
+#define TIMER_TIMER1_CTRL		0x0c
+#define TIMER_TIMER1_STAT		0x1c
+
+/* TIMER defines */
+#define RESET_TIMER			0x0
+#define START_TIMER			0xbfffffff
+#define TIMER_MASK			0x3fffffff
+
+/* PM_CTRL bitfield (Method #0) */
+#define PM_FAST_PWRDOWN			(1 << 6)
+#define PM_WARM_BOOT			(1 << 5)
+#define PM_DEEP_STANDBY			(1 << 4)
+#define PM_CPU_PWR			(1 << 3)
+#define PM_USE_CPU_RDY			(1 << 2)
+#define PM_PLL_PWRDOWN			(1 << 1)
+#define PM_PWR_DOWN			(1 << 0)
+
+/* PM_CTRL bitfield (Method #1) */
+#define PM_DPHY_STANDBY_CLEAR		(1 << 20)
+#define PM_MIN_S3_WIDTH_TIMER_BYPASS	(1 << 7)
+
+#define PM_S2_COMMAND	(PM_PLL_PWRDOWN | PM_USE_CPU_RDY | PM_PWR_DOWN)
+
+/* Method 0 bitmasks */
+#define PM_COLD_CONFIG	(PM_PLL_PWRDOWN | PM_DEEP_STANDBY)
+#define PM_WARM_CONFIG	(PM_COLD_CONFIG | PM_USE_CPU_RDY | PM_WARM_BOOT)
+
+/* Method 1 bitmask */
+#define M1_PM_WARM_CONFIG (PM_DPHY_STANDBY_CLEAR | \
+			   PM_MIN_S3_WIDTH_TIMER_BYPASS | \
+			   PM_WARM_BOOT | PM_DEEP_STANDBY | \
+			   PM_PLL_PWRDOWN | PM_PWR_DOWN)
+
+#define M1_PM_COLD_CONFIG (PM_DPHY_STANDBY_CLEAR | \
+			   PM_MIN_S3_WIDTH_TIMER_BYPASS | \
+			   PM_DEEP_STANDBY | \
+			   PM_PLL_PWRDOWN | PM_PWR_DOWN)
+
+#ifndef __ASSEMBLY__
+
+extern const unsigned long brcmstb_pm_do_s2_sz;
+extern asmlinkage int brcmstb_pm_do_s2(void __iomem *aon_ctrl_base,
+		void __iomem *ddr_phy_pll_status);
+#endif
+
+#endif /* __BRCMSTB_PM_H__ */
diff --git a/drivers/soc/bcm/brcmstb/pm/s2-arm.S b/drivers/soc/bcm/brcmstb/pm/s2-arm.S
new file mode 100644
index 000000000000..1d472d564638
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/s2-arm.S
@@ -0,0 +1,76 @@
+/*
+ * Copyright ? 2014-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+#include "pm.h"
+
+	.text
+	.align	3
+
+#define AON_CTRL_REG		r10
+#define DDR_PHY_STATUS_REG	r11
+
+/*
+ * r0: AON_CTRL base address
+ * r1: DDRY PHY PLL status register address
+ */
+ENTRY(brcmstb_pm_do_s2)
+	stmfd	sp!, {r4-r11, lr}
+	mov	AON_CTRL_REG, r0
+	mov	DDR_PHY_STATUS_REG, r1
+
+	/* Flush memory transactions */
+	dsb
+
+	/* Cache DDR_PHY_STATUS_REG translation */
+	ldr	r0, [DDR_PHY_STATUS_REG]
+
+	/* power down request */
+	ldr	r0, =PM_S2_COMMAND
+	ldr	r1, =0
+	str	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+	ldr	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+
+	/* Wait for interrupt */
+	wfi
+	nop
+
+	/* Bring MEMC back up */
+1:	ldr	r0, [DDR_PHY_STATUS_REG]
+	ands	r0, #1
+	beq	1b
+
+	/* Power-up handshake */
+	ldr	r0, =1
+	str	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
+	ldr	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
+
+	ldr	r0, =0
+	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
+
+	/* Return to caller */
+	ldr	r0, =0
+	ldmfd	sp!, {r4-r11, pc}
+
+	ENDPROC(brcmstb_pm_do_s2)
+
+	/* Place literal pool here */
+	.ltorg
+
+ENTRY(brcmstb_pm_do_s2_sz)
+	.word   . - brcmstb_pm_do_s2
-- 
2.9.3
