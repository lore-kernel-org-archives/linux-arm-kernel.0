From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  7 Apr 2011 23:24:42 +0200
Subject: [PATCH] ARM: remove support for mxc91231
Message-ID: <1302211482-17926-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since support for mxc91231 was introduced 2009 it only saw patches that
were part of (mxc or arm) global cleanups. The only supported machine
only had 4 devices (2x UART, sdhc, watchdog).

Cc: Dmitriy Taychenachev <dimichxp@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile                               |    1 -
 arch/arm/mach-mxc91231/Kconfig                  |   17 -
 arch/arm/mach-mxc91231/Makefile                 |    2 -
 arch/arm/mach-mxc91231/Makefile.boot            |    3 -
 arch/arm/mach-mxc91231/clock.c                  |  601 -----------------------
 arch/arm/mach-mxc91231/crm_regs.h               |  394 ---------------
 arch/arm/mach-mxc91231/devices.c                |  251 ----------
 arch/arm/mach-mxc91231/devices.h                |   13 -
 arch/arm/mach-mxc91231/iomux.c                  |  177 -------
 arch/arm/mach-mxc91231/magx-zn5.c               |   62 ---
 arch/arm/mach-mxc91231/mm.c                     |   62 ---
 arch/arm/mach-mxc91231/system.c                 |   51 --
 arch/arm/plat-mxc/Kconfig                       |    6 -
 arch/arm/plat-mxc/include/mach/common.h         |    7 -
 arch/arm/plat-mxc/include/mach/debug-macro.S    |    7 -
 arch/arm/plat-mxc/include/mach/hardware.h       |   13 -
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h |  283 -----------
 arch/arm/plat-mxc/include/mach/irqs.h           |    2 -
 arch/arm/plat-mxc/include/mach/memory.h         |    3 -
 arch/arm/plat-mxc/include/mach/mxc.h            |   15 +-
 arch/arm/plat-mxc/include/mach/mxc91231.h       |  256 ----------
 arch/arm/plat-mxc/include/mach/system.h         |    6 -
 arch/arm/plat-mxc/include/mach/timex.h          |    2 -
 arch/arm/plat-mxc/system.c                      |    6 -
 arch/arm/plat-mxc/time.c                        |    2 +-
 25 files changed, 2 insertions(+), 2240 deletions(-)
 delete mode 100644 arch/arm/mach-mxc91231/Kconfig
 delete mode 100644 arch/arm/mach-mxc91231/Makefile
 delete mode 100644 arch/arm/mach-mxc91231/Makefile.boot
 delete mode 100644 arch/arm/mach-mxc91231/clock.c
 delete mode 100644 arch/arm/mach-mxc91231/crm_regs.h
 delete mode 100644 arch/arm/mach-mxc91231/devices.c
 delete mode 100644 arch/arm/mach-mxc91231/devices.h
 delete mode 100644 arch/arm/mach-mxc91231/iomux.c
 delete mode 100644 arch/arm/mach-mxc91231/magx-zn5.c
 delete mode 100644 arch/arm/mach-mxc91231/mm.c
 delete mode 100644 arch/arm/mach-mxc91231/system.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/mxc91231.h

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5af05ab..2b39030 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,7 +160,6 @@ machine-$(CONFIG_ARCH_MX2)		:= imx
 machine-$(CONFIG_ARCH_MX25)		:= imx
 machine-$(CONFIG_ARCH_MX3)		:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
-machine-$(CONFIG_ARCH_MXC91231)		:= mxc91231
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
diff --git a/arch/arm/mach-mxc91231/Kconfig b/arch/arm/mach-mxc91231/Kconfig
deleted file mode 100644
index d513ef9..0000000
--- a/arch/arm/mach-mxc91231/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-if ARCH_MXC91231
-
-comment "MXC91231 platforms:"
-
-config SOC_MXC91231
-	bool
-	select CPU_V6
-	select MXC_AVIC
-
-config MACH_MAGX_ZN5
-	bool "Support Motorola Zn5 GSM phone"
-	select SOC_MXC91231
-	default n
-	help
-	  Include support for Motorola Zn5 GSM phone.
-
-endif
diff --git a/arch/arm/mach-mxc91231/Makefile b/arch/arm/mach-mxc91231/Makefile
deleted file mode 100644
index 011d5e1..0000000
--- a/arch/arm/mach-mxc91231/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y	:= mm.o clock.o devices.o system.o iomux.o
-obj-$(CONFIG_MACH_MAGX_ZN5) += magx-zn5.o
diff --git a/arch/arm/mach-mxc91231/Makefile.boot b/arch/arm/mach-mxc91231/Makefile.boot
deleted file mode 100644
index 9939a19..0000000
--- a/arch/arm/mach-mxc91231/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	:= 0x90008000
-params_phys-y	:= 0x90000100
-initrd_phys-y	:= 0x90800000
diff --git a/arch/arm/mach-mxc91231/clock.c b/arch/arm/mach-mxc91231/clock.c
deleted file mode 100644
index 8745a21..0000000
--- a/arch/arm/mach-mxc91231/clock.c
+++ /dev/null
@@ -1,601 +0,0 @@
-#include <linux/clk.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/clkdev.h>
-
-#include <mach/clock.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
-
-#include <asm/bug.h>
-#include <asm/div64.h>
-
-#include "crm_regs.h"
-
-#define CRM_SMALL_DIVIDER(base, name) \
-	crm_small_divider(base, \
-			  base ## _ ## name ## _OFFSET, \
-			  base ## _ ## name ## _MASK)
-#define CRM_1DIVIDER(base, name) \
-	crm_divider(base, \
-		    base ## _ ## name ## _OFFSET, \
-		    base ## _ ## name ## _MASK, 1)
-#define CRM_16DIVIDER(base, name) \
-	crm_divider(base, \
-		    base ## _ ## name ## _OFFSET, \
-		    base ## _ ## name ## _MASK, 16)
-
-static u32 crm_small_divider(void __iomem *reg, u8 offset, u32 mask)
-{
-	static const u32 crm_small_dividers[] = {
-		2, 3, 4, 5, 6, 8, 10, 12
-	};
-	u8 idx;
-
-	idx = (__raw_readl(reg) & mask) >> offset;
-	if (idx > 7)
-		return 1;
-
-	return crm_small_dividers[idx];
-}
-
-static u32 crm_divider(void __iomem *reg, u8 offset, u32 mask, u32 z)
-{
-	u32 div;
-	div = (__raw_readl(reg) & mask) >> offset;
-	return div ? div : z;
-}
-
-static int _clk_1bit_enable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg |= 1 << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
-
-	return 0;
-}
-
-static void _clk_1bit_disable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(1 << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
-}
-
-static int _clk_3bit_enable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg |= 0x7 << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
-
-	return 0;
-}
-
-static void _clk_3bit_disable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(0x7 << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
-}
-
-static unsigned long ckih_rate;
-
-static unsigned long clk_ckih_get_rate(struct clk *clk)
-{
-	return ckih_rate;
-}
-
-static struct clk ckih_clk = {
-	.get_rate = clk_ckih_get_rate,
-};
-
-static unsigned long clk_ckih_x2_get_rate(struct clk *clk)
-{
-	return 2 * clk_get_rate(clk->parent);
-}
-
-static struct clk ckih_x2_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_ckih_x2_get_rate,
-};
-
-/* plls stuff */
-static struct clk mcu_pll_clk;
-static struct clk dsp_pll_clk;
-static struct clk usb_pll_clk;
-
-static struct clk *pll_clk(u8 sel)
-{
-	switch (sel) {
-	case 0:
-		return &mcu_pll_clk;
-	case 1:
-		return &dsp_pll_clk;
-	case 2:
-		return &usb_pll_clk;
-	}
-	BUG();
-}
-
-static void __iomem *pll_base(struct clk *clk)
-{
-	if (clk == &mcu_pll_clk)
-		return MXC_PLL0_BASE;
-	else if (clk == &dsp_pll_clk)
-		return MXC_PLL1_BASE;
-	else if (clk == &usb_pll_clk)
-		return MXC_PLL2_BASE;
-	BUG();
-}
-
-static unsigned long clk_pll_get_rate(struct clk *clk)
-{
-	const void __iomem *pllbase;
-	unsigned long dp_op, dp_mfd, dp_mfn, pll_hfsm, ref_clk, mfi;
-	long mfn, mfn_abs, mfd, pdf;
-	s64 temp;
-	pllbase = pll_base(clk);
-
-	pll_hfsm = __raw_readl(pllbase + MXC_PLL_DP_CTL) & MXC_PLL_DP_CTL_HFSM;
-	if (pll_hfsm == 0) {
-		dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
-		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
-		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
-	} else {
-		dp_op = __raw_readl(pllbase + MXC_PLL_DP_HFS_OP);
-		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFD);
-		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFN);
-	}
-
-	pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
-	mfi = (dp_op >> MXC_PLL_DP_OP_MFI_OFFSET) & MXC_PLL_DP_OP_PDF_MASK;
-	mfi = (mfi <= 5) ? 5 : mfi;
-	mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
-	mfn = dp_mfn & MXC_PLL_DP_MFN_MASK;
-	mfn = (mfn <= 0x4000000) ? mfn : (mfn - 0x10000000);
-
-	if (mfn < 0)
-		mfn_abs = -mfn;
-	else
-		mfn_abs = mfn;
-
-/* XXX: actually this asumes that ckih is fed to pll, but spec says
- * that ckih_x2 is also possible. need to check this out.
- */
-	ref_clk = clk_get_rate(&ckih_clk);
-
-	ref_clk *= 2;
-	ref_clk /= pdf + 1;
-
-	temp = (u64) ref_clk * mfn_abs;
-	do_div(temp, mfd);
-	if (mfn < 0)
-		temp = -temp;
-	temp += ref_clk * mfi;
-
-	return temp;
-}
-
-static int clk_pll_enable(struct clk *clk)
-{
-	void __iomem *ctl;
-	u32 reg;
-
-	ctl = pll_base(clk);
-	reg = __raw_readl(ctl);
-	reg |= (MXC_PLL_DP_CTL_RST | MXC_PLL_DP_CTL_UPEN);
-	__raw_writel(reg, ctl);
-	do {
-		reg = __raw_readl(ctl);
-	} while ((reg & MXC_PLL_DP_CTL_LRF) != MXC_PLL_DP_CTL_LRF);
-	return 0;
-}
-
-static void clk_pll_disable(struct clk *clk)
-{
-	void __iomem *ctl;
-	u32 reg;
-
-	ctl = pll_base(clk);
-	reg = __raw_readl(ctl);
-	reg &= ~(MXC_PLL_DP_CTL_RST | MXC_PLL_DP_CTL_UPEN);
-	__raw_writel(reg, ctl);
-}
-
-static struct clk mcu_pll_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_pll_get_rate,
-	.enable = clk_pll_enable,
-	.disable = clk_pll_disable,
-};
-
-static struct clk dsp_pll_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_pll_get_rate,
-	.enable = clk_pll_enable,
-	.disable = clk_pll_disable,
-};
-
-static struct clk usb_pll_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_pll_get_rate,
-	.enable = clk_pll_enable,
-	.disable = clk_pll_disable,
-};
-/* plls stuff end */
-
-/* ap_ref_clk stuff */
-static struct clk ap_ref_clk;
-
-static unsigned long clk_ap_ref_get_rate(struct clk *clk)
-{
-	u32 ascsr, acsr;
-	u8 ap_pat_ref_div_2, ap_isel, acs, ads;
-
-	ascsr = __raw_readl(MXC_CRMAP_ASCSR);
-	acsr = __raw_readl(MXC_CRMAP_ACSR);
-
-	/* 0 for ckih, 1 for ckih*2 */
-	ap_isel = ascsr & MXC_CRMAP_ASCSR_APISEL;
-	/* reg divider */
-	ap_pat_ref_div_2 = (ascsr >> MXC_CRMAP_ASCSR_AP_PATDIV2_OFFSET) & 0x1;
-	/* undocumented, 1 for disabling divider */
-	ads = (acsr >> MXC_CRMAP_ACSR_ADS_OFFSET) & 0x1;
-	/* 0 for pat_ref, 1 for divider out */
-	acs = acsr & MXC_CRMAP_ACSR_ACS;
-
-	if (acs & !ads)
-		/* use divided clock */
-		return clk_get_rate(clk->parent) / (ap_pat_ref_div_2 ? 2 : 1);
-
-	return clk_get_rate(clk->parent) * (ap_isel ? 2 : 1);
-}
-
-static struct clk ap_ref_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_ap_ref_get_rate,
-};
-/* ap_ref_clk stuff end */
-
-/* ap_pre_dfs_clk stuff */
-static struct clk ap_pre_dfs_clk;
-
-static unsigned long clk_ap_pre_dfs_get_rate(struct clk *clk)
-{
-	u32 acsr, ascsr;
-
-	acsr = __raw_readl(MXC_CRMAP_ACSR);
-	ascsr = __raw_readl(MXC_CRMAP_ASCSR);
-
-	if (acsr & MXC_CRMAP_ACSR_ACS) {
-		u8 sel;
-		sel = (ascsr & MXC_CRMAP_ASCSR_APSEL_MASK) >>
-			MXC_CRMAP_ASCSR_APSEL_OFFSET;
-		return clk_get_rate(pll_clk(sel)) /
-			CRM_SMALL_DIVIDER(MXC_CRMAP_ACDR, ARMDIV);
-	}
-	return clk_get_rate(&ap_ref_clk);
-}
-
-static struct clk ap_pre_dfs_clk = {
-	.get_rate = clk_ap_pre_dfs_get_rate,
-};
-/* ap_pre_dfs_clk stuff end */
-
-/* usb_clk stuff */
-static struct clk usb_clk;
-
-static struct clk *clk_usb_parent(struct clk *clk)
-{
-	u32 acsr, ascsr;
-
-	acsr = __raw_readl(MXC_CRMAP_ACSR);
-	ascsr = __raw_readl(MXC_CRMAP_ASCSR);
-
-	if (acsr & MXC_CRMAP_ACSR_ACS) {
-		u8 sel;
-		sel = (ascsr & MXC_CRMAP_ASCSR_USBSEL_MASK) >>
-			MXC_CRMAP_ASCSR_USBSEL_OFFSET;
-		return pll_clk(sel);
-	}
-	return &ap_ref_clk;
-}
-
-static unsigned long clk_usb_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) /
-		CRM_SMALL_DIVIDER(MXC_CRMAP_ACDER2, USBDIV);
-}
-
-static struct clk usb_clk = {
-	.enable_reg = MXC_CRMAP_ACDER2,
-	.enable_shift = MXC_CRMAP_ACDER2_USBEN_OFFSET,
-	.get_rate = clk_usb_get_rate,
-	.enable = _clk_1bit_enable,
-	.disable = _clk_1bit_disable,
-};
-/* usb_clk stuff end */
-
-static unsigned long clk_ipg_get_rate(struct clk *clk)
-{
-	return clk_get_rate(clk->parent) / CRM_16DIVIDER(MXC_CRMAP_ACDR, IPDIV);
-}
-
-static struct clk ipg_clk = {
-	.parent = &ap_pre_dfs_clk,
-	.get_rate = clk_ipg_get_rate,
-};
-
-/* perclk_clk stuff */
-static struct clk perclk_clk;
-
-static unsigned long clk_perclk_get_rate(struct clk *clk)
-{
-	u32 acder2;
-
-	acder2 = __raw_readl(MXC_CRMAP_ACDER2);
-	if (acder2 & MXC_CRMAP_ACDER2_BAUD_ISEL_MASK)
-		return 2 * clk_get_rate(clk->parent);
-
-	return clk_get_rate(clk->parent);
-}
-
-static struct clk perclk_clk = {
-	.parent = &ckih_clk,
-	.get_rate = clk_perclk_get_rate,
-};
-/* perclk_clk stuff end */
-
-/* uart_clk stuff */
-static struct clk uart_clk[];
-
-static unsigned long clk_uart_get_rate(struct clk *clk)
-{
-	u32 div;
-
-	switch (clk->id) {
-	case 0:
-	case 1:
-		div = CRM_SMALL_DIVIDER(MXC_CRMAP_ACDER2, BAUDDIV);
-		break;
-	case 2:
-		div = CRM_SMALL_DIVIDER(MXC_CRMAP_APRA, UART3DIV);
-		break;
-	default:
-		BUG();
-	}
-	return clk_get_rate(clk->parent) / div;
-}
-
-static struct clk uart_clk[] = {
-	{
-		.id = 0,
-		.parent = &perclk_clk,
-		.enable_reg = MXC_CRMAP_APRA,
-		.enable_shift = MXC_CRMAP_APRA_UART1EN_OFFSET,
-		.get_rate = clk_uart_get_rate,
-		.enable = _clk_1bit_enable,
-		.disable = _clk_1bit_disable,
-	}, {
-		.id = 1,
-		.parent = &perclk_clk,
-		.enable_reg = MXC_CRMAP_APRA,
-		.enable_shift = MXC_CRMAP_APRA_UART2EN_OFFSET,
-		.get_rate = clk_uart_get_rate,
-		.enable = _clk_1bit_enable,
-		.disable = _clk_1bit_disable,
-	}, {
-		.id = 2,
-		.parent = &perclk_clk,
-		.enable_reg = MXC_CRMAP_APRA,
-		.enable_shift = MXC_CRMAP_APRA_UART3EN_OFFSET,
-		.get_rate = clk_uart_get_rate,
-		.enable = _clk_1bit_enable,
-		.disable = _clk_1bit_disable,
-	},
-};
-/* uart_clk stuff end */
-
-/* sdhc_clk stuff */
-static struct clk sdhc_clk[];
-
-static struct clk *clk_sdhc_parent(struct clk *clk)
-{
-	u32 aprb;
-	u8 sel;
-	u32 mask;
-	int offset;
-
-	aprb = __raw_readl(MXC_CRMAP_APRB);
-
-	switch (clk->id) {
-	case 0:
-		mask = MXC_CRMAP_APRB_SDHC1_ISEL_MASK;
-		offset = MXC_CRMAP_APRB_SDHC1_ISEL_OFFSET;
-		break;
-	case 1:
-		mask = MXC_CRMAP_APRB_SDHC2_ISEL_MASK;
-		offset = MXC_CRMAP_APRB_SDHC2_ISEL_OFFSET;
-		break;
-	default:
-		BUG();
-	}
-	sel = (aprb & mask) >> offset;
-
-	switch (sel) {
-	case 0:
-		return &ckih_clk;
-	case 1:
-		return &ckih_x2_clk;
-	}
-	return &usb_clk;
-}
-
-static unsigned long clk_sdhc_get_rate(struct clk *clk)
-{
-	u32 div;
-
-	switch (clk->id) {
-	case 0:
-		div = CRM_SMALL_DIVIDER(MXC_CRMAP_APRB, SDHC1_DIV);
-		break;
-	case 1:
-		div = CRM_SMALL_DIVIDER(MXC_CRMAP_APRB, SDHC2_DIV);
-		break;
-	default:
-		BUG();
-	}
-
-	return clk_get_rate(clk->parent) / div;
-}
-
-static int clk_sdhc_enable(struct clk *clk)
-{
-	u32 amlpmre1, aprb;
-
-	amlpmre1 = __raw_readl(MXC_CRMAP_AMLPMRE1);
-	aprb = __raw_readl(MXC_CRMAP_APRB);
-	switch (clk->id) {
-	case 0:
-		amlpmre1 |= (0x7 << MXC_CRMAP_AMLPMRE1_MLPME4_OFFSET);
-		aprb |= (0x1 << MXC_CRMAP_APRB_SDHC1EN_OFFSET);
-		break;
-	case 1:
-		amlpmre1 |= (0x7 << MXC_CRMAP_AMLPMRE1_MLPME5_OFFSET);
-		aprb |= (0x1 << MXC_CRMAP_APRB_SDHC2EN_OFFSET);
-		break;
-	}
-	__raw_writel(amlpmre1, MXC_CRMAP_AMLPMRE1);
-	__raw_writel(aprb, MXC_CRMAP_APRB);
-	return 0;
-}
-
-static void clk_sdhc_disable(struct clk *clk)
-{
-	u32 amlpmre1, aprb;
-
-	amlpmre1 = __raw_readl(MXC_CRMAP_AMLPMRE1);
-	aprb = __raw_readl(MXC_CRMAP_APRB);
-	switch (clk->id) {
-	case 0:
-		amlpmre1 &= ~(0x7 << MXC_CRMAP_AMLPMRE1_MLPME4_OFFSET);
-		aprb &= ~(0x1 << MXC_CRMAP_APRB_SDHC1EN_OFFSET);
-		break;
-	case 1:
-		amlpmre1 &= ~(0x7 << MXC_CRMAP_AMLPMRE1_MLPME5_OFFSET);
-		aprb &= ~(0x1 << MXC_CRMAP_APRB_SDHC2EN_OFFSET);
-		break;
-	}
-	__raw_writel(amlpmre1, MXC_CRMAP_AMLPMRE1);
-	__raw_writel(aprb, MXC_CRMAP_APRB);
-}
-
-static struct clk sdhc_clk[] = {
-	{
-		.id = 0,
-		.get_rate = clk_sdhc_get_rate,
-		.enable = clk_sdhc_enable,
-		.disable = clk_sdhc_disable,
-	}, {
-		.id = 1,
-		.get_rate = clk_sdhc_get_rate,
-		.enable = clk_sdhc_enable,
-		.disable = clk_sdhc_disable,
-	},
-};
-/* sdhc_clk stuff end */
-
-/* wdog_clk stuff */
-static struct clk wdog_clk[] = {
-	{
-		.id = 0,
-		.parent = &ipg_clk,
-		.enable_reg = MXC_CRMAP_AMLPMRD,
-		.enable_shift = MXC_CRMAP_AMLPMRD_MLPMD7_OFFSET,
-		.enable = _clk_3bit_enable,
-		.disable = _clk_3bit_disable,
-	}, {
-		.id = 1,
-		.parent = &ipg_clk,
-		.enable_reg = MXC_CRMAP_AMLPMRD,
-		.enable_shift = MXC_CRMAP_AMLPMRD_MLPMD3_OFFSET,
-		.enable = _clk_3bit_enable,
-		.disable = _clk_3bit_disable,
-	},
-};
-/* wdog_clk stuff end */
-
-/* gpt_clk stuff */
-static struct clk gpt_clk = {
-	.parent = &ipg_clk,
-	.enable_reg = MXC_CRMAP_AMLPMRC,
-	.enable_shift = MXC_CRMAP_AMLPMRC_MLPMC4_OFFSET,
-	.enable = _clk_3bit_enable,
-	.disable = _clk_3bit_disable,
-};
-/* gpt_clk stuff end */
-
-/* cspi_clk stuff */
-static struct clk cspi_clk[] = {
-	{
-		.id = 0,
-		.parent = &ipg_clk,
-		.enable_reg = MXC_CRMAP_AMLPMRE2,
-		.enable_shift = MXC_CRMAP_AMLPMRE2_MLPME0_OFFSET,
-		.enable = _clk_3bit_enable,
-		.disable = _clk_3bit_disable,
-	}, {
-		.id = 1,
-		.parent = &ipg_clk,
-		.enable_reg = MXC_CRMAP_AMLPMRE1,
-		.enable_shift = MXC_CRMAP_AMLPMRE1_MLPME6_OFFSET,
-		.enable = _clk_3bit_enable,
-		.disable = _clk_3bit_disable,
-	},
-};
-/* cspi_clk stuff end */
-
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
-static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk[0])
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk[1])
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk[2])
-	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc_clk[0])
-	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc_clk[1])
-	_REGISTER_CLOCK("mxc-wdt.0", NULL, wdog_clk[0])
-	_REGISTER_CLOCK("spi_imx.0", NULL, cspi_clk[0])
-	_REGISTER_CLOCK("spi_imx.1", NULL, cspi_clk[1])
-};
-
-int __init mxc91231_clocks_init(unsigned long fref)
-{
-	void __iomem *gpt_base;
-
-	ckih_rate = fref;
-
-	usb_clk.parent = clk_usb_parent(&usb_clk);
-	sdhc_clk[0].parent = clk_sdhc_parent(&sdhc_clk[0]);
-	sdhc_clk[1].parent = clk_sdhc_parent(&sdhc_clk[1]);
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	gpt_base = MXC91231_IO_ADDRESS(MXC91231_GPT1_BASE_ADDR);
-	mxc_timer_init(&gpt_clk, gpt_base, MXC91231_INT_GPT);
-
-	return 0;
-}
diff --git a/arch/arm/mach-mxc91231/crm_regs.h b/arch/arm/mach-mxc91231/crm_regs.h
deleted file mode 100644
index b989bac..0000000
--- a/arch/arm/mach-mxc91231/crm_regs.h
+++ /dev/null
@@ -1,394 +0,0 @@
-/*
- * Copyright 2006 Freescale Semiconductor, Inc.
- * Copyright 2006-2007 Motorola, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _ARCH_ARM_MACH_MXC91231_CRM_REGS_H_
-#define _ARCH_ARM_MACH_MXC91231_CRM_REGS_H_
-
-#define CKIL_CLK_FREQ			32768
-
-#define MXC_CRM_AP_BASE			MXC91231_IO_ADDRESS(MXC91231_CRM_AP_BASE_ADDR)
-#define MXC_CRM_COM_BASE		MXC91231_IO_ADDRESS(MXC91231_CRM_COM_BASE_ADDR)
-#define MXC_DSM_BASE			MXC91231_IO_ADDRESS(MXC91231_DSM_BASE_ADDR)
-#define MXC_PLL0_BASE			MXC91231_IO_ADDRESS(MXC91231_PLL0_BASE_ADDR)
-#define MXC_PLL1_BASE			MXC91231_IO_ADDRESS(MXC91231_PLL1_BASE_ADDR)
-#define MXC_PLL2_BASE			MXC91231_IO_ADDRESS(MXC91231_PLL2_BASE_ADDR)
-#define MXC_CLKCTL_BASE			MXC91231_IO_ADDRESS(MXC91231_CLKCTL_BASE_ADDR)
-
-/* PLL Register Offsets */
-#define MXC_PLL_DP_CTL			0x00
-#define MXC_PLL_DP_CONFIG		0x04
-#define MXC_PLL_DP_OP			0x08
-#define MXC_PLL_DP_MFD			0x0C
-#define MXC_PLL_DP_MFN			0x10
-#define MXC_PLL_DP_HFS_OP		0x1C
-#define MXC_PLL_DP_HFS_MFD		0x20
-#define MXC_PLL_DP_HFS_MFN		0x24
-
-/* PLL Register Bit definitions */
-#define MXC_PLL_DP_CTL_DPDCK0_2_EN	0x1000
-#define MXC_PLL_DP_CTL_ADE		0x800
-#define MXC_PLL_DP_CTL_REF_CLK_DIV	0x400
-#define MXC_PLL_DP_CTL_HFSM		0x80
-#define MXC_PLL_DP_CTL_PRE		0x40
-#define MXC_PLL_DP_CTL_UPEN		0x20
-#define MXC_PLL_DP_CTL_RST		0x10
-#define MXC_PLL_DP_CTL_RCP		0x8
-#define MXC_PLL_DP_CTL_PLM		0x4
-#define MXC_PLL_DP_CTL_BRM0		0x2
-#define MXC_PLL_DP_CTL_LRF		0x1
-
-#define MXC_PLL_DP_OP_MFI_OFFSET	4
-#define MXC_PLL_DP_OP_MFI_MASK		0xF
-#define MXC_PLL_DP_OP_PDF_OFFSET	0
-#define MXC_PLL_DP_OP_PDF_MASK		0xF
-
-#define MXC_PLL_DP_MFD_OFFSET		0
-#define MXC_PLL_DP_MFD_MASK		0x7FFFFFF
-
-#define MXC_PLL_DP_MFN_OFFSET		0
-#define MXC_PLL_DP_MFN_MASK		0x7FFFFFF
-
-/* CRM AP Register Offsets */
-#define MXC_CRMAP_ASCSR			(MXC_CRM_AP_BASE + 0x00)
-#define MXC_CRMAP_ACDR			(MXC_CRM_AP_BASE + 0x04)
-#define MXC_CRMAP_ACDER1		(MXC_CRM_AP_BASE + 0x08)
-#define MXC_CRMAP_ACDER2		(MXC_CRM_AP_BASE + 0x0C)
-#define MXC_CRMAP_ACGCR			(MXC_CRM_AP_BASE + 0x10)
-#define MXC_CRMAP_ACCGCR		(MXC_CRM_AP_BASE + 0x14)
-#define MXC_CRMAP_AMLPMRA		(MXC_CRM_AP_BASE + 0x18)
-#define MXC_CRMAP_AMLPMRB		(MXC_CRM_AP_BASE + 0x1C)
-#define MXC_CRMAP_AMLPMRC		(MXC_CRM_AP_BASE + 0x20)
-#define MXC_CRMAP_AMLPMRD		(MXC_CRM_AP_BASE + 0x24)
-#define MXC_CRMAP_AMLPMRE1		(MXC_CRM_AP_BASE + 0x28)
-#define MXC_CRMAP_AMLPMRE2		(MXC_CRM_AP_BASE + 0x2C)
-#define MXC_CRMAP_AMLPMRF		(MXC_CRM_AP_BASE + 0x30)
-#define MXC_CRMAP_AMLPMRG		(MXC_CRM_AP_BASE + 0x34)
-#define MXC_CRMAP_APGCR			(MXC_CRM_AP_BASE + 0x38)
-#define MXC_CRMAP_ACSR			(MXC_CRM_AP_BASE + 0x3C)
-#define MXC_CRMAP_ADCR			(MXC_CRM_AP_BASE + 0x40)
-#define MXC_CRMAP_ACR			(MXC_CRM_AP_BASE + 0x44)
-#define MXC_CRMAP_AMCR			(MXC_CRM_AP_BASE + 0x48)
-#define MXC_CRMAP_APCR			(MXC_CRM_AP_BASE + 0x4C)
-#define MXC_CRMAP_AMORA			(MXC_CRM_AP_BASE + 0x50)
-#define MXC_CRMAP_AMORB			(MXC_CRM_AP_BASE + 0x54)
-#define MXC_CRMAP_AGPR			(MXC_CRM_AP_BASE + 0x58)
-#define MXC_CRMAP_APRA			(MXC_CRM_AP_BASE + 0x5C)
-#define MXC_CRMAP_APRB			(MXC_CRM_AP_BASE + 0x60)
-#define MXC_CRMAP_APOR			(MXC_CRM_AP_BASE + 0x64)
-#define MXC_CRMAP_ADFMR			(MXC_CRM_AP_BASE + 0x68)
-
-/* CRM AP Register Bit definitions */
-#define MXC_CRMAP_ASCSR_CRS			0x10000
-#define MXC_CRMAP_ASCSR_AP_PATDIV2_OFFSET	15
-#define MXC_CRMAP_ASCSR_AP_PATREF_DIV2		0x8000
-#define MXC_CRMAP_ASCSR_USBSEL_OFFSET		13
-#define MXC_CRMAP_ASCSR_USBSEL_MASK		(0x3 << 13)
-#define MXC_CRMAP_ASCSR_CSISEL_OFFSET		11
-#define MXC_CRMAP_ASCSR_CSISEL_MASK		(0x3 << 11)
-#define MXC_CRMAP_ASCSR_SSI2SEL_OFFSET		7
-#define MXC_CRMAP_ASCSR_SSI2SEL_MASK		(0x3 << 7)
-#define MXC_CRMAP_ASCSR_SSI1SEL_OFFSET		5
-#define MXC_CRMAP_ASCSR_SSI1SEL_MASK		(0x3 << 5)
-#define MXC_CRMAP_ASCSR_APSEL_OFFSET		3
-#define MXC_CRMAP_ASCSR_APSEL_MASK		(0x3 << 3)
-#define MXC_CRMAP_ASCSR_AP_PATDIV1_OFFSET	2
-#define MXC_CRMAP_ASCSR_AP_PATREF_DIV1		0x4
-#define MXC_CRMAP_ASCSR_APISEL			0x1
-
-#define MXC_CRMAP_ACDR_ARMDIV_OFFSET		8
-#define MXC_CRMAP_ACDR_ARMDIV_MASK		(0xF << 8)
-#define MXC_CRMAP_ACDR_AHBDIV_OFFSET		4
-#define MXC_CRMAP_ACDR_AHBDIV_MASK		(0xF << 4)
-#define MXC_CRMAP_ACDR_IPDIV_OFFSET		0
-#define MXC_CRMAP_ACDR_IPDIV_MASK		0xF
-
-#define MXC_CRMAP_ACDER1_CSIEN_OFFSET		30
-#define MXC_CRMAP_ACDER1_CSIDIV_OFFSET		24
-#define MXC_CRMAP_ACDER1_CSIDIV_MASK		(0x3F << 24)
-#define MXC_CRMAP_ACDER1_SSI2EN_OFFSET		14
-#define MXC_CRMAP_ACDER1_SSI2DIV_OFFSET		8
-#define MXC_CRMAP_ACDER1_SSI2DIV_MASK		(0x3F << 8)
-#define MXC_CRMAP_ACDER1_SSI1EN_OFFSET		6
-#define MXC_CRMAP_ACDER1_SSI1DIV_OFFSET		0
-#define MXC_CRMAP_ACDER1_SSI1DIV_MASK		0x3F
-
-#define MXC_CRMAP_ACDER2_CRCT_CLK_DIV_OFFSET	24
-#define MXC_CRMAP_ACDER2_CRCT_CLK_DIV_MASK	(0x7 << 24)
-#define MXC_CRMAP_ACDER2_NFCEN_OFFSET		20
-#define MXC_CRMAP_ACDER2_NFCDIV_OFFSET		16
-#define MXC_CRMAP_ACDER2_NFCDIV_MASK		(0xF << 16)
-#define MXC_CRMAP_ACDER2_USBEN_OFFSET		12
-#define MXC_CRMAP_ACDER2_USBDIV_OFFSET		8
-#define MXC_CRMAP_ACDER2_USBDIV_MASK		(0xF << 8)
-#define MXC_CRMAP_ACDER2_BAUD_ISEL_OFFSET	5
-#define MXC_CRMAP_ACDER2_BAUD_ISEL_MASK		(0x3 << 5)
-#define MXC_CRMAP_ACDER2_BAUDDIV_OFFSET		0
-#define MXC_CRMAP_ACDER2_BAUDDIV_MASK		0xF
-
-#define MXC_CRMAP_AMLPMRA_MLPMA7_OFFSET		22
-#define MXC_CRMAP_AMLPMRA_MLPMA7_MASK		(0x7 << 22)
-#define MXC_CRMAP_AMLPMRA_MLPMA6_OFFSET		19
-#define MXC_CRMAP_AMLPMRA_MLPMA6_MASK		(0x7 << 19)
-#define MXC_CRMAP_AMLPMRA_MLPMA4_OFFSET		12
-#define MXC_CRMAP_AMLPMRA_MLPMA4_MASK		(0x7 << 12)
-#define MXC_CRMAP_AMLPMRA_MLPMA3_OFFSET		9
-#define MXC_CRMAP_AMLPMRA_MLPMA3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRA_MLPMA2_OFFSET		6
-#define MXC_CRMAP_AMLPMRA_MLPMA2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRA_MLPMA1_OFFSET		3
-#define MXC_CRMAP_AMLPMRA_MLPMA1_MASK		(0x7 << 3)
-
-#define MXC_CRMAP_AMLPMRB_MLPMB0_OFFSET		0
-#define MXC_CRMAP_AMLPMRB_MLPMB0_MASK		0x7
-
-#define MXC_CRMAP_AMLPMRC_MLPMC9_OFFSET		28
-#define MXC_CRMAP_AMLPMRC_MLPMC9_MASK		(0x7 << 28)
-#define MXC_CRMAP_AMLPMRC_MLPMC7_OFFSET		22
-#define MXC_CRMAP_AMLPMRC_MLPMC7_MASK		(0x7 << 22)
-#define MXC_CRMAP_AMLPMRC_MLPMC5_OFFSET		16
-#define MXC_CRMAP_AMLPMRC_MLPMC5_MASK		(0x7 << 16)
-#define MXC_CRMAP_AMLPMRC_MLPMC4_OFFSET		12
-#define MXC_CRMAP_AMLPMRC_MLPMC4_MASK		(0x7 << 12)
-#define MXC_CRMAP_AMLPMRC_MLPMC3_OFFSET		9
-#define MXC_CRMAP_AMLPMRC_MLPMC3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRC_MLPMC2_OFFSET		6
-#define MXC_CRMAP_AMLPMRC_MLPMC2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRC_MLPMC1_OFFSET		3
-#define MXC_CRMAP_AMLPMRC_MLPMC1_MASK		(0x7 << 3)
-#define MXC_CRMAP_AMLPMRC_MLPMC0_OFFSET		0
-#define MXC_CRMAP_AMLPMRC_MLPMC0_MASK		0x7
-
-#define MXC_CRMAP_AMLPMRD_MLPMD7_OFFSET		22
-#define MXC_CRMAP_AMLPMRD_MLPMD7_MASK		(0x7 << 22)
-#define MXC_CRMAP_AMLPMRD_MLPMD4_OFFSET		12
-#define MXC_CRMAP_AMLPMRD_MLPMD4_MASK		(0x7 << 12)
-#define MXC_CRMAP_AMLPMRD_MLPMD3_OFFSET		9
-#define MXC_CRMAP_AMLPMRD_MLPMD3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRD_MLPMD2_OFFSET		6
-#define MXC_CRMAP_AMLPMRD_MLPMD2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRD_MLPMD0_OFFSET		0
-#define MXC_CRMAP_AMLPMRD_MLPMD0_MASK		0x7
-
-#define MXC_CRMAP_AMLPMRE1_MLPME9_OFFSET	28
-#define MXC_CRMAP_AMLPMRE1_MLPME9_MASK		(0x7 << 28)
-#define MXC_CRMAP_AMLPMRE1_MLPME8_OFFSET	25
-#define MXC_CRMAP_AMLPMRE1_MLPME8_MASK		(0x7 << 25)
-#define MXC_CRMAP_AMLPMRE1_MLPME7_OFFSET	22
-#define MXC_CRMAP_AMLPMRE1_MLPME7_MASK		(0x7 << 22)
-#define MXC_CRMAP_AMLPMRE1_MLPME6_OFFSET	19
-#define MXC_CRMAP_AMLPMRE1_MLPME6_MASK		(0x7 << 19)
-#define MXC_CRMAP_AMLPMRE1_MLPME5_OFFSET	16
-#define MXC_CRMAP_AMLPMRE1_MLPME5_MASK		(0x7 << 16)
-#define MXC_CRMAP_AMLPMRE1_MLPME4_OFFSET	12
-#define MXC_CRMAP_AMLPMRE1_MLPME4_MASK		(0x7 << 12)
-#define MXC_CRMAP_AMLPMRE1_MLPME3_OFFSET	9
-#define MXC_CRMAP_AMLPMRE1_MLPME3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRE1_MLPME2_OFFSET	6
-#define MXC_CRMAP_AMLPMRE1_MLPME2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRE1_MLPME1_OFFSET	3
-#define MXC_CRMAP_AMLPMRE1_MLPME1_MASK		(0x7 << 3)
-#define MXC_CRMAP_AMLPMRE1_MLPME0_OFFSET	0
-#define MXC_CRMAP_AMLPMRE1_MLPME0_MASK		0x7
-
-#define MXC_CRMAP_AMLPMRE2_MLPME0_OFFSET	0
-#define MXC_CRMAP_AMLPMRE2_MLPME0_MASK		0x7
-
-#define MXC_CRMAP_AMLPMRF_MLPMF6_OFFSET		19
-#define MXC_CRMAP_AMLPMRF_MLPMF6_MASK		(0x7 << 19)
-#define MXC_CRMAP_AMLPMRF_MLPMF5_OFFSET		16
-#define MXC_CRMAP_AMLPMRF_MLPMF5_MASK		(0x7 << 16)
-#define MXC_CRMAP_AMLPMRF_MLPMF3_OFFSET		9
-#define MXC_CRMAP_AMLPMRF_MLPMF3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRF_MLPMF2_OFFSET		6
-#define MXC_CRMAP_AMLPMRF_MLPMF2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRF_MLPMF1_OFFSET		3
-#define MXC_CRMAP_AMLPMRF_MLPMF1_MASK		(0x7 << 3)
-#define MXC_CRMAP_AMLPMRF_MLPMF0_OFFSET		0
-#define MXC_CRMAP_AMLPMRF_MLPMF0_MASK		(0x7 << 0)
-
-#define MXC_CRMAP_AMLPMRG_MLPMG9_OFFSET		28
-#define MXC_CRMAP_AMLPMRG_MLPMG9_MASK		(0x7 << 28)
-#define MXC_CRMAP_AMLPMRG_MLPMG7_OFFSET		22
-#define MXC_CRMAP_AMLPMRG_MLPMG7_MASK		(0x7 << 22)
-#define MXC_CRMAP_AMLPMRG_MLPMG6_OFFSET		19
-#define MXC_CRMAP_AMLPMRG_MLPMG6_MASK		(0x7 << 19)
-#define MXC_CRMAP_AMLPMRG_MLPMG5_OFFSET		16
-#define MXC_CRMAP_AMLPMRG_MLPMG5_MASK		(0x7 << 16)
-#define MXC_CRMAP_AMLPMRG_MLPMG4_OFFSET		12
-#define MXC_CRMAP_AMLPMRG_MLPMG4_MASK		(0x7 << 12)
-#define MXC_CRMAP_AMLPMRG_MLPMG3_OFFSET		9
-#define MXC_CRMAP_AMLPMRG_MLPMG3_MASK		(0x7 << 9)
-#define MXC_CRMAP_AMLPMRG_MLPMG2_OFFSET		6
-#define MXC_CRMAP_AMLPMRG_MLPMG2_MASK		(0x7 << 6)
-#define MXC_CRMAP_AMLPMRG_MLPMG1_OFFSET		3
-#define MXC_CRMAP_AMLPMRG_MLPMG1_MASK		(0x7 << 3)
-#define MXC_CRMAP_AMLPMRG_MLPMG0_OFFSET		0
-#define MXC_CRMAP_AMLPMRG_MLPMG0_MASK		0x7
-
-#define MXC_CRMAP_AGPR_IPUPAD_OFFSET		20
-#define MXC_CRMAP_AGPR_IPUPAD_MASK		(0x7 << 20)
-
-#define MXC_CRMAP_APRA_EL1TEN_OFFSET		29
-#define MXC_CRMAP_APRA_SIMEN_OFFSET		24
-#define MXC_CRMAP_APRA_UART3DIV_OFFSET		17
-#define MXC_CRMAP_APRA_UART3DIV_MASK		(0xF << 17)
-#define MXC_CRMAP_APRA_UART3EN_OFFSET		16
-#define MXC_CRMAP_APRA_SAHARA_DIV2_CLKEN_OFFSET	14
-#define MXC_CRMAP_APRA_MQSPIEN_OFFSET		13
-#define MXC_CRMAP_APRA_UART2EN_OFFSET		8
-#define MXC_CRMAP_APRA_UART1EN_OFFSET		0
-
-#define MXC_CRMAP_APRB_SDHC2_ISEL_OFFSET	13
-#define MXC_CRMAP_APRB_SDHC2_ISEL_MASK		(0x7 << 13)
-#define MXC_CRMAP_APRB_SDHC2_DIV_OFFSET		9
-#define MXC_CRMAP_APRB_SDHC2_DIV_MASK		(0xF << 9)
-#define MXC_CRMAP_APRB_SDHC2EN_OFFSET		8
-#define MXC_CRMAP_APRB_SDHC1_ISEL_OFFSET	5
-#define MXC_CRMAP_APRB_SDHC1_ISEL_MASK		(0x7 << 5)
-#define MXC_CRMAP_APRB_SDHC1_DIV_OFFSET		1
-#define MXC_CRMAP_APRB_SDHC1_DIV_MASK		(0xF << 1)
-#define MXC_CRMAP_APRB_SDHC1EN_OFFSET		0
-
-#define MXC_CRMAP_ACSR_ADS_OFFSET		8
-#define MXC_CRMAP_ACSR_ADS			(0x1 << 8)
-#define MXC_CRMAP_ACSR_ACS			0x1
-
-#define MXC_CRMAP_ADCR_LFDF_0			(0x0 << 8)
-#define MXC_CRMAP_ADCR_LFDF_2			(0x1 << 8)
-#define MXC_CRMAP_ADCR_LFDF_4			(0x2 << 8)
-#define MXC_CRMAP_ADCR_LFDF_8			(0x3 << 8)
-#define MXC_CRMAP_ADCR_LFDF_OFFSET		8
-#define MXC_CRMAP_ADCR_LFDF_MASK		(0x3 << 8)
-#define MXC_CRMAP_ADCR_ALT_PLL			0x80
-#define MXC_CRMAP_ADCR_DFS_DIVEN		0x20
-#define MXC_CRMAP_ADCR_DIV_BYP			0x2
-#define MXC_CRMAP_ADCR_VSTAT			0x8
-#define MXC_CRMAP_ADCR_TSTAT			0x10
-#define MXC_CRMAP_ADCR_DVFS_VCTRL		0x10
-#define MXC_CRMAP_ADCR_CLK_ON			0x40
-
-#define MXC_CRMAP_ADFMR_FC_OFFSET		16
-#define MXC_CRMAP_ADFMR_FC_MASK			(0x1F << 16)
-#define MXC_CRMAP_ADFMR_MF_OFFSET		1
-#define MXC_CRMAP_ADFMR_MF_MASK			(0x3FF << 1)
-#define MXC_CRMAP_ADFMR_DFM_CLK_READY		0x1
-#define MXC_CRMAP_ADFMR_DFM_PWR_DOWN		0x8000
-
-#define MXC_CRMAP_ACR_CKOHS_HIGH		(1 << 18)
-#define MXC_CRMAP_ACR_CKOS_HIGH			(1 << 16)
-#define MXC_CRMAP_ACR_CKOHS_MASK		(0x7 << 12)
-#define MXC_CRMAP_ACR_CKOHD			(1 << 11)
-#define MXC_CRMAP_ACR_CKOHDIV_MASK		(0xF << 8)
-#define MXC_CRMAP_ACR_CKOHDIV_OFFSET		8
-#define MXC_CRMAP_ACR_CKOD			(1 << 7)
-#define MXC_CRMAP_ACR_CKOS_MASK			(0x7 << 4)
-
-/* AP Warm reset */
-#define MXC_CRMAP_AMCR_SW_AP			(1 << 14)
-
-/* Bit definitions of ACGCR in CRM_AP for tree level clock gating */
-#define MXC_CRMAP_ACGCR_ACG0_STOP_WAIT		0x00000001
-#define MXC_CRMAP_ACGCR_ACG0_STOP		0x00000003
-#define MXC_CRMAP_ACGCR_ACG0_RUN		0x00000007
-#define MXC_CRMAP_ACGCR_ACG0_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG1_STOP_WAIT		0x00000008
-#define MXC_CRMAP_ACGCR_ACG1_STOP		0x00000018
-#define MXC_CRMAP_ACGCR_ACG1_RUN		0x00000038
-#define MXC_CRMAP_ACGCR_ACG1_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG2_STOP_WAIT		0x00000040
-#define MXC_CRMAP_ACGCR_ACG2_STOP		0x000000C0
-#define MXC_CRMAP_ACGCR_ACG2_RUN		0x000001C0
-#define MXC_CRMAP_ACGCR_ACG2_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG3_STOP_WAIT		0x00000200
-#define MXC_CRMAP_ACGCR_ACG3_STOP		0x00000600
-#define MXC_CRMAP_ACGCR_ACG3_RUN		0x00000E00
-#define MXC_CRMAP_ACGCR_ACG3_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG4_STOP_WAIT		0x00001000
-#define MXC_CRMAP_ACGCR_ACG4_STOP		0x00003000
-#define MXC_CRMAP_ACGCR_ACG4_RUN		0x00007000
-#define MXC_CRMAP_ACGCR_ACG4_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG5_STOP_WAIT		0x00010000
-#define MXC_CRMAP_ACGCR_ACG5_STOP		0x00030000
-#define MXC_CRMAP_ACGCR_ACG5_RUN		0x00070000
-#define MXC_CRMAP_ACGCR_ACG5_DISABLED		0x00000000
-
-#define MXC_CRMAP_ACGCR_ACG6_STOP_WAIT		0x00080000
-#define MXC_CRMAP_ACGCR_ACG6_STOP		0x00180000
-#define MXC_CRMAP_ACGCR_ACG6_RUN		0x00380000
-#define MXC_CRMAP_ACGCR_ACG6_DISABLED		0x00000000
-
-#define NUM_GATE_CTRL				6
-
-/* CRM COM Register Offsets */
-#define MXC_CRMCOM_CSCR				(MXC_CRM_COM_BASE + 0x0C)
-#define MXC_CRMCOM_CCCR				(MXC_CRM_COM_BASE + 0x10)
-
-/* CRM COM Bit Definitions */
-#define MXC_CRMCOM_CSCR_PPD1			0x08000000
-#define MXC_CRMCOM_CSCR_CKOHSEL			(1 << 18)
-#define MXC_CRMCOM_CSCR_CKOSEL			(1 << 17)
-#define MXC_CRMCOM_CCCR_CC_DIV_OFFSET		8
-#define MXC_CRMCOM_CCCR_CC_DIV_MASK		(0x1F << 8)
-#define MXC_CRMCOM_CCCR_CC_SEL_OFFSET		0
-#define MXC_CRMCOM_CCCR_CC_SEL_MASK		0x3
-
-/* DSM Register Offsets */
-#define MXC_DSM_SLEEP_TIME			(MXC_DSM_BASE + 0x0c)
-#define MXC_DSM_CONTROL0			(MXC_DSM_BASE + 0x20)
-#define MXC_DSM_CONTROL1			(MXC_DSM_BASE + 0x24)
-#define MXC_DSM_CTREN				(MXC_DSM_BASE + 0x28)
-#define MXC_DSM_WARM_PER			(MXC_DSM_BASE + 0x40)
-#define MXC_DSM_LOCK_PER			(MXC_DSM_BASE + 0x44)
-#define MXC_DSM_MGPER				(MXC_DSM_BASE + 0x4c)
-#define MXC_DSM_CRM_CONTROL			(MXC_DSM_BASE + 0x50)
-
-/* Bit definitions of various registers in DSM */
-#define MXC_DSM_CRM_CTRL_DVFS_BYP		0x00000008
-#define MXC_DSM_CRM_CTRL_DVFS_VCTRL		0x00000004
-#define MXC_DSM_CRM_CTRL_LPMD1			0x00000002
-#define MXC_DSM_CRM_CTRL_LPMD0			0x00000001
-#define MXC_DSM_CRM_CTRL_LPMD_STOP_MODE		0x00000000
-#define MXC_DSM_CRM_CTRL_LPMD_WAIT_MODE		0x00000001
-#define MXC_DSM_CRM_CTRL_LPMD_RUN_MODE		0x00000003
-#define MXC_DSM_CONTROL0_STBY_COMMIT_EN		0x00000200
-#define MXC_DSM_CONTROL0_MSTR_EN		0x00000001
-#define MXC_DSM_CONTROL0_RESTART		0x00000010
-/* Counter Block reset */
-#define MXC_DSM_CONTROL1_CB_RST			0x00000002
-/* State Machine reset */
-#define MXC_DSM_CONTROL1_SM_RST			0x00000004
-/* Bit needed to reset counter block */
-#define MXC_CONTROL1_RST_CNT32			0x00000008
-#define MXC_DSM_CONTROL1_RST_CNT32_EN		0x00000800
-#define MXC_DSM_CONTROL1_SLEEP			0x00000100
-#define MXC_DSM_CONTROL1_WAKEUP_DISABLE		0x00004000
-#define MXC_DSM_CTREN_CNT32			0x00000001
-
-/* Magic Fix enable bit */
-#define MXC_DSM_MGPER_EN_MGFX			0x80000000
-#define MXC_DSM_MGPER_PER_MASK			0x000003FF
-#define MXC_DSM_MGPER_PER(n)			(MXC_DSM_MGPER_PER_MASK & n)
-
-/* Address offsets of the CLKCTL registers */
-#define MXC_CLKCTL_GP_CTRL	(MXC_CLKCTL_BASE + 0x00)
-#define MXC_CLKCTL_GP_SER	(MXC_CLKCTL_BASE + 0x04)
-#define MXC_CLKCTL_GP_CER	(MXC_CLKCTL_BASE + 0x08)
-
-#endif /* _ARCH_ARM_MACH_MXC91231_CRM_REGS_H_ */
diff --git a/arch/arm/mach-mxc91231/devices.c b/arch/arm/mach-mxc91231/devices.c
deleted file mode 100644
index 027af4f..0000000
--- a/arch/arm/mach-mxc91231/devices.c
+++ /dev/null
@@ -1,251 +0,0 @@
-/*
- * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Sascha Hauer, kernel@pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/serial.h>
-#include <linux/gpio.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/imx-uart.h>
-
-static struct resource uart0[] = {
-	{
-		.start = MXC91231_UART1_BASE_ADDR,
-		.end = MXC91231_UART1_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_UART1_RX,
-		.end = MXC91231_INT_UART1_RX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART1_TX,
-		.end = MXC91231_INT_UART1_TX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART1_MINT,
-		.end = MXC91231_INT_UART1_MINT,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device0 = {
-	.name = "imx-uart",
-	.id = 0,
-	.resource = uart0,
-	.num_resources = ARRAY_SIZE(uart0),
-};
-
-static struct resource uart1[] = {
-	{
-		.start = MXC91231_UART2_BASE_ADDR,
-		.end = MXC91231_UART2_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_UART2_RX,
-		.end = MXC91231_INT_UART2_RX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART2_TX,
-		.end = MXC91231_INT_UART2_TX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART2_MINT,
-		.end = MXC91231_INT_UART2_MINT,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device1 = {
-	.name = "imx-uart",
-	.id = 1,
-	.resource = uart1,
-	.num_resources = ARRAY_SIZE(uart1),
-};
-
-static struct resource uart2[] = {
-	{
-		.start = MXC91231_UART3_BASE_ADDR,
-		.end = MXC91231_UART3_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_UART3_RX,
-		.end = MXC91231_INT_UART3_RX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART3_TX,
-		.end = MXC91231_INT_UART3_TX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MXC91231_INT_UART3_MINT,
-		.end = MXC91231_INT_UART3_MINT,
-		.flags = IORESOURCE_IRQ,
-
-	},
-};
-
-struct platform_device mxc_uart_device2 = {
-	.name = "imx-uart",
-	.id = 2,
-	.resource = uart2,
-	.num_resources = ARRAY_SIZE(uart2),
-};
-
-/* GPIO port description */
-static struct mxc_gpio_port mxc_gpio_ports[] = {
-	[0] = {
-		.chip.label = "gpio-0",
-		.base = MXC91231_IO_ADDRESS(MXC91231_GPIO1_AP_BASE_ADDR),
-		.irq = MXC91231_INT_GPIO1,
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	},
-	[1] = {
-		.chip.label = "gpio-1",
-		.base = MXC91231_IO_ADDRESS(MXC91231_GPIO2_AP_BASE_ADDR),
-		.irq = MXC91231_INT_GPIO2,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	},
-	[2] = {
-		.chip.label = "gpio-2",
-		.base = MXC91231_IO_ADDRESS(MXC91231_GPIO3_AP_BASE_ADDR),
-		.irq = MXC91231_INT_GPIO3,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	},
-	[3] = {
-		.chip.label = "gpio-3",
-		.base = MXC91231_IO_ADDRESS(MXC91231_GPIO4_SH_BASE_ADDR),
-		.irq = MXC91231_INT_GPIO4,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
-	},
-};
-
-int __init mxc91231_register_gpios(void)
-{
-	return mxc_gpio_init(mxc_gpio_ports, ARRAY_SIZE(mxc_gpio_ports));
-}
-
-static struct resource mxc_nand_resources[] = {
-	{
-		.start	= MXC91231_NFC_BASE_ADDR,
-		.end	= MXC91231_NFC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM
-	}, {
-		.start	= MXC91231_INT_NANDFC,
-		.end	= MXC91231_INT_NANDFC,
-		.flags	= IORESOURCE_IRQ
-	},
-};
-
-struct platform_device mxc_nand_device = {
-	.name = "mxc_nand",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_nand_resources),
-	.resource = mxc_nand_resources,
-};
-
-static struct resource mxc_sdhc0_resources[] = {
-	{
-		.start = MXC91231_MMC_SDHC1_BASE_ADDR,
-		.end = MXC91231_MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_MMC_SDHC1,
-		.end = MXC91231_INT_MMC_SDHC1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource mxc_sdhc1_resources[] = {
-	{
-		.start = MXC91231_MMC_SDHC2_BASE_ADDR,
-		.end = MXC91231_MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_MMC_SDHC2,
-		.end = MXC91231_INT_MMC_SDHC2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_sdhc_device0 = {
-	.name = "mxc-mmc",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_sdhc0_resources),
-	.resource = mxc_sdhc0_resources,
-};
-
-struct platform_device mxc_sdhc_device1 = {
-	.name = "mxc-mmc",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_sdhc1_resources),
-	.resource = mxc_sdhc1_resources,
-};
-
-static struct resource mxc_cspi0_resources[] = {
-	{
-		.start = MXC91231_CSPI1_BASE_ADDR,
-		.end = MXC91231_CSPI1_BASE_ADDR + 0x20,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_CSPI1,
-		.end = MXC91231_INT_CSPI1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_cspi_device0 = {
-	.name = "spi_imx",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_cspi0_resources),
-	.resource = mxc_cspi0_resources,
-};
-
-static struct resource mxc_cspi1_resources[] = {
-	{
-		.start = MXC91231_CSPI2_BASE_ADDR,
-		.end = MXC91231_CSPI2_BASE_ADDR + 0x20,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC91231_INT_CSPI2,
-		.end = MXC91231_INT_CSPI2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_cspi_device1 = {
-	.name = "spi_imx",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_cspi1_resources),
-	.resource = mxc_cspi1_resources,
-};
-
-static struct resource mxc_wdog0_resources[] = {
-	{
-		.start = MXC91231_WDOG1_BASE_ADDR,
-		.end = MXC91231_WDOG1_BASE_ADDR + 0x10,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_wdog_device0 = {
-	.name = "mxc-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_wdog0_resources),
-	.resource = mxc_wdog0_resources,
-};
diff --git a/arch/arm/mach-mxc91231/devices.h b/arch/arm/mach-mxc91231/devices.h
deleted file mode 100644
index 72a2136..0000000
--- a/arch/arm/mach-mxc91231/devices.h
+++ /dev/null
@@ -1,13 +0,0 @@
-extern struct platform_device mxc_uart_device0;
-extern struct platform_device mxc_uart_device1;
-extern struct platform_device mxc_uart_device2;
-
-extern struct platform_device mxc_nand_device;
-
-extern struct platform_device mxc_sdhc_device0;
-extern struct platform_device mxc_sdhc_device1;
-
-extern struct platform_device mxc_cspi_device0;
-extern struct platform_device mxc_cspi_device1;
-
-extern struct platform_device mxc_wdog_device0;
diff --git a/arch/arm/mach-mxc91231/iomux.c b/arch/arm/mach-mxc91231/iomux.c
deleted file mode 100644
index 66fc41c..0000000
--- a/arch/arm/mach-mxc91231/iomux.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Copyright 2004-2006 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
- * Copyright (C) 2009 by Valentin Longchamp <valentin.longchamp@epfl.ch>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-#include <mach/iomux-mxc91231.h>
-
-/*
- * IOMUX register (base) addresses
- */
-#define IOMUX_AP_BASE		MXC91231_IO_ADDRESS(MXC91231_IOMUX_AP_BASE_ADDR)
-#define IOMUX_COM_BASE		MXC91231_IO_ADDRESS(MXC91231_IOMUX_COM_BASE_ADDR)
-#define IOMUXSW_AP_MUX_CTL	(IOMUX_AP_BASE + 0x000)
-#define IOMUXSW_SP_MUX_CTL	(IOMUX_COM_BASE + 0x000)
-#define IOMUXSW_PAD_CTL		(IOMUX_COM_BASE + 0x200)
-
-#define IOMUXINT_OBS1		(IOMUX_AP_BASE + 0x600)
-#define IOMUXINT_OBS2		(IOMUX_AP_BASE + 0x004)
-
-static DEFINE_SPINLOCK(gpio_mux_lock);
-
-#define NB_PORTS			((PIN_MAX + 32) / 32)
-#define PIN_GLOBAL_NUM(pin) \
-	(((pin & MUX_SIDE_MASK) >> MUX_SIDE_SHIFT)*PIN_AP_MAX +	\
-	 ((pin & MUX_REG_MASK) >> MUX_REG_SHIFT)*4 +		\
-	 ((pin & MUX_FIELD_MASK) >> MUX_FIELD_SHIFT))
-
-unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
-/*
- * set the mode for a IOMUX pin.
- */
-int mxc_iomux_mode(unsigned int pin_mode)
-{
-	u32 side, field, l, mode, ret = 0;
-	void __iomem *reg;
-
-	side = (pin_mode & MUX_SIDE_MASK) >> MUX_SIDE_SHIFT;
-	switch (side) {
-	case MUX_SIDE_AP:
-		reg = IOMUXSW_AP_MUX_CTL;
-		break;
-	case MUX_SIDE_SP:
-		reg = IOMUXSW_SP_MUX_CTL;
-		break;
-	default:
-		return -EINVAL;
-	}
-	reg += ((pin_mode & MUX_REG_MASK) >> MUX_REG_SHIFT) * 4;
-	field = (pin_mode & MUX_FIELD_MASK) >> MUX_FIELD_SHIFT;
-	mode = (pin_mode & MUX_MODE_MASK) >> MUX_MODE_SHIFT;
-
-	spin_lock(&gpio_mux_lock);
-
-	l = __raw_readl(reg);
-	l &= ~(0xff << (field * 8));
-	l |= mode << (field * 8);
-	__raw_writel(l, reg);
-
-	spin_unlock(&gpio_mux_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(mxc_iomux_mode);
-
-/*
- * This function configures the pad value for a IOMUX pin.
- */
-void mxc_iomux_set_pad(enum iomux_pins pin, u32 config)
-{
-	u32 padgrp, field, l;
-	void __iomem *reg;
-
-	padgrp = (pin & MUX_PADGRP_MASK) >> MUX_PADGRP_SHIFT;
-	reg = IOMUXSW_PAD_CTL + (pin + 2) / 3 * 4;
-	field = (pin + 2) % 3;
-
-	pr_debug("%s: reg offset = 0x%x, field = %d\n",
-			__func__, (pin + 2) / 3, field);
-
-	spin_lock(&gpio_mux_lock);
-
-	l = __raw_readl(reg);
-	l &= ~(0x1ff << (field * 10));
-	l |= config << (field * 10);
-	__raw_writel(l, reg);
-
-	spin_unlock(&gpio_mux_lock);
-}
-EXPORT_SYMBOL(mxc_iomux_set_pad);
-
-/*
- * allocs a single pin:
- * 	- reserves the pin so that it is not claimed by another driver
- * 	- setups the iomux according to the configuration
- */
-int mxc_iomux_alloc_pin(unsigned int pin_mode, const char *label)
-{
-	unsigned pad = PIN_GLOBAL_NUM(pin_mode);
-	if (pad >= (PIN_MAX + 1)) {
-		printk(KERN_ERR "mxc_iomux: Attempt to request nonexistant pin %u for \"%s\"\n",
-			pad, label ? label : "?");
-		return -EINVAL;
-	}
-
-	if (test_and_set_bit(pad, mxc_pin_alloc_map)) {
-		printk(KERN_ERR "mxc_iomux: pin %u already used. Allocation for \"%s\" failed\n",
-			pad, label ? label : "?");
-		return -EBUSY;
-	}
-	mxc_iomux_mode(pin_mode);
-
-	return 0;
-}
-EXPORT_SYMBOL(mxc_iomux_alloc_pin);
-
-int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
-		const char *label)
-{
-	const unsigned int *p = pin_list;
-	int i;
-	int ret = -EINVAL;
-
-	for (i = 0; i < count; i++) {
-		ret = mxc_iomux_alloc_pin(*p, label);
-		if (ret)
-			goto setup_error;
-		p++;
-	}
-	return 0;
-
-setup_error:
-	mxc_iomux_release_multiple_pins(pin_list, i);
-	return ret;
-}
-EXPORT_SYMBOL(mxc_iomux_setup_multiple_pins);
-
-void mxc_iomux_release_pin(unsigned int pin_mode)
-{
-	unsigned pad = PIN_GLOBAL_NUM(pin_mode);
-
-	if (pad < (PIN_MAX + 1))
-		clear_bit(pad, mxc_pin_alloc_map);
-}
-EXPORT_SYMBOL(mxc_iomux_release_pin);
-
-void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count)
-{
-	const unsigned int *p = pin_list;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		mxc_iomux_release_pin(*p);
-		p++;
-	}
-}
-EXPORT_SYMBOL(mxc_iomux_release_multiple_pins);
diff --git a/arch/arm/mach-mxc91231/magx-zn5.c b/arch/arm/mach-mxc91231/magx-zn5.c
deleted file mode 100644
index f31a45e..0000000
--- a/arch/arm/mach-mxc91231/magx-zn5.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright 2009 Dmitriy Taychenachev <dimichxp@gmail.com>
- *
- * This file is released under the GPLv2 or later.
- */
-
-#include <linux/irq.h>
-#include <linux/init.h>
-#include <linux/device.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/time.h>
-#include <asm/mach/arch.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-mxc91231.h>
-#include <mach/mmc.h>
-#include <mach/imx-uart.h>
-
-#include "devices.h"
-
-static struct imxuart_platform_data uart_pdata = {
-};
-
-static struct imxmmc_platform_data sdhc_pdata = {
-};
-
-static void __init zn5_init(void)
-{
-	pm_power_off = mxc91231_power_off;
-
-	mxc_iomux_alloc_pin(MXC91231_PIN_SP_USB_DAT_VP__RXD2, "uart2-rx");
-	mxc_iomux_alloc_pin(MXC91231_PIN_SP_USB_SE0_VM__TXD2, "uart2-tx");
-
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-
-	mxc_register_device(&mxc_sdhc_device0, &sdhc_pdata);
-
-	mxc_register_device(&mxc_wdog_device0, NULL);
-
-	return;
-}
-
-static void __init zn5_timer_init(void)
-{
-	mxc91231_clocks_init(26000000); /* 26mhz ckih */
-}
-
-struct sys_timer zn5_timer = {
-	.init = zn5_timer_init,
-};
-
-MACHINE_START(MAGX_ZN5, "Motorola Zn5")
-	.boot_params = MXC91231_PHYS_OFFSET + 0x100,
-	.map_io = mxc91231_map_io,
-	.init_early = mxc91231_init_early,
-	.init_irq = mxc91231_init_irq,
-	.timer = &zn5_timer,
-	.init_machine = zn5_init,
-MACHINE_END
diff --git a/arch/arm/mach-mxc91231/mm.c b/arch/arm/mach-mxc91231/mm.c
deleted file mode 100644
index a77f6da..0000000
--- a/arch/arm/mach-mxc91231/mm.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- *  Copyright (C) 1999,2000 Arm Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
- *  Copyright 2004-2005 Freescale Semiconductor, Inc. All Rights Reserved.
- *    - add MXC specific definitions
- *  Copyright 2006 Motorola, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-
-/*
- * This structure defines the MXC memory map.
- */
-static struct map_desc mxc91231_io_desc[] __initdata = {
-	imx_map_entry(MXC91231, L2CC, MT_DEVICE),
-	imx_map_entry(MXC91231, X_MEMC, MT_DEVICE),
-	imx_map_entry(MXC91231, ROMP, MT_DEVICE),
-	imx_map_entry(MXC91231, AVIC, MT_DEVICE),
-	imx_map_entry(MXC91231, AIPS1, MT_DEVICE),
-	imx_map_entry(MXC91231, SPBA0, MT_DEVICE),
-	imx_map_entry(MXC91231, SPBA1, MT_DEVICE),
-	imx_map_entry(MXC91231, AIPS2, MT_DEVICE),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory map for
- * the IO modules.
- */
-void __init mxc91231_map_io(void)
-{
-	iotable_init(mxc91231_io_desc, ARRAY_SIZE(mxc91231_io_desc));
-}
-
-void __init mxc91231_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MXC91231);
-}
-
-int mxc91231_register_gpios(void);
-
-void __init mxc91231_init_irq(void)
-{
-	mxc91231_register_gpios();
-	mxc_init_irq(MXC91231_IO_ADDRESS(MXC91231_AVIC_BASE_ADDR));
-}
diff --git a/arch/arm/mach-mxc91231/system.c b/arch/arm/mach-mxc91231/system.c
deleted file mode 100644
index 736f7ef..0000000
--- a/arch/arm/mach-mxc91231/system.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright 2009 Dmitriy Taychenachev <dimichxp@gmail.com>
- *
- * This file is released under the GPLv2 or later.
- */
-
-#include <linux/delay.h>
-#include <linux/io.h>
-
-#include <asm/proc-fns.h>
-#include <mach/hardware.h>
-
-#include "crm_regs.h"
-
-#define WDOG_WCR		MXC91231_IO_ADDRESS(MXC91231_WDOG1_BASE_ADDR)
-#define WDOG_WCR_OUT_ENABLE	(1 << 6)
-#define WDOG_WCR_ASSERT		(1 << 5)
-
-void mxc91231_power_off(void)
-{
-	u16 wcr;
-
-	wcr = __raw_readw(WDOG_WCR);
-	wcr |= WDOG_WCR_OUT_ENABLE;
-	wcr &= ~WDOG_WCR_ASSERT;
-	__raw_writew(wcr, WDOG_WCR);
-}
-
-void mxc91231_arch_reset(char mode, const char *cmd)
-{
-	u32 amcr;
-
-	/* Reset the AP using CRM */
-	amcr = __raw_readl(MXC_CRMAP_AMCR);
-	amcr &= ~MXC_CRMAP_AMCR_SW_AP;
-	__raw_writel(amcr, MXC_CRMAP_AMCR);
-
-	mdelay(10);
-	cpu_reset(0);
-}
-
-void mxc91231_prepare_idle(void)
-{
-	u32 crm_ctl;
-
-	/* Go to WAIT mode after WFI */
-	crm_ctl = __raw_readl(MXC_DSM_CRM_CONTROL);
-	crm_ctl &= ~(MXC_DSM_CRM_CTRL_LPMD0 | MXC_DSM_CRM_CTRL_LPMD1);
-	crm_ctl |=  MXC_DSM_CRM_CTRL_LPMD_WAIT_MODE;
-	__raw_writel(crm_ctl, MXC_DSM_CRM_CONTROL);
-}
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 69fceaf..ce6ed5e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -36,11 +36,6 @@ config ARCH_MX3
 	  This enables support for machines using Freescale's i.MX31 and i.MX35
 	  processors.
 
-config ARCH_MXC91231
-	bool "MXC91231-based"
-	help
-	  This enables support for systems based on the Freescale MXC91231 family
-
 config ARCH_MX5
 	bool "MX5-based"
 	help
@@ -49,7 +44,6 @@ config ARCH_MX5
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
-source "arch/arm/mach-mxc91231/Kconfig"
 source "arch/arm/mach-mx5/Kconfig"
 
 endmenu
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index bfa1ffc..da79918 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -23,7 +23,6 @@ extern void mx35_map_io(void);
 extern void mx50_map_io(void);
 extern void mx51_map_io(void);
 extern void mx53_map_io(void);
-extern void mxc91231_map_io(void);
 extern void imx1_init_early(void);
 extern void imx21_init_early(void);
 extern void imx25_init_early(void);
@@ -33,7 +32,6 @@ extern void imx35_init_early(void);
 extern void imx50_init_early(void);
 extern void imx51_init_early(void);
 extern void imx53_init_early(void);
-extern void mxc91231_init_early(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
@@ -45,7 +43,6 @@ extern void mx35_init_irq(void);
 extern void mx50_init_irq(void);
 extern void mx51_init_irq(void);
 extern void mx53_init_irq(void);
-extern void mxc91231_init_irq(void);
 extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
 extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
@@ -58,14 +55,10 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
-extern int mxc91231_clocks_init(unsigned long fref);
 extern int mxc_register_gpios(void);
 extern int mxc_register_device(struct platform_device *pdev, void *data);
 extern void mxc_set_cpu_type(unsigned int type);
 extern void mxc_arch_reset_init(void __iomem *);
-extern void mxc91231_power_off(void);
-extern void mxc91231_arch_reset(int, const char *);
-extern void mxc91231_prepare_idle(void);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 3b3a37c..8e8d175 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -44,13 +44,6 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MXC91231
-#ifdef UART_PADDR
-#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
-#endif
-#define UART_PADDR	MXC91231_UART2_BASE_ADDR
-#endif
-
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
 
 		.macro	addruart, rp, rv
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 15e2097..67d3e2b 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -86,15 +86,6 @@
  *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
  *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
  *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
- * mxc91231:
- *	L2CC	0x30000000+0x010000	->	0xf4400000+0x010000
- *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
- *	ROMP	0x60000000+0x010000	->	0xf5000000+0x010000
- *	AVIC	0x68000000+0x010000	->	0xf5800000+0x010000
- *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
- *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
- *	SPBA1	0x52000000+0x100000	->	0xf5600000+0x100000
- *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
  */
 #define IMX_IO_P2V(x)	(						\
 			0xf4000000 +					\
@@ -136,10 +127,6 @@
 # include <mach/mx25.h>
 #endif
 
-#ifdef CONFIG_ARCH_MXC91231
-# include <mach/mxc91231.h>
-#endif
-
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
 	.pfn = __phys_to_pfn(soc ## _ ## name ## _BASE_ADDR),		\
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
deleted file mode 100644
index bf28df0..0000000
--- a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
+++ /dev/null
@@ -1,283 +0,0 @@
-/*
- * Copyright 2004-2006 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
- * Copyright (C) 2009 by Dmitriy Taychenachev <dimichxp@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __MACH_IOMUX_MXC91231_H__
-#define __MACH_IOMUX_MXC91231_H__
-
-/*
- * various IOMUX output functions
- */
-
-#define	IOMUX_OCONFIG_GPIO (0 << 4)	/* used as GPIO */
-#define	IOMUX_OCONFIG_FUNC (1 << 4)	/* used as function */
-#define	IOMUX_OCONFIG_ALT1 (2 << 4)	/* used as alternate function 1 */
-#define	IOMUX_OCONFIG_ALT2 (3 << 4)	/* used as alternate function 2 */
-#define	IOMUX_OCONFIG_ALT3 (4 << 4)	/* used as alternate function 3 */
-#define	IOMUX_OCONFIG_ALT4 (5 << 4)	/* used as alternate function 4 */
-#define	IOMUX_OCONFIG_ALT5 (6 << 4)	/* used as alternate function 5 */
-#define	IOMUX_OCONFIG_ALT6 (7 << 4)	/* used as alternate function 6 */
-#define	IOMUX_ICONFIG_NONE  0	 	/* not configured for input */
-#define	IOMUX_ICONFIG_GPIO  1		/* used as GPIO */
-#define	IOMUX_ICONFIG_FUNC  2		/* used as function */
-#define	IOMUX_ICONFIG_ALT1  4		/* used as alternate function 1 */
-#define	IOMUX_ICONFIG_ALT2  8		/* used as alternate function 2 */
-
-#define IOMUX_CONFIG_GPIO (IOMUX_OCONFIG_GPIO | IOMUX_ICONFIG_GPIO)
-#define IOMUX_CONFIG_FUNC (IOMUX_OCONFIG_FUNC | IOMUX_ICONFIG_FUNC)
-#define IOMUX_CONFIG_ALT1 (IOMUX_OCONFIG_ALT1 | IOMUX_ICONFIG_ALT1)
-#define IOMUX_CONFIG_ALT2 (IOMUX_OCONFIG_ALT2 | IOMUX_ICONFIG_ALT2)
-
-/*
- * setups a single pin:
- * 	- reserves the pin so that it is not claimed by another driver
- * 	- setups the iomux according to the configuration
- * 	- if the pin is configured as a GPIO, we claim it through kernel gpiolib
- */
-int mxc_iomux_alloc_pin(unsigned int pin_mode, const char *label);
-/*
- * setups mutliple pins
- * convenient way to call the above function with tables
- */
-int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
-		const char *label);
-
-/*
- * releases a single pin:
- * 	- make it available for a future use by another driver
- * 	- frees the GPIO if the pin was configured as GPIO
- * 	- DOES NOT reconfigure the IOMUX in its reset state
- */
-void mxc_iomux_release_pin(unsigned int pin_mode);
-/*
- * releases multiple pins
- * convenvient way to call the above function with tables
- */
-void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count);
-
-#define MUX_SIDE_AP		(0)
-#define MUX_SIDE_SP		(1)
-
-#define MUX_SIDE_SHIFT		(26)
-#define MUX_SIDE_MASK		(0x1 << MUX_SIDE_SHIFT)
-
-#define MUX_GPIO_PORT_SHIFT	(23)
-#define MUX_GPIO_PORT_MASK	(0x7 << MUX_GPIO_PORT_SHIFT)
-
-#define MUX_GPIO_PIN_SHIFT	(20)
-#define MUX_GPIO_PIN_MASK	(0x1f << MUX_GPIO_PIN_SHIFT)
-
-#define MUX_REG_SHIFT		(15)
-#define MUX_REG_MASK		(0x1f << MUX_REG_SHIFT)
-
-#define MUX_FIELD_SHIFT		(13)
-#define MUX_FIELD_MASK		(0x3 << MUX_FIELD_SHIFT)
-
-#define MUX_PADGRP_SHIFT	(8)
-#define MUX_PADGRP_MASK		(0x1f << MUX_PADGRP_SHIFT)
-
-#define MUX_PIN_MASK		(0xffffff << 8)
-
-#define GPIO_PORT_MAX		(3)
-
-#define IOMUX_PIN(side, gport, gpin, ctlreg, ctlfield, padgrp) \
-	(((side) << MUX_SIDE_SHIFT) |		  \
-	 (gport << MUX_GPIO_PORT_SHIFT) |		\
-	 ((gpin) << MUX_GPIO_PIN_SHIFT) |		\
-	 ((ctlreg) << MUX_REG_SHIFT) |		\
-	 ((ctlfield) << MUX_FIELD_SHIFT) |		\
-	 ((padgrp) << MUX_PADGRP_SHIFT))
-
-#define MUX_MODE_OUT_SHIFT	(4)
-#define MUX_MODE_IN_SHIFT	(0)
-#define MUX_MODE_SHIFT		(0)
-#define MUX_MODE_MASK		(0xff << MUX_MODE_SHIFT)
-
-#define IOMUX_MODE(pin, mode) \
-	(pin | (mode << MUX_MODE_SHIFT))
-
-enum iomux_pins {
-	/* AP Side pins */
-	MXC91231_PIN_AP_CLE		= IOMUX_PIN(0, 0,  0,  0, 0, 24),
-	MXC91231_PIN_AP_ALE		= IOMUX_PIN(0, 0,  1,  0, 1, 24),
-	MXC91231_PIN_AP_CE_B		= IOMUX_PIN(0, 0,  2,  0, 2, 24),
-	MXC91231_PIN_AP_RE_B		= IOMUX_PIN(0, 0,  3,  0, 3, 24),
-	MXC91231_PIN_AP_WE_B		= IOMUX_PIN(0, 0,  4,  1, 0, 24),
-	MXC91231_PIN_AP_WP_B		= IOMUX_PIN(0, 0,  5,  1, 1, 24),
-	MXC91231_PIN_AP_BSY_B		= IOMUX_PIN(0, 0,  6,  1, 2, 24),
-	MXC91231_PIN_AP_U1_TXD		= IOMUX_PIN(0, 0,  7,  1, 3, 28),
-	MXC91231_PIN_AP_U1_RXD		= IOMUX_PIN(0, 0,  8,  2, 0, 28),
-	MXC91231_PIN_AP_U1_RTS_B	= IOMUX_PIN(0, 0,  9,  2, 1, 28),
-	MXC91231_PIN_AP_U1_CTS_B	= IOMUX_PIN(0, 0, 10,  2, 2, 28),
-	MXC91231_PIN_AP_AD1_TXD		= IOMUX_PIN(0, 0, 11,  2, 3,  9),
-	MXC91231_PIN_AP_AD1_RXD		= IOMUX_PIN(0, 0, 12,  3, 0,  9),
-	MXC91231_PIN_AP_AD1_TXC		= IOMUX_PIN(0, 0, 13,  3, 1,  9),
-	MXC91231_PIN_AP_AD1_TXFS	= IOMUX_PIN(0, 0, 14,  3, 2,  9),
-	MXC91231_PIN_AP_AD2_TXD		= IOMUX_PIN(0, 0, 15,  3, 3,  9),
-	MXC91231_PIN_AP_AD2_RXD		= IOMUX_PIN(0, 0, 16,  4, 0,  9),
-	MXC91231_PIN_AP_AD2_TXC		= IOMUX_PIN(0, 0, 17,  4, 1,  9),
-	MXC91231_PIN_AP_AD2_TXFS	= IOMUX_PIN(0, 0, 18,  4, 2,  9),
-	MXC91231_PIN_AP_OWDAT		= IOMUX_PIN(0, 0, 19,  4, 3, 28),
-	MXC91231_PIN_AP_IPU_LD17	= IOMUX_PIN(0, 0, 20,  5, 0, 28),
-	MXC91231_PIN_AP_IPU_D3_VSYNC	= IOMUX_PIN(0, 0, 21,  5, 1, 28),
-	MXC91231_PIN_AP_IPU_D3_HSYNC	= IOMUX_PIN(0, 0, 22,  5, 2, 28),
-	MXC91231_PIN_AP_IPU_D3_CLK	= IOMUX_PIN(0, 0, 23,  5, 3, 28),
-	MXC91231_PIN_AP_IPU_D3_DRDY	= IOMUX_PIN(0, 0, 24,  6, 0, 28),
-	MXC91231_PIN_AP_IPU_D3_CONTR	= IOMUX_PIN(0, 0, 25,  6, 1, 28),
-	MXC91231_PIN_AP_IPU_D0_CS	= IOMUX_PIN(0, 0, 26,  6, 2, 28),
-	MXC91231_PIN_AP_IPU_LD16	= IOMUX_PIN(0, 0, 27,  6, 3, 28),
-	MXC91231_PIN_AP_IPU_D2_CS	= IOMUX_PIN(0, 0, 28,  7, 0, 28),
-	MXC91231_PIN_AP_IPU_PAR_RS	= IOMUX_PIN(0, 0, 29,  7, 1, 28),
-	MXC91231_PIN_AP_IPU_D3_PS	= IOMUX_PIN(0, 0, 30,  7, 2, 28),
-	MXC91231_PIN_AP_IPU_D3_CLS	= IOMUX_PIN(0, 0, 31,  7, 3, 28),
-	MXC91231_PIN_AP_IPU_RD		= IOMUX_PIN(0, 1,  0,  8, 0, 28),
-	MXC91231_PIN_AP_IPU_WR		= IOMUX_PIN(0, 1,  1,  8, 1, 28),
-	MXC91231_PIN_AP_IPU_LD0		= IOMUX_PIN(0, 7,  0,  8, 2, 28),
-	MXC91231_PIN_AP_IPU_LD1		= IOMUX_PIN(0, 7,  0,  8, 3, 28),
-	MXC91231_PIN_AP_IPU_LD2		= IOMUX_PIN(0, 7,  0,  9, 0, 28),
-	MXC91231_PIN_AP_IPU_LD3		= IOMUX_PIN(0, 1,  2,  9, 1, 28),
-	MXC91231_PIN_AP_IPU_LD4		= IOMUX_PIN(0, 1,  3,  9, 2, 28),
-	MXC91231_PIN_AP_IPU_LD5		= IOMUX_PIN(0, 1,  4,  9, 3, 28),
-	MXC91231_PIN_AP_IPU_LD6		= IOMUX_PIN(0, 1,  5, 10, 0, 28),
-	MXC91231_PIN_AP_IPU_LD7		= IOMUX_PIN(0, 1,  6, 10, 1, 28),
-	MXC91231_PIN_AP_IPU_LD8		= IOMUX_PIN(0, 1,  7, 10, 2, 28),
-	MXC91231_PIN_AP_IPU_LD9		= IOMUX_PIN(0, 1,  8, 10, 3, 28),
-	MXC91231_PIN_AP_IPU_LD10	= IOMUX_PIN(0, 1,  9, 11, 0, 28),
-	MXC91231_PIN_AP_IPU_LD11	= IOMUX_PIN(0, 1, 10, 11, 1, 28),
-	MXC91231_PIN_AP_IPU_LD12	= IOMUX_PIN(0, 1, 11, 11, 2, 28),
-	MXC91231_PIN_AP_IPU_LD13	= IOMUX_PIN(0, 1, 12, 11, 3, 28),
-	MXC91231_PIN_AP_IPU_LD14	= IOMUX_PIN(0, 1, 13, 12, 0, 28),
-	MXC91231_PIN_AP_IPU_LD15	= IOMUX_PIN(0, 1, 14, 12, 1, 28),
-	MXC91231_PIN_AP_KPROW4		= IOMUX_PIN(0, 7,  0, 12, 2, 10),
-	MXC91231_PIN_AP_KPROW5		= IOMUX_PIN(0, 1, 16, 12, 3, 10),
-	MXC91231_PIN_AP_GPIO_AP_B17	= IOMUX_PIN(0, 1, 17, 13, 0, 10),
-	MXC91231_PIN_AP_GPIO_AP_B18	= IOMUX_PIN(0, 1, 18, 13, 1, 10),
-	MXC91231_PIN_AP_KPCOL3		= IOMUX_PIN(0, 1, 19, 13, 2, 11),
-	MXC91231_PIN_AP_KPCOL4		= IOMUX_PIN(0, 1, 20, 13, 3, 11),
-	MXC91231_PIN_AP_KPCOL5		= IOMUX_PIN(0, 1, 21, 14, 0, 11),
-	MXC91231_PIN_AP_GPIO_AP_B22	= IOMUX_PIN(0, 1, 22, 14, 1, 11),
-	MXC91231_PIN_AP_GPIO_AP_B23	= IOMUX_PIN(0, 1, 23, 14, 2, 11),
-	MXC91231_PIN_AP_CSI_D0		= IOMUX_PIN(0, 1, 24, 14, 3, 21),
-	MXC91231_PIN_AP_CSI_D1		= IOMUX_PIN(0, 1, 25, 15, 0, 21),
-	MXC91231_PIN_AP_CSI_D2		= IOMUX_PIN(0, 1, 26, 15, 1, 21),
-	MXC91231_PIN_AP_CSI_D3		= IOMUX_PIN(0, 1, 27, 15, 2, 21),
-	MXC91231_PIN_AP_CSI_D4		= IOMUX_PIN(0, 1, 28, 15, 3, 21),
-	MXC91231_PIN_AP_CSI_D5		= IOMUX_PIN(0, 1, 29, 16, 0, 21),
-	MXC91231_PIN_AP_CSI_D6		= IOMUX_PIN(0, 1, 30, 16, 1, 21),
-	MXC91231_PIN_AP_CSI_D7		= IOMUX_PIN(0, 1, 31, 16, 2, 21),
-	MXC91231_PIN_AP_CSI_D8		= IOMUX_PIN(0, 2,  0, 16, 3, 21),
-	MXC91231_PIN_AP_CSI_D9		= IOMUX_PIN(0, 2,  1, 17, 0, 21),
-	MXC91231_PIN_AP_CSI_MCLK	= IOMUX_PIN(0, 2,  2, 17, 1, 21),
-	MXC91231_PIN_AP_CSI_VSYNC	= IOMUX_PIN(0, 2,  3, 17, 2, 21),
-	MXC91231_PIN_AP_CSI_HSYNC	= IOMUX_PIN(0, 2,  4, 17, 3, 21),
-	MXC91231_PIN_AP_CSI_PIXCLK	= IOMUX_PIN(0, 2,  5, 18, 0, 21),
-	MXC91231_PIN_AP_I2CLK		= IOMUX_PIN(0, 2,  6, 18, 1, 12),
-	MXC91231_PIN_AP_I2DAT		= IOMUX_PIN(0, 2,  7, 18, 2, 12),
-	MXC91231_PIN_AP_GPIO_AP_C8	= IOMUX_PIN(0, 2,  8, 18, 3,  9),
-	MXC91231_PIN_AP_GPIO_AP_C9	= IOMUX_PIN(0, 2,  9, 19, 0,  9),
-	MXC91231_PIN_AP_GPIO_AP_C10	= IOMUX_PIN(0, 2, 10, 19, 1,  9),
-	MXC91231_PIN_AP_GPIO_AP_C11	= IOMUX_PIN(0, 2, 11, 19, 2,  9),
-	MXC91231_PIN_AP_GPIO_AP_C12	= IOMUX_PIN(0, 2, 12, 19, 3,  9),
-	MXC91231_PIN_AP_GPIO_AP_C13	= IOMUX_PIN(0, 2, 13, 20, 0, 28),
-	MXC91231_PIN_AP_GPIO_AP_C14	= IOMUX_PIN(0, 2, 14, 20, 1, 28),
-	MXC91231_PIN_AP_GPIO_AP_C15	= IOMUX_PIN(0, 2, 15, 20, 2,  9),
-	MXC91231_PIN_AP_GPIO_AP_C16	= IOMUX_PIN(0, 2, 16, 20, 3,  9),
-	MXC91231_PIN_AP_GPIO_AP_C17	= IOMUX_PIN(0, 2, 17, 21, 0,  9),
-	MXC91231_PIN_AP_ED_INT0		= IOMUX_PIN(0, 2, 18, 21, 1, 22),
-	MXC91231_PIN_AP_ED_INT1		= IOMUX_PIN(0, 2, 19, 21, 2, 22),
-	MXC91231_PIN_AP_ED_INT2		= IOMUX_PIN(0, 2, 20, 21, 3, 22),
-	MXC91231_PIN_AP_ED_INT3		= IOMUX_PIN(0, 2, 21, 22, 0, 22),
-	MXC91231_PIN_AP_ED_INT4		= IOMUX_PIN(0, 2, 22, 22, 1, 23),
-	MXC91231_PIN_AP_ED_INT5		= IOMUX_PIN(0, 2, 23, 22, 2, 23),
-	MXC91231_PIN_AP_ED_INT6		= IOMUX_PIN(0, 2, 24, 22, 3, 23),
-	MXC91231_PIN_AP_ED_INT7		= IOMUX_PIN(0, 2, 25, 23, 0, 23),
-	MXC91231_PIN_AP_U2_DSR_B	= IOMUX_PIN(0, 2, 26, 23, 1, 28),
-	MXC91231_PIN_AP_U2_RI_B		= IOMUX_PIN(0, 2, 27, 23, 2, 28),
-	MXC91231_PIN_AP_U2_CTS_B	= IOMUX_PIN(0, 2, 28, 23, 3, 28),
-	MXC91231_PIN_AP_U2_DTR_B	= IOMUX_PIN(0, 2, 29, 24, 0, 28),
-	MXC91231_PIN_AP_KPROW0		= IOMUX_PIN(0, 7,  0, 24, 1, 10),
-	MXC91231_PIN_AP_KPROW1		= IOMUX_PIN(0, 1, 15, 24, 2, 10),
-	MXC91231_PIN_AP_KPROW2		= IOMUX_PIN(0, 7,  0, 24, 3, 10),
-	MXC91231_PIN_AP_KPROW3		= IOMUX_PIN(0, 7,  0, 25, 0, 10),
-	MXC91231_PIN_AP_KPCOL0		= IOMUX_PIN(0, 7,  0, 25, 1, 11),
-	MXC91231_PIN_AP_KPCOL1		= IOMUX_PIN(0, 7,  0, 25, 2, 11),
-	MXC91231_PIN_AP_KPCOL2		= IOMUX_PIN(0, 7,  0, 25, 3, 11),
-
-	/* Shared pins */
-	MXC91231_PIN_SP_U3_TXD		= IOMUX_PIN(1, 3,  0,  0, 0, 28),
-	MXC91231_PIN_SP_U3_RXD		= IOMUX_PIN(1, 3,  1,  0, 1, 28),
-	MXC91231_PIN_SP_U3_RTS_B	= IOMUX_PIN(1, 3,  2,  0, 2, 28),
-	MXC91231_PIN_SP_U3_CTS_B	= IOMUX_PIN(1, 3,  3,  0, 3, 28),
-	MXC91231_PIN_SP_USB_TXOE_B	= IOMUX_PIN(1, 3,  4,  1, 0, 28),
-	MXC91231_PIN_SP_USB_DAT_VP	= IOMUX_PIN(1, 3,  5,  1, 1, 28),
-	MXC91231_PIN_SP_USB_SE0_VM	= IOMUX_PIN(1, 3,  6,  1, 2, 28),
-	MXC91231_PIN_SP_USB_RXD		= IOMUX_PIN(1, 3,  7,  1, 3, 28),
-	MXC91231_PIN_SP_UH2_TXOE_B	= IOMUX_PIN(1, 3,  8,  2, 0, 28),
-	MXC91231_PIN_SP_UH2_SPEED	= IOMUX_PIN(1, 3,  9,  2, 1, 28),
-	MXC91231_PIN_SP_UH2_SUSPEN	= IOMUX_PIN(1, 3, 10,  2, 2, 28),
-	MXC91231_PIN_SP_UH2_TXDP	= IOMUX_PIN(1, 3, 11,  2, 3, 28),
-	MXC91231_PIN_SP_UH2_RXDP	= IOMUX_PIN(1, 3, 12,  3, 0, 28),
-	MXC91231_PIN_SP_UH2_RXDM	= IOMUX_PIN(1, 3, 13,  3, 1, 28),
-	MXC91231_PIN_SP_UH2_OVR		= IOMUX_PIN(1, 3, 14,  3, 2, 28),
-	MXC91231_PIN_SP_UH2_PWR		= IOMUX_PIN(1, 3, 15,  3, 3, 28),
-	MXC91231_PIN_SP_SD1_DAT0	= IOMUX_PIN(1, 3, 16,  4, 0, 25),
-	MXC91231_PIN_SP_SD1_DAT1	= IOMUX_PIN(1, 3, 17,  4, 1, 25),
-	MXC91231_PIN_SP_SD1_DAT2	= IOMUX_PIN(1, 3, 18,  4, 2, 25),
-	MXC91231_PIN_SP_SD1_DAT3	= IOMUX_PIN(1, 3, 19,  4, 3, 25),
-	MXC91231_PIN_SP_SD1_CMD		= IOMUX_PIN(1, 3, 20,  5, 0, 25),
-	MXC91231_PIN_SP_SD1_CLK		= IOMUX_PIN(1, 3, 21,  5, 1, 25),
-	MXC91231_PIN_SP_SD2_DAT0	= IOMUX_PIN(1, 3, 22,  5, 2, 26),
-	MXC91231_PIN_SP_SD2_DAT1	= IOMUX_PIN(1, 3, 23,  5, 3, 26),
-	MXC91231_PIN_SP_SD2_DAT2	= IOMUX_PIN(1, 3, 24,  6, 0, 26),
-	MXC91231_PIN_SP_SD2_DAT3	= IOMUX_PIN(1, 3, 25,  6, 1, 26),
-	MXC91231_PIN_SP_GPIO_SP_A26	= IOMUX_PIN(1, 3, 26,  6, 2, 28),
-	MXC91231_PIN_SP_SPI1_CLK	= IOMUX_PIN(1, 3, 27,  6, 3, 13),
-	MXC91231_PIN_SP_SPI1_MOSI	= IOMUX_PIN(1, 3, 28,  7, 0, 13),
-	MXC91231_PIN_SP_SPI1_MISO	= IOMUX_PIN(1, 3, 29,  7, 1, 13),
-	MXC91231_PIN_SP_SPI1_SS0	= IOMUX_PIN(1, 3, 30,  7, 2, 13),
-	MXC91231_PIN_SP_SPI1_SS1	= IOMUX_PIN(1, 3, 31,  7, 3, 13),
-	MXC91231_PIN_SP_SD2_CMD		= IOMUX_PIN(1, 7,  0,  8, 0, 26),
-	MXC91231_PIN_SP_SD2_CLK		= IOMUX_PIN(1, 7,  0,  8, 1, 26),
-	MXC91231_PIN_SP_SIM1_RST_B	= IOMUX_PIN(1, 2, 30,  8, 2, 28),
-	MXC91231_PIN_SP_SIM1_SVEN	= IOMUX_PIN(1, 7,  0,  8, 3, 28),
-	MXC91231_PIN_SP_SIM1_CLK	= IOMUX_PIN(1, 7,  0,  9, 0, 28),
-	MXC91231_PIN_SP_SIM1_TRXD	= IOMUX_PIN(1, 7,  0,  9, 1, 28),
-	MXC91231_PIN_SP_SIM1_PD		= IOMUX_PIN(1, 2, 31,  9, 2, 28),
-	MXC91231_PIN_SP_UH2_TXDM	= IOMUX_PIN(1, 7,  0,  9, 3, 28),
-	MXC91231_PIN_SP_UH2_RXD		= IOMUX_PIN(1, 7,  0, 10, 0, 28),
-};
-
-#define PIN_AP_MAX	(104)
-#define PIN_SP_MAX	(41)
-
-#define PIN_MAX		(PIN_AP_MAX + PIN_SP_MAX)
-
-/*
- * Convenience values for use with mxc_iomux_mode()
- *
- * Format here is MXC91231_PIN_(pin name)__(function)
- */
-
-#define MXC91231_PIN_SP_USB_DAT_VP__USB_DAT_VP \
-	IOMUX_MODE(MXC91231_PIN_SP_USB_DAT_VP, IOMUX_CONFIG_FUNC)
-#define MXC91231_PIN_SP_USB_SE0_VM__USB_SE0_VM \
-	IOMUX_MODE(MXC91231_PIN_SP_USB_SE0_VM, IOMUX_CONFIG_FUNC)
-#define MXC91231_PIN_SP_USB_DAT_VP__RXD2 \
-	IOMUX_MODE(MXC91231_PIN_SP_USB_DAT_VP, IOMUX_CONFIG_ALT1)
-#define MXC91231_PIN_SP_USB_SE0_VM__TXD2 \
-	IOMUX_MODE(MXC91231_PIN_SP_USB_SE0_VM, IOMUX_CONFIG_ALT1)
-
-
-#endif /* __MACH_IOMUX_MXC91231_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index a3d930d..35c89bc 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -35,8 +35,6 @@
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_SOC_IMX51
 #define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MXC91231
-#define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX3
 #define MXC_GPIO_IRQS		(32 * 3)
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 5d51cbb..11be5cd 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -19,7 +19,6 @@
 #define MX50_PHYS_OFFSET	UL(0x70000000)
 #define MX51_PHYS_OFFSET	UL(0x90000000)
 #define MX53_PHYS_OFFSET	UL(0x70000000)
-#define MXC91231_PHYS_OFFSET	UL(0x90000000)
 
 #if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
 # if defined CONFIG_ARCH_MX1
@@ -32,8 +31,6 @@
 #  define PLAT_PHYS_OFFSET		MX27_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX3
 #  define PLAT_PHYS_OFFSET		MX3x_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MXC91231
-#  define PLAT_PHYS_OFFSET		MXC91231_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX50
 #  define PLAT_PHYS_OFFSET		MX50_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX51
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a6757dd..4ac53ce 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -35,7 +35,6 @@
 #define MXC_CPU_MX50		50
 #define MXC_CPU_MX51		51
 #define MXC_CPU_MX53		53
-#define MXC_CPU_MXC91231	91231
 
 #define IMX_CHIP_REVISION_1_0		0x10
 #define IMX_CHIP_REVISION_1_1		0x11
@@ -177,18 +176,6 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx53()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MXC91231
-# ifdef mxc_cpu_type
-#  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MXC91231
-# endif
-# define cpu_is_mxc91231()	(mxc_cpu_type == MXC_CPU_MXC91231)
-#else
-# define cpu_is_mxc91231()	(0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 struct cpu_op {
@@ -207,7 +194,7 @@ enum mxc_cpu_pwr_mode {
 extern struct cpu_op *(*get_cpu_op)(int *op);
 #endif
 
-#define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35() || cpu_is_mxc91231())
+#define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35())
 #define cpu_is_mx2()	(cpu_is_mx21() || cpu_is_mx27())
 
 #endif /*  __ASM_ARCH_MXC_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mxc91231.h b/arch/arm/plat-mxc/include/mach/mxc91231.h
deleted file mode 100644
index 765190f..0000000
--- a/arch/arm/plat-mxc/include/mach/mxc91231.h
+++ /dev/null
@@ -1,256 +0,0 @@
-/*
- *  Copyright 2004-2006 Freescale Semiconductor, Inc. All Rights Reserved.
- *    - Platform specific register memory map
- *
- *  Copyright 2005-2007 Motorola, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __MACH_MXC91231_H__
-#define __MACH_MXC91231_H__
-
-/*
- * L2CC
- */
-#define MXC91231_L2CC_BASE_ADDR		0x30000000
-#define MXC91231_L2CC_SIZE		SZ_64K
-
-/*
- * AIPS 1
- */
-#define MXC91231_AIPS1_BASE_ADDR	0x43F00000
-#define MXC91231_AIPS1_SIZE		SZ_1M
-
-#define MXC91231_AIPS1_CTRL_BASE_ADDR	MXC91231_AIPS1_BASE_ADDR
-#define MXC91231_MAX_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0x04000)
-#define MXC91231_EVTMON_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x08000)
-#define MXC91231_CLKCTL_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x0C000)
-#define MXC91231_ETB_SLOT4_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x10000)
-#define MXC91231_ETB_SLOT5_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x14000)
-#define MXC91231_ECT_CTIO_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x18000)
-#define MXC91231_I2C_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0x80000)
-#define MXC91231_MU_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0x88000)
-#define MXC91231_UART1_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x90000)
-#define MXC91231_UART2_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x94000)
-#define MXC91231_DSM_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0x98000)
-#define MXC91231_OWIRE_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0x9C000)
-#define MXC91231_SSI1_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0xA0000)
-#define MXC91231_KPP_BASE_ADDR		(MXC91231_AIPS1_BASE_ADDR + 0xA8000)
-#define MXC91231_IOMUX_AP_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0xAC000)
-#define MXC91231_CTI_AP_BASE_ADDR	(MXC91231_AIPS1_BASE_ADDR + 0xB8000)
-
-/*
- * AIPS 2
- */
-#define MXC91231_AIPS2_BASE_ADDR	0x53F00000
-#define MXC91231_AIPS2_SIZE		SZ_1M
-
-#define MXC91231_GEMK_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0x8C000)
-#define MXC91231_GPT1_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0x90000)
-#define MXC91231_EPIT1_AP_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0x94000)
-#define MXC91231_SCC_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xAC000)
-#define MXC91231_RNGA_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xB0000)
-#define MXC91231_IPU_CTRL_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xC0000)
-#define MXC91231_AUDMUX_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xC4000)
-#define MXC91231_EDIO_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xC8000)
-#define MXC91231_GPIO1_AP_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xCC000)
-#define MXC91231_GPIO2_AP_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xD0000)
-#define MXC91231_SDMA_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xD4000)
-#define MXC91231_RTC_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xD8000)
-#define MXC91231_WDOG1_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xDC000)
-#define MXC91231_PWM_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xE0000)
-#define MXC91231_GPIO3_AP_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xE4000)
-#define MXC91231_WDOG2_BASE_ADDR	(MXC91231_AIPS2_BASE_ADDR + 0xE8000)
-#define MXC91231_RTIC_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xEC000)
-#define MXC91231_LPMC_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0xF0000)
-
-/*
- * SPBA global module 0
- */
-#define MXC91231_SPBA0_BASE_ADDR	0x50000000
-#define MXC91231_SPBA0_SIZE		SZ_1M
-
-#define MXC91231_MMC_SDHC1_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x04000)
-#define MXC91231_MMC_SDHC2_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x08000)
-#define MXC91231_UART3_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x0C000)
-#define MXC91231_CSPI2_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x10000)
-#define MXC91231_SSI2_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x14000)
-#define MXC91231_SIM_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x18000)
-#define MXC91231_IIM_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x1C000)
-#define MXC91231_CTI_SDMA_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x20000)
-#define MXC91231_USBOTG_CTRL_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x24000)
-#define MXC91231_USBOTG_DATA_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x28000)
-#define MXC91231_CSPI1_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x30000)
-#define MXC91231_SPBA_CTRL_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x3C000)
-#define MXC91231_IOMUX_COM_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x40000)
-#define MXC91231_CRM_COM_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x44000)
-#define MXC91231_CRM_AP_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x48000)
-#define MXC91231_PLL0_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x4C000)
-#define MXC91231_PLL1_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x50000)
-#define MXC91231_PLL2_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x54000)
-#define MXC91231_GPIO4_SH_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x58000)
-#define MXC91231_HAC_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x5C000)
-#define MXC91231_SAHARA_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x5C000)
-#define MXC91231_PLL3_BASE_ADDR		(MXC91231_SPBA0_BASE_ADDR + 0x60000)
-
-/*
- * SPBA global module 1
- */
-#define MXC91231_SPBA1_BASE_ADDR	0x52000000
-#define MXC91231_SPBA1_SIZE		SZ_1M
-
-#define MXC91231_MQSPI_BASE_ADDR	(MXC91231_SPBA1_BASE_ADDR + 0x34000)
-#define MXC91231_EL1T_BASE_ADDR		(MXC91231_SPBA1_BASE_ADDR + 0x38000)
-
-/*!
- * Defines for SPBA modules
- */
-#define MXC91231_SPBA_SDHC1		0x04
-#define MXC91231_SPBA_SDHC2		0x08
-#define MXC91231_SPBA_UART3		0x0C
-#define MXC91231_SPBA_CSPI2		0x10
-#define MXC91231_SPBA_SSI2		0x14
-#define MXC91231_SPBA_SIM		0x18
-#define MXC91231_SPBA_IIM		0x1C
-#define MXC91231_SPBA_CTI_SDMA		0x20
-#define MXC91231_SPBA_USBOTG_CTRL_REGS	0x24
-#define MXC91231_SPBA_USBOTG_DATA_REGS	0x28
-#define MXC91231_SPBA_CSPI1		0x30
-#define MXC91231_SPBA_MQSPI		0x34
-#define MXC91231_SPBA_EL1T		0x38
-#define MXC91231_SPBA_IOMUX		0x40
-#define MXC91231_SPBA_CRM_COM		0x44
-#define MXC91231_SPBA_CRM_AP		0x48
-#define MXC91231_SPBA_PLL0		0x4C
-#define MXC91231_SPBA_PLL1		0x50
-#define MXC91231_SPBA_PLL2		0x54
-#define MXC91231_SPBA_GPIO4		0x58
-#define MXC91231_SPBA_SAHARA		0x5C
-
-/*
- * ROMP and AVIC
- */
-#define MXC91231_ROMP_BASE_ADDR		0x60000000
-#define MXC91231_ROMP_SIZE		SZ_64K
-
-#define MXC91231_AVIC_BASE_ADDR		0x68000000
-#define MXC91231_AVIC_SIZE		SZ_64K
-
-/*
- * NAND, SDRAM, WEIM, M3IF, EMI controllers
- */
-#define MXC91231_X_MEMC_BASE_ADDR	0xB8000000
-#define MXC91231_X_MEMC_SIZE		SZ_64K
-
-#define MXC91231_NFC_BASE_ADDR		(MXC91231_X_MEMC_BASE_ADDR + 0x0000)
-#define MXC91231_ESDCTL_BASE_ADDR	(MXC91231_X_MEMC_BASE_ADDR + 0x1000)
-#define MXC91231_WEIM_BASE_ADDR		(MXC91231_X_MEMC_BASE_ADDR + 0x2000)
-#define MXC91231_M3IF_BASE_ADDR		(MXC91231_X_MEMC_BASE_ADDR + 0x3000)
-#define MXC91231_EMI_CTL_BASE_ADDR	(MXC91231_X_MEMC_BASE_ADDR + 0x4000)
-
-/*
- * Memory regions and CS
- * CPLD is connected on CS4
- * CS5 is TP1021 or it is not connected
- * */
-#define MXC91231_FB_RAM_BASE_ADDR	0x78000000
-#define MXC91231_FB_RAM_SIZE		SZ_256K
-#define MXC91231_CSD0_BASE_ADDR		0x80000000
-#define MXC91231_CSD1_BASE_ADDR		0x90000000
-#define MXC91231_CS0_BASE_ADDR		0xA0000000
-#define MXC91231_CS1_BASE_ADDR		0xA8000000
-#define MXC91231_CS2_BASE_ADDR		0xB0000000
-#define MXC91231_CS3_BASE_ADDR		0xB2000000
-#define MXC91231_CS4_BASE_ADDR		0xB4000000
-#define MXC91231_CS5_BASE_ADDR		0xB6000000
-
-/*
- * This macro defines the physical to virtual address mapping for all the
- * peripheral modules. It is used by passing in the physical address as x
- * and returning the virtual address.
- */
-#define MXC91231_IO_P2V(x)		IMX_IO_P2V(x)
-#define MXC91231_IO_ADDRESS(x)		IOMEM(MXC91231_IO_P2V(x))
-
-/*
- * Interrupt numbers
- */
-#define MXC91231_INT_GPIO3		0
-#define MXC91231_INT_EL1T_CI		1
-#define MXC91231_INT_EL1T_RFCI		2
-#define MXC91231_INT_EL1T_RFI		3
-#define MXC91231_INT_EL1T_MCU		4
-#define MXC91231_INT_EL1T_IPI		5
-#define MXC91231_INT_MU_GEN		6
-#define MXC91231_INT_GPIO4		7
-#define MXC91231_INT_MMC_SDHC2		8
-#define MXC91231_INT_MMC_SDHC1		9
-#define MXC91231_INT_I2C		10
-#define MXC91231_INT_SSI2		11
-#define MXC91231_INT_SSI1		12
-#define MXC91231_INT_CSPI2		13
-#define MXC91231_INT_CSPI1		14
-#define MXC91231_INT_RTIC		15
-#define MXC91231_INT_SAHARA		15
-#define MXC91231_INT_HAC		15
-#define MXC91231_INT_UART3_RX		16
-#define MXC91231_INT_UART3_TX		17
-#define MXC91231_INT_UART3_MINT		18
-#define MXC91231_INT_ECT		19
-#define MXC91231_INT_SIM_IPB		20
-#define MXC91231_INT_SIM_DATA		21
-#define MXC91231_INT_RNGA		22
-#define MXC91231_INT_DSM_AP		23
-#define MXC91231_INT_KPP		24
-#define MXC91231_INT_RTC		25
-#define MXC91231_INT_PWM		26
-#define MXC91231_INT_GEMK_AP		27
-#define MXC91231_INT_EPIT		28
-#define MXC91231_INT_GPT		29
-#define MXC91231_INT_UART2_RX		30
-#define MXC91231_INT_UART2_TX		31
-#define MXC91231_INT_UART2_MINT		32
-#define MXC91231_INT_NANDFC		33
-#define MXC91231_INT_SDMA		34
-#define MXC91231_INT_USB_WAKEUP		35
-#define MXC91231_INT_USB_SOF		36
-#define MXC91231_INT_PMU_EVTMON		37
-#define MXC91231_INT_USB_FUNC		38
-#define MXC91231_INT_USB_DMA		39
-#define MXC91231_INT_USB_CTRL		40
-#define MXC91231_INT_IPU_ERR		41
-#define MXC91231_INT_IPU_SYN		42
-#define MXC91231_INT_UART1_RX		43
-#define MXC91231_INT_UART1_TX		44
-#define MXC91231_INT_UART1_MINT		45
-#define MXC91231_INT_IIM		46
-#define MXC91231_INT_MU_RX_OR		47
-#define MXC91231_INT_MU_TX_OR		48
-#define MXC91231_INT_SCC_SCM		49
-#define MXC91231_INT_SCC_SMN		50
-#define MXC91231_INT_GPIO2		51
-#define MXC91231_INT_GPIO1		52
-#define MXC91231_INT_MQSPI1		53
-#define MXC91231_INT_MQSPI2		54
-#define MXC91231_INT_WDOG2		55
-#define MXC91231_INT_EXT_INT7		56
-#define MXC91231_INT_EXT_INT6		57
-#define MXC91231_INT_EXT_INT5		58
-#define MXC91231_INT_EXT_INT4		59
-#define MXC91231_INT_EXT_INT3		60
-#define MXC91231_INT_EXT_INT2		61
-#define MXC91231_INT_EXT_INT1		62
-#define MXC91231_INT_EXT_INT0		63
-
-#define MXC91231_MAX_INT_LINES		63
-#define MXC91231_MAX_EXT_LINES		8
-
-#endif /* __MACH_MXC91231_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 0417da9..51f02a9 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -24,12 +24,6 @@ extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
 
 static inline void arch_idle(void)
 {
-#ifdef CONFIG_ARCH_MXC91231
-	if (cpu_is_mxc91231()) {
-		/* Need this to set DSM low-power mode */
-		mxc91231_prepare_idle();
-	}
-#endif
 	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
 	if (cpu_is_mx31() || cpu_is_mx35()) {
 		unsigned long reg = 0;
diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/plat-mxc/include/mach/timex.h
index 2d96246..d61d5c7 100644
--- a/arch/arm/plat-mxc/include/mach/timex.h
+++ b/arch/arm/plat-mxc/include/mach/timex.h
@@ -26,8 +26,6 @@
 #define CLOCK_TICK_RATE		16000000
 #elif defined CONFIG_ARCH_MX5
 #define CLOCK_TICK_RATE		8000000
-#elif defined CONFIG_ARCH_MXC91231
-#define CLOCK_TICK_RATE		13000000
 #endif
 
 #endif				/* __ASM_ARCH_MXC_TIMEX_H__ */
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 3455fc0..8024f2a 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -37,12 +37,6 @@ void arch_reset(char mode, const char *cmd)
 {
 	unsigned int wcr_enable;
 
-#ifdef CONFIG_ARCH_MXC91231
-	if (cpu_is_mxc91231()) {
-		mxc91231_arch_reset(mode, cmd);
-		return;
-	}
-#endif
 #ifdef CONFIG_MACH_MX51_EFIKAMX
 	if (machine_is_mx51_efikamx()) {
 		mx51_efikamx_reset();
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 2237ff8..40f32e7 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -54,7 +54,7 @@
 #define MX2_TSTAT_CAPT		(1 << 1)
 #define MX2_TSTAT_COMP		(1 << 0)
 
-/* MX31, MX35, MX25, MXC91231, MX5 */
+/* MX31, MX35, MX25, MX5 */
 #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
 #define V2_TCTL_CLK_IPG		(1 << 6)
 #define V2_TCTL_FRR		(1 << 9)
-- 
1.7.2.3
