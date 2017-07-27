From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 15:09:40 +0200
Subject: [PATCH 2/2] clk: meson: gxbb: fix clk_mclk_i958 divider flags
In-Reply-To: <20170727130940.18005-1-jbrunet@baylibre.com>
References: <20170727130940.18005-1-jbrunet@baylibre.com>
Message-ID: <20170727130940.18005-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_DIVIDER_ROUND_CLOSEST was incorrectly put in the hw.init flags
while it should have been in the divider flags

Fixes: 3c277c247eab ("clk: meson: gxbb: add cts_mclk_i958")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index b1b72524153b..59a296b119ea 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -876,7 +876,7 @@ static struct clk_mux gxbb_cts_mclk_i958_sel = {
 	/* Default parent unknown (register reset value: 0) */
 	.table = (u32[]){ 1, 2, 3 },
 	.lock = &clk_lock,
-		.hw.init = &(struct clk_init_data){
+	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_sel",
 		.ops = &clk_mux_ops,
 		.parent_names = (const char *[]){ "mpll0", "mpll1", "mpll2" },
@@ -890,12 +890,13 @@ static struct clk_divider gxbb_cts_mclk_i958_div = {
 	.shift = 16,
 	.width = 8,
 	.lock = &clk_lock,
-	.hw.init = &(struct clk_init_data){
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_div",
 		.ops = &clk_divider_ops,
 		.parent_names = (const char *[]){ "cts_mclk_i958_sel" },
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.9.4
