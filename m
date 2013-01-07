From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon,  7 Jan 2013 02:05:19 +0100
Subject: [PATCH] clk: max77686: Avoid double free at remove time
Message-ID: <1357520719-3782-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_lookup entry is dropped at remove time by a call to
clkdev_drop(). That function frees the entry, which is also freed by the
driver core as it has been allocated through devm_kzalloc(). This
results in a double free.

Use kzalloc() instead of devm_kzalloc() to fix this.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/clk/clk-max77686.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index d098f72..6de05c5 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -130,8 +130,7 @@ static int max77686_clk_register(struct device *dev,
 	if (IS_ERR(clk))
 		return -ENOMEM;
 
-	max77686->lookup = devm_kzalloc(dev, sizeof(struct clk_lookup),
-					GFP_KERNEL);
+	max77686->lookup = kzalloc(sizeof(struct clk_lookup), GFP_KERNEL);
 	if (IS_ERR(max77686->lookup))
 		return -ENOMEM;
 
-- 
Regards,

Laurent Pinchart
