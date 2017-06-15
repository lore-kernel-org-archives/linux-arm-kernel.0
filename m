From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Thu, 15 Jun 2017 07:53:11 +0200
Subject: [PATCH] ASoC: rockchip: Fix an error handling in 'rockchip_i2s_probe'
Message-ID: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If this memory allocation fail, we must disable what has been enabled.
Do not return immediately but go thrue the error handling path instead.

Also use 'devm_kmemdup' instead of 'devm_kzalloc+memcpy' to simplify code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/rockchip/rockchip_i2s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index af5e0da144f7..f3aa3dfe914b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -643,12 +643,13 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	soc_dai = devm_kzalloc(&pdev->dev,
+	soc_dai = devm_kmemdup(&pdev->dev, &rockchip_i2s_dai
 			       sizeof(*soc_dai), GFP_KERNEL);
-	if (!soc_dai)
-		return -ENOMEM;
+	if (!soc_dai) {
+		err = -ENOMEM;
+		goto err_pm_disable;
+	}
 
-	memcpy(soc_dai, &rockchip_i2s_dai, sizeof(*soc_dai));
 	if (!of_property_read_u32(node, "rockchip,playback-channels", &val)) {
 		if (val >= 2 && val <= 8)
 			soc_dai->playback.channels_max = val;
-- 
2.11.0
