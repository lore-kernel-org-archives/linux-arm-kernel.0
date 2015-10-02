From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 2 Oct 2015 18:57:41 -0400
Subject: [PATCH 06/10] clk: iproc: Split off dig_filter
In-Reply-To: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1443826665-17570-7-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLL loop filter/gain can be located in a separate register on some
SoCs.  Split these off into a separate variable, so that an offset can
be added if necessary.  Also, make the necessary modifications to the
Cygnus and NSP drivers for this change.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 drivers/clk/bcm/clk-cygnus.c    | 17 +++++++++++------
 drivers/clk/bcm/clk-iproc-pll.c | 14 +++++++++-----
 drivers/clk/bcm/clk-iproc.h     | 10 +++++++++-
 drivers/clk/bcm/clk-nsp.c       | 14 +++++++++-----
 4 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/bcm/clk-cygnus.c b/drivers/clk/bcm/clk-cygnus.c
index 316c603..c526143 100644
--- a/drivers/clk/bcm/clk-cygnus.c
+++ b/drivers/clk/bcm/clk-cygnus.c
@@ -34,9 +34,11 @@
 		{ .offset = o, .en_shift = es, .high_shift = hs, \
 		.high_width = hw, .low_shift = ls, .low_width = lw }
 
-#define reset_val(o, rs, prs, kis, kiw, kps, kpw, kas, kaw) { .offset = o, \
-	.reset_shift = rs, .p_reset_shift = prs, .ki_shift = kis, \
-	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas, \
+#define reset_val(o, rs, prs) { .offset = o, .reset_shift = rs, \
+	.p_reset_shift = prs }
+
+#define df_val(o, kis, kiw, kps, kpw, kas, kaw) { .offset = o, .ki_shift = kis,\
+	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas,    \
 	.ka_width = kaw }
 
 #define vco_ctrl_val(uo, lo) { .u_offset = uo, .l_offset = lo }
@@ -56,7 +58,8 @@ static const struct iproc_pll_ctrl genpll = {
 	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_HAS_NDIV_FRAC |
 		IPROC_CLK_PLL_NEEDS_SW_CFG,
 	.aon = aon_val(0x0, 2, 1, 0),
-	.reset = reset_val(0x0, 11, 10, 4, 3, 0, 4, 7, 3),
+	.reset = reset_val(0x0, 11, 10),
+	.dig_filter = df_val(0x0, 4, 3, 0, 4, 7, 3),
 	.sw_ctrl = sw_ctrl_val(0x10, 31),
 	.ndiv_int = reg_val(0x10, 20, 10),
 	.ndiv_frac = reg_val(0x10, 0, 20),
@@ -114,7 +117,8 @@ CLK_OF_DECLARE(cygnus_genpll, "brcm,cygnus-genpll", cygnus_genpll_clk_init);
 static const struct iproc_pll_ctrl lcpll0 = {
 	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_NEEDS_SW_CFG,
 	.aon = aon_val(0x0, 2, 5, 4),
-	.reset = reset_val(0x0, 31, 30, 27, 3, 23, 4, 19, 4),
+	.reset = reset_val(0x0, 31, 30),
+	.dig_filter = df_val(0x0, 27, 3, 23, 4, 19, 4),
 	.sw_ctrl = sw_ctrl_val(0x4, 31),
 	.ndiv_int = reg_val(0x4, 16, 10),
 	.pdiv = reg_val(0x4, 26, 4),
@@ -191,7 +195,8 @@ static const struct iproc_pll_ctrl mipipll = {
 		 IPROC_CLK_NEEDS_READ_BACK,
 	.aon = aon_val(0x0, 4, 17, 16),
 	.asiu = asiu_gate_val(0x0, 3),
-	.reset = reset_val(0x0, 11, 10, 4, 3, 0, 4, 7, 4),
+	.reset = reset_val(0x0, 11, 10),
+	.dig_filter = df_val(0x0, 4, 3, 0, 4, 7, 4),
 	.ndiv_int = reg_val(0x10, 20, 10),
 	.ndiv_frac = reg_val(0x10, 0, 20),
 	.pdiv = reg_val(0x14, 0, 4),
diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index a4602aa..882aced 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -224,13 +224,17 @@ static void __pll_bring_out_reset(struct iproc_pll *pll, unsigned int kp,
 	u32 val;
 	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
 	const struct iproc_pll_reset_ctrl *reset = &ctrl->reset;
+	const struct iproc_pll_dig_filter_ctrl *dig_filter = &ctrl->dig_filter;
+
+	val = readl(pll->pll_base + dig_filter->offset);
+	val &= ~(bit_mask(dig_filter->ki_width) << dig_filter->ki_shift |
+		bit_mask(dig_filter->kp_width) << dig_filter->kp_shift |
+		bit_mask(dig_filter->ka_width) << dig_filter->ka_shift);
+	val |= ki << dig_filter->ki_shift | kp << dig_filter->kp_shift |
+	       ka << dig_filter->ka_shift;
+	iproc_pll_write(pll, pll->pll_base, dig_filter->offset, val);
 
 	val = readl(pll->pll_base + reset->offset);
-	val &= ~(bit_mask(reset->ki_width) << reset->ki_shift |
-		 bit_mask(reset->kp_width) << reset->kp_shift |
-		 bit_mask(reset->ka_width) << reset->ka_shift);
-	val |=  ki << reset->ki_shift | kp << reset->kp_shift |
-		ka << reset->ka_shift;
 	val |= 1 << reset->reset_shift | 1 << reset->p_reset_shift;
 	iproc_pll_write(pll, pll->pll_base, reset->offset, val);
 }
diff --git a/drivers/clk/bcm/clk-iproc.h b/drivers/clk/bcm/clk-iproc.h
index ff7bfad..b71c197 100644
--- a/drivers/clk/bcm/clk-iproc.h
+++ b/drivers/clk/bcm/clk-iproc.h
@@ -94,12 +94,19 @@ struct iproc_pll_aon_pwr_ctrl {
 };
 
 /*
- * Control of the PLL reset, with Ki, Kp, and Ka parameters
+ * Control of the PLL reset
  */
 struct iproc_pll_reset_ctrl {
 	unsigned int offset;
 	unsigned int reset_shift;
 	unsigned int p_reset_shift;
+};
+
+/*
+ * Control of the Ki, Kp, and Ka parameters
+ */
+struct iproc_pll_dig_filter_ctrl {
+	unsigned int offset;
 	unsigned int ki_shift;
 	unsigned int ki_width;
 	unsigned int kp_shift;
@@ -129,6 +136,7 @@ struct iproc_pll_ctrl {
 	struct iproc_pll_aon_pwr_ctrl aon;
 	struct iproc_asiu_gate asiu;
 	struct iproc_pll_reset_ctrl reset;
+	struct iproc_pll_dig_filter_ctrl dig_filter;
 	struct iproc_pll_sw_ctrl sw_ctrl;
 	struct iproc_clk_reg_op ndiv_int;
 	struct iproc_clk_reg_op ndiv_frac;
diff --git a/drivers/clk/bcm/clk-nsp.c b/drivers/clk/bcm/clk-nsp.c
index 708961a..4fc4b1d 100644
--- a/drivers/clk/bcm/clk-nsp.c
+++ b/drivers/clk/bcm/clk-nsp.c
@@ -28,9 +28,11 @@
 #define aon_val(o, pw, ps, is) { .offset = o, .pwr_width = pw, \
 	.pwr_shift = ps, .iso_shift = is }
 
-#define reset_val(o, rs, prs, kis, kiw, kps, kpw, kas, kaw) { .offset = o, \
-	.reset_shift = rs, .p_reset_shift = prs, .ki_shift = kis, \
-	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas, \
+#define reset_val(o, rs, prs) { .offset = o, .reset_shift = rs, \
+	.p_reset_shift = prs }
+
+#define df_val(o, kis, kiw, kps, kpw, kas, kaw) { .offset = o, .ki_shift = kis,\
+	.ki_width = kiw, .kp_shift = kps, .kp_width = kpw, .ka_shift = kas,    \
 	.ka_width = kaw }
 
 #define vco_ctrl_val(uo, lo) { .u_offset = uo, .l_offset = lo }
@@ -47,7 +49,8 @@ CLK_OF_DECLARE(nsp_armpll, "brcm,nsp-armpll", nsp_armpll_init);
 static const struct iproc_pll_ctrl genpll = {
 	.flags = IPROC_CLK_PLL_HAS_NDIV_FRAC | IPROC_CLK_EMBED_PWRCTRL,
 	.aon = aon_val(0x0, 1, 12, 0),
-	.reset = reset_val(0x0, 11, 10, 4, 3, 0, 4, 7, 3),
+	.reset = reset_val(0x0, 11, 10),
+	.dig_filter = df_val(0x0, 4, 3, 0, 4, 7, 3),
 	.ndiv_int = reg_val(0x14, 20, 10),
 	.ndiv_frac = reg_val(0x14, 0, 20),
 	.pdiv = reg_val(0x18, 24, 3),
@@ -103,7 +106,8 @@ CLK_OF_DECLARE(nsp_genpll_clk, "brcm,nsp-genpll", nsp_genpll_clk_init);
 static const struct iproc_pll_ctrl lcpll0 = {
 	.flags = IPROC_CLK_PLL_HAS_NDIV_FRAC | IPROC_CLK_EMBED_PWRCTRL,
 	.aon = aon_val(0x0, 1, 24, 0),
-	.reset = reset_val(0x0, 23, 22, 16, 3, 12, 4, 19, 4),
+	.reset = reset_val(0x0, 23, 22),
+	.dig_filter = df_val(0x0, 16, 3, 12, 4, 19, 4),
 	.ndiv_int = reg_val(0x4, 20, 8),
 	.ndiv_frac = reg_val(0x4, 0, 20),
 	.pdiv = reg_val(0x4, 28, 3),
-- 
1.9.1
