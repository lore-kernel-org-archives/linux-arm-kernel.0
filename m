From: chenhui.zhao@freescale.com (Chenhui Zhao)
Date: Fri, 30 Jan 2015 20:22:20 +0800
Subject: [PATCH 3/4] arm: ls1021a: add deep sleep support
In-Reply-To: <1422620541-6843-1-git-send-email-chenhui.zhao@freescale.com>
References: <1422620541-6843-1-git-send-email-chenhui.zhao@freescale.com>
Message-ID: <1422620541-6843-3-git-send-email-chenhui.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ls1021a SoC supports deep sleep feature that can switch off most
parts of the SoC when it is in deep sleep state.

The DDR controller will also be powered off in deep sleep. Therefore,
copy the last stage code to enter deep sleep to SRAM and run it
with disabling MMU and caches.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/arm/mach-imx/Kconfig     |   1 +
 arch/arm/mach-imx/Makefile    |   2 +
 arch/arm/mach-imx/pm-ls1.c    | 374 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/sleep-ls1.S | 137 ++++++++++++++++
 arch/arm/mach-imx/sleep-ls1.h |  19 +++
 5 files changed, 533 insertions(+)
 create mode 100644 arch/arm/mach-imx/pm-ls1.c
 create mode 100644 arch/arm/mach-imx/sleep-ls1.S
 create mode 100644 arch/arm/mach-imx/sleep-ls1.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e8627e0..c10acff 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -664,6 +664,7 @@ config SOC_LS1021A
 	select HAVE_ARM_ARCH_TIMER
 	select PCI_DOMAINS if PCI
 	select ZONE_DMA if ARM_LPAE
+	select FSL_SLEEP_FSM if PM
 
 	help
 	  This enable support for Freescale LS1021A processor.
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index f5ac685..358adf4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o mach-imx6sx.o
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
+AFLAGS_sleep-ls1.o :=-Wa,-march=armv7-a
+obj-$(CONFIG_SOC_LS1021A) += pm-ls1.o sleep-ls1.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
diff --git a/arch/arm/mach-imx/pm-ls1.c b/arch/arm/mach-imx/pm-ls1.c
new file mode 100644
index 0000000..4f9ca80
--- /dev/null
+++ b/arch/arm/mach-imx/pm-ls1.c
@@ -0,0 +1,374 @@
+/*
+ * Support deep sleep feature for LS1
+ *
+ * Copyright 2014-2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/cpu_pm.h>
+#include <asm/suspend.h>
+#include <asm/delay.h>
+#include <asm/cp15.h>
+#include <asm/cacheflush.h>
+#include <asm/idmap.h>
+
+#include "common.h"
+#include "sleep-ls1.h"
+
+#define FSL_SLEEP		0x1
+#define FSL_DEEP_SLEEP		0x2
+
+#define DCSR_EPU_EPSMCR15	0x278
+#define DCSR_EPU_EPECR0		0x300
+#define DCSR_RCPM_CG1CR0	0x31c
+#define DCSR_RCPM_CSTTACR0	0xb00
+
+#define CCSR_SCFG_DPSLPCR	0
+#define CCSR_SCFG_DPSLPCR_VAL	0x1
+#define CCSR_SCFG_PMCINTECR	0x160
+#define CCSR_SCFG_PMCINTLECR	0x164
+#define CCSR_SCFG_PMCINTSR	0x168
+#define CCSR_SCFG_SPARECR2	0x504
+#define CCSR_SCFG_SPARECR3	0x508
+
+#define CCSR_DCFG_CRSTSR	0x400
+#define CCSR_DCFG_CRSTSR_VAL	0x00000008
+
+#define CCSR_RCPM_POWMGTCSR		0x130
+#define CCSR_RCPM_POWMGTCSR_LPM20_REQ	0x00100000
+#define CCSR_RCPM_POWMGTCSR_LPM20_ST	0x00000200
+#define CCSR_RCPM_POWMGTCSR_P_LPM20_ST	0x00000100
+#define CCSR_RCPM_CLPCL10SETR		0x1c4
+#define CCSR_RCPM_CLPCL10SETR_C0	0x1
+#define CCSR_RCPM_IPPDEXPCR0		0x140
+#define CCSR_RCPM_IPPDEXPCR1		0x144
+
+#define QIXIS_CTL_SYS			0x5
+#define QIXIS_CTL_SYS_EVTSW_MASK	0x0c
+#define QIXIS_CTL_SYS_EVTSW_IRQ		0x04
+
+#define QIXIS_PWR_CTL2		0x21
+#define QIXIS_PWR_CTL2_PCTL	0x2
+
+#define OCRAM_BASE	0x10000000
+#define OCRAM_SIZE	0x10000		/* 64K */
+/* use the last page of SRAM */
+#define SRAM_CODE_BASE_PHY	(OCRAM_BASE + OCRAM_SIZE - PAGE_SIZE)
+
+struct ls1_pm_baseaddr {
+	void __iomem *rcpm;
+	void __iomem *epu;
+	void __iomem *dcsr_rcpm1;
+	void __iomem *scfg;
+	void __iomem *dcfg;
+	void __iomem *fpga;
+	void __iomem *sram;
+};
+
+/* 128 bytes buffer for restoring data broke by DDR training initialization */
+#define DDR_BUF_SIZE	128
+static u8 ddr_buff[DDR_BUF_SIZE] __aligned(64);
+static struct ls1_pm_baseaddr ls1_pm_base;
+/* supported sleep modes by the present platform */
+static unsigned int sleep_modes;
+static suspend_state_t ls1_pm_state;
+
+static inline void ls1_clrsetbits_be32(void __iomem *addr, u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = ioread32be(addr);
+	tmp = (tmp & ~mask) | val;
+	iowrite32be(tmp, addr);
+}
+
+static void __iomem *of_iomap_str(const char *compatible)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	if (!np) {
+		pr_err("%s: can not find the compatible \"%s\"\n",
+			__func__, compatible);
+		return NULL;
+	}
+
+	base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!base)
+		return NULL;
+
+	return base;
+}
+
+static int ls1_pm_iomap(void)
+{
+	ls1_pm_base.epu = of_iomap_str("fsl,ls1021a-dcsr-epu");
+	ls1_pm_base.scfg = of_iomap_str("fsl,ls1021a-scfg");
+	ls1_pm_base.dcfg = of_iomap_str("fsl,ls1021a-dcfg");
+	ls1_pm_base.fpga = of_iomap_str("fsl,ls1021aqds-fpga");
+	ls1_pm_base.dcsr_rcpm1 = of_iomap_str("fsl,ls1021a-dcsr-rcpm");
+	ls1_pm_base.sram = ioremap(SRAM_CODE_BASE_PHY, PAGE_SIZE);
+	if (!ls1_pm_base.epu || !ls1_pm_base.scfg || !ls1_pm_base.dcfg ||
+	    !ls1_pm_base.fpga || !ls1_pm_base.dcsr_rcpm1 || !ls1_pm_base.sram)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ls1_pm_uniomap(void)
+{
+	iounmap(ls1_pm_base.epu);
+	iounmap(ls1_pm_base.dcsr_rcpm1);
+	iounmap(ls1_pm_base.scfg);
+	iounmap(ls1_pm_base.dcfg);
+	iounmap(ls1_pm_base.sram);
+	iounmap(ls1_pm_base.fpga);
+}
+
+static void ls1_save_ddr(void __iomem *base)
+{
+	u32 ddr_buff_addr;
+
+	/*
+	 * DDR training initialization will break 128 bytes at the beginning
+	 * of DDR, therefore, save them so that the bootloader will restore
+	 * them. Assume that DDR is mapped to the address space started with
+	 * CONFIG_PAGE_OFFSET.
+	 */
+	memcpy(ddr_buff, (void *)CONFIG_PAGE_OFFSET, DDR_BUF_SIZE);
+
+	ddr_buff_addr = (u32)__pa(ddr_buff);
+
+	/*
+	 * the bootloader will restore the first 128 bytes of DDR from
+	 * the location indicated by the register SPARECR3
+	 */
+	iowrite32(ddr_buff_addr, base + CCSR_SCFG_SPARECR3);
+}
+
+static void ls1_set_resume_entry(void __iomem *base)
+{
+	u32 resume_addr;
+
+	/* the bootloader will finally jump to this address to resume kernel */
+	resume_addr = (u32)(__pa(ls1_deepsleep_resume));
+
+	/* use the register SPARECR2 to save the return entry */
+	iowrite32(resume_addr, base + CCSR_SCFG_SPARECR2);
+}
+
+static void ls1_copy_sram_code(void)
+{
+	memcpy(ls1_pm_base.sram, ls1_start_fsm, ls1_sram_code_size);
+}
+
+static int ls1_start_deepsleep(unsigned long addr)
+{
+	/* Switch to the identity mapping */
+	setup_mm_for_reboot();
+	v7_exit_coherency_flush(all);
+
+	ls1_do_deepsleep(addr);
+
+	/* never get here  */
+	BUG();
+
+	return 0;
+}
+
+static void ls1_fsm_setup(void)
+{
+	/* Request to put cluster 0 in PCL10 state */
+	ls1_clrsetbits_be32(ls1_pm_base.rcpm + CCSR_RCPM_CLPCL10SETR,
+			    CCSR_RCPM_CLPCL10SETR_C0,
+			    CCSR_RCPM_CLPCL10SETR_C0);
+
+	iowrite32be(0x00001001, ls1_pm_base.dcsr_rcpm1 + DCSR_RCPM_CSTTACR0);
+	iowrite32be(0x00000001, ls1_pm_base.dcsr_rcpm1 + DCSR_RCPM_CG1CR0);
+
+	fsl_epu_setup(ls1_pm_base.epu);
+
+	/*
+	 * pull the MCKE signal(EVT4_B pin) low before enabling
+	 * deep sleep signals by FPGA
+	 */
+	iowrite32be(0x5, ls1_pm_base.epu + DCSR_EPU_EPECR0);
+
+	iowrite32be(0x76300000, ls1_pm_base.epu + DCSR_EPU_EPSMCR15);
+}
+
+static void ls1_board_suspend(void)
+{
+	u32 tmp;
+
+	/* connect the EVENT button to IRQ in FPGA */
+	tmp = ioread8(ls1_pm_base.fpga + QIXIS_CTL_SYS);
+	tmp &= ~QIXIS_CTL_SYS_EVTSW_MASK;
+	tmp |= QIXIS_CTL_SYS_EVTSW_IRQ;
+	iowrite8(tmp, ls1_pm_base.fpga + QIXIS_CTL_SYS);
+
+	/*
+	 * enable deep sleep signals in FPGA
+	 * Note that the MCKE signal(EVT4_B pin) should be pulled low (invalid)
+	 * before enabling deep sleep signals.
+	 */
+	tmp = ioread8(ls1_pm_base.fpga + QIXIS_PWR_CTL2);
+	iowrite8(tmp | QIXIS_PWR_CTL2_PCTL,
+			ls1_pm_base.fpga + QIXIS_PWR_CTL2);
+}
+
+static void ls1_board_resume(void)
+{
+	u32 tmp;
+
+	/* disable deep sleep signals in FPGA */
+	tmp = ioread8(ls1_pm_base.fpga + QIXIS_PWR_CTL2);
+	iowrite8(tmp & ~QIXIS_PWR_CTL2_PCTL,
+			ls1_pm_base.fpga + QIXIS_PWR_CTL2);
+
+	tmp = ioread8(ls1_pm_base.fpga + QIXIS_CTL_SYS);
+	tmp &= ~QIXIS_CTL_SYS_EVTSW_MASK;
+	iowrite8(tmp, ls1_pm_base.fpga + QIXIS_CTL_SYS);
+}
+
+static void ls1_enter_deepsleep(void)
+{
+	/* save DDR data */
+	ls1_save_ddr(ls1_pm_base.scfg);
+
+	/* save kernel resume entry */
+	ls1_set_resume_entry(ls1_pm_base.scfg);
+
+	/* setup the registers of the EPU FSM for deep sleep */
+	ls1_fsm_setup();
+
+	ls1_board_suspend();
+
+	/* enable Warm Device Reset */
+	ls1_clrsetbits_be32(ls1_pm_base.scfg + CCSR_SCFG_DPSLPCR,
+			    CCSR_SCFG_DPSLPCR_VAL, CCSR_SCFG_DPSLPCR_VAL);
+
+	ls1_clrsetbits_be32(ls1_pm_base.dcfg + CCSR_DCFG_CRSTSR,
+			    CCSR_DCFG_CRSTSR_VAL, CCSR_DCFG_CRSTSR_VAL);
+
+	/* copy the last stage code to sram */
+	ls1_copy_sram_code();
+
+	cpu_suspend(SRAM_CODE_BASE_PHY, ls1_start_deepsleep);
+
+	/* disable Warm Device Reset */
+	ls1_clrsetbits_be32(ls1_pm_base.scfg + CCSR_SCFG_DPSLPCR,
+			    CCSR_SCFG_DPSLPCR_VAL, 0);
+
+	ls1_board_resume();
+}
+
+static int ls1_suspend_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		flush_cache_louis();
+		ls1_clrsetbits_be32(ls1_pm_base.rcpm + CCSR_RCPM_POWMGTCSR,
+				    CCSR_RCPM_POWMGTCSR_LPM20_REQ,
+				    CCSR_RCPM_POWMGTCSR_LPM20_REQ);
+
+		cpu_do_idle();
+		break;
+
+	case PM_SUSPEND_MEM:
+		ls1_enter_deepsleep();
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ls1_suspend_valid(suspend_state_t state)
+{
+	if ((state == PM_SUSPEND_STANDBY) && (sleep_modes & FSL_SLEEP))
+		return 1;
+
+	if ((state == PM_SUSPEND_MEM) && (sleep_modes & FSL_DEEP_SLEEP))
+		return 1;
+
+	return 0;
+}
+
+static int ls1_suspend_begin(suspend_state_t state)
+{
+	int ret = 0;
+
+	ls1_pm_state = state;
+
+	if (ls1_pm_state == PM_SUSPEND_MEM)
+		ret = ls1_pm_iomap();
+
+	return ret;
+}
+
+static void ls1_suspend_end(void)
+{
+	if (ls1_pm_state == PM_SUSPEND_MEM)
+		ls1_pm_uniomap();
+}
+
+static const struct platform_suspend_ops ls1_suspend_ops = {
+	.valid = ls1_suspend_valid,
+	.enter = ls1_suspend_enter,
+	.begin = ls1_suspend_begin,
+	.end = ls1_suspend_end,
+};
+
+static const struct of_device_id rcpm_matches[] = {
+	{ .compatible = "fsl,ls1021a-rcpm", },
+	{}
+};
+
+static int __init ls1_pm_init(void)
+{
+	struct device_node *np;
+	struct property *prop;
+	void __iomem *base;
+
+	np = of_find_matching_node_and_match(NULL, rcpm_matches, NULL);
+	if (!np) {
+		pr_err("%s: can't find the RCPM node.\n", __func__);
+		return -EINVAL;
+	}
+
+	sleep_modes = FSL_SLEEP;
+	base = of_iomap(np, 0);
+	if (!base) {
+		of_node_put(np);
+		pr_err("%s: failed to map the register set of RCPM node.\n",
+			__func__);
+		return -ENOMEM;
+	}
+	ls1_pm_base.rcpm = base;
+
+	prop = of_find_property(np, "fsl,deep-sleep", NULL);
+	if (prop)
+		sleep_modes |= FSL_DEEP_SLEEP;
+	of_node_put(np);
+
+	suspend_set_ops(&ls1_suspend_ops);
+
+	return 0;
+}
+arch_initcall(ls1_pm_init);
diff --git a/arch/arm/mach-imx/sleep-ls1.S b/arch/arm/mach-imx/sleep-ls1.S
new file mode 100644
index 0000000..2020da6
--- /dev/null
+++ b/arch/arm/mach-imx/sleep-ls1.S
@@ -0,0 +1,137 @@
+/*
+ * Support deep sleep feature for LS1
+ *
+ * Copyright 2014-2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
+#include <asm/cp15.h>
+
+#define CCSR_DDR_BASE			0x01080000
+#define CCSR_DDR_SDRAM_CFG_2		0x114
+
+#define CCSR_SCFG_BASE			0x01570000
+#define CCSR_SCFG_HRSTCR		0x1a8
+
+#define DCSR_EPU_BASE			0x20000000
+#define	DCSR_EPU_EPGCR			0x0
+#define DCSR_EPU_EPECR0			0x300
+#define DCSR_EPU_EPECR15		0x33c
+
+/* for big endian registers */
+.macro ls1_set_bits, addr, value
+	ldr	r4, \addr
+	ldr	r5, [r4]
+	ldr	r6, \value
+	rev	r6, r6
+	orr	r5, r5, r6
+	str	r5, [r4]
+.endm
+
+/* 1000 loops per round */
+.macro ls1_delay, count
+	mov	r0, \count
+11:	mov	r7, #1000
+12:	subs	r7, r7, #1
+	bne	12b
+	subs	r0, r0, #1
+	bne	11b
+.endm
+
+/*
+ * r0: the physical entry address of SRAM code
+ */
+	.align L1_CACHE_SHIFT
+	.pushsection	.idmap.text,"ax"
+ENTRY(ls1_do_deepsleep)
+	/* disable MMU, M bit in SCTLR */
+	mrc	p15, 0, r3, c1, c0, 0
+	bic	r3, r3, #CR_M
+	mcr	p15, 0, r3, c1, c0, 0
+	isb
+
+	/* jump to the code in SRAM using physical address */
+ THUMB( orr r0, r0, #1 )
+	bx	r0
+ENDPROC(ls1_do_deepsleep)
+	.popsection
+
+/*
+ * The code will run in SRAM.
+ */
+	.align L1_CACHE_SHIFT
+ENTRY(ls1_start_fsm)
+	/* set HRSTCR */
+	ls1_set_bits	ls1_ccsr_scfg_hrstcr_addr, ls1_ccsr_scfg_hrstcr_val
+
+	/* Place DDR controller in self refresh mode */
+	ls1_set_bits	ls1_ddr_cfg2_addr, ls1_ddr_cfg2_val
+
+	ls1_delay	#2000
+
+	/* Set EVT4_B to lock the signal MCKE down */
+	ldr	r4, ls1_dcsr_epu_epecr0
+	ldr	r5, ls1_dcsr_epu_epecr0_val
+	rev	r5, r5
+	str	r5, [r4]
+
+	ls1_delay	#2000
+
+	/* Enable all EPU Counters */
+	ls1_set_bits	ls1_dcsr_epu_epgcr_addr, ls1_dcsr_epu_epgcr_val
+
+	/* Set SCU15 */
+	ldr	r4, ls1_dcsr_epu_epecr15
+	ldr	r5, ls1_dcsr_epu_epecr15_val
+	rev	r5, r5
+	str	r5, [r4]
+
+
+	/* Enter WFI mode, and EPU FSM will start */
+20:	wfi
+	b	20b
+
+ls1_ccsr_scfg_hrstcr_addr:
+	.word	CCSR_SCFG_BASE + CCSR_SCFG_HRSTCR
+ls1_ccsr_scfg_hrstcr_val:
+	.word	0x80000000
+
+ls1_ddr_cfg2_addr:
+	.word	CCSR_DDR_BASE + CCSR_DDR_SDRAM_CFG_2
+ls1_ddr_cfg2_val:
+	.word	(1 << 31)
+
+ls1_dcsr_epu_epecr0:
+	.word	DCSR_EPU_BASE + DCSR_EPU_EPECR0
+ls1_dcsr_epu_epecr0_val:
+	.word	0
+
+ls1_dcsr_epu_epgcr_addr:
+	.word	DCSR_EPU_BASE + DCSR_EPU_EPGCR
+ls1_dcsr_epu_epgcr_val:
+	.word	0x80000000
+
+ls1_dcsr_epu_epecr15:
+	.word	DCSR_EPU_BASE + DCSR_EPU_EPECR15
+ls1_dcsr_epu_epecr15_val:
+	.word	0x90000004
+
+ENTRY(ls1_sram_code_size)
+	.word	. - ls1_start_fsm
+
+/* the bootloader will jump to here after wakeup from deep sleep  */
+	.arm
+	.align L1_CACHE_SHIFT
+ENTRY(ls1_deepsleep_resume)
+ THUMB(	adr	r6, BSYM(1f)	)
+ THUMB(	bx	r6		)
+ THUMB(	.thumb			)
+ THUMB(1:			)
+	b cpu_resume
diff --git a/arch/arm/mach-imx/sleep-ls1.h b/arch/arm/mach-imx/sleep-ls1.h
new file mode 100644
index 0000000..2d694ac
--- /dev/null
+++ b/arch/arm/mach-imx/sleep-ls1.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2014-2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ARM_SLEEP_LS1_H
+#define __ARM_SLEEP_LS1_H
+
+void ls1_do_deepsleep(unsigned long addr);
+void ls1_start_fsm(void);
+void ls1_deepsleep_resume(void);
+void fsl_epu_setup(void __iomem *epu_base);
+
+extern int ls1_sram_code_size;
+
+#endif
-- 
1.9.1
