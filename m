From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Fri, 21 Sep 2018 11:28:13 +0800
Subject: [PATCH v3 03/12] drm/mediatek: adjust EDGE to match clock and data
In-Reply-To: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
Message-ID: <20180921032822.30771-4-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

The default timing of DPI data and clock is not match.
We could adjust this bit to make them match.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 8 ++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 74a32833bde1..1e7369e0d91c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -121,6 +121,7 @@ struct mtk_dpi_yc_limit {
 
 struct mtk_dpi_conf {
 	u32 reg_h_fre_con;
+	bool edge_sel_en;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -351,6 +352,12 @@ static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
+static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
+{
+	if (dpi->conf->edge_sel_en)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
+}
+
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 					enum mtk_dpi_out_color_format format)
 {
@@ -536,6 +543,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 	mtk_dpi_config_color_format(dpi, dpi->color_format);
 	mtk_dpi_config_2n_h_fre(dpi);
+	mtk_dpi_config_disable_edge(dpi);
 	mtk_dpi_sw_reset(dpi, false);
 
 	return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 040444d7718d..d9db8c4cacd7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -223,5 +223,6 @@
 #define ESAV_CODE2			(0xFFF << 0)
 #define ESAV_CODE3_MSB			BIT(16)
 
+#define EDGE_SEL_EN			BIT(5)
 #define H_FRE_2N			BIT(25)
 #endif /* __MTK_DPI_REGS_H */
-- 
2.12.5.2.gbdf23ab
