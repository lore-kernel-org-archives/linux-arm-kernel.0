From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 15:38:43 +0200
Subject: [PATCH 3/8] ASoC: uda134x: Optionally initialize L3 ops to default
 GPIO ops
In-Reply-To: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1470317928-25365-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO ops can be selected by platform_data which allows the
codec platform device to probe without the sound card's driver
intervention.

The downside is that it will request GPIOs on behalf of the codec
device and thus allow only one user on the bus, but it desn't seem
to be a limitation with current code and usage of the GPIO ops is
optional anyway.
The proper approach would presumably be to create a proper Linux
bus driver for L3, should this rather ancient bus specification
suddenly gain more interest.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/codecs/uda134x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index e4c694c..b72c925 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -544,6 +544,7 @@ static int uda134x_codec_probe(struct platform_device *pdev)
 {
 	struct uda134x_platform_data *pd = pdev->dev.platform_data;
 	struct uda134x_priv *uda134x;
+	int ret;
 
 	if (!pd) {
 		dev_err(&pdev->dev, "Missing L3 bitbang function\n");
@@ -557,6 +558,12 @@ static int uda134x_codec_probe(struct platform_device *pdev)
 	uda134x->pd = pd;
 	platform_set_drvdata(pdev, uda134x);
 
+	if (pd->l3.use_gpios) {
+		ret = l3_set_gpio_ops(&pdev->dev, &uda134x->pd->l3);
+		if (ret < 0)
+			return ret;
+	}
+
 	uda134x->regmap = devm_regmap_init(&pdev->dev, NULL, pd,
 		&uda134x_regmap_config);
 	if (IS_ERR(uda134x->regmap))
-- 
1.9.1
