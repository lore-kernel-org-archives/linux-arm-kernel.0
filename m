From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 28 Jul 2016 10:22:53 +0800
Subject: [PATCH v4 2/4] drm/mediatek: Add GAMMA engine basic function
In-Reply-To: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469672575-5847-3-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to correct brightness values, we have
to support gamma funciton on MT8173. In MT8173,
we have two engines for supporting gamma function:
AAL and GAMMA. This patch add some GAMMA engine
basic function, include config, start and stop
function.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 5fc9671..ba895c8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -41,6 +41,9 @@
 #define DISP_AAL_EN				0x0000
 #define DISP_AAL_SIZE				0x0030
 
+#define DISP_GAMMA_EN				0x0000
+#define DISP_GAMMA_SIZE				0x0030
+
 #define	OD_RELAY_MODE		BIT(0)
 
 #define	UFO_BYPASS		BIT(2)
@@ -50,6 +53,8 @@
 
 #define AAL_EN			BIT(0)
 
+#define GAMMA_EN		BIT(0)
+
 static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh)
 {
@@ -97,12 +102,34 @@ static void mtk_aal_stop(struct mtk_ddp_comp *comp)
 	writel_relaxed(0x0, comp->regs + DISP_AAL_EN);
 }
 
+static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
+			     unsigned int h, unsigned int vrefresh)
+{
+	writel(h << 16 | w, comp->regs + DISP_GAMMA_SIZE);
+}
+
+static void mtk_gamma_start(struct mtk_ddp_comp *comp)
+{
+	writel(GAMMA_EN, comp->regs  + DISP_GAMMA_EN);
+}
+
+static void mtk_gamma_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs  + DISP_GAMMA_EN);
+}
+
 static const struct mtk_ddp_comp_funcs ddp_aal = {
 	.config = mtk_aal_config,
 	.start = mtk_aal_start,
 	.stop = mtk_aal_stop,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_gamma = {
+	.config = mtk_gamma_config,
+	.start = mtk_gamma_start,
+	.stop = mtk_gamma_stop,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_color = {
 	.config = mtk_color_config,
 	.start = mtk_color_start,
@@ -145,7 +172,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
-	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, NULL },
+	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
 	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
 	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
-- 
1.7.9.5
