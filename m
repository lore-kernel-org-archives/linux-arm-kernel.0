From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Jan 2017 12:41:16 +0100
Subject: [PATCH 14/14] ASoC: sunxi: simplify optional reset handling
In-Reply-To: <20170130114116.22089-1-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
Message-ID: <20170130114116.22089-14-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_deassert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marcus Cooper <codekipper@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 88fbb3a1e6601..d02d91b168243 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -493,13 +493,12 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "allwinner,sun6i-a31-spdif")) {
 		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
-		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		if (IS_ERR(host->rst)) {
+			ret = PTR_ERR(host->rst);
 			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
 			goto err_disable_apb_clk;
 		}
-		if (!IS_ERR(host->rst))
-			reset_control_deassert(host->rst);
+		reset_control_deassert(host->rst);
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-- 
2.11.0
