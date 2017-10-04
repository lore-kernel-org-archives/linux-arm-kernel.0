From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:28:45 +0100
Subject: Applied "ASoC: rockchip: Allocate enough memory so we don't overflow
 routes" to the asoc tree
In-Reply-To: <20170929220324.16413-1-dianders@chromium.org>
Message-ID: <E1dzhr3-0004Qh-D0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Allocate enough memory so we don't overflow routes

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8eae6c2585b0455f0e7200495d5e513020ca2fa2 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Fri, 29 Sep 2017 15:03:24 -0700
Subject: [PATCH] ASoC: rockchip: Allocate enough memory so we don't overflow
 routes

In the recent commit d9f9c167edae ("ASoC: rockchip: Init dapm routes
dynamically") we improperly allocated memory for the card->dapm_routes
causing us to overflow the allocation on every boot.  Oops.

Let's allocate the correct amount of memory.  We'll also add a check
to make sure that we don't overrun memory even if we encounter some
sort of weird device tree.

Fixes: d9f9c167edae ("ASoC: rockchip: Init dapm routes dynamically")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
