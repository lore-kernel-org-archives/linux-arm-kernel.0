From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 28 May 2018 14:38:26 +0800
Subject: [PATCH v4 8/9] drm/mediatek: add third ddp path
In-Reply-To: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527489507-24453-9-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch create third crtc by third ddp path

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 5 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  | 7 +++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 658b8dd45b83..2d6aa150a9ff 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -539,6 +539,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	int ret;
 	int i;
 
+	if (!path)
+		return 0;
+
 	for (i = 0; i < path_len; i++) {
 		enum mtk_ddp_comp_id comp_id = path[i];
 		struct device_node *node;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 08d5d0b47bfe..3d279a299383 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -232,6 +232,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	if (ret < 0)
 		goto err_component_unbind;
 
+	ret = mtk_drm_crtc_create(drm, private->data->third_path,
+				  private->data->third_len);
+	if (ret < 0)
+		goto err_component_unbind;
+
 	/* Use OVL device for all DMA memory allocations */
 	np = private->comp_node[private->data->main_path[0]] ?:
 	     private->comp_node[private->data->ext_path[0]];
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index c3378c452c0a..d867e2683923 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -17,8 +17,8 @@
 #include <linux/io.h>
 #include "mtk_drm_ddp_comp.h"
 
-#define MAX_CRTC	2
-#define MAX_CONNECTOR	2
+#define MAX_CRTC	3
+#define MAX_CONNECTOR	3
 
 struct device;
 struct device_node;
@@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
 	unsigned int main_len;
 	const enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
+	const enum mtk_ddp_comp_id *third_path;
+	unsigned int third_len;
+
 	bool shadow_register;
 };
 
-- 
2.12.5
