From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:07 +0800
Subject: [PATCH v11 06/12] drm/mediatek: update display module connections
In-Reply-To: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484117473-46644-7-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update connections for OVL, RDMA, BLS, DSI

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index b77d456..a9b209c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -32,6 +32,10 @@
 #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
+#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
+#define DISP_REG_CONFIG_OUT_SEL			0x04c
+#define DISP_REG_CONFIG_DSI_SEL			0x050
+
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
@@ -71,6 +75,10 @@
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
+#define OVL_MOUT_EN_RDMA		0x1
+#define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define DSI_SEL_IN_BLS			0x0
+
 struct mtk_disp_mutex {
 	int id;
 	bool claimed;
@@ -111,6 +119,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
 		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
 		value = OVL0_MOUT_EN_COLOR0;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD_MOUT_EN_RDMA0;
@@ -148,6 +159,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSI_SEL;
+		value = DSI_SEL_IN_BLS;
 	} else {
 		value = 0;
 	}
@@ -155,6 +169,15 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
+static void mtk_ddp_sout_sel(void __iomem *config_regs,
+			     enum mtk_ddp_comp_id cur,
+			     enum mtk_ddp_comp_id next)
+{
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
+		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
+			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+}
+
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
@@ -167,6 +190,8 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 		writel_relaxed(reg, config_regs + addr);
 	}
 
+	mtk_ddp_sout_sel(config_regs, cur, next);
+
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
-- 
1.9.1
