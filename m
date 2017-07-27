From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 27 Jul 2017 10:01:10 +0800
Subject: [PATCH 1/3] memory: mtk-smi: add larbid init routine
In-Reply-To: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1501120872-19652-2-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
the larb->larbid was added but not initialized.
Mediatek's gen1 smi need this hardware larbid information to get the
register offset which controls whether enable iommu for this larb.
This patch add the initialize routine for larbid.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 2b798bb4..fe36b3e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -240,6 +240,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
+	int err;
 
 	if (!dev->pm_domain)
 		return -EPROBE_DEFER;
@@ -263,6 +264,14 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return PTR_ERR(larb->smi.clk_smi);
 	larb->smi.dev = dev;
 
+	err = of_property_read_u32(dev->of_node, "mediatek,larbid",
+				   &larb->larbid);
+	if (err && of_device_is_compatible(dev->of_node,
+					   "mediatek,mt2701-smi-larb")) {
+		dev_err(dev, "missing larbid property\n");
+		return err;
+	}
+
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
-- 
2.6.4
