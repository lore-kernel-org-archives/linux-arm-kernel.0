From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  5 Jul 2015 11:00:15 +0200
Subject: [PATCH 2/7] clk: rockchip: fix issues in the mmc-phase clock
In-Reply-To: <1436086820-3757-1-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
Message-ID: <1436086820-3757-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The review for the new inverter clock type uncovered some issues (missing
headers and name handling) that are also present in the mmc-phase clock
type, I got (to much) inspiration from. Fix these there too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-mmc-phase.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index e9f8df32..f2c6889 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -15,6 +15,8 @@
 
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include "clk.h"
 
 struct rockchip_mmc_clock {
@@ -131,6 +133,7 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 	if (!mmc_clock)
 		return NULL;
 
+	init.name = name;
 	init.num_parents = num_parents;
 	init.parent_names = parent_names;
 	init.ops = &rockchip_mmc_clk_ops;
@@ -139,9 +142,6 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 	mmc_clock->reg = reg;
 	mmc_clock->shift = shift;
 
-	if (name)
-		init.name = name;
-
 	clk = clk_register(NULL, &mmc_clock->hw);
 	if (IS_ERR(clk))
 		goto err_free;
-- 
2.1.4
