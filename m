From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 17:59:58 +0000
Subject: [RFC PATCH 2/4] clk: sunxi: re-add old sun6i_a31_pll6 clock
In-Reply-To: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455300000-18723-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The older version of the A31 PLL6 clock driver was used by many DTs
which we want to stay compatible with.
As an intermediate step bring back the code for the old driver, but
don't instantiate it yet.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b4ab84b..12131ba 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -248,6 +248,21 @@ static void sun6i_a31_get_pll_factors(struct factors_request *req)
 	req->n = DIV_ROUND_UP(div, (req->k + 1)) - 1;
 }
 
+static void sun6i_a31_get_pll6_factors(struct factors_request *req)
+{
+	u8 div;
+
+	/* Normalize value to a parent_rate multiple (24M) */
+	div = req->rate / req->parent_rate;
+	req->rate = req->parent_rate * div;
+
+	req->k = div / 32;
+	if (req->k > 3)
+		req->k = 3;
+
+	req->n = DIV_ROUND_UP(div, (req->k + 1)) - 1;
+}
+
 static void sun6i_a31_pll6_recalc(struct factors_request *req)
 {
 	req->rate = req->parent_rate;
@@ -549,6 +564,13 @@ static const struct factors_data sun6i_a31_pll_data __initconst = {
 	.recalc = sun6i_a31_pll6_recalc,
 };
 
+static const struct factors_data sun6i_a31_pll6_data __initconst = {
+	.enable = 31,
+	.table = &sun6i_a31_pll6_config,
+	.getter = sun6i_a31_get_pll6_factors,
+	.name	= "pll6x2",
+};
+
 static const struct factors_data sun5i_a13_ahb_data __initconst = {
 	.mux = 6,
 	.muxmask = BIT(1) | BIT(0),
@@ -954,6 +976,15 @@ static const struct divs_data pll6_divs_data __initconst = {
 	}
 };
 
+static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
+	.factors = &sun6i_a31_pll6_data,
+	.ndivs = 2,
+	.div = {
+		{ .fixed = 2 }, /* normal output */
+		{ .self = 1 }, /* base factor clock, 2x */
+	}
+};
+
 /**
  * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
  *
-- 
2.6.4
