From: jassi.brar@samsung.com (Jassi)
Date: Wed, 16 Sep 2009 16:26:09 +0900
Subject: [PATCH] S3C64XX PLL: EPLL control implemented
Message-ID: <1253085969-6661-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implemented enable, get_rate and set_rate functions to control
the EPLL. Even though the EPLL version is different for 6400 and
6410, their output clock generation equations are exactly same.
6410 recommends values for M, P, S and K coeff for a given XTAL
freq(12MHz or 27MHz), the condition on coeffs for 6410 also works
for 6400, so we define common control for the two EPLLs.

Signed-off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/pll.h        |   34 +++++++
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    3 +
 arch/arm/plat-s3c64xx/s3c6400-clock.c           |  117 +++++++++++++++++++++++
 3 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/pll.h b/arch/arm/plat-s3c64xx/include/plat/pll.h
index 90bbd72..7b40f79 100644
--- a/arch/arm/plat-s3c64xx/include/plat/pll.h
+++ b/arch/arm/plat-s3c64xx/include/plat/pll.h
@@ -21,6 +21,33 @@
 
 #include <asm/div64.h>
 
+struct epll_divs {
+	unsigned int m;
+	unsigned int p;
+	unsigned int s;
+	unsigned int k;
+};
+
+enum xtal_freq {
+	XTAL_12M = 0,
+	XTAL_27M
+};
+
+enum epll_fout_freq {
+	EPLL_OUT_36000 = 0,
+	EPLL_OUT_48000,
+	EPLL_OUT_60000,
+	EPLL_OUT_72000,
+	EPLL_OUT_84000,
+	EPLL_OUT_96000,
+	EPLL_OUT_32768,
+	EPLL_OUT_45158,
+	EPLL_OUT_49152,
+	EPLL_OUT_67738,
+	EPLL_OUT_73728,
+	EPLL_OUT_LAST
+};
+
 static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
 					    u32 pllcon)
 {
@@ -44,6 +71,13 @@ static inline unsigned long s3c6400_get_pll(unsigned long baseclk,
 #define S3C6400_EPLL_PDIV_SHIFT	(8)
 #define S3C6400_EPLL_SDIV_SHIFT	(0)
 #define S3C6400_EPLL_KDIV_MASK  (0xffff)
+#define S3C6400_EPLL_KDIV_SHIFT	(0)
+
+#define S3C6400_EPLL_SET_MPSDIV(m, p, s) (((m)<<S3C6400_EPLL_MDIV_SHIFT) \
+					   | ((p)<<S3C6400_EPLL_PDIV_SHIFT) \
+					   | ((s)<<S3C6400_EPLL_SDIV_SHIFT))
+
+#define S3C6400_EPLL_SET_KDIV(k)	((k)<<S3C6400_EPLL_KDIV_SHIFT)
 
 static inline unsigned long s3c6400_get_epll(unsigned long baseclk)
 {
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index a8777a7..97da30f 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -34,6 +34,9 @@
 #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
 
+/* EPLLCON */
+#define S3C6400_EPLL_ENABLE	(0x1 << 31)
+
 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_MFC_MASK	(0xf << 28)
 #define S3C6400_CLKDIV0_MFC_SHIFT	(28)
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 1debc1f..0795a59 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -88,9 +88,126 @@ static struct clksrc_clk clk_mout_apll = {
 	.sources	= &clk_src_apll,
 };
 
+static struct epll_divs epll_div[][EPLL_OUT_LAST] = {
+  [XTAL_12M] = {
+	[EPLL_OUT_36000] = {48, 1, 4, 0},
+	[EPLL_OUT_48000] = {32, 1, 3, 0},
+	[EPLL_OUT_60000] = {40, 1, 3, 0},
+	[EPLL_OUT_72000] = {48, 1, 3, 0},
+	[EPLL_OUT_84000] = {28, 1, 2, 0},
+	[EPLL_OUT_96000] = {32, 1, 2, 0},
+	[EPLL_OUT_32768] = {43, 1, 4, 45264},
+	[EPLL_OUT_45158] = {30, 1, 3, 6903},
+	[EPLL_OUT_49152] = {32, 1, 3, 50332},
+	[EPLL_OUT_67738] = {45, 1, 3, 10398},
+	[EPLL_OUT_73728] = {49, 1, 3, 9961},
+  },
+  [XTAL_27M] = {
+	[EPLL_OUT_36000] = {42, 2, 4, 43691},
+	[EPLL_OUT_48000] = {28, 2, 3, 29127},
+	[EPLL_OUT_60000] = {35, 2, 3, 36409},
+	[EPLL_OUT_72000] = {42, 2, 3, 43691},
+	[EPLL_OUT_84000] = {24, 2, 2, 58254},
+	[EPLL_OUT_96000] = {28, 2, 2, 29127},
+	[EPLL_OUT_32768] = {38, 2, 4, 54798},
+	[EPLL_OUT_45158] = {26, 2, 3, 49827},
+	[EPLL_OUT_49152] = {29, 2, 3, 8330},
+	[EPLL_OUT_67738] = {40, 2, 3, 9243},
+	[EPLL_OUT_73728] = {43, 2, 3, 45264},
+  },
+};
+
+static int fout_enable(struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	unsigned int epll_con0 = __raw_readl(S3C_EPLL_CON0) & ~ctrlbit;
+
+	if (enable)
+		__raw_writel(epll_con0 | ctrlbit, S3C_EPLL_CON0);
+	else
+		__raw_writel(epll_con0, S3C_EPLL_CON0);
+
+	return 0;
+}
+
+static unsigned long fout_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+static int fout_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con0, epll_con1;
+	enum xtal_freq idx_xtal;
+	enum epll_fout_freq idx_fout;
+
+	if (clk_fin_epll.rate == 12000000) {
+		idx_xtal = XTAL_12M;
+	} else if (clk_fin_epll.rate == 27000000) {
+		idx_xtal = XTAL_27M;
+	} else {
+		printk(KERN_ERR "%s:%d TODO\n", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	epll_con0 = __raw_readl(S3C_EPLL_CON0);
+	epll_con1 = __raw_readl(S3C_EPLL_CON1);
+
+	epll_con0 &= ~S3C6400_EPLL_SET_MPSDIV(S3C6400_EPLL_MDIV_MASK,
+						S3C6400_EPLL_PDIV_MASK,
+						S3C6400_EPLL_SDIV_MASK);
+
+	epll_con1 &= ~S3C6400_EPLL_SET_KDIV(S3C6400_EPLL_KDIV_MASK);
+
+	switch (rate) {
+	case 36000000:
+		idx_fout = EPLL_OUT_36000; break;
+	case 48000000:
+		idx_fout = EPLL_OUT_48000; break;
+	case 60000000:
+		idx_fout = EPLL_OUT_60000; break;
+	case 72000000:
+		idx_fout = EPLL_OUT_72000; break;
+	case 84000000:
+		idx_fout = EPLL_OUT_84000; break;
+	case 96000000:
+		idx_fout = EPLL_OUT_96000; break;
+	case 32768000:
+		idx_fout = EPLL_OUT_32768; break;
+	case 45158000:
+		idx_fout = EPLL_OUT_45158; break;
+	case 49152000:
+		idx_fout = EPLL_OUT_49152; break;
+	case 67738000:
+		idx_fout = EPLL_OUT_67738; break;
+	case 73728000:
+		idx_fout = EPLL_OUT_73728; break;
+	default:
+		printk(KERN_ERR "Invalid Clock Freq!\n");
+		return -EINVAL;
+	}
+
+	epll_con0 |= S3C6400_EPLL_SET_MPSDIV(epll_div[idx_xtal][idx_fout].m,
+						epll_div[idx_xtal][idx_fout].p,
+						epll_div[idx_xtal][idx_fout].s);
+
+	epll_con1 |= S3C6400_EPLL_SET_KDIV(epll_div[idx_xtal][idx_fout].k);
+
+	__raw_writel(epll_con0, S3C_EPLL_CON0);
+	__raw_writel(epll_con1, S3C_EPLL_CON1);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
 static struct clk clk_fout_epll = {
 	.name		= "fout_epll",
 	.id		= -1,
+	.ctrlbit	= S3C6400_EPLL_ENABLE,
+	.enable		= fout_enable,
+	.get_rate	= fout_get_rate,
+	.set_rate	= fout_set_rate,
 };
 
 static struct clk *clk_src_epll_list[] = {
-- 
1.6.2.5
