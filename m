From: stefan@agner.ch (Stefan Agner)
Date: Fri, 29 Jan 2016 14:49:24 -0800
Subject: [PATCH 2/2] clk: imx: return correct frequency for Ethernet PLL
In-Reply-To: <1454107764-19876-1-git-send-email-stefan@agner.ch>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
Message-ID: <1454107764-19876-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7 designs Ethernet PLL provides a 1000MHz reference clock.
Store the reference clock in the clk_pllv3 structure according to
the PLL type.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-pllv3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index b5ff561..c344ae6 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -44,6 +44,7 @@ struct clk_pllv3 {
 	u32		powerdown;
 	u32		div_mask;
 	u32		div_shift;
+	unsigned long	ref_clock;
 };
 
 #define to_clk_pllv3(_hw) container_of(_hw, struct clk_pllv3, hw)
@@ -289,7 +290,9 @@ static const struct clk_ops clk_pllv3_av_ops = {
 static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	return 500000000;
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+
+	return pll->ref_clock;
 }
 
 static const struct clk_ops clk_pllv3_enet_ops = {
@@ -329,7 +332,11 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		break;
 	case IMX_PLLV3_ENET_IMX7:
 		pll->powerdown = IMX7_ENET_PLL_POWER;
+		pll->ref_clock = 1000000000;
+		ops = &clk_pllv3_enet_ops;
+		break;
 	case IMX_PLLV3_ENET:
+		pll->ref_clock = 500000000;
 		ops = &clk_pllv3_enet_ops;
 		break;
 	default:
-- 
2.7.0
