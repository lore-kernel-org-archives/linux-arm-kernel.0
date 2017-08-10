From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 10 Aug 2017 17:06:44 +0800
Subject: [PATCH 1/2] media: ov7670: Add entity pads initialization
In-Reply-To: <20170810090645.24344-1-wenyou.yang@microchip.com>
References: <20170810090645.24344-1-wenyou.yang@microchip.com>
Message-ID: <20170810090645.24344-2-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the media entity pads initialization.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

 drivers/media/i2c/ov7670.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index e88549f0e704..5c8460ee65c3 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -213,6 +213,7 @@ struct ov7670_devtype {
 struct ov7670_format_struct;  /* coming later */
 struct ov7670_info {
 	struct v4l2_subdev sd;
+	struct media_pad pad;
 	struct v4l2_ctrl_handler hdl;
 	struct {
 		/* gain cluster */
@@ -1688,14 +1689,23 @@ static int ov7670_probe(struct i2c_client *client,
 	v4l2_ctrl_auto_cluster(2, &info->auto_exposure,
 			       V4L2_EXPOSURE_MANUAL, false);
 	v4l2_ctrl_cluster(2, &info->saturation);
+
+	info->pad.flags = MEDIA_PAD_FL_SOURCE;
+	info->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ret = media_entity_pads_init(&info->sd.entity, 1, &info->pad);
+	if (ret < 0)
+		goto hdl_free;
+
 	v4l2_ctrl_handler_setup(&info->hdl);
 
 	ret = v4l2_async_register_subdev(&info->sd);
 	if (ret < 0)
-		goto hdl_free;
+		goto entity_cleanup;
 
 	return 0;
 
+entity_cleanup:
+	media_entity_cleanup(&info->sd.entity);
 hdl_free:
 	v4l2_ctrl_handler_free(&info->hdl);
 clk_disable:
@@ -1712,6 +1722,7 @@ static int ov7670_remove(struct i2c_client *client)
 	v4l2_device_unregister_subdev(sd);
 	v4l2_ctrl_handler_free(&info->hdl);
 	clk_disable_unprepare(info->clk);
+	media_entity_cleanup(&info->sd.entity);
 	return 0;
 }
 
-- 
2.13.0
