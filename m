From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 16 Oct 2017 11:14:25 +0800
Subject: [PATCH v6 1/3] media: ov7670: Add entity pads initialization
In-Reply-To: <20171016031427.4194-1-wenyou.yang@microchip.com>
References: <20171016031427.4194-1-wenyou.yang@microchip.com>
Message-ID: <20171016031427.4194-2-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the media entity pads initialization.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4:
 - Fix the build error when not enabling Media Controller API option.

Changes in v3: None
Changes in v2: None

 drivers/media/i2c/ov7670.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index e88549f0e704..553945d4ca28 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -213,6 +213,9 @@ struct ov7670_devtype {
 struct ov7670_format_struct;  /* coming later */
 struct ov7670_info {
 	struct v4l2_subdev sd;
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	struct media_pad pad;
+#endif
 	struct v4l2_ctrl_handler hdl;
 	struct {
 		/* gain cluster */
@@ -1688,14 +1691,27 @@ static int ov7670_probe(struct i2c_client *client,
 	v4l2_ctrl_auto_cluster(2, &info->auto_exposure,
 			       V4L2_EXPOSURE_MANUAL, false);
 	v4l2_ctrl_cluster(2, &info->saturation);
+
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	info->pad.flags = MEDIA_PAD_FL_SOURCE;
+	info->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ret = media_entity_pads_init(&info->sd.entity, 1, &info->pad);
+	if (ret < 0)
+		goto hdl_free;
+#endif
+
 	v4l2_ctrl_handler_setup(&info->hdl);
 
 	ret = v4l2_async_register_subdev(&info->sd);
 	if (ret < 0)
-		goto hdl_free;
+		goto entity_cleanup;
 
 	return 0;
 
+entity_cleanup:
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	media_entity_cleanup(&info->sd.entity);
+#endif
 hdl_free:
 	v4l2_ctrl_handler_free(&info->hdl);
 clk_disable:
@@ -1712,6 +1728,9 @@ static int ov7670_remove(struct i2c_client *client)
 	v4l2_device_unregister_subdev(sd);
 	v4l2_ctrl_handler_free(&info->hdl);
 	clk_disable_unprepare(info->clk);
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	media_entity_cleanup(&info->sd.entity);
+#endif
 	return 0;
 }
 
-- 
2.13.0
