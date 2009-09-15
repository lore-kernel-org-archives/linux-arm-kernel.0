From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:41 +0900
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
Message-ID: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly route audio-bus from FOUTepll via MOUTepll.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 66f4ded..71aeb33 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -254,6 +254,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_i2sv2_info *i2s;
 	struct snd_soc_dai *dai;
+	struct clk *cm, *cf;
 	int ret;
 
 	if (pdev->id >= ARRAY_SIZE(s3c64xx_i2s)) {
@@ -275,6 +276,21 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	cm = clk_get(NULL, "mout_epll");
+	if (IS_ERR(cm)) {
+		dev_err(&pdev->dev, "failed to get mout_epll\n");
+		ret = PTR_ERR(cm);
+		goto mout_err;
+	}
+	clk_set_parent(i2s->iis_cclk, cm);
+	cf = clk_get(NULL, "fout_epll");
+	if (IS_ERR(cf)) {
+		dev_err(&pdev->dev, "failed to get fout_epll\n");
+		ret = PTR_ERR(cf);
+		goto fout_err;
+	}
+	clk_set_parent(cm, cf);
+
 	ret = s3c_i2sv2_probe(pdev, dai, i2s, 0);
 	if (ret)
 		goto err_clk;
@@ -283,11 +299,17 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_i2sv2;
 
+	clk_put(cf);
+	clk_put(cm);
 	return 0;
 
 err_i2sv2:
 	/* Not implemented for I2Sv2 core yet */
 err_clk:
+	clk_put(cf);
+fout_err:
+	clk_put(cm);
+mout_err:
 	clk_put(i2s->iis_cclk);
 err:
 	return ret;
-- 
1.6.2.5
