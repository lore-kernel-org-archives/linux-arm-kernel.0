From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Nov 2014 18:28:35 +0100
Subject: [PATCH v6 RESEND 10/10] [media] v4l: Forbid usage of V4L2_MBUS_FMT
 definitions inside the kernel
In-Reply-To: <1415640515-15069-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415640515-15069-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415640515-15069-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place v4l2_mbus_pixelcode in a #ifndef __KERNEL__ section so that kernel
users don't have access to these definitions.

We have to keep this definition for user-space users even though they're
encouraged to move to the new media_bus_format enum.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/uapi/linux/v4l2-mediabus.h | 45 ++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/v4l2-mediabus.h b/include/uapi/linux/v4l2-mediabus.h
index 2618084..b1934a3 100644
--- a/include/uapi/linux/v4l2-mediabus.h
+++ b/include/uapi/linux/v4l2-mediabus.h
@@ -15,6 +15,33 @@
 #include <linux/types.h>
 #include <linux/videodev2.h>
 
+/**
+ * struct v4l2_mbus_framefmt - frame format on the media bus
+ * @width:	frame width
+ * @height:	frame height
+ * @code:	data format code (from enum v4l2_mbus_pixelcode)
+ * @field:	used interlacing type (from enum v4l2_field)
+ * @colorspace:	colorspace of the data (from enum v4l2_colorspace)
+ */
+struct v4l2_mbus_framefmt {
+	__u32			width;
+	__u32			height;
+	__u32			code;
+	__u32			field;
+	__u32			colorspace;
+	__u32			reserved[7];
+};
+
+#ifndef __KERNEL__
+/*
+ * enum v4l2_mbus_pixelcode and its definitions are now deprecated, and
+ * MEDIA_BUS_FMT_ definitions (defined in media-bus-format.h) should be
+ * used instead.
+ *
+ * New defines should only be added to media-bus-format.h. The
+ * v4l2_mbus_pixelcode enum is frozen.
+ */
+
 #define V4L2_MBUS_FROM_MEDIA_BUS_FMT(name)	\
 	V4L2_MBUS_FMT_ ## name = MEDIA_BUS_FMT_ ## name
 
@@ -102,22 +129,6 @@ enum v4l2_mbus_pixelcode {
 
 	V4L2_MBUS_FROM_MEDIA_BUS_FMT(AHSV8888_1X32),
 };
-
-/**
- * struct v4l2_mbus_framefmt - frame format on the media bus
- * @width:	frame width
- * @height:	frame height
- * @code:	data format code (from enum v4l2_mbus_pixelcode)
- * @field:	used interlacing type (from enum v4l2_field)
- * @colorspace:	colorspace of the data (from enum v4l2_colorspace)
- */
-struct v4l2_mbus_framefmt {
-	__u32			width;
-	__u32			height;
-	__u32			code;
-	__u32			field;
-	__u32			colorspace;
-	__u32			reserved[7];
-};
+#endif /* __KERNEL__ */
 
 #endif
-- 
1.9.1
