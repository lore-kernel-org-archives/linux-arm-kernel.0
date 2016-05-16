From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:05 +0200
Subject: [PATCH 05/20] drm/sun4i: request exact rates to our parents
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our pixel clock currently only tries to deal with the current parent rate.

While that works when the resolution is the same than the one already
program, or when we can compute directly the rate from the current parent
rate, it cannot work in most situation when we want to change the
frequency, and we end up with an improper pixel clock rate, which obviously
doesn't work as expected.

Ask our parent for all the possible dividers if it can reach that
frequency, and return the best parent rate to the clock framework so that
we can use it.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 6c9c090a8006..1ddf6d7a7107 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -72,14 +72,40 @@ static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
 static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	return *parent_rate / DIV_ROUND_CLOSEST(*parent_rate, rate);
+	unsigned long best_parent = 0;
+	u8 best_div = 1;
+	int i;
+
+	for (i = 6; i < 127; i++) {
+		unsigned long ideal = rate * i;
+		unsigned long rounded;
+
+		rounded = clk_hw_round_rate(clk_hw_get_parent(hw),
+					    ideal);
+
+		if (rounded == ideal) {
+			best_parent = rounded;
+			best_div = i;
+			goto out;
+		}
+
+		if ((rounded < ideal) && (rounded > best_parent)) {
+			best_parent = rounded;
+			best_div = i;
+		}
+	}
+
+out:
+	*parent_rate = best_parent;
+
+	return best_parent / best_div;
 }
 
 static int sun4i_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate)
 {
 	struct sun4i_dclk *dclk = hw_to_dclk(hw);
-	int div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	u8 div = parent_rate / rate;
 
 	return regmap_update_bits(dclk->regmap, SUN4I_TCON0_DCLK_REG,
 				  GENMASK(6, 0), div);
-- 
2.8.2
