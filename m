From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 20 Oct 2018 20:50:19 +0300
Subject: [PATCH] media: mtk-vcodec: Release device nodes in
 mtk_vcodec_init_enc_pm()
Message-ID: <1540057819-5075-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_parse_phandle() returns the device node with refcount incremented.
There are two nodes that are used temporary in mtk_vcodec_init_enc_pm(),
but their refcounts are not decremented.

The patch adds one of_node_put() and fixes returning error codes.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 3e73e9db781f..7c025045ea90 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -41,25 +41,27 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
 	if (!node) {
 		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
+		return -ENODEV;
 	}
 	pdev = of_find_device_by_node(node);
+	of_node_put(node);
 	if (!pdev) {
 		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
+		return -ENODEV;
 	}
 	pm->larbvenc = &pdev->dev;
 
 	node = of_parse_phandle(dev->of_node, "mediatek,larb", 1);
 	if (!node) {
 		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
+		return -ENODEV;
 	}
 
 	pdev = of_find_device_by_node(node);
+	of_node_put(node);
 	if (!pdev) {
 		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
+		return -ENODEV;
 	}
 
 	pm->larbvenclt = &pdev->dev;
-- 
2.7.4
