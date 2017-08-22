From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 22 Aug 2017 23:10:02 +0800
Subject: [PATCH v6 1/8] ASoC: rockchip: Correct 'dmic-delay' property name
In-Reply-To: <20170822151009.19014-1-jeffy.chen@rock-chips.com>
References: <20170822151009.19014-1-jeffy.chen@rock-chips.com>
Message-ID: <20170822151009.19014-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'dmic-delay' property name is different with the dt-binding.

So correct it with 'dmic-wakeup-delay-ms'.

Fixes: 3a6f9dce6116 (ASoC: rk3399_gru_sound: fix recording pop at first attempt)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

Changes in v6: None
Changes in v5:
Keep the dmic-delay property, but correct it with the name in
dt-binding.
        -- Suggested-by Mark Brown <broonie@kernel.org>

Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/rk3399_gru_sound.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3475c61a5fa0..70b5821afb17 100644
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
2.11.0
