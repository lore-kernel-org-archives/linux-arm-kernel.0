From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 5 Sep 2018 16:31:44 +0800
Subject: [PATCH v2 11/13] drm/mediatek: implement connection from BLS to DPI0
In-Reply-To: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
Message-ID: <20180905083146.14727-12-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify display driver to support connection from BLS to DPI.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 87e4191c250e..cc8d49e60c7e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -39,6 +39,7 @@
 #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
 #define DISP_REG_CONFIG_OUT_SEL			0x04c
 #define DISP_REG_CONFIG_DSI_SEL			0x050
+#define DISP_REG_CONFIG_DPI_SEL			0x064
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
@@ -132,7 +133,11 @@
 
 #define OVL_MOUT_EN_RDMA		0x1
 #define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define BLS_TO_DPI_RDMA1_TO_DSI		0x2
 #define DSI_SEL_IN_BLS			0x0
+#define DPI_SEL_IN_BLS			0x0
+#define DSI_SEL_IN_RDMA			0x1
+#define DPI_SEL_IN_RDMA			0x1
 
 struct mtk_disp_mutex {
 	int id;
@@ -323,9 +328,21 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
 			     enum mtk_ddp_comp_id cur,
 			     enum mtk_ddp_comp_id next)
 {
-	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
 		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
 			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		writel_relaxed(DSI_SEL_IN_BLS,
+			       config_regs + DISP_REG_CONFIG_DSI_SEL);
+		writel_relaxed(DPI_SEL_IN_RDMA,
+			       config_regs + DISP_REG_CONFIG_DPI_SEL);
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
+		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
+			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		writel_relaxed(DSI_SEL_IN_RDMA,
+			       config_regs + DISP_REG_CONFIG_DSI_SEL);
+		writel_relaxed(DPI_SEL_IN_BLS,
+			       config_regs + DISP_REG_CONFIG_DPI_SEL);
+	}
 }
 
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
-- 
2.12.5.2.gbdf23ab
