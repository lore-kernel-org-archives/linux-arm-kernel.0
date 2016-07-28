From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 28 Jul 2016 10:22:52 +0800
Subject: [PATCH v4 1/4] drm/mediatek: Add AAL engine basic function
In-Reply-To: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469672575-5847-2-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to correct brightness values, we have
to support gamma funciton on MT8173. In MT8173,
we have two engines for supporting gamma function:
AAL and GAMMA. This patch add some AAL engine
basic function, include config, start and stop
function.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3970fcf..5fc9671 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -38,6 +38,9 @@
 #define DISP_COLOR_WIDTH			0x0c50
 #define DISP_COLOR_HEIGHT			0x0c54
 
+#define DISP_AAL_EN				0x0000
+#define DISP_AAL_SIZE				0x0030
+
 #define	OD_RELAY_MODE		BIT(0)
 
 #define	UFO_BYPASS		BIT(2)
@@ -45,6 +48,8 @@
 #define	COLOR_BYPASS_ALL	BIT(7)
 #define	COLOR_SEQ_SEL		BIT(13)
 
+#define AAL_EN			BIT(0)
+
 static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh)
 {
@@ -76,6 +81,28 @@ static void mtk_ufoe_start(struct mtk_ddp_comp *comp)
 	writel(UFO_BYPASS, comp->regs + DISP_REG_UFO_START);
 }
 
+static void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
+			   unsigned int h, unsigned int vrefresh)
+{
+	writel(h << 16 | w, comp->regs + DISP_AAL_SIZE);
+}
+
+static void mtk_aal_start(struct mtk_ddp_comp *comp)
+{
+	writel(AAL_EN, comp->regs + DISP_AAL_EN);
+}
+
+static void mtk_aal_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs + DISP_AAL_EN);
+}
+
+static const struct mtk_ddp_comp_funcs ddp_aal = {
+	.config = mtk_aal_config,
+	.start = mtk_aal_start,
+	.stop = mtk_aal_stop,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_color = {
 	.config = mtk_color_config,
 	.start = mtk_color_start,
@@ -112,7 +139,7 @@ struct mtk_ddp_comp_match {
 };
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
-	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
+	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
-- 
1.7.9.5
