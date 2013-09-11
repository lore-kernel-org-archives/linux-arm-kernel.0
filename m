From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:35 +0300
Subject: [PATCH v2 4/9] [media] s5p-tv: convert to use I2C core runtime PM
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-5-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core now prepares runtime PM on behalf of the I2C client device, so
only thing the driver needs to do is to call pm_runtime_put() at the end of
its ->probe().

This patch converts s5p-tv driver to use this model.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/media/platform/s5p-tv/sii9234_drv.c | 30 ++++++-----------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/s5p-tv/sii9234_drv.c b/drivers/media/platform/s5p-tv/sii9234_drv.c
index 3dd762e..c0e8d42 100644
--- a/drivers/media/platform/s5p-tv/sii9234_drv.c
+++ b/drivers/media/platform/s5p-tv/sii9234_drv.c
@@ -325,8 +325,7 @@ static int sii9234_probe(struct i2c_client *client,
 	ctx = devm_kzalloc(&client->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
 		dev_err(dev, "out of memory\n");
-		ret = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 	ctx->client = client;
 
@@ -345,42 +344,25 @@ static int sii9234_probe(struct i2c_client *client,
 
 	v4l2_i2c_subdev_init(&ctx->sd, client, &sii9234_ops);
 
-	pm_runtime_enable(dev);
-
-	/* enable device */
-	ret = pm_runtime_get_sync(dev);
-	if (ret)
-		goto fail_pm;
-
 	/* verify chip version */
 	ret = sii9234_verify_version(client);
-	if (ret)
-		goto fail_pm_get;
+	if (ret) {
+		dev_err(dev, "failed to verify chip version\n");
+		return ret;
+	}
 
-	/* stop processing */
 	pm_runtime_put(dev);
 
 	dev_info(dev, "probe successful\n");
 
 	return 0;
-
-fail_pm_get:
-	pm_runtime_put_sync(dev);
-
-fail_pm:
-	pm_runtime_disable(dev);
-
-fail:
-	dev_err(dev, "probe failed\n");
-
-	return ret;
 }
 
 static int sii9234_remove(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 
-	pm_runtime_disable(dev);
+	pm_runtime_get(dev);
 
 	dev_info(dev, "remove successful\n");
 
-- 
1.8.4.rc3
