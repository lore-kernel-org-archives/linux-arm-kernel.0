From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:06 +0800
Subject: [PATCH v11 05/12] drm/mediatek: add BLS component
In-Reply-To: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484117473-46644-6-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add BLS component for PWM + GAMMA function

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 5 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3ff788c..f6e853a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -255,6 +255,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
 	[MTK_DISP_PWM] = "pwm",
 	[MTK_DISP_MUTEX] = "mutex",
 	[MTK_DISP_OD] = "od",
+	[MTK_DISP_BLS] = "bls",
 };
 
 struct mtk_ddp_comp_match {
@@ -265,6 +266,7 @@ struct mtk_ddp_comp_match {
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
+	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
@@ -336,7 +338,8 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	comp->id = comp_id;
 	comp->funcs = funcs ?: mtk_ddp_matches[comp_id].funcs;
 
-	if (comp_id == DDP_COMPONENT_DPI0 ||
+	if (comp_id == DDP_COMPONENT_BLS ||
+	    comp_id == DDP_COMPONENT_DPI0 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 22a33ee..0828cf8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -36,11 +36,13 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_PWM,
 	MTK_DISP_MUTEX,
 	MTK_DISP_OD,
+	MTK_DISP_BLS,
 	MTK_DDP_COMP_TYPE_MAX,
 };
 
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL,
+	DDP_COMPONENT_BLS,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_DPI0,
-- 
1.9.1
