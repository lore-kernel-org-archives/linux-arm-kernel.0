From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 22 Nov 2018 22:22:11 +0100
Subject: [PATCH 1/2] clk: core: clarify the check for runtime PM
In-Reply-To: <20181122212212.16039-1-miquel.raynal@bootlin.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
Message-ID: <20181122212212.16039-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the core->dev entry is populated only if runtime PM is
enabled. Doing so prevents accessing the device structure in any
case.

Keep the same logic but instead of using the presence of core->dev as
the only condition, also check the status of
pm_runtime_enabled(). Then, we can set the core->dev pointer at any
time as long as a device structure is available.

This change will help supporting device links in the clock subsystem.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..b799347c5fd6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 {
 	int ret = 0;
 
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return 0;
 
 	ret = pm_runtime_get_sync(core->dev);
@@ -106,7 +106,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
 
 static void clk_pm_runtime_put(struct clk_core *core)
 {
-	if (!core->dev)
+	if (!core->dev || !pm_runtime_enabled(core->dev))
 		return;
 
 	pm_runtime_put_sync(core->dev);
@@ -226,7 +226,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 	 * taking enable spinlock, but the below check is needed if one tries
 	 * to call it from other places.
 	 */
-	if (core->dev) {
+	if (core->dev && pm_runtime_enabled(core->dev)) {
 		pm_runtime_get_noresume(core->dev);
 		if (!pm_runtime_active(core->dev)) {
 			ret = false;
@@ -236,7 +236,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 	ret = core->ops->is_enabled(core->hw);
 done:
-	if (core->dev)
+	if (core->dev && pm_runtime_enabled(core->dev))
 		pm_runtime_put(core->dev);
 
 	return ret;
@@ -3272,8 +3272,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	}
 	core->ops = hw->init->ops;
 
-	if (dev && pm_runtime_enabled(dev))
-		core->dev = dev;
+	core->dev = dev;
 	if (dev && dev->driver)
 		core->owner = dev->driver->owner;
 	core->hw = hw;
-- 
2.19.1
