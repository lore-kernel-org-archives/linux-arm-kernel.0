From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sun, 20 Jul 2014 11:42:52 +0800
Subject: [PATCH -next] ASoC: samsung: Fix return value check in
 s3c24xx_iis_dev_probe()
Message-ID: <1405827772-25980-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR(). Also remove redundant return value check of
platform_get_resource().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/samsung/s3c24xx-i2s.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index e87d9a2..36dbc17 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -456,13 +456,9 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Can't get IO resource.\n");
-		return -ENOENT;
-	}
 	s3c24xx_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
-	if (s3c24xx_i2s.regs == NULL)
-		return -ENXIO;
+	if (IS_ERR(s3c24xx_i2s.regs))
+		return PTR_ERR(s3c24xx_i2s.regs);
 
 	s3c24xx_i2s_pcm_stereo_out.dma_addr = res->start + S3C2410_IISFIFO;
 	s3c24xx_i2s_pcm_stereo_in.dma_addr = res->start + S3C2410_IISFIFO;
