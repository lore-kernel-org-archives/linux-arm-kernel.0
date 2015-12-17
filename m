From: lho@apm.com (Loc Ho)
Date: Wed, 16 Dec 2015 18:37:35 -0700
Subject: [PATCH] clk: xgene: Add SoC and PMD PLL clocks with v2 hardware
Message-ID: <1450316255-9372-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene SoC and PMD PLL clocks support for v2 hardware.
X-Gene SoC v2 and above use an slightly different SoC
and PMD PLL hardware logic.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/clk/clk-xgene.c |   57 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 8131ccf..0f446d3 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -27,9 +27,12 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
+#include <asm/cputype.h>
 
 /* Register SCU_PCPPLL bit fields */
-#define N_DIV_RD(src)			(((src) & 0x000001ff))
+#define N_DIV_RD(src)			((src) & 0x000001ff)
+#define SC_N_DIV_RD(src)		((src) & 0x0000007f)
+#define SC_OUTDIV2(src)			(((src) & 0x00000100) >> 8)
 
 /* Register SCU_SOCPLL bit fields */
 #define CLKR_RD(src)			(((src) & 0x07000000)>>24)
@@ -41,6 +44,14 @@
 
 static DEFINE_SPINLOCK(clk_lock);
 
+static int xgene_clk_version(void)
+{
+	#define MIDR_EL1_VARIANT_MASK	0x00f00000
+	u32 val = read_cpuid_id();
+
+	return (val & MIDR_EL1_VARIANT_MASK) == 0 ? 1 : 2;
+}
+
 static inline u32 xgene_clk_read(void __iomem *csr)
 {
 	return readl_relaxed(csr);
@@ -92,27 +103,37 @@ static unsigned long xgene_clk_pll_recalc_rate(struct clk_hw *hw,
 
 	pll = xgene_clk_read(pllclk->reg + pllclk->pll_offset);
 
-	if (pllclk->type == PLL_TYPE_PCP) {
-		/*
-		 * PLL VCO = Reference clock * NF
-		 * PCP PLL = PLL_VCO / 2
-		 */
-		nout = 2;
-		fvco = parent_rate * (N_DIV_RD(pll) + 4);
+	if (xgene_clk_version() <= 1) {
+		if (pllclk->type == PLL_TYPE_PCP) {
+			/*
+			* PLL VCO = Reference clock * NF
+			* PCP PLL = PLL_VCO / 2
+			*/
+			nout = 2;
+			fvco = parent_rate * (N_DIV_RD(pll) + 4);
+		} else {
+			/*
+			* Fref = Reference Clock / NREF;
+			* Fvco = Fref * NFB;
+			* Fout = Fvco / NOUT;
+			*/
+			nref = CLKR_RD(pll) + 1;
+			nout = CLKOD_RD(pll) + 1;
+			nfb = CLKF_RD(pll);
+			fref = parent_rate / nref;
+			fvco = fref * nfb;
+		}
 	} else {
 		/*
-		 * Fref = Reference Clock / NREF;
-		 * Fvco = Fref * NFB;
-		 * Fout = Fvco / NOUT;
+		 * fvco = Reference clock * FBDIVC
+		 * PLL freq = fvco / NOUT
 		 */
-		nref = CLKR_RD(pll) + 1;
-		nout = CLKOD_RD(pll) + 1;
-		nfb = CLKF_RD(pll);
-		fref = parent_rate / nref;
-		fvco = fref * nfb;
+		nout = SC_OUTDIV2(pll) ? 2 : 3;
+		fvco = parent_rate * SC_N_DIV_RD(pll);
 	}
-	pr_debug("%s pll recalc rate %ld parent %ld\n", clk_hw_get_name(hw),
-		fvco / nout, parent_rate);
+	pr_debug("%s pll recalc rate %ld parent %ld version %d\n",
+		 clk_hw_get_name(hw), fvco / nout, parent_rate,
+		 xgene_clk_version());
 
 	return fvco / nout;
 }
-- 
1.7.1
