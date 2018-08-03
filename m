From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Fri, 3 Aug 2018 11:11:04 +0800
Subject: [PATCH v2 11/15] drm/mediatek: add callback function to return OVL
 layer number
In-Reply-To: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533265868-28110-12-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add callback function to return OVL layer number

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 978782a77629..a42cfa057f42 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -58,6 +58,7 @@
 struct mtk_disp_ovl_data {
 	unsigned int addr;
 	bool fmt_rgb565_is_0;
+	unsigned int layer_nr;
 };
 
 /**
@@ -132,6 +133,13 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
 	writel(0x0, comp->regs + DISP_REG_OVL_RST);
 }
 
+static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
+
+	return ovl->data->layer_nr;
+}
+
 static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
 {
 	unsigned int reg;
@@ -221,6 +229,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
 	.stop = mtk_ovl_stop,
 	.enable_vblank = mtk_ovl_enable_vblank,
 	.disable_vblank = mtk_ovl_disable_vblank,
+	.layer_nr = mtk_ovl_layer_nr,
 	.layer_on = mtk_ovl_layer_on,
 	.layer_off = mtk_ovl_layer_off,
 	.layer_config = mtk_ovl_layer_config,
@@ -319,6 +328,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
 static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.addr = DISP_REG_OVL_ADDR_MT8173,
 	.fmt_rgb565_is_0 = true,
+	.layer_nr = 4,
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
-- 
2.12.5.2.gbdf23ab
