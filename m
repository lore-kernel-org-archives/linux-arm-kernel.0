From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 15:18:18 +0100
Subject: [PATCH] pinctrl: sunxi: fix theoretical uninitialized variable access
Message-ID: <20161116141841.2030776-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns about a  way that it could use an uninitialized variable:

drivers/pinctrl/sunxi/pinctrl-sunxi.c: In function 'sunxi_pinctrl_init':
drivers/pinctrl/sunxi/pinctrl-sunxi.c:1191:8: error: 'best_div' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This cannot really happen except if 'freq' is UINT_MAX and 'clock' is
zero, and both of these are forbidden. To shut up the warning anyway,
this changes the logic to initialize the return code to the first
divider value before looking at the others.

Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 2339d4718b4d..6b7953da4228 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1125,10 +1125,13 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 static int sunxi_pinctrl_get_debounce_div(struct clk *clk, int freq, int *diff)
 {
 	unsigned long clock = clk_get_rate(clk);
-	unsigned int best_diff = ~0, best_div;
+	unsigned int best_diff, best_div;
 	int i;
 
-	for (i = 0; i < 8; i++) {
+	best_diff = abs(freq - clock);
+	best_div = 0;
+
+	for (i = 1; i < 8; i++) {
 		int cur_diff = abs(freq - (clock >> i));
 
 		if (cur_diff < best_diff) {
-- 
2.9.0
