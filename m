From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Mon, 28 Dec 2015 09:32:46 -0200
Subject: [PATCH] [media] call media_device_init() before registering the V4L2
 device
Message-ID: <75cff54a4808086de9d043b2a15a590372c6ab60.1451302363.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, v4l2_device_register() doesn't use the media_device
struct. So, calling media_device_init() could be called either
before or after v4l2_device_register().

Yet, it is a good practice to initialize everything before calling
the register functions. Also, the other drivers call
media_device_init() before registering the V4L2 device.

So, move the call for media_device_init() to happen earlier on
exynos4-is and s3c-camif.

This is just a cleanup patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
---
 drivers/media/platform/exynos4-is/media-dev.c | 4 ++--
 drivers/media/platform/s3c-camif/camif-core.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 27663dd45294..e96d246043ad 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1347,14 +1347,14 @@ static int fimc_md_probe(struct platform_device *pdev)
 	fmd->use_isp = fimc_md_is_isp_available(dev->of_node);
 	fmd->user_subdev_api = true;
 
+	media_device_init(&fmd->media_dev);
+
 	ret = v4l2_device_register(dev, &fmd->v4l2_dev);
 	if (ret < 0) {
 		v4l2_err(v4l2_dev, "Failed to register v4l2_device: %d\n", ret);
 		return ret;
 	}
 
-	media_device_init(&fmd->media_dev);
-
 	ret = fimc_md_get_clocks(fmd);
 	if (ret)
 		goto err_md;
diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index ea02b7ef2119..0b44b9accf50 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -324,12 +324,12 @@ static int camif_media_dev_init(struct camif_dev *camif)
 	strlcpy(v4l2_dev->name, "s3c-camif", sizeof(v4l2_dev->name));
 	v4l2_dev->mdev = md;
 
-	ret = v4l2_device_register(camif->dev, v4l2_dev);
-	if (ret < 0)
-		return ret;
-
 	media_device_init(md);
 
+	ret = v4l2_device_register(camif->dev, v4l2_dev);
+	if (ret < 0)
+		return ret;
+
 	return ret;
 }
 
-- 
2.5.0
