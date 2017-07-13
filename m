From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:13:04 +0200
Subject: [PATCH 09/18] drm/sun4i: tcon: Adjust dotclock dividers range
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <74db696da66cffafe1e729fe2df73b437c8fd483.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems like the dotclock dividers are a bit less strict range, and can
operate even with a smaller than 6 divider. Loose the boundaries a bit.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index d401156490f3..0b844c0dd102 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -77,7 +77,25 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	u8 best_div = 1;
 	int i;
 
-	for (i = 6; i <= 127; i++) {
+	/*
+	 * There's something odd here.
+	 *
+	 * In the A13 user manual, this is stated to be >= 6 when
+	 * dclk1 and dclk2 are used (without any hint on how to use
+	 * them), and >= 4 when only dclk is used.
+	 *
+	 * In the A33 user manual, when only dclk is used, it is set
+	 * to be >= 6 in the former case, and >= 1 in the
+	 * latter. There's also some (obscure) explanations about the
+	 * dclk1 and dclk2 vs dclk that seems to be in the upper 4
+	 * bits. What those clocks are and what bit does what is not
+	 * really clear.
+	 *
+	 * On the A33 however, while something lower than 4 works, it
+	 * does have a few artifacts. Let's not use those values, and
+	 * see how it goes.
+	 */
+	for (i = 4; i <= 127; i++) {
 		unsigned long ideal = rate * i;
 		unsigned long rounded;
 
-- 
git-series 0.9.1
