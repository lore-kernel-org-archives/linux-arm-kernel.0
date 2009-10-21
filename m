From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Oct 2009 18:17:59 +0100
Subject: [PATCH 4/4] S3C64XX: Provide control of APLL
In-Reply-To: <1256145479-27952-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1256145479-27952-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1256145479-27952-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up runtime control of APLL in the clock API. Since both APLL and
MPLL use the same IP a generic PLL6552 clock is provided but at present
only APLL is hooked up.  Since the documentation recommends using only
one of a specific list of configurations we do not attempt to calculate
arbatrary PLL setups but instead choose from that list.

Note that reconfiguration of APLL may not be safe when SYNCMUX is set to
clock HCLKx2 from the APLL mux since it will also change the state of
that tree without notice.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |   83 +++++++++++++++++++++++++++++++--
 1 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 6ffa21e..3fa16b7 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -63,14 +63,86 @@ struct clksrc_clk {
 	void __iomem		*reg_divider;
 };
 
-static struct clk clk_fout_apll = {
-	.name		= "fout_apll",
-	.id		= -1,
+#define PLL6552_CON(mdiv, pdiv, sdiv) (0x8000000 | (mdiv << 16) | \
+				       (pdiv << 8) | sdiv)
+#define PLL6552_MASK PLL6552_CON(0x1f, 0x3ff, 7)
+
+/* While PLL output can be calculated as MDIV * input / (PDIV *
+ * 2^SDIV) the datasheet recommends using one of the configurations
+ * listed below.
+ */
+static const struct {
+	int input;
+	int output;
+	u32 reg;
+} pll6552_cfg[] = {
+	{ 12000000, 0,         0                      },
+	{ 12000000, 100000000, PLL6552_CON(400, 3, 4) },
+	{ 12000000, 200000000, PLL6552_CON(400, 3, 3) },
+	{ 12000000, 266000000, PLL6552_CON(266, 3, 2) },
+	{ 12000000, 400000000, PLL6552_CON(400, 3, 2) },
+	{ 12000000, 533000000, PLL6552_CON(266, 3, 1) },
+	{ 12000000, 667000000, PLL6552_CON(333, 3, 1) },
+	{ 27000000, 0,         0                      },
+	{ 27000000, 100000000, PLL6552_CON(474, 8, 4) },
+	{ 27000000, 200000000, PLL6552_CON(474, 8, 3) },
+	{ 27000000, 266000000, PLL6552_CON(276, 7, 2) },
+	{ 27000000, 400000000, PLL6552_CON(474, 8, 2) },
+	{ 27000000, 533000000, PLL6552_CON(276, 7, 1) },
+	{ 27000000, 667000000, PLL6552_CON(346, 7, 1) },
+};
+
+struct pll6552_clk {
+	struct clk		clk;
+	void __iomem		*pll_con;
+};
+
+static unsigned long pll6552_get_rate(struct clk *clk)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	struct pll6552_clk *pll6552 =
+		container_of(clk, struct pll6552_clk, clk);
+
+	return s3c6400_get_pll(parent, __raw_readl(pll6552->pll_con));
+}
+
+static int pll6552_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long parent = clk_get_rate(clk->parent);
+	struct pll6552_clk *pll6552 =
+		container_of(clk, struct pll6552_clk, clk);
+	int i;
+	u32 val;
+
+	for (i = 0; i < ARRAY_SIZE(pll6552_cfg); i++)
+		if (pll6552_cfg[i].input == parent &&
+		    pll6552_cfg[i].output == rate)
+			break;
+	if (i == ARRAY_SIZE(pll6552_cfg))
+		return -EINVAL;
+
+	val = __raw_readl(pll6552->pll_con);
+	val &= ~PLL6552_MASK;
+	val |= pll6552_cfg[i].reg;
+
+	__raw_writel(val, pll6552->pll_con);
+
+	return 0;
+}
+
+static struct pll6552_clk clk_fout_apll = {
+	.clk = {
+		.name		= "fout_apll",
+		.id		= -1,
+		.get_rate	= pll6552_get_rate,
+		.set_rate	= pll6552_set_rate,
+	},
+	.pll_con = S3C_APLL_CON,
 };
 
 static struct clk *clk_src_apll_list[] = {
 	[0] = &clk_fin_apll,
-	[1] = &clk_fout_apll,
+	[1] = &clk_fout_apll.clk,
 };
 
 static struct clk_sources clk_src_apll = {
@@ -698,7 +770,6 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
-	clk_fout_apll.rate = apll;
 
 	clk_h2.rate = hclk2;
 	clk_h.rate = hclk;
@@ -729,6 +800,7 @@ static struct clk *clks[] __initdata = {
 	&clk_audio1.clk,
 	&clk_irda.clk,
 	&clk_camif.clk,
+	&clk_fout_apll.clk,
 	&clk_arm,
 };
 
@@ -761,6 +833,7 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
 		}
 	}
 
+	clk_fout_apll.clk.parent = &clk_fin_apll;
 	clk_mpll.parent = &clk_mout_mpll.clk;
 	clk_epll.parent = &clk_mout_epll.clk;
 }
-- 
1.6.5
