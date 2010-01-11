From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:16 +0800
Subject: [PATCH 08/16] [ARM] pxa: introduce processor specific
	pxa27x_assert_ac97reset()
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-9-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is really pxa27x specific and should be kept in pxa27x.c. With this
newly introduced function, the original set_resetgpio_mode() is deprecated.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/pxa27x.c  |   19 ++++++++++++++++
 sound/arm/pxa2xx-ac97-lib.c |   50 +++++-------------------------------------
 2 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6a0b731..7c53543 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -40,6 +40,25 @@ void pxa27x_clear_otgph(void)
 }
 EXPORT_SYMBOL(pxa27x_clear_otgph);
 
+static unsigned long ac97_reset_config[] = {
+	GPIO95_AC97_nRESET,
+	GPIO95_GPIO,
+	GPIO113_AC97_nRESET,
+	GPIO113_GPIO,
+};
+
+void pxa27x_assert_ac97reset(int reset_gpio, int on)
+{
+	if (reset_gpio == 113)
+		pxa2xx_mfp_config(on ? &ac97_reset_config[0] :
+				       &ac97_reset_config[1], 1);
+
+	if (reset_gpio == 95)
+		pxa2xx_mfp_config(on ? &ac97_reset_config[2] :
+				       &ac97_reset_config[3], 1);
+}
+EXPORT_SYMBOL_GPL(pxa27x_assert_ac97reset);
+
 /* Crystal clock: 13MHz */
 #define BASE_CLK	13000000
 
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 7587a74..ee68728 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -32,6 +32,8 @@ static struct clk *ac97_clk;
 static struct clk *ac97conf_clk;
 static int reset_gpio;
 
+extern void pxa27x_assert_ac97reset(int reset_gpio, int on);
+
 /*
  * Beware PXA27x bugs:
  *
@@ -42,45 +44,6 @@ static int reset_gpio;
  * 1 jiffy timeout if interrupt never comes).
  */
 
-enum {
-	RESETGPIO_FORCE_HIGH,
-	RESETGPIO_FORCE_LOW,
-	RESETGPIO_NORMAL_ALTFUNC
-};
-
-/**
- * set_resetgpio_mode - computes and sets the AC97_RESET gpio mode on PXA
- * @mode: chosen action
- *
- * As the PXA27x CPUs suffer from a AC97 bug, a manual control of the reset line
- * must be done to insure proper work of AC97 reset line.  This function
- * computes the correct gpio_mode for further use by reset functions, and
- * applied the change through pxa_gpio_mode.
- */
-static void set_resetgpio_mode(int resetgpio_action)
-{
-	int mode = 0;
-
-	if (reset_gpio)
-		switch (resetgpio_action) {
-		case RESETGPIO_NORMAL_ALTFUNC:
-			if (reset_gpio == 113)
-				mode = 113 | GPIO_ALT_FN_2_OUT;
-			if (reset_gpio == 95)
-				mode = 95 | GPIO_ALT_FN_1_OUT;
-			break;
-		case RESETGPIO_FORCE_LOW:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_LOW;
-			break;
-		case RESETGPIO_FORCE_HIGH:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_HIGH;
-			break;
-		};
-
-	if (mode)
-		pxa_gpio_mode(mode);
-}
-
 unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	unsigned short val = -1;
@@ -174,12 +137,11 @@ static inline void pxa_ac97_warm_pxa27x(void)
 {
 	gsr_bits = 0;
 
-	/* warm reset broken on Bulverde,
-	   so manually keep AC97 reset high */
-	set_resetgpio_mode(RESETGPIO_FORCE_HIGH);
+	/* warm reset broken on Bulverde, so manually keep AC97 reset high */
+	pxa27x_assert_ac97reset(reset_gpio, 1);
 	udelay(10);
 	GCR |= GCR_WARM_RST;
-	set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
+	pxa27x_assert_ac97reset(reset_gpio, 0);
 	udelay(500);
 }
 
@@ -385,7 +347,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 
 	if (cpu_is_pxa27x()) {
 		/* Use GPIO 113 as AC97 Reset on Bulverde */
-		set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
+		pxa27x_assert_ac97reset(reset_gpio, 0);
 		ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
 		if (IS_ERR(ac97conf_clk)) {
 			ret = PTR_ERR(ac97conf_clk);
-- 
1.6.3.3
