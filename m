From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 20 Jul 2016 11:02:00 +0800
Subject: [PATCH 2/3] drm/mediatek: Add probe-defer for MTK IOMMU and SMI
In-Reply-To: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
References: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1468983721-3627-2-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If DRM begin to probe before SMI probe done. It will hang:

[    7.832359] Call trace:
[    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
[    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450

Use the new interface(mtk_smi_larb_is_ready) to wait for IOMMU and
SMI probe done.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3970fcf..3ef3124 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
+#include <soc/mediatek/smi.h>
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
 #include "mtk_drm_ddp_comp.h"
@@ -201,6 +202,10 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	}
 	of_node_put(larb_node);
 
+	/* Wait until MTK IOMMU and SMI probe done.*/
+	if (!mtk_smi_larb_is_ready(&larb_pdev->dev))
+		return -EPROBE_DEFER;
+
 	comp->larb_dev = &larb_pdev->dev;
 
 	return 0;
-- 
1.8.1.1.dirty
