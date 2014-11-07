From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  7 Nov 2014 17:27:10 +0100
Subject: [PATCH v4 10/10] [media] v4l: Forbid usage of V4L2_MBUS_FMT
 definitions inside the kernel
In-Reply-To: <545CDB8D.4080406@xs4all.nl>
References: <545CDB8D.4080406@xs4all.nl>
Message-ID: <1415377630-16564-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place v4l2_mbus_pixelcode in a #ifndef __KERNEL__ section so that kernel
users don't have access to these definitions.

We have to keep this definition for user-space users even though they're
encouraged to move to the new media_bus_format enum.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/uapi/linux/v4l2-mediabus.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/v4l2-mediabus.h b/include/uapi/linux/v4l2-mediabus.h
index d712df8..3358e86 100644
--- a/include/uapi/linux/v4l2-mediabus.h
+++ b/include/uapi/linux/v4l2-mediabus.h
@@ -15,6 +15,17 @@
 #include <linux/types.h>
 #include <linux/videodev2.h>
 
+#ifndef __KERNEL__
+
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
 	MEDIA_BUS_FMT_ ## name = V4L2_MBUS_FMT_ ## name
 
@@ -102,6 +113,7 @@ enum v4l2_mbus_pixelcode {
 
 	V4L2_MBUS_FROM_MEDIA_BUS_FMT(AHSV8888_1X32),
 };
+#endif /* __KERNEL__ */
 
 /**
  * struct v4l2_mbus_framefmt - frame format on the media bus
-- 
1.9.1
