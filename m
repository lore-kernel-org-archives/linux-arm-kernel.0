From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 15 Jul 2010 17:47:38 +0900
Subject: [PATCH] ARM: SAMSUNG SoC: clksrc register uses parent value to set
	default src.
Message-ID: <1279183658-27762-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If .parent field is filled when a struct clksrc_clk is being registered,
s3c_register_clksrc sets the source clock register accordingly to the
.parent field; i.e., it searches for the clock of .parent and sets SRC
register with the searched index.

In the previous versions, the parent value was "ignored" and overwritten
because the value of default register value overwrites the parent field.
The default register value overwrites .parent field only if the .parent
field is INVALID (not listed as SRC) or NULL.

Although this feature is not used, yet, in the future, users may want to
use .parent field of a struct clksrc_clk with the support of
clock-clksrc.c's initializer.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/clock-clksrc.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index ae8b850..46d204a 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -177,7 +177,7 @@ static struct clk_ops clksrc_ops_nosrc = {
 
 void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 {
-	int ret;
+	int ret, err = 0;
 
 	for (; size > 0; size--, clksrc++) {
 		if (!clksrc->reg_div.reg && !clksrc->reg_src.reg)
@@ -195,12 +195,26 @@ void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 				clksrc->clk.ops = &clksrc_ops;
 		}
 
+		if (clksrc->clk.parent && clksrc->sources &&
+				clksrc->reg_src.reg) {
+			err = s3c_setparent_clksrc(&clksrc->clk,
+					clksrc->clk.parent);
+			if (err < 0)
+				printk(KERN_ERR "[%s:%d] setparent error@reg"
+						"ister_clksrc %s p = %s...\n",
+						__FILE__, __LINE__,
+						clksrc->clk.name,
+						clksrc->clk.parent->name);
+		} else if (!clksrc->clk.parent)
+			err = -1; /* no parent is set */
+
 		/* setup the clocksource, but do not announce it
 		 * as it may be re-set by the setup routines
 		 * called after the rest of the clocks have been
 		 * registered
 		 */
-		s3c_set_clksrc(clksrc, false);
+		if (err < 0)
+			s3c_set_clksrc(clksrc, false);
 
 		ret = s3c24xx_register_clock(&clksrc->clk);
 
-- 
1.6.3.3
