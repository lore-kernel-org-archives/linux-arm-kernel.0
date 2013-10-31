From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Oct 2013 13:03:56 +0100
Subject: [PATCH] clk: Do not dereference potential NULL pointer
Message-ID: <1383221036-26890-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A NULL pointer may be passed to _clk_register() for the dev parameter
(via clk_register()). Make sure not to dereference it before checking
that it's valid.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b68a999..c0b52e3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1976,7 +1976,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		hw->regmap = hw->init->regmap;
 	else if (dev && dev_get_regmap(dev, NULL))
 		hw->regmap = dev_get_regmap(dev, NULL);
-	else if (dev->parent)
+	else if (dev && dev->parent)
 		hw->regmap = dev_get_regmap(dev->parent, NULL);
 
 	/* allocate local copy in case parent_names is __initdata */
-- 
1.8.4
