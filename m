From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 17 Nov 2010 09:41:54 -0700
Subject: [PATCH] ARM i.MX: consolidate chip revision macros
In-Reply-To: <1289986586-27227-1-git-send-email-s.hauer@pengutronix.de>
References: <1289986586-27227-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <86A0E76937111F4C92FABEC0A20988510523D456@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
>Sent: Wednesday, November 17, 2010 3:36 AM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Nguyen Dinh-R00091; Sascha Hauer
>Subject: [PATCH] ARM i.MX: consolidate chip revision macros
>
>We have several SoC specific chip revision defines in the tree. This
>patch consolidates these defines to defines usable on all i.MX.
>
>Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>---
> arch/arm/mach-imx/clock-imx27.c       |   22 +++++++++++-----------
> arch/arm/mach-imx/cpu-imx27.c         |   14 +++++++++++++-
> arch/arm/mach-mx3/clock-imx31.c       |    2 +-
> arch/arm/mach-mx3/cpu.c               |   31
++++++++++++++++++-------------
> arch/arm/mach-mx5/cpu.c               |   12 ++++++------
> arch/arm/mach-mx5/mm.c                |    2 +-
> arch/arm/plat-mxc/include/mach/mx27.h |    4 ----
> arch/arm/plat-mxc/include/mach/mx31.h |   16 ----------------
> arch/arm/plat-mxc/include/mach/mx35.h |    3 ---
> arch/arm/plat-mxc/include/mach/mx3x.h |   16 ----------------
> arch/arm/plat-mxc/include/mach/mx51.h |   13 -------------
> arch/arm/plat-mxc/include/mach/mxc.h  |   14 ++++++++++++++
> 12 files changed, 64 insertions(+), 85 deletions(-)
>
>diff --git a/arch/arm/mach-imx/clock-imx27.c
b/arch/arm/mach-imx/clock-imx27.c
>index 98a25ba..2202b88 100644
>--- a/arch/arm/mach-imx/clock-imx27.c
>+++ b/arch/arm/mach-imx/clock-imx27.c
>@@ -125,7 +125,7 @@ static int clk_cpu_set_parent(struct clk *clk,
struct clk *parent)
> 	if (clk->parent == parent)
> 		return 0;
>
>-	if (mx27_revision() >= CHIP_REV_2_0) {
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
> 		if (parent == &mpll_main1_clk) {
> 			cscr |= CCM_CSCR_ARM_SRC;
> 		} else {
>@@ -174,7 +174,7 @@ static int set_rate_cpu(struct clk *clk, unsigned
long rate)
> 	div--;
>
> 	reg = __raw_readl(CCM_CSCR);
>-	if (mx27_revision() >= CHIP_REV_2_0) {
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
> 		reg &= ~(3 << 12);
> 		reg |= div << 12;
> 		reg &= ~(CCM_CSCR_FPM | CCM_CSCR_SPEN);
>@@ -244,7 +244,7 @@ static unsigned long get_rate_ssix(struct clk *clk,
unsigned long pdf)
>
> 	parent_rate = clk_get_rate(clk->parent);
>
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		pdf += 4;  /* MX27 TO2+ */
> 	else
> 		pdf = (pdf < 2) ? 124UL : pdf;  /* MX21 & MX27 TO1 */
>@@ -269,7 +269,7 @@ static unsigned long get_rate_nfc(struct clk *clk)
>
> 	parent_rate = clk_get_rate(clk->parent);
>
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		nfc_pdf = (__raw_readl(CCM_PCDR0) >> 6) & 0xf;
> 	else
> 		nfc_pdf = (__raw_readl(CCM_PCDR0) >> 12) & 0xf;
>@@ -284,7 +284,7 @@ static unsigned long get_rate_vpu(struct clk *clk)
>
> 	parent_rate = clk_get_rate(clk->parent);
>
>-	if (mx27_revision() >= CHIP_REV_2_0) {
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
> 		vpu_pdf = (__raw_readl(CCM_PCDR0) >> 10) & 0x3f;
> 		vpu_pdf += 4;
> 	} else {
>@@ -347,7 +347,7 @@ static unsigned long get_rate_mpll_main(struct clk
*clk)
> 	 * clk->id == 0: arm clock source path 1 which is from 2 * MPLL
/ 2
> 	 * clk->id == 1: arm clock source path 2 which is from 2 * MPLL
/ 3
> 	 */
>-	if (mx27_revision() >= CHIP_REV_2_0 && clk->id == 1)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0 && clk->id == 1)
> 		return 2UL * parent_rate / 3UL;
>
> 	return parent_rate;
>@@ -365,7 +365,7 @@ static unsigned long get_rate_spll(struct clk *clk)
> 	/* On TO2 we have to write the value back. Otherwise we
> 	 * read 0 from this register the next time.
> 	 */
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		__raw_writel(reg, CCM_SPCTL0);
>
> 	return mxc_decode_pll(reg, rate);
>@@ -376,7 +376,7 @@ static unsigned long get_rate_cpu(struct clk *clk)
> 	u32 div;
> 	unsigned long rate;
>
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		div = (__raw_readl(CCM_CSCR) >> 12) & 0x3;
> 	else
> 		div = (__raw_readl(CCM_CSCR) >> 13) & 0x7;
>@@ -389,7 +389,7 @@ static unsigned long get_rate_ahb(struct clk *clk)
> {
> 	unsigned long rate, bclk_pdf;
>
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		bclk_pdf = (__raw_readl(CCM_CSCR) >> 8) & 0x3;
> 	else
> 		bclk_pdf = (__raw_readl(CCM_CSCR) >> 9) & 0xf;
>@@ -402,7 +402,7 @@ static unsigned long get_rate_ipg(struct clk *clk)
> {
> 	unsigned long rate, ipg_pdf;
>
>-	if (mx27_revision() >= CHIP_REV_2_0)
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
> 		return clk_get_rate(clk->parent);
> 	else
> 		ipg_pdf = (__raw_readl(CCM_CSCR) >> 8) & 1;
>@@ -683,7 +683,7 @@ static void __init to2_adjust_clocks(void)
> {
> 	unsigned long cscr = __raw_readl(CCM_CSCR);
>
>-	if (mx27_revision() >= CHIP_REV_2_0) {
>+	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
> 		if (cscr & CCM_CSCR_ARM_SRC)
> 			cpu_clk.parent = &mpll_main1_clk;
>
>diff --git a/arch/arm/mach-imx/cpu-imx27.c
b/arch/arm/mach-imx/cpu-imx27.c
>index d8d3b2d..3b117be 100644
>--- a/arch/arm/mach-imx/cpu-imx27.c
>+++ b/arch/arm/mach-imx/cpu-imx27.c
>@@ -42,7 +42,19 @@ static void query_silicon_parameter(void)
> 	val = __raw_readl(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR
> 				+ SYS_CHIP_ID));
>
>-	cpu_silicon_rev = (int)(val >> 28);
>+	switch (val >> 28) {
>+	case 0:
>+		cpu_silicon_rev = IMX_CHIP_REVISION_1_0;
>+		break;
>+	case 1:
>+		cpu_silicon_rev = IMX_CHIP_REVISION_2_0;
>+		break;
>+	case 2:
>+		cpu_silicon_rev = IMX_CHIP_REVISION_2_1;
>+		break;
>+	default:
>+		cpu_silicon_rev = IMX_CHIP_REVISION_UNKNOWN;
>+	}
> 	cpu_partnumber = (int)((val >> 12) & 0xFFFF);
> }
>
>diff --git a/arch/arm/mach-mx3/clock-imx31.c
b/arch/arm/mach-mx3/clock-imx31.c
>index 109e98f..7cf6d29 100644
>--- a/arch/arm/mach-mx3/clock-imx31.c
>+++ b/arch/arm/mach-mx3/clock-imx31.c
>@@ -615,7 +615,7 @@ int __init mx31_clocks_init(unsigned long fref)
>
> 	mx31_read_cpu_rev();
>
>-	if (mx31_revision() >= MX31_CHIP_REV_2_0) {
>+	if (mx31_revision() >= IMX_CHIP_REVISION_2_0) {
> 		reg = __raw_readl(MXC_CCM_PMCR1);
> 		/* No PLL restart on DVFS switch; enable auto EMI
handshake */
> 		reg |= MXC_CCM_PMCR1_PLLRDIS | MXC_CCM_PMCR1_EMIRQ_EN;
>diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
>index d00a754..aa33c76 100644
>--- a/arch/arm/mach-mx3/cpu.c
>+++ b/arch/arm/mach-mx3/cpu.c
>@@ -25,15 +25,15 @@ struct mx3_cpu_type {
> };
>
> static struct mx3_cpu_type mx31_cpu_type[] __initdata = {
>-	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev =
MX3x_CHIP_REV_1_0 },
>-	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev =
MX3x_CHIP_REV_1_1 },
>-	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev =
MX3x_CHIP_REV_1_1 },
>-	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev =
MX3x_CHIP_REV_1_1 },
>-	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev =
MX3x_CHIP_REV_1_1 },
>-	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev =
MX3x_CHIP_REV_1_2 },
>-	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev =
MX3x_CHIP_REV_1_2 },
>-	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev =
MX3x_CHIP_REV_2_0 },
>-	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev =
MX3x_CHIP_REV_2_0 },
>+	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev =
IMX_CHIP_REVISION_1_0	},
>+	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev =
IMX_CHIP_REVISION_1_1	},
>+	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev =
IMX_CHIP_REVISION_1_1	},
>+	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev =
IMX_CHIP_REVISION_1_1	},
>+	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev =
IMX_CHIP_REVISION_1_1	},
>+	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev =
IMX_CHIP_REVISION_1_2	},
>+	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev =
IMX_CHIP_REVISION_1_2	},
>+	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev =
IMX_CHIP_REVISION_2_0	},
>+	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev =
IMX_CHIP_REVISION_2_0	},
> };
>
> void __init mx31_read_cpu_rev(void)
>@@ -53,6 +53,8 @@ void __init mx31_read_cpu_rev(void)
> 			return;
> 		}
>
>+	mx31_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
>+
> 	printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n",
srev);
> }
>
>@@ -62,22 +64,25 @@ EXPORT_SYMBOL(mx35_cpu_rev);
> void __init mx35_read_cpu_rev(void)
> {
> 	u32 rev;
>-	char *srev = "unknown";
>+	char *srev;
>
> 	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR +
MXC_IIMSREV));
> 	switch (rev) {
> 	case 0x00:
>-		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
>+		mx35_cpu_rev = IMX_CHIP_REVISION_1_0;
> 		srev = "1.0";
> 		break;
> 	case 0x10:
>-		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
>+		mx35_cpu_rev = IMX_CHIP_REVISION_2_0;
> 		srev = "2.0";
> 		break;
> 	case 0x11:
>-		mx35_cpu_rev = MX3x_CHIP_REV_2_1;
>+		mx35_cpu_rev = IMX_CHIP_REVISION_2_1;
> 		srev = "2.1";
> 		break;
>+	defaukt:
>+		mx35_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
>+		srev = "unknown";
> 	}
>
> 	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n",
srev);
>diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
>index 061ab70..8c1a1a8 100644
>--- a/arch/arm/mach-mx5/cpu.c
>+++ b/arch/arm/mach-mx5/cpu.c
>@@ -35,19 +35,19 @@ static void query_silicon_parameter(void)
> 	rev = readl(rom + SI_REV);
> 	switch (rev) {
> 	case 0x1:
>-		cpu_silicon_rev = MX51_CHIP_REV_1_0;
>+		cpu_silicon_rev = IMX_CHIP_REVISION_1_0;
> 		break;
> 	case 0x2:
>-		cpu_silicon_rev = MX51_CHIP_REV_1_1;
>+		cpu_silicon_rev = IMX_CHIP_REVISION_1_1;
> 		break;
> 	case 0x10:
>-		cpu_silicon_rev = MX51_CHIP_REV_2_0;
>+		cpu_silicon_rev = IMX_CHIP_REVISION_2_0;
> 		break;
> 	case 0x20:
>-		cpu_silicon_rev = MX51_CHIP_REV_3_0;
>+		cpu_silicon_rev = IMX_CHIP_REVISION_3_0;
> 		break;
> 	default:
>-		cpu_silicon_rev = 0;
>+		cpu_silicon_rev = IMX_CHIP_REVISION_UNKNOWN;
> 	}
>

You may not want to touch MX51 for now. I'm sure you've seen my patch to
get the chip version from the IIM instead of the rom. The IIM will
return 0x00 for REV_2_0 and 0x10 for REV_3_0. There should not be any
MX51 REV < 2_0 outside of Freescale, and even if you stumble across one,
you should throw it away.

> 	iounmap(rom);
>@@ -82,7 +82,7 @@ static int __init mx51_neon_fixup(void)
> 	if (!cpu_is_mx51())
> 		return 0;
>
>-	if (mx51_revision() < MX51_CHIP_REV_3_0 && (elf_hwcap &
HWCAP_NEON)) {
>+	if (mx51_revision() < IMX_CHIP_REVISION_3_0 && (elf_hwcap &
HWCAP_NEON)) {
> 		elf_hwcap &= ~HWCAP_NEON;
> 		pr_info("Turning off NEON support, detected broken NEON
implementation\n");
> 	}
>diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
>index 01dff26..843f2ba 100644
>--- a/arch/arm/mach-mx5/mm.c
>+++ b/arch/arm/mach-mx5/mm.c
>@@ -51,7 +51,7 @@ void __init mx51_init_irq(void)
> 	unsigned long tzic_addr;
> 	void __iomem *tzic_virt;
>
>-	if (mx51_revision() < MX51_CHIP_REV_2_0)
>+	if (mx51_revision() < IMX_CHIP_REVISION_2_0)
> 		tzic_addr = MX51_TZIC_BASE_ADDR_TO1;
> 	else
> 		tzic_addr = MX51_TZIC_BASE_ADDR;
>diff --git a/arch/arm/plat-mxc/include/mach/mx27.h
b/arch/arm/plat-mxc/include/mach/mx27.h
>index 3116b3b..992678f 100644
>--- a/arch/arm/plat-mxc/include/mach/mx27.h
>+++ b/arch/arm/plat-mxc/include/mach/mx27.h
>@@ -236,10 +236,6 @@ static inline void mx27_setup_weimcs(size_t cs,
> #define MX27_DMA_REQ_SDHC3	36
> #define MX27_DMA_REQ_NFC	37
>
>-/* silicon revisions specific to i.MX27 */
>-#define CHIP_REV_1_0		0x00
>-#define CHIP_REV_2_0		0x01
>-
> #ifndef __ASSEMBLY__
> extern int mx27_revision(void);
> #endif
>diff --git a/arch/arm/plat-mxc/include/mach/mx31.h
b/arch/arm/plat-mxc/include/mach/mx31.h
>index 6d4b98f..c159407 100644
>--- a/arch/arm/plat-mxc/include/mach/mx31.h
>+++ b/arch/arm/plat-mxc/include/mach/mx31.h
>@@ -199,20 +199,4 @@ static inline void mx31_setup_weimcs(size_t cs,
>
> #define MX31_PROD_SIGNATURE		0x1	/* For MX31 */
>
>-/* silicon revisions specific to i.MX31 */
>-#define MX31_CHIP_REV_1_0		0x10
>-#define MX31_CHIP_REV_1_1		0x11
>-#define MX31_CHIP_REV_1_2		0x12
>-#define MX31_CHIP_REV_1_3		0x13
>-#define MX31_CHIP_REV_2_0		0x20
>-#define MX31_CHIP_REV_2_1		0x21
>-#define MX31_CHIP_REV_2_2		0x22
>-#define MX31_CHIP_REV_2_3		0x23
>-#define MX31_CHIP_REV_3_0		0x30
>-#define MX31_CHIP_REV_3_1		0x31
>-#define MX31_CHIP_REV_3_2		0x32
>-
>-#define MX31_SYSTEM_REV_MIN		MX31_CHIP_REV_1_0
>-#define MX31_SYSTEM_REV_NUM		3
>-
> #endif /* ifndef __MACH_MX31_H__ */
>diff --git a/arch/arm/plat-mxc/include/mach/mx35.h
b/arch/arm/plat-mxc/include/mach/mx35.h
>index 9067225..4bd073f 100644
>--- a/arch/arm/plat-mxc/include/mach/mx35.h
>+++ b/arch/arm/plat-mxc/include/mach/mx35.h
>@@ -180,7 +180,4 @@
>
> #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
>
>-#define MX35_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
>-#define MX35_SYSTEM_REV_NUM		3
>-
> #endif /* ifndef __MACH_MX35_H__ */
>diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h
b/arch/arm/plat-mxc/include/mach/mx3x.h
>index 8c7f34e..388a407 100644
>--- a/arch/arm/plat-mxc/include/mach/mx3x.h
>+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
>@@ -184,22 +184,6 @@
>
> #define MX3x_PROD_SIGNATURE		0x1	/* For MX31 */
>
>-/* silicon revisions specific to i.MX31 and i.MX35 */
>-#define MX3x_CHIP_REV_1_0		0x10
>-#define MX3x_CHIP_REV_1_1		0x11
>-#define MX3x_CHIP_REV_1_2		0x12
>-#define MX3x_CHIP_REV_1_3		0x13
>-#define MX3x_CHIP_REV_2_0		0x20
>-#define MX3x_CHIP_REV_2_1		0x21
>-#define MX3x_CHIP_REV_2_2		0x22
>-#define MX3x_CHIP_REV_2_3		0x23
>-#define MX3x_CHIP_REV_3_0		0x30
>-#define MX3x_CHIP_REV_3_1		0x31
>-#define MX3x_CHIP_REV_3_2		0x32
>-
>-#define MX3x_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
>-#define MX3x_SYSTEM_REV_NUM		3
>-
> /* Mandatory defines used globally */
>
> #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
>diff --git a/arch/arm/plat-mxc/include/mach/mx51.h
b/arch/arm/plat-mxc/include/mach/mx51.h
>index 636347c..8fddfef 100644
>--- a/arch/arm/plat-mxc/include/mach/mx51.h
>+++ b/arch/arm/plat-mxc/include/mach/mx51.h
>@@ -345,19 +345,6 @@
> #define MX51_MXC_INT_EMI_NFC		101
> #define MX51_MXC_INT_GPU_IDLE		102
>
>-/* silicon revisions specific to i.MX51 */
>-#define MX51_CHIP_REV_1_0		0x10
>-#define MX51_CHIP_REV_1_1		0x11
>-#define MX51_CHIP_REV_1_2		0x12
>-#define MX51_CHIP_REV_1_3		0x13
>-#define MX51_CHIP_REV_2_0		0x20
>-#define MX51_CHIP_REV_2_1		0x21
>-#define MX51_CHIP_REV_2_2		0x22
>-#define MX51_CHIP_REV_2_3		0x23
>-#define MX51_CHIP_REV_3_0		0x30
>-#define MX51_CHIP_REV_3_1		0x31
>-#define MX51_CHIP_REV_3_2		0x32
>-
> #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
> extern int mx51_revision(void);
> #endif
>diff --git a/arch/arm/plat-mxc/include/mach/mxc.h
b/arch/arm/plat-mxc/include/mach/mxc.h
>index a42c720..19c3ba7 100644
>--- a/arch/arm/plat-mxc/include/mach/mxc.h
>+++ b/arch/arm/plat-mxc/include/mach/mxc.h
>@@ -35,6 +35,20 @@
> #define MXC_CPU_MX51		51
> #define MXC_CPU_MXC91231	91231
>
>+#define IMX_CHIP_REVISION_1_0		0x10
>+#define IMX_CHIP_REVISION_1_1		0x11
>+#define IMX_CHIP_REVISION_1_2		0x12
>+#define IMX_CHIP_REVISION_1_3		0x13
>+#define IMX_CHIP_REVISION_2_0		0x20
>+#define IMX_CHIP_REVISION_2_1		0x21
>+#define IMX_CHIP_REVISION_2_2		0x22
>+#define IMX_CHIP_REVISION_2_3		0x23
>+#define IMX_CHIP_REVISION_3_0		0x30
>+#define IMX_CHIP_REVISION_3_1		0x31
>+#define IMX_CHIP_REVISION_3_2		0x32
>+#define IMX_CHIP_REVISION_3_3		0x33
>+#define IMX_CHIP_REVISION_UNKNOWN	0xff
>+
> #ifndef __ASSEMBLY__
> extern unsigned int __mxc_cpu_type;
> #endif
>--
>1.7.2.3
>

Thanks,

Dinh
