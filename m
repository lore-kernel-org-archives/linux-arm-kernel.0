From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 12 Jul 2016 11:02:28 +0000
Subject: [PATCH -next] [media] vcodec: mediatek: Fix return value check in
 mtk_vcodec_init_enc_pm()
Message-ID: <1468321348-16045-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_clk_get() returns ERR_PTR()
and not returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 2379e97..3e73e9d 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -67,27 +67,27 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	pm->dev = &pdev->dev;
 
 	pm->vencpll_d2 = devm_clk_get(&pdev->dev, "venc_sel_src");
-	if (pm->vencpll_d2 == NULL) {
+	if (IS_ERR(pm->vencpll_d2)) {
 		mtk_v4l2_err("devm_clk_get vencpll_d2 fail");
-		ret = -1;
+		ret = PTR_ERR(pm->vencpll_d2);
 	}
 
 	pm->venc_sel = devm_clk_get(&pdev->dev, "venc_sel");
-	if (pm->venc_sel == NULL) {
+	if (IS_ERR(pm->venc_sel)) {
 		mtk_v4l2_err("devm_clk_get venc_sel fail");
-		ret = -1;
+		ret = PTR_ERR(pm->venc_sel);
 	}
 
 	pm->univpll1_d2 = devm_clk_get(&pdev->dev, "venc_lt_sel_src");
-	if (pm->univpll1_d2 == NULL) {
+	if (IS_ERR(pm->univpll1_d2)) {
 		mtk_v4l2_err("devm_clk_get univpll1_d2 fail");
-		ret = -1;
+		ret = PTR_ERR(pm->univpll1_d2);
 	}
 
 	pm->venc_lt_sel = devm_clk_get(&pdev->dev, "venc_lt_sel");
-	if (pm->venc_lt_sel == NULL) {
+	if (IS_ERR(pm->venc_lt_sel)) {
 		mtk_v4l2_err("devm_clk_get venc_lt_sel fail");
-		ret = -1;
+		ret = PTR_ERR(pm->venc_lt_sel);
 	}
 
 	return ret;
