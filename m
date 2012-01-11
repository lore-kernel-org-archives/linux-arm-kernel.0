From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:31 +1100
Subject: [PATCH 06/11] ep93xx: Don't use system controller defines in audio
 drivers
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-7-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the Snapper CL15 and EDB93xx audio drivers set the same audio
configuration in ep93xx_i2s_acquire. Remove the arguments to
ep93xx_i2s_acquire so that the audio drivers no longer need the
EP93XX_SYSCON defines exported.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c                  |   19 ++++---------------
 arch/arm/mach-ep93xx/include/mach/platform.h |    2 +-
 sound/soc/ep93xx/edb93xx.c                   |    4 +---
 sound/soc/ep93xx/snappercl15.c               |    4 +---
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index bd59696..0726b7b 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -836,23 +836,12 @@ void __init ep93xx_register_i2s(void)
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
@@ -862,7 +851,7 @@ int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config)
 	 */
 	val = __raw_readl(EP93XX_SYSCON_I2SCLKDIV);
 	val &= ~EP93XX_I2SCLKDIV_MASK;
-	val |= i2s_config;
+	val |= EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDIV_SPOL;
 	ep93xx_syscon_swlocked_write(val, EP93XX_SYSCON_I2SCLKDIV);
 
 	return 0;
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 5066045..35e5d73 100644
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
index 51930b6..3a6ab05 100644
--- a/sound/soc/ep93xx/edb93xx.c
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -94,9 +94,7 @@ static int __devinit edb93xx_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &snd_soc_edb93xx;
 	int ret;
 
-	ret = ep93xx_i2s_acquire(EP93XX_SYSCON_DEVCFG_I2SONAC97,
-				 EP93XX_SYSCON_I2SCLKDIV_ORIDE |
-				 EP93XX_SYSCON_I2SCLKDIV_SPOL);
+	ret = ep93xx_i2s_acquire();
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 2cde433..6ccac5a 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -110,9 +110,7 @@ static int __devinit snappercl15_probe(struct platform_device *pdev)
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
