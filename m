From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Tue, 10 Oct 2017 10:46:39 +0800
Subject: [PATCH v4 4/5] media: atmel-isc: Remove unnecessary member
In-Reply-To: <20171010024640.5733-1-wenyou.yang@microchip.com>
References: <20171010024640.5733-1-wenyou.yang@microchip.com>
Message-ID: <20171010024640.5733-5-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the memeber *config from the isc_subdev_entity struct,
the member is useless afterward.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/media/platform/atmel/atmel-isc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index a44a66ad2c02..29780fcdfc8b 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -83,7 +83,6 @@ struct isc_subdev_entity {
 	struct v4l2_subdev		*sd;
 	struct v4l2_async_subdev	*asd;
 	struct v4l2_async_notifier      notifier;
-	struct v4l2_subdev_pad_config	*config;
 
 	u32 pfe_cfg0;
 
@@ -1000,6 +999,7 @@ static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
 {
 	struct isc_format *isc_fmt;
 	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
+	struct v4l2_subdev_pad_config pad_cfg;
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_TRY,
 	};
@@ -1030,7 +1030,7 @@ static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
 
 	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
 	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
-			       isc->current_subdev->config, &format);
+			       &pad_cfg, &format);
 	if (ret < 0)
 		return ret;
 
@@ -1495,8 +1495,6 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 					      struct isc_device, v4l2_dev);
 	cancel_work_sync(&isc->awb_work);
 	video_unregister_device(&isc->video_dev);
-	if (isc->current_subdev->config)
-		v4l2_subdev_free_pad_config(isc->current_subdev->config);
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
 }
 
@@ -1648,10 +1646,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	INIT_LIST_HEAD(&isc->dma_queue);
 	spin_lock_init(&isc->dma_queue_lock);
 
-	sd_entity->config = v4l2_subdev_alloc_pad_config(sd_entity->sd);
-	if (!sd_entity->config)
-		return -ENOMEM;
-
 	ret = isc_formats_init(isc);
 	if (ret < 0) {
 		v4l2_err(&isc->v4l2_dev,
-- 
2.13.0
