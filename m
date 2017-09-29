From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 29 Sep 2017 15:03:24 -0700
Subject: [PATCH] ASoC: rockchip: Allocate enough memory so we don't overflow
 routes
Message-ID: <20170929220324.16413-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the recent commit d9f9c167edae ("ASoC: rockchip: Init dapm routes
dynamically") we improperly allocated memory for the card->dapm_routes
causing us to overflow the allocation on every boot.  Oops.

Let's allocate the correct amount of memory.  We'll also add a check
to make sure that we don't overrun memory even if we encounter some
sort of weird device tree.

Fixes: d9f9c167edae ("ASoC: rockchip: Init dapm routes dynamically")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 30eed83e8a13..d64fbbd50544 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -494,13 +494,17 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	struct snd_soc_dai_link *dai;
 	struct snd_soc_dapm_route *routes;
 	int i, index;
+	int num_routes;
 
 	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
 				      GFP_KERNEL);
 	if (!card->dai_link)
 		return -ENOMEM;
 
-	routes = devm_kzalloc(dev, sizeof(rockchip_routes),
+	num_routes = 0;
+	for (i = 0; i < ARRAY_SIZE(rockchip_routes); i++)
+		num_routes += rockchip_routes[i].num_routes;
+	routes = devm_kzalloc(dev, num_routes * sizeof(*routes),
 			      GFP_KERNEL);
 	if (!routes)
 		return -ENOMEM;
@@ -538,6 +542,12 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		dai->platform_of_node = np_cpu;
 		dai->cpu_of_node = np_cpu;
 
+		if (card->num_dapm_routes + rockchip_routes[index].num_routes >
+		    num_routes) {
+			dev_err(dev, "Too many routes\n");
+			return -EINVAL;
+		}
+
 		memcpy(routes + card->num_dapm_routes,
 		       rockchip_routes[index].routes,
 		       rockchip_routes[index].num_routes * sizeof(*routes));
-- 
2.14.2.822.g60be5d43e6-goog
