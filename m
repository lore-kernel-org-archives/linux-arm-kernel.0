From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:13 +1100
Subject: [PATCH v4 02/11] ep93xx: Don't use system controller defines in audio
 drivers
Message-ID: <1331592502-9083-3-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the Snapper CL15 and EDB93xx audio drivers set the same audio
configuration in ep93xx_i2s_acquire. Remove the arguments to
ep93xx_i2s_acquire so that the audio drivers no longer need the
EP93XX_SYSCON defines exported.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
---
This patch has already been applied in Mark's tree. It is posted
for inclusion here because this series is against v3.3-rc7 and
will cause build failures without it. There have been no changes
to the patch since Mark applied it, so it should be okay to
merge into both his tree and the arm-soc tree.

 arch/arm/mach-ep93xx/core.c                  |   19 ++++---------------
 arch/arm/mach-ep93xx/include/mach/platform.h |    2 +-
 sound/soc/ep93xx/edb93xx.c                   |    4 +---
 sound/soc/ep93xx/snappercl15.c               |    4 +---
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 24203f9..b5c1dae 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -817,23 +817,12 @@ void __init ep93xx_register_i2s(void)
 #define EP93XX_I2SCLKDIV_MASK		(EP93XX_SYSCON_I2SCLKDIV_ORIDE | \
 					 EP93XX_SYSCON_I2SCLKDIV_SPOL)
 
-int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config)
+int ep93xx_i2s_acquire(void)
 {
 	unsigned val;
 
-	/* Sanity check */
-	if (i2s_pins & ~EP93XX_SYSCON_DEVCFG_I2S_MASK)
-		return -EINVAL;
-	if (i2s_config & ~EP93XX_I2SCLKDIV_MASK)
-		return -EINVAL;
-
-	/* Must have only one of I2SONSSP/I2SONAC97 set */
-	if ((i2s_pins & EP93XX_SYSCON_DEVCFG_I2SONSSP) ==
-	    (i2s_pins & EP93XX_SYSCON_DEVCFG_I2SONAC97))
-		return -EINVAL;
-
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2S_MASK);
-	ep93xx_devcfg_set_bits(i2s_pins);
+	ep93xx_devcfg_set_clear(EP93XX_SYSCON_DEVCFG_I2SONAC97,
+			EP93XX_SYSCON_DEVCFG_I2S_MASK);
 
 	/*
 	 * This is potentially racy with the clock api for i2s_mclk, sclk and 
@@ -843,7 +832,7 @@ int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config)
 	 */
 	val = __raw_readl(EP93XX_SYSCON_I2SCLKDIV);
 	val &= ~EP93XX_I2SCLKDIV_MASK;
-	val |= i2s_config;
+	val |= EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDIV_SPOL;
 	ep93xx_syscon_swlocked_write(val, EP93XX_SYSCON_I2SCLKDIV);
 
 	return 0;
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index d4c9349..ad63d4b 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -59,7 +59,7 @@ void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
 int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
 void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 void ep93xx_register_i2s(void);
-int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config);
+int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 void ep93xx_register_ac97(void);
 
diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
index bae5cbb..e01cb02 100644
--- a/sound/soc/ep93xx/edb93xx.c
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -85,9 +85,7 @@ static int __devinit edb93xx_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &snd_soc_edb93xx;
 	int ret;
 
-	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
-				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
-				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	ret = ep93xx_i2s_acquire();
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index ccae34a..a193cea 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -103,9 +103,7 @@ static int __devinit snappercl15_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &snd_soc_snappercl15;
 	int ret;
 
-	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
-				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
-				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	ret = ep93xx_i2s_acquire();
 	if (ret)
 		return ret;
 
-- 
1.7.0.4
