From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Feb 2014 22:54:42 +0100
Subject: [PATCH 3/5] mt9t001: Add clock support
In-Reply-To: <1392069284-18024-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1392069284-18024-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1392069284-18024-4-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sensor needs a master clock, handle it explictly in the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/mt9t001.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/mt9t001.c b/drivers/media/i2c/mt9t001.c
index 9a0bb06..422e068 100644
--- a/drivers/media/i2c/mt9t001.c
+++ b/drivers/media/i2c/mt9t001.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
 #include <linux/module.h>
@@ -118,6 +119,7 @@ struct mt9t001 {
 	struct v4l2_subdev subdev;
 	struct media_pad pad;
 
+	struct clk *clk;
 	struct regulator_bulk_data regulators[2];
 
 	struct mutex power_lock; /* lock to protect power_count */
@@ -189,9 +191,21 @@ static int mt9t001_reset(struct mt9t001 *mt9t001)
 
 static int mt9t001_power_on(struct mt9t001 *mt9t001)
 {
+	int ret;
+
 	/* Bring up the supplies */
-	return regulator_bulk_enable(ARRAY_SIZE(mt9t001->regulators),
-				     mt9t001->regulators);
+	ret = regulator_bulk_enable(ARRAY_SIZE(mt9t001->regulators),
+				   mt9t001->regulators);
+	if (ret < 0)
+		return ret;
+
+	/* Enable clock */
+	ret = clk_prepare_enable(mt9t001->clk);
+	if (ret < 0)
+		regulator_bulk_disable(ARRAY_SIZE(mt9t001->regulators),
+				       mt9t001->regulators);
+
+	return ret;
 }
 
 static void mt9t001_power_off(struct mt9t001 *mt9t001)
@@ -199,6 +213,9 @@ static void mt9t001_power_off(struct mt9t001 *mt9t001)
 	regulator_bulk_disable(ARRAY_SIZE(mt9t001->regulators),
 			       mt9t001->regulators);
 
+	clk_disable_unprepare(mt9t001->clk);
+}
+
 static int __mt9t001_set_power(struct mt9t001 *mt9t001, bool on)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&mt9t001->subdev);
@@ -854,6 +871,12 @@ static int mt9t001_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	mt9t001->clk = devm_clk_get(&client->dev, NULL);
+	if (IS_ERR(mt9t001->clk)) {
+		dev_err(&client->dev, "Unable to get clock\n");
+		return PTR_ERR(mt9t001->clk);
+	}
+
 	v4l2_ctrl_handler_init(&mt9t001->ctrls, ARRAY_SIZE(mt9t001_ctrls) +
 						ARRAY_SIZE(mt9t001_gains) + 4);
 
-- 
1.8.3.2
