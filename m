From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 27 Jan 2014 14:55:25 +0800
Subject: [PATCH v2 2/3] ASoC: atmel_wm8904: make it available to choose clock
In-Reply-To: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1390805726-1841-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it available to choose the clock from TK pin or RK pin. This
is hardware design decided.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2: None

 sound/soc/atmel/atmel_wm8904.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index b4e3690..9346410 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -108,6 +108,7 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
 	struct device_node *codec_np, *cpu_np;
 	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
+	struct atmel_ssc_info *ssc_info;
 	int ret;
 
 	if (!np) {
@@ -115,6 +116,15 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ssc_info = devm_kzalloc(&pdev->dev, sizeof(*ssc_info), GFP_KERNEL);
+	if (!ssc_info)
+		return -ENOMEM;
+
+	ssc_info->clk_from_rk_pin =
+		of_property_read_bool(np, "atmel,clk-from-rk-pin");
+
+	card->drvdata = (void *)ssc_info;
+
 	ret = snd_soc_of_parse_card_name(card, "atmel,model");
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse card name\n");
-- 
1.8.5.2
