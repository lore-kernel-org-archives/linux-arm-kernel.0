From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Aug 2017 17:21:01 +0100
Subject: Applied "ASoC: rockchip: Correct 'dmic-delay' property name" to the
 asoc tree
In-Reply-To: <20170822151009.19014-2-jeffy.chen@rock-chips.com>
Message-ID: <E1dkBvJ-0004PE-KG@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Correct 'dmic-delay' property name

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

>From f628c4ed3de499f027d3ae70cbb46c6dfadfc098 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 22 Aug 2017 23:35:48 +0800
Subject: [PATCH] ASoC: rockchip: Correct 'dmic-delay' property name

The 'dmic-delay' property name is different with the dt-binding.

So correct it with 'dmic-wakeup-delay-ms'.

Fixes: 3a6f9dce6116 (ASoC: rk3399_gru_sound: fix recording pop at first attempt)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 70c0908fb9b4..566ccb39fb31 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,7 +38,7 @@
 
 #define SOUND_FS	256
 
-static unsigned int rt5514_dmic_delay;
+static unsigned int dmic_wakeup_delay;
 
 static struct snd_soc_jack rockchip_sound_jack;
 
@@ -126,7 +126,7 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Wait for DMIC stable */
-	msleep(rt5514_dmic_delay);
+	msleep(dmic_wakeup_delay);
 
 	return 0;
 }
@@ -348,13 +348,13 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Set DMIC delay */
-	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
-					&rt5514_dmic_delay);
+	/* Set DMIC wakeup delay */
+	ret = device_property_read_u32(&pdev->dev, "dmic-wakeup-delay-ms",
+					&dmic_wakeup_delay);
 	if (ret) {
-		rt5514_dmic_delay = 0;
+		dmic_wakeup_delay = 0;
 		dev_dbg(&pdev->dev,
-			"no optional property 'dmic-delay' found, default: no delay\n");
+			"no optional property 'dmic-wakeup-delay-ms' found, default: no delay\n");
 	}
 
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-- 
2.13.3
