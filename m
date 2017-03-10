From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu,  9 Mar 2017 20:52:58 -0800
Subject: [PATCH v5 18/39] [media] v4l: subdev: Add function to validate frame
 interval
In-Reply-To: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1489121599-23206-19-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the pads on both sides of a link specify a frame interval, then
those frame intervals should match. Create the exported function
v4l2_subdev_link_validate_frame_interval() to verify this. This
function can be called in a subdevice's media_entity_operations
or v4l2_subdev_pad_ops link_validate callbacks.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 50 +++++++++++++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 10 +++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index da78497..7a0f387 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -521,6 +521,25 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_default);
 
 static int
+v4l2_subdev_link_validate_get_fi(struct media_pad *pad,
+				 struct v4l2_subdev_frame_interval *fi)
+{
+	if (is_media_entity_v4l2_subdev(pad->entity)) {
+		struct v4l2_subdev *sd =
+			media_entity_to_v4l2_subdev(pad->entity);
+
+		fi->pad = pad->index;
+		return v4l2_subdev_call(sd, video, g_frame_interval, fi);
+	}
+
+	WARN(pad->entity->function != MEDIA_ENT_F_IO_V4L,
+	     "Driver bug! Wrong media entity type 0x%08x, entity %s\n",
+	     pad->entity->function, pad->entity->name);
+
+	return -EINVAL;
+}
+
+static int
 v4l2_subdev_link_validate_get_format(struct media_pad *pad,
 				     struct v4l2_subdev_format *fmt)
 {
@@ -540,6 +559,37 @@ v4l2_subdev_link_validate_get_format(struct media_pad *pad,
 	return -EINVAL;
 }
 
+int v4l2_subdev_link_validate_frame_interval(struct media_link *link)
+{
+	struct v4l2_subdev_frame_interval src_fi, sink_fi;
+	unsigned long src_usec, sink_usec;
+	int rval;
+
+	rval = v4l2_subdev_link_validate_get_fi(link->source, &src_fi);
+	if (rval < 0)
+		return 0;
+
+	rval = v4l2_subdev_link_validate_get_fi(link->sink, &sink_fi);
+	if (rval < 0)
+		return 0;
+
+	if (src_fi.interval.numerator == 0   ||
+	    src_fi.interval.denominator == 0 ||
+	    sink_fi.interval.numerator == 0  ||
+	    sink_fi.interval.denominator == 0)
+		return -EPIPE;
+
+	src_usec = DIV_ROUND_CLOSEST_ULL(
+		(u64)src_fi.interval.numerator * USEC_PER_SEC,
+		src_fi.interval.denominator);
+	sink_usec = DIV_ROUND_CLOSEST_ULL(
+		(u64)sink_fi.interval.numerator * USEC_PER_SEC,
+		sink_fi.interval.denominator);
+
+	return (src_usec != sink_usec) ? -EPIPE : 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_frame_interval);
+
 int v4l2_subdev_link_validate(struct media_link *link)
 {
 	struct v4l2_subdev *sink;
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 0ab1c5d..60c941d 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -929,6 +929,16 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_format *sink_fmt);
 
 /**
+ * v4l2_subdev_link_validate_frame_interval - validates a media link
+ *
+ * @link: pointer to &struct media_link
+ *
+ * This function ensures that the frame intervals, if specified by
+ * both the source and sink subdevs of the link, are equal.
+ */
+int v4l2_subdev_link_validate_frame_interval(struct media_link *link);
+
+/**
  * v4l2_subdev_link_validate - validates a media link
  *
  * @link: pointer to &struct media_link
-- 
2.7.4
