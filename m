From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Wed, 30 Jul 2014 08:04:12 +0800
Subject: [PATCH] ASoC: sirf-audio-codec: Fix return value check in
 sirf_audio_codec_driver_probe()
Message-ID: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/sirf-audio-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index d90cb0f..06ba492 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -471,8 +471,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (base == NULL)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	sirf_audio_codec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    &sirf_audio_codec_regmap_config);
