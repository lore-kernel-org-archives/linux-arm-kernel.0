From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 18 Jun 2015 17:11:33 -0700
Subject: [PATCH 4/7] soc: brcmstb: add PM suspend/resume support (S2/S3/S5)
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1434672696-13632-5-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support S2, S3, and S5 through /sys/power/state ("standby" and "mem")
and the poweroff code paths. See comments in pm.c for a few more details
about these system suspend modes.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/soc/brcmstb/Kconfig       |  10 +
 drivers/soc/brcmstb/Makefile      |   2 +
 drivers/soc/brcmstb/pm/Makefile   |   1 +
 drivers/soc/brcmstb/pm/aon_defs.h |  85 +++++++
 drivers/soc/brcmstb/pm/pm.c       | 512 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/brcmstb/pm/pm.h       |  40 +++
 drivers/soc/brcmstb/pm/s2.S       |  73 ++++++
 7 files changed, 723 insertions(+)
 create mode 100644 drivers/soc/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/brcmstb/pm/pm.c
 create mode 100644 drivers/soc/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/brcmstb/pm/s2.S

diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
index 39cab3bd544d..5025dacce6f0 100644
--- a/drivers/soc/brcmstb/Kconfig
+++ b/drivers/soc/brcmstb/Kconfig
@@ -7,3 +7,13 @@ menuconfig SOC_BRCMSTB
 	  can be enabled individually within this menu.
 
 	  If unsure, say N.
+
+if SOC_BRCMSTB
+
+config BRCMSTB_PM
+	bool "Support suspend/resume for STB platforms"
+	default y
+	depends on PM
+	depends on ARM && ARCH_BRCMSTB
+
+endif # SOC_BRCMSTB
diff --git a/drivers/soc/brcmstb/Makefile b/drivers/soc/brcmstb/Makefile
index 183280e39f80..677e3fa0d042 100644
--- a/drivers/soc/brcmstb/Makefile
+++ b/drivers/soc/brcmstb/Makefile
@@ -1 +1,3 @@
+obj-$(CONFIG_BRCMSTB_PM)	+= pm/
+
 obj-y				+= common.o
diff --git a/drivers/soc/brcmstb/pm/Makefile b/drivers/soc/brcmstb/pm/Makefile
new file mode 100644
index 000000000000..71a1ff4c368b
--- /dev/null
+++ b/drivers/soc/brcmstb/pm/Makefile
@@ -0,0 +1 @@
+obj-y				+= pm.o s2.o
diff --git a/drivers/soc/brcmstb/pm/aon_defs.h b/drivers/soc/brcmstb/pm/aon_defs.h
new file mode 100644
index 000000000000..2b660fa788e4
--- /dev/null
+++ b/drivers/soc/brcmstb/pm/aon_defs.h
@@ -0,0 +1,85 @@
+/*
+ * Always ON (AON) register interface between bootloader and Linux
+ *
+ * Copyright ? 2014-2015 Broadcom Corporation
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
+};
+
+#define BRCMSTB_HASH_LEN			(128 / 8) /* 128-bit hash */
+
+#define AON_REG_MAGIC_FLAGS			0x00
+#define AON_REG_CONTROL_LOW			0x04
+#define AON_REG_CONTROL_HIGH			0x08
+#define AON_REG_S3_HASH				0x0c /* hash of S3 params */
+#define AON_REG_CONTROL_HASH_LEN		0x1c
+
+#define BRCMSTB_S3_MAGIC		0x5AFEB007
+#define BOOTLOADER_SCRATCH_SIZE		64
+#define IMAGE_DESCRIPTORS_BUFSIZE	(2 * 1024)
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
+} __packed;
+
+#endif /* __BRCMSTB_AON_DEFS_H__ */
diff --git a/drivers/soc/brcmstb/pm/pm.c b/drivers/soc/brcmstb/pm/pm.c
new file mode 100644
index 000000000000..04f0528d5322
--- /dev/null
+++ b/drivers/soc/brcmstb/pm/pm.c
@@ -0,0 +1,512 @@
+/*
+ * ARM-specific support for Broadcom STB S2/S3/S5 power management
+ *
+ * S2: clock gate CPUs and as many peripherals as possible
+ * S3: power off all of the chip except the Always ON (AON) island; keep DDR is
+ *     self-refresh
+ * S5: (a.k.a. S3 cold boot) much like S3, except DDR is powered down, so we
+ *     treat this mode like a soft power-off, with wakeup allowed from AON
+ *
+ * Copyright ? 2014-2015 Broadcom Corporation
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
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/compiler.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/kconfig.h>
+#include <asm/fncpy.h>
+#include <asm/suspend.h>
+#include <asm/setup.h>
+
+#include <soc/brcmstb/common.h>
+
+#include "pm.h"
+#include "aon_defs.h"
+
+#define BRCMSTB_DDR_PHY_PLL_STATUS	0x04
+
+#define SHIMPHY_DDR_PAD_CNTRL		0x8c
+#define SHIMPHY_PAD_PLL_SEQUENCE	BIT(8)
+#define SHIMPHY_PAD_GATE_PLL_S3		BIT(9)
+
+#define MAX_NUM_MEMC			3
+
+/* Capped for performance reasons */
+#define MAX_HASH_SIZE			SZ_256M
+/* Max per bank, to keep some fairness */
+#define MAX_HASH_SIZE_BANK		SZ_64M
+
+struct brcmstb_memc {
+	void __iomem *ddr_phy_base;
+	void __iomem *ddr_shimphy_base;
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
+	int num_memc;
+
+	struct brcmstb_s3_params *s3_params;
+	dma_addr_t s3_params_pa;
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
+extern const unsigned long brcmstb_pm_do_s2_sz;
+extern asmlinkage int brcmstb_pm_do_s2(void __iomem *aon_ctrl_base,
+		void __iomem *ddr_phy_pll_status);
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
+	sram = __arm_ioremap_exec(res.start, resource_size(&res), true);
+	if (!sram)
+		return -ENOMEM;
+
+	ctrl.boot_sram = sram;
+	ctrl.boot_sram_len = resource_size(&res);
+
+	return 0;
+}
+
+/*
+ * Latch into the BRCM SRAM compatible property here to be more specific than
+ * the standard "mmio-sram". Could be supported with genalloc too, but that
+ * would be overkill for its current single use-case.
+ */
+static const struct of_device_id sram_dt_ids[] = {
+	{ .compatible = "brcm,boot-sram" },
+	{}
+};
+
+static int do_bsp_initiate_command(enum bsp_initiate_command cmd)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+	int ret;
+	int timeo = 1000 * 1000; /* 1 second */
+
+	__raw_writel(0, base + AON_CTRL_PM_INITIATE);
+	(void)__raw_readl(base + AON_CTRL_PM_INITIATE);
+
+	/* Go! */
+	__raw_writel((cmd << 1) | PM_INITIATE, base + AON_CTRL_PM_INITIATE);
+
+	for (;;) {
+		ret = __raw_readl(base + AON_CTRL_PM_INITIATE);
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
+	tmp = __raw_readl(base + AON_CTRL_HOST_MISC_CMDS);
+	tmp &= ~1UL;
+	__raw_writel(tmp, base + AON_CTRL_HOST_MISC_CMDS);
+	(void)__raw_readl(base + AON_CTRL_HOST_MISC_CMDS);
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
+/*
+ * Run a Power Management State Machine (PMSM) shutdown command and put the CPU
+ * into a low-power mode
+ */
+static void brcmstb_do_pmsm_power_down(unsigned long base_cmd)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+
+	/* pm_start_pwrdn transition 0->1 */
+	__raw_writel(base_cmd, base + AON_CTRL_PM_CTRL);
+	(void)__raw_readl(base + AON_CTRL_PM_CTRL);
+
+	__raw_writel(base_cmd | PM_PWR_DOWN, base + AON_CTRL_PM_CTRL);
+	(void)__raw_readl(base + AON_CTRL_PM_CTRL);
+
+	wfi();
+}
+
+/* Support S5 cold boot out of "poweroff" */
+static void brcmstb_pm_poweroff(void)
+{
+	brcmstb_pm_handshake();
+
+	/* Clear magic S3 warm-boot value */
+	__raw_writel(0, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+	(void)__raw_readl(ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+
+	/* Skip wait-for-interrupt signal; just use a countdown */
+	__raw_writel(0x10, ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
+	(void)__raw_readl(ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
+
+	brcmstb_do_pmsm_power_down(PM_COLD_CONFIG);
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
+	brcmstb_pm_do_s2_sram = brcmstb_pm_copy_to_sram(&brcmstb_pm_do_s2,
+			brcmstb_pm_do_s2_sz);
+	if (!brcmstb_pm_do_s2_sram)
+		return -EINVAL;
+
+	return brcmstb_pm_do_s2_sram(ctrl.aon_ctrl_base,
+			ctrl.memcs[0].ddr_phy_base +
+			BRCMSTB_DDR_PHY_PLL_STATUS);
+}
+
+static int brcmstb_pm_s3_finish(void)
+{
+	struct brcmstb_s3_params *params = ctrl.s3_params;
+	phys_addr_t params_pa = ctrl.s3_params_pa;
+	phys_addr_t reentry = virt_to_phys(&cpu_resume);
+	u32 flags = S3_FLAG_NO_MEM_VERIFY;
+	int i;
+
+	/* Clear parameter structure */
+	memset(params, 0, sizeof(*params));
+
+	params->magic = BRCMSTB_S3_MAGIC;
+	params->reentry = reentry;
+
+	flush_cache_all();
+
+	flags |= BRCMSTB_S3_MAGIC_SHORT;
+
+	__raw_writel(flags, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
+	__raw_writel(lower_32_bits(params_pa),
+		     ctrl.aon_sram + AON_REG_CONTROL_LOW);
+	__raw_writel(upper_32_bits(params_pa),
+		     ctrl.aon_sram + AON_REG_CONTROL_HIGH);
+
+	/* gate PLL | S3 */
+	for (i = 0; i < ctrl.num_memc; i++) {
+		u32 tmp;
+		tmp = __raw_readl(ctrl.memcs[i].ddr_shimphy_base +
+				SHIMPHY_DDR_PAD_CNTRL);
+		tmp |= SHIMPHY_PAD_GATE_PLL_S3 | SHIMPHY_PAD_PLL_SEQUENCE;
+		__raw_writel(tmp, ctrl.memcs[i].ddr_shimphy_base +
+				SHIMPHY_DDR_PAD_CNTRL);
+	}
+
+	brcmstb_do_pmsm_power_down(PM_WARM_CONFIG);
+
+	/* Must have been interrupted from wfi()? */
+	return -EINTR;
+}
+
+/*
+ * S3 mode resume to the bootloader before jumping back to Linux, so we can be
+ * a little less careful about running from DRAM.
+ */
+static int brcmstb_pm_do_s3(unsigned long sp)
+{
+	int ret;
+
+	/* should not return */
+	ret = brcmstb_pm_s3_finish();
+
+	pr_err("Could not enter S3\n");
+
+	return ret;
+}
+
+static int brcmstb_pm_s3(void)
+{
+	void __iomem *sp = ctrl.boot_sram + ctrl.boot_sram_len - 8;
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
+};
+
+static struct ddr_phy_ofdata ddr_phy_225_1 = { .supports_warm_boot = false, };
+static struct ddr_phy_ofdata ddr_phy_240_1 = { .supports_warm_boot = true, };
+
+static const struct of_device_id ddr_phy_dt_ids[] = {
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
+static const struct of_device_id ddr_shimphy_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-ddr-shimphy-v1.0" },
+	{}
+};
+
+static inline void __iomem *brcmstb_ioremap_node(struct device_node *dn,
+						 int index)
+{
+	return of_io_request_and_map(dn, index, dn->full_name);
+}
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
+	return brcmstb_ioremap_node(dn, index);
+}
+
+static int brcmstb_pm_init(void)
+{
+	struct device_node *dn;
+	void __iomem *base;
+	int ret, i;
+	const struct ddr_phy_ofdata *ddr_phy_data;
+
+	if (!soc_is_brcmstb())
+		return 0;
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
+	/* DDR PHY registers */
+	base = brcmstb_ioremap_match(ddr_phy_dt_ids, 0,
+				     (const void **)&ddr_phy_data);
+	if (IS_ERR(base)) {
+		pr_err("error mapping DDR PHY\n");
+		return PTR_ERR(base);
+	}
+	ctrl.support_warm_boot = ddr_phy_data->supports_warm_boot;
+	/* Only need DDR PHY 0 for now? */
+	ctrl.memcs[0].ddr_phy_base = base;
+
+	/* DDR SHIM-PHY registers */
+	for_each_matching_node(dn, ddr_shimphy_dt_ids) {
+		i = ctrl.num_memc;
+		if (i >= MAX_NUM_MEMC) {
+			pr_warn("too many MEMCs (max %d)\n", MAX_NUM_MEMC);
+			break;
+		}
+		base = brcmstb_ioremap_node(dn, 0);
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
+	ctrl.s3_params = kmalloc(sizeof(*ctrl.s3_params), GFP_KERNEL);
+	if (!ctrl.s3_params)
+		return -ENOMEM;
+	ctrl.s3_params_pa = dma_map_single(NULL, ctrl.s3_params,
+					   sizeof(*ctrl.s3_params),
+					   DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, ctrl.s3_params_pa)) {
+		pr_err("error mapping DMA memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pm_power_off = brcmstb_pm_poweroff;
+	suspend_set_ops(&brcmstb_pm_ops);
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
+arch_initcall(brcmstb_pm_init);
diff --git a/drivers/soc/brcmstb/pm/pm.h b/drivers/soc/brcmstb/pm/pm.h
new file mode 100644
index 000000000000..fadab6dc424a
--- /dev/null
+++ b/drivers/soc/brcmstb/pm/pm.h
@@ -0,0 +1,40 @@
+/*
+ * Definitions for Broadcom STB power management / Always ON (AON) block
+ *
+ * Copyright ? 2014 Broadcom Corporation
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
+/* PM_CTRL bitfield */
+#define PM_FAST_PWRDOWN			(1 << 6)
+#define PM_WARM_BOOT			(1 << 5)
+#define PM_DEEP_STANDBY			(1 << 4)
+#define PM_CPU_PWR			(1 << 3)
+#define PM_USE_CPU_RDY			(1 << 2)
+#define PM_PLL_PWRDOWN			(1 << 1)
+#define PM_PWR_DOWN			(1 << 0)
+
+#define PM_S2_COMMAND	(PM_PLL_PWRDOWN | PM_USE_CPU_RDY | PM_PWR_DOWN)
+#define PM_COLD_CONFIG	(PM_PLL_PWRDOWN | PM_DEEP_STANDBY)
+#define PM_WARM_CONFIG	(PM_COLD_CONFIG | PM_USE_CPU_RDY | PM_WARM_BOOT)
+
+#endif /* __BRCMSTB_PM_H__ */
diff --git a/drivers/soc/brcmstb/pm/s2.S b/drivers/soc/brcmstb/pm/s2.S
new file mode 100644
index 000000000000..704c4ecb6f6f
--- /dev/null
+++ b/drivers/soc/brcmstb/pm/s2.S
@@ -0,0 +1,73 @@
+/*
+ * Copyright ? 2014 Broadcom Corporation
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
1.9.1
