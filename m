From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 20 Jul 2016 11:02:01 +0800
Subject: [PATCH 3/3] vcodec: mediatek: Add probe-defer for MTK IOMMU and SMI
In-Reply-To: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
References: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1468983721-3627-3-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek V4l2 depend on the IOMMU and SMI. we should add probe-defer
to wait for the IOMMU and SMI is ready.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 4c977b2..9e6203e 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -66,6 +66,11 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
+	/* Wait until MTK IOMMU and SMI probe done.*/
+	if (!mtk_smi_larb_is_ready(pm->larbvenc) ||
+	    !mtk_smi_larb_is_ready(pm->larbvenclt))
+		return -EPROBE_DEFER;
+
 	pm->vencpll_d2 = devm_clk_get(&pdev->dev, "venc_sel_src");
 	if (IS_ERR(pm->vencpll_d2)) {
 		mtk_v4l2_err("devm_clk_get vencpll_d2 fail");
-- 
1.8.1.1.dirty
