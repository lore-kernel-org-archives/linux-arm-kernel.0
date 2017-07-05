From: hiroh@chromium.org (Hirokazu Honda)
Date: Wed,  5 Jul 2017 14:33:48 +0900
Subject: [PATCH v3] [media] mtk-vcodec: Show mtk driver error without DEBUG
 definition
Message-ID: <20170705053348.2865-1-hiroh@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A driver error message is shown without DEBUG definition
to find an error and debug easily.

Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 237e144c194f..c1378c1b402c 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -32,6 +32,15 @@ extern int mtk_v4l2_dbg_level;
 extern bool mtk_vcodec_dbg;
 
 
+#define mtk_v4l2_err(fmt, args...)					\
+	pr_err("[MTK_V4L2][ERROR] %s:%d: " fmt "\n", __func__, __LINE__, \
+	       ##args)
+
+#define mtk_vcodec_err(h, fmt, args...)					\
+	pr_err("[MTK_VCODEC][ERROR][%d]: %s() " fmt "\n",		\
+	       ((struct mtk_vcodec_ctx *)h->ctx)->id, __func__, ##args)
+
+
 #if defined(DEBUG)
 
 #define mtk_v4l2_debug(level, fmt, args...)				 \
@@ -41,11 +50,6 @@ extern bool mtk_vcodec_dbg;
 				level, __func__, __LINE__, ##args);	 \
 	} while (0)
 
-#define mtk_v4l2_err(fmt, args...)                \
-	pr_err("[MTK_V4L2][ERROR] %s:%d: " fmt "\n", __func__, __LINE__, \
-	       ##args)
-
-
 #define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
 #define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
 
@@ -57,22 +61,16 @@ extern bool mtk_vcodec_dbg;
 				__func__, ##args);			\
 	} while (0)
 
-#define mtk_vcodec_err(h, fmt, args...)					\
-	pr_err("[MTK_VCODEC][ERROR][%d]: %s() " fmt "\n",		\
-	       ((struct mtk_vcodec_ctx *)h->ctx)->id, __func__, ##args)
-
 #define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
 #define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
 
 #else
 
 #define mtk_v4l2_debug(level, fmt, args...) {}
-#define mtk_v4l2_err(fmt, args...) {}
 #define mtk_v4l2_debug_enter() {}
 #define mtk_v4l2_debug_leave() {}
 
 #define mtk_vcodec_debug(h, fmt, args...) {}
-#define mtk_vcodec_err(h, fmt, args...) {}
 #define mtk_vcodec_debug_enter(h) {}
 #define mtk_vcodec_debug_leave(h) {}
 
-- 
2.13.2.725.g09c95d1e9-goog
