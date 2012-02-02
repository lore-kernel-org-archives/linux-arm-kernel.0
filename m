From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  2 Feb 2012 20:02:31 -0200
Subject: [PATCH v2 1/2] ARM: mx3: Let mx31 and mx35 share the same CCM header
 file
Message-ID: <1328220152-3037-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let mx31 and mx35 share the same CCM header file

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes
 arch/arm/mach-imx/clock-imx31.c                    |    2 +-
 arch/arm/mach-imx/clock-imx35.c                    |  166 +++++++++-----------
 .../mach-imx/{crmregs-imx31.h => crmregs-imx3.h}   |   15 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +-
 4 files changed, 91 insertions(+), 94 deletions(-)
 rename arch/arm/mach-imx/{crmregs-imx31.h => crmregs-imx3.h} (94%)

diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index 988a281..3a943cd 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -32,7 +32,7 @@
 #include <mach/mx31.h>
 #include <mach/common.h>
 
-#include "crmregs-imx31.h"
+#include "crmregs-imx3.h"
 
 #define PRE_DIV_MIN_FREQ    10000000 /* Minimum Frequency after Predivider */
 
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index ac8238c..1e279af 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -27,23 +27,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
-#define CCM_BASE	MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR)
-
-#define CCM_CCMR        0x00
-#define CCM_PDR0        0x04
-#define CCM_PDR1        0x08
-#define CCM_PDR2        0x0C
-#define CCM_PDR3        0x10
-#define CCM_PDR4        0x14
-#define CCM_RCSR        0x18
-#define CCM_MPCTL       0x1C
-#define CCM_PPCTL       0x20
-#define CCM_ACMR        0x24
-#define CCM_COSR        0x28
-#define CCM_CGR0        0x2C
-#define CCM_CGR1        0x30
-#define CCM_CGR2        0x34
-#define CCM_CGR3        0x38
+#include "crmregs-imx3.h"
 
 #ifdef HAVE_SET_RATE_SUPPORT
 static void calc_dividers(u32 div, u32 *pre, u32 *post, u32 maxpost)
@@ -111,14 +95,14 @@ static void calc_dividers_3_3(u32 div, u32 *pre, u32 *post)
 
 static unsigned long get_rate_mpll(void)
 {
-	ulong mpctl = __raw_readl(CCM_BASE + CCM_MPCTL);
+	ulong mpctl = __raw_readl(MX35_CCM_MPCTL);
 
 	return mxc_decode_pll(mpctl, 24000000);
 }
 
 static unsigned long get_rate_ppll(void)
 {
-	ulong ppctl = __raw_readl(CCM_BASE + CCM_PPCTL);
+	ulong ppctl = __raw_readl(MX35_CCM_PPCTL);
 
 	return mxc_decode_pll(ppctl, 24000000);
 }
@@ -148,7 +132,7 @@ static struct arm_ahb_div clk_consumer[] = {
 
 static unsigned long get_rate_arm(void)
 {
-	unsigned long pdr0 = __raw_readl(CCM_BASE + CCM_PDR0);
+	unsigned long pdr0 = __raw_readl(MXC_CCM_PDR0);
 	struct arm_ahb_div *aad;
 	unsigned long fref = get_rate_mpll();
 
@@ -161,7 +145,7 @@ static unsigned long get_rate_arm(void)
 
 static unsigned long get_rate_ahb(struct clk *clk)
 {
-	unsigned long pdr0 = __raw_readl(CCM_BASE + CCM_PDR0);
+	unsigned long pdr0 = __raw_readl(MXC_CCM_PDR0);
 	struct arm_ahb_div *aad;
 	unsigned long fref = get_rate_arm();
 
@@ -177,8 +161,8 @@ static unsigned long get_rate_ipg(struct clk *clk)
 
 static unsigned long get_rate_uart(struct clk *clk)
 {
-	unsigned long pdr3 = __raw_readl(CCM_BASE + CCM_PDR3);
-	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
+	unsigned long pdr3 = __raw_readl(MX35_CCM_PDR3);
+	unsigned long pdr4 = __raw_readl(MX35_CCM_PDR4);
 	unsigned long div = ((pdr4 >> 10) & 0x3f) + 1;
 
 	if (pdr3 & (1 << 14))
@@ -189,7 +173,7 @@ static unsigned long get_rate_uart(struct clk *clk)
 
 static unsigned long get_rate_sdhc(struct clk *clk)
 {
-	unsigned long pdr3 = __raw_readl(CCM_BASE + CCM_PDR3);
+	unsigned long pdr3 = __raw_readl(MX35_CCM_PDR3);
 	unsigned long div, rate;
 
 	if (pdr3 & (1 << 6))
@@ -215,7 +199,7 @@ static unsigned long get_rate_sdhc(struct clk *clk)
 
 static unsigned long get_rate_mshc(struct clk *clk)
 {
-	unsigned long pdr1 = __raw_readl(CCM_BASE + CCM_PDR1);
+	unsigned long pdr1 = __raw_readl(MXC_CCM_PDR1);
 	unsigned long div1, div2, rate;
 
 	if (pdr1 & (1 << 7))
@@ -231,7 +215,7 @@ static unsigned long get_rate_mshc(struct clk *clk)
 
 static unsigned long get_rate_ssi(struct clk *clk)
 {
-	unsigned long pdr2 = __raw_readl(CCM_BASE + CCM_PDR2);
+	unsigned long pdr2 = __raw_readl(MX35_CCM_PDR2);
 	unsigned long div1, div2, rate;
 
 	if (pdr2 & (1 << 6))
@@ -256,7 +240,7 @@ static unsigned long get_rate_ssi(struct clk *clk)
 
 static unsigned long get_rate_csi(struct clk *clk)
 {
-	unsigned long pdr2 = __raw_readl(CCM_BASE + CCM_PDR2);
+	unsigned long pdr2 = __raw_readl(MX35_CCM_PDR2);
 	unsigned long rate;
 
 	if (pdr2 & (1 << 7))
@@ -269,7 +253,7 @@ static unsigned long get_rate_csi(struct clk *clk)
 
 static unsigned long get_rate_otg(struct clk *clk)
 {
-	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
+	unsigned long pdr4 = __raw_readl(MX35_CCM_PDR4);
 	unsigned long rate;
 
 	if (pdr4 & (1 << 9))
@@ -282,8 +266,8 @@ static unsigned long get_rate_otg(struct clk *clk)
 
 static unsigned long get_rate_ipg_per(struct clk *clk)
 {
-	unsigned long pdr0 = __raw_readl(CCM_BASE + CCM_PDR0);
-	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
+	unsigned long pdr0 = __raw_readl(MXC_CCM_PDR0);
+	unsigned long pdr4 = __raw_readl(MX35_CCM_PDR4);
 	unsigned long div;
 
 	if (pdr0 & (1 << 26)) {
@@ -297,7 +281,7 @@ static unsigned long get_rate_ipg_per(struct clk *clk)
 
 static unsigned long get_rate_hsp(struct clk *clk)
 {
-	unsigned long hsp_podf = (__raw_readl(CCM_BASE + CCM_PDR0) >> 20) & 0x03;
+	unsigned long hsp_podf = (__raw_readl(MXC_CCM_PDR0) >> 20) & 0x03;
 	unsigned long fref = get_rate_mpll();
 
 	if (fref > 400 * 1000 * 1000) {
@@ -345,7 +329,7 @@ static void clk_cgr_disable(struct clk *clk)
 #define DEFINE_CLOCK(name, i, er, es, gr, sr)		\
 	static struct clk name = {			\
 		.id		= i,			\
-		.enable_reg	= CCM_BASE + er,	\
+		.enable_reg	= er,			\
 		.enable_shift	= es,			\
 		.get_rate	= gr,			\
 		.set_rate	= sr,			\
@@ -353,59 +337,59 @@ static void clk_cgr_disable(struct clk *clk)
 		.disable	= clk_cgr_disable,	\
 	}
 
-DEFINE_CLOCK(asrc_clk,   0, CCM_CGR0,  0, NULL, NULL);
-DEFINE_CLOCK(pata_clk,    0, CCM_CGR0,  2, get_rate_ipg, NULL);
-/* DEFINE_CLOCK(audmux_clk, 0, CCM_CGR0,  4, NULL, NULL); */
-DEFINE_CLOCK(can1_clk,   0, CCM_CGR0,  6, get_rate_ipg, NULL);
-DEFINE_CLOCK(can2_clk,   1, CCM_CGR0,  8, get_rate_ipg, NULL);
-DEFINE_CLOCK(cspi1_clk,  0, CCM_CGR0, 10, get_rate_ipg, NULL);
-DEFINE_CLOCK(cspi2_clk,  1, CCM_CGR0, 12, get_rate_ipg, NULL);
-DEFINE_CLOCK(ect_clk,    0, CCM_CGR0, 14, get_rate_ipg, NULL);
-DEFINE_CLOCK(edio_clk,   0, CCM_CGR0, 16, NULL, NULL);
-DEFINE_CLOCK(emi_clk,    0, CCM_CGR0, 18, get_rate_ipg, NULL);
-DEFINE_CLOCK(epit1_clk,  0, CCM_CGR0, 20, get_rate_ipg, NULL);
-DEFINE_CLOCK(epit2_clk,  1, CCM_CGR0, 22, get_rate_ipg, NULL);
-DEFINE_CLOCK(esai_clk,   0, CCM_CGR0, 24, NULL, NULL);
-DEFINE_CLOCK(esdhc1_clk, 0, CCM_CGR0, 26, get_rate_sdhc, NULL);
-DEFINE_CLOCK(esdhc2_clk, 1, CCM_CGR0, 28, get_rate_sdhc, NULL);
-DEFINE_CLOCK(esdhc3_clk, 2, CCM_CGR0, 30, get_rate_sdhc, NULL);
-
-DEFINE_CLOCK(fec_clk,    0, CCM_CGR1,  0, get_rate_ipg, NULL);
-DEFINE_CLOCK(gpio1_clk,  0, CCM_CGR1,  2, NULL, NULL);
-DEFINE_CLOCK(gpio2_clk,  1, CCM_CGR1,  4, NULL, NULL);
-DEFINE_CLOCK(gpio3_clk,  2, CCM_CGR1,  6, NULL, NULL);
-DEFINE_CLOCK(gpt_clk,    0, CCM_CGR1,  8, get_rate_ipg, NULL);
-DEFINE_CLOCK(i2c1_clk,   0, CCM_CGR1, 10, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(i2c2_clk,   1, CCM_CGR1, 12, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(i2c3_clk,   2, CCM_CGR1, 14, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(iomuxc_clk, 0, CCM_CGR1, 16, NULL, NULL);
-DEFINE_CLOCK(ipu_clk,    0, CCM_CGR1, 18, get_rate_hsp, NULL);
-DEFINE_CLOCK(kpp_clk,    0, CCM_CGR1, 20, get_rate_ipg, NULL);
-DEFINE_CLOCK(mlb_clk,    0, CCM_CGR1, 22, get_rate_ahb, NULL);
-DEFINE_CLOCK(mshc_clk,   0, CCM_CGR1, 24, get_rate_mshc, NULL);
-DEFINE_CLOCK(owire_clk,  0, CCM_CGR1, 26, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(pwm_clk,    0, CCM_CGR1, 28, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(rngc_clk,   0, CCM_CGR1, 30, get_rate_ipg, NULL);
-
-DEFINE_CLOCK(rtc_clk,    0, CCM_CGR2,  0, get_rate_ipg, NULL);
-DEFINE_CLOCK(rtic_clk,   0, CCM_CGR2,  2, get_rate_ahb, NULL);
-DEFINE_CLOCK(scc_clk,    0, CCM_CGR2,  4, get_rate_ipg, NULL);
-DEFINE_CLOCK(sdma_clk,   0, CCM_CGR2,  6, NULL, NULL);
-DEFINE_CLOCK(spba_clk,   0, CCM_CGR2,  8, get_rate_ipg, NULL);
-DEFINE_CLOCK(spdif_clk,  0, CCM_CGR2, 10, NULL, NULL);
-DEFINE_CLOCK(ssi1_clk,   0, CCM_CGR2, 12, get_rate_ssi, NULL);
-DEFINE_CLOCK(ssi2_clk,   1, CCM_CGR2, 14, get_rate_ssi, NULL);
-DEFINE_CLOCK(uart1_clk,  0, CCM_CGR2, 16, get_rate_uart, NULL);
-DEFINE_CLOCK(uart2_clk,  1, CCM_CGR2, 18, get_rate_uart, NULL);
-DEFINE_CLOCK(uart3_clk,  2, CCM_CGR2, 20, get_rate_uart, NULL);
-DEFINE_CLOCK(usbotg_clk, 0, CCM_CGR2, 22, get_rate_otg, NULL);
-DEFINE_CLOCK(wdog_clk,   0, CCM_CGR2, 24, NULL, NULL);
-DEFINE_CLOCK(max_clk,    0, CCM_CGR2, 26, NULL, NULL);
-DEFINE_CLOCK(audmux_clk, 0, CCM_CGR2, 30, NULL, NULL);
-
-DEFINE_CLOCK(csi_clk,    0, CCM_CGR3,  0, get_rate_csi, NULL);
-DEFINE_CLOCK(iim_clk,    0, CCM_CGR3,  2, NULL, NULL);
-DEFINE_CLOCK(gpu2d_clk,  0, CCM_CGR3,  4, NULL, NULL);
+DEFINE_CLOCK(asrc_clk,   0, MX35_CCM_CGR0,  0, NULL, NULL);
+DEFINE_CLOCK(pata_clk,    0, MX35_CCM_CGR0,  2, get_rate_ipg, NULL);
+/* DEFINE_CLOCK(audmux_clk, 0, MX35_CCM_CGR0,  4, NULL, NULL); */
+DEFINE_CLOCK(can1_clk,   0, MX35_CCM_CGR0,  6, get_rate_ipg, NULL);
+DEFINE_CLOCK(can2_clk,   1, MX35_CCM_CGR0,  8, get_rate_ipg, NULL);
+DEFINE_CLOCK(cspi1_clk,  0, MX35_CCM_CGR0, 10, get_rate_ipg, NULL);
+DEFINE_CLOCK(cspi2_clk,  1, MX35_CCM_CGR0, 12, get_rate_ipg, NULL);
+DEFINE_CLOCK(ect_clk,    0, MX35_CCM_CGR0, 14, get_rate_ipg, NULL);
+DEFINE_CLOCK(edio_clk,   0, MX35_CCM_CGR0, 16, NULL, NULL);
+DEFINE_CLOCK(emi_clk,    0, MX35_CCM_CGR0, 18, get_rate_ipg, NULL);
+DEFINE_CLOCK(epit1_clk,  0, MX35_CCM_CGR0, 20, get_rate_ipg, NULL);
+DEFINE_CLOCK(epit2_clk,  1, MX35_CCM_CGR0, 22, get_rate_ipg, NULL);
+DEFINE_CLOCK(esai_clk,   0, MX35_CCM_CGR0, 24, NULL, NULL);
+DEFINE_CLOCK(esdhc1_clk, 0, MX35_CCM_CGR0, 26, get_rate_sdhc, NULL);
+DEFINE_CLOCK(esdhc2_clk, 1, MX35_CCM_CGR0, 28, get_rate_sdhc, NULL);
+DEFINE_CLOCK(esdhc3_clk, 2, MX35_CCM_CGR0, 30, get_rate_sdhc, NULL);
+
+DEFINE_CLOCK(fec_clk,    0, MX35_CCM_CGR1,  0, get_rate_ipg, NULL);
+DEFINE_CLOCK(gpio1_clk,  0, MX35_CCM_CGR1,  2, NULL, NULL);
+DEFINE_CLOCK(gpio2_clk,  1, MX35_CCM_CGR1,  4, NULL, NULL);
+DEFINE_CLOCK(gpio3_clk,  2, MX35_CCM_CGR1,  6, NULL, NULL);
+DEFINE_CLOCK(gpt_clk,    0, MX35_CCM_CGR1,  8, get_rate_ipg, NULL);
+DEFINE_CLOCK(i2c1_clk,   0, MX35_CCM_CGR1, 10, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(i2c2_clk,   1, MX35_CCM_CGR1, 12, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(i2c3_clk,   2, MX35_CCM_CGR1, 14, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(iomuxc_clk, 0, MX35_CCM_CGR1, 16, NULL, NULL);
+DEFINE_CLOCK(ipu_clk,    0, MX35_CCM_CGR1, 18, get_rate_hsp, NULL);
+DEFINE_CLOCK(kpp_clk,    0, MX35_CCM_CGR1, 20, get_rate_ipg, NULL);
+DEFINE_CLOCK(mlb_clk,    0, MX35_CCM_CGR1, 22, get_rate_ahb, NULL);
+DEFINE_CLOCK(mshc_clk,   0, MX35_CCM_CGR1, 24, get_rate_mshc, NULL);
+DEFINE_CLOCK(owire_clk,  0, MX35_CCM_CGR1, 26, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(pwm_clk,    0, MX35_CCM_CGR1, 28, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(rngc_clk,   0, MX35_CCM_CGR1, 30, get_rate_ipg, NULL);
+
+DEFINE_CLOCK(rtc_clk,    0, MX35_CCM_CGR2,  0, get_rate_ipg, NULL);
+DEFINE_CLOCK(rtic_clk,   0, MX35_CCM_CGR2,  2, get_rate_ahb, NULL);
+DEFINE_CLOCK(scc_clk,    0, MX35_CCM_CGR2,  4, get_rate_ipg, NULL);
+DEFINE_CLOCK(sdma_clk,   0, MX35_CCM_CGR2,  6, NULL, NULL);
+DEFINE_CLOCK(spba_clk,   0, MX35_CCM_CGR2,  8, get_rate_ipg, NULL);
+DEFINE_CLOCK(spdif_clk,  0, MX35_CCM_CGR2, 10, NULL, NULL);
+DEFINE_CLOCK(ssi1_clk,   0, MX35_CCM_CGR2, 12, get_rate_ssi, NULL);
+DEFINE_CLOCK(ssi2_clk,   1, MX35_CCM_CGR2, 14, get_rate_ssi, NULL);
+DEFINE_CLOCK(uart1_clk,  0, MX35_CCM_CGR2, 16, get_rate_uart, NULL);
+DEFINE_CLOCK(uart2_clk,  1, MX35_CCM_CGR2, 18, get_rate_uart, NULL);
+DEFINE_CLOCK(uart3_clk,  2, MX35_CCM_CGR2, 20, get_rate_uart, NULL);
+DEFINE_CLOCK(usbotg_clk, 0, MX35_CCM_CGR2, 22, get_rate_otg, NULL);
+DEFINE_CLOCK(wdog_clk,   0, MX35_CCM_CGR2, 24, NULL, NULL);
+DEFINE_CLOCK(max_clk,    0, MX35_CCM_CGR2, 26, NULL, NULL);
+DEFINE_CLOCK(audmux_clk, 0, MX35_CCM_CGR2, 30, NULL, NULL);
+
+DEFINE_CLOCK(csi_clk,    0, MX35_CCM_CGR3,  0, get_rate_csi, NULL);
+DEFINE_CLOCK(iim_clk,    0, MX35_CCM_CGR3,  2, NULL, NULL);
+DEFINE_CLOCK(gpu2d_clk,  0, MX35_CCM_CGR3,  4, NULL, NULL);
 
 DEFINE_CLOCK(usbahb_clk, 0, 0,         0, get_rate_ahb, NULL);
 
@@ -422,7 +406,7 @@ static unsigned long get_rate_nfc(struct clk *clk)
 {
 	unsigned long div1;
 
-	div1 = (__raw_readl(CCM_BASE + CCM_PDR4) >> 28) + 1;
+	div1 = (__raw_readl(MX35_CCM_PDR4) >> 28) + 1;
 
 	return get_rate_ahb(NULL) / div1;
 }
@@ -518,11 +502,11 @@ int __init mx35_clocks_init()
 	/* Turn off all clocks except the ones we need to survive, namely:
 	 * EMI, GPIO1/2/3, GPT, IOMUX, MAX and eventually uart
 	 */
-	__raw_writel((3 << 18), CCM_BASE + CCM_CGR0);
+	__raw_writel((3 << 18), MX35_CCM_CGR0);
 	__raw_writel((3 << 2) | (3 << 4) | (3 << 6) | (3 << 8) | (3 << 16),
-			CCM_BASE + CCM_CGR1);
-	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
-	__raw_writel(0, CCM_BASE + CCM_CGR3);
+			MX35_CCM_CGR1);
+	__raw_writel(cgr2, MX35_CCM_CGR2);
+	__raw_writel(0, MX35_CCM_CGR3);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX35", mx35_revision());
@@ -533,7 +517,7 @@ int __init mx35_clocks_init()
 	 * extra clocks turned on, otherwise the MX35 boot ROM code will
 	 * hang after a watchdog reset.
 	 */
-	if (!(__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10))) {
+	if (!(__raw_readl(MX35_CCM_RCSR) & (3 << 10))) {
 		/* Additionally turn on UART1, SCC, and IIM clocks */
 		clk_enable(&iim_clk);
 		clk_enable(&uart1_clk);
diff --git a/arch/arm/mach-imx/crmregs-imx31.h b/arch/arm/mach-imx/crmregs-imx3.h
similarity index 94%
rename from arch/arm/mach-imx/crmregs-imx31.h
rename to arch/arm/mach-imx/crmregs-imx3.h
index 37a8a07..9462cf7 100644
--- a/arch/arm/mach-imx/crmregs-imx31.h
+++ b/arch/arm/mach-imx/crmregs-imx3.h
@@ -24,23 +24,36 @@
 #define CKIH_CLK_FREQ_27MHZ     27000000
 #define CKIL_CLK_FREQ           32768
 
-#define MXC_CCM_BASE		MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR)
+#define MXC_CCM_BASE		(cpu_is_mx31() ? \
+MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR) : MX35_IO_ADDRESS(MX35_CCM_BASE_ADDR))
 
 /* Register addresses */
 #define MXC_CCM_CCMR		(MXC_CCM_BASE + 0x00)
 #define MXC_CCM_PDR0		(MXC_CCM_BASE + 0x04)
 #define MXC_CCM_PDR1		(MXC_CCM_BASE + 0x08)
+#define MX35_CCM_PDR2		(MXC_CCM_BASE + 0x0C)
 #define MXC_CCM_RCSR		(MXC_CCM_BASE + 0x0C)
+#define MX35_CCM_PDR3		(MXC_CCM_BASE + 0x10)
 #define MXC_CCM_MPCTL		(MXC_CCM_BASE + 0x10)
+#define MX35_CCM_PDR4		(MXC_CCM_BASE + 0x14)
 #define MXC_CCM_UPCTL		(MXC_CCM_BASE + 0x14)
+#define MX35_CCM_RCSR		(MXC_CCM_BASE + 0x18)
 #define MXC_CCM_SRPCTL		(MXC_CCM_BASE + 0x18)
+#define MX35_CCM_MPCTL		(MXC_CCM_BASE + 0x1C)
 #define MXC_CCM_COSR		(MXC_CCM_BASE + 0x1C)
+#define MX35_CCM_PPCTL		(MXC_CCM_BASE + 0x20)
 #define MXC_CCM_CGR0		(MXC_CCM_BASE + 0x20)
+#define MX35_CCM_ACMR		(MXC_CCM_BASE + 0x24)
 #define MXC_CCM_CGR1		(MXC_CCM_BASE + 0x24)
+#define MX35_CCM_COSR		(MXC_CCM_BASE + 0x28)
 #define MXC_CCM_CGR2		(MXC_CCM_BASE + 0x28)
+#define MX35_CCM_CGR0		(MXC_CCM_BASE + 0x2C)
 #define MXC_CCM_WIMR		(MXC_CCM_BASE + 0x2C)
+#define MX35_CCM_CGR1		(MXC_CCM_BASE + 0x30)
 #define MXC_CCM_LDC		(MXC_CCM_BASE + 0x30)
+#define MX35_CCM_CGR2		(MXC_CCM_BASE + 0x34)
 #define MXC_CCM_DCVR0		(MXC_CCM_BASE + 0x34)
+#define MX35_CCM_CGR3		(MXC_CCM_BASE + 0x38)
 #define MXC_CCM_DCVR1		(MXC_CCM_BASE + 0x38)
 #define MXC_CCM_DCVR2		(MXC_CCM_BASE + 0x3C)
 #define MXC_CCM_DCVR3		(MXC_CCM_BASE + 0x40)
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index e4f426a..27bc27e 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -51,7 +51,7 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "crmregs-imx31.h"
+#include "crmregs-imx3.h"
 
 static int armadillo5x0_pins[] = {
 	/* UART1 */
-- 
1.7.1
