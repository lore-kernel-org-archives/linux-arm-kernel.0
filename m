From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 18:36:13 +0100
Subject: [RFC/PATCH 1/4] pxa: Remove INIT_CLKREG macro, replace it with the
 equivalent CLKDEV_INIT
Message-ID: <1331919373.31118.20.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLKDEV_INIT macro was added in 196a57c2749119be4732cc2b2adb8aafcb4fcb14
(ARM: 7131/1: clkdev: Add Common Macro for clk_lookup) for this purpose.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/clock.h   |    7 -----
 arch/arm/mach-pxa/eseries.c |    2 +-
 arch/arm/mach-pxa/pxa25x.c  |   42 ++++++++++++++++----------------
 arch/arm/mach-pxa/pxa27x.c  |   56 +++++++++++++++++++++---------------------
 arch/arm/mach-pxa/pxa300.c  |    6 ++--
 arch/arm/mach-pxa/pxa320.c  |    4 +-
 arch/arm/mach-pxa/pxa3xx.c  |   48 ++++++++++++++++++------------------
 arch/arm/mach-pxa/pxa95x.c  |   32 ++++++++++++------------
 8 files changed, 95 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index 3a258b1..2946fa2 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -22,13 +22,6 @@ void clk_dummy_disable(struct clk *);
 extern const struct clkops clk_dummy_ops;
 extern struct clk clk_dummy;
 
-#define INIT_CLKREG(_clk,_devname,_conname)		\
-	{						\
-		.clk		= _clk,			\
-		.dev_id		= _devname,		\
-		.con_id		= _conname,		\
-	}
-
 #define DEFINE_CK(_name, _cken, _ops)			\
 struct clk clk_##_name = {				\
 		.ops	= _ops,				\
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 4cb2391..3c29343 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -141,7 +141,7 @@ static struct clk tmio_dummy_clk = {
 };
 
 static struct clk_lookup eseries_clkregs[] = {
-	INIT_CLKREG(&tmio_dummy_clk, NULL, "CLK_CK32K"),
+	CLKDEV_INIT(NULL, "CLK_CK32K", &tmio_dummy_clk),
 };
 
 static void __init eseries_register_clks(void)
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 3352b37..99dd55e 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -189,30 +189,30 @@ static DEFINE_CLK(pxa25x_gpio12, &clk_pxa25x_gpio12_ops, 32768, 0);
 static DEFINE_CLK(pxa25x_mem, &clk_pxa25x_mem_ops, 0, 0);
 
 static struct clk_lookup pxa25x_clkregs[] = {
-	INIT_CLKREG(&clk_pxa25x_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa25x_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa25x_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa25x_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa25x_usb, "pxa25x-udc", NULL),
-	INIT_CLKREG(&clk_pxa25x_mmc, "pxa2xx-mci.0", NULL),
-	INIT_CLKREG(&clk_pxa25x_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa25x_ssp, "pxa25x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa25x_nssp, "pxa25x-nssp.1", NULL),
-	INIT_CLKREG(&clk_pxa25x_assp, "pxa25x-nssp.2", NULL),
-	INIT_CLKREG(&clk_pxa25x_pwm0, "pxa25x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa25x_pwm1, "pxa25x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa25x_i2s, "pxa2xx-i2s", NULL),
-	INIT_CLKREG(&clk_pxa25x_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa25x_ficp, "pxa2xx-ir", "FICPCLK"),
-	INIT_CLKREG(&clk_pxa25x_ac97, NULL, "AC97CLK"),
-	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
-	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
-	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
+	CLKDEV_INIT("pxa2xx-fb", NULL, &clk_pxa25x_lcd),
+	CLKDEV_INIT("pxa2xx-uart.0", NULL, &clk_pxa25x_ffuart),
+	CLKDEV_INIT("pxa2xx-uart.1", NULL, &clk_pxa25x_btuart),
+	CLKDEV_INIT("pxa2xx-uart.2", NULL, &clk_pxa25x_stuart),
+	CLKDEV_INIT("pxa25x-udc", NULL, &clk_pxa25x_usb),
+	CLKDEV_INIT("pxa2xx-mci.0", NULL, &clk_pxa25x_mmc),
+	CLKDEV_INIT("pxa2xx-i2c.0", NULL, &clk_pxa25x_i2c),
+	CLKDEV_INIT("pxa25x-ssp.0", NULL, &clk_pxa25x_ssp),
+	CLKDEV_INIT("pxa25x-nssp.1", NULL, &clk_pxa25x_nssp),
+	CLKDEV_INIT("pxa25x-nssp.2", NULL, &clk_pxa25x_assp),
+	CLKDEV_INIT("pxa25x-pwm.0", NULL, &clk_pxa25x_pwm0),
+	CLKDEV_INIT("pxa25x-pwm.1", NULL, &clk_pxa25x_pwm1),
+	CLKDEV_INIT("pxa2xx-i2s", NULL, &clk_pxa25x_i2s),
+	CLKDEV_INIT("pxa2xx-ir", "UARTCLK", &clk_pxa25x_stuart),
+	CLKDEV_INIT("pxa2xx-ir", "FICPCLK", &clk_pxa25x_ficp),
+	CLKDEV_INIT(NULL, "AC97CLK", &clk_pxa25x_ac97),
+	CLKDEV_INIT(NULL, "GPIO11_CLK", &clk_pxa25x_gpio11),
+	CLKDEV_INIT(NULL, "GPIO12_CLK", &clk_pxa25x_gpio12),
+	CLKDEV_INIT("pxa2xx-pcmcia", NULL, &clk_pxa25x_mem),
+	CLKDEV_INIT("pxa-gpio", NULL, &clk_dummy),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
-	INIT_CLKREG(&clk_pxa25x_hwuart, "pxa2xx-uart.3", NULL);
+	CLKDEV_INIT("pxa2xx-uart.3", NULL, &clk_pxa25x_hwuart);
 
 #ifdef CONFIG_PM
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6bce78e..2ece3e2 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -202,34 +202,34 @@ static DEFINE_CK(pxa27x_camera, CAMERA, &clk_pxa27x_lcd_ops);
 static DEFINE_CLK(pxa27x_mem, &clk_pxa27x_mem_ops, 0, 0);
 
 static struct clk_lookup pxa27x_clkregs[] = {
-	INIT_CLKREG(&clk_pxa27x_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa27x_camera, "pxa27x-camera.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa27x_i2s, "pxa2xx-i2s", NULL),
-	INIT_CLKREG(&clk_pxa27x_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_usb, "pxa27x-udc", NULL),
-	INIT_CLKREG(&clk_pxa27x_mmc, "pxa2xx-mci.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa27x_ficp, "pxa2xx-ir", "FICPCLK"),
-	INIT_CLKREG(&clk_pxa27x_usbhost, "pxa27x-ohci", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwri2c, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp1, "pxa27x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp2, "pxa27x-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_ssp3, "pxa27x-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwm0, "pxa27x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa27x_pwm1, "pxa27x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa27x_ac97, NULL, "AC97CLK"),
-	INIT_CLKREG(&clk_pxa27x_ac97conf, NULL, "AC97CONFCLK"),
-	INIT_CLKREG(&clk_pxa27x_msl, NULL, "MSLCLK"),
-	INIT_CLKREG(&clk_pxa27x_usim, NULL, "USIMCLK"),
-	INIT_CLKREG(&clk_pxa27x_memstk, NULL, "MSTKCLK"),
-	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
-	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
-	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
+	CLKDEV_INIT("pxa2xx-fb", NULL, &clk_pxa27x_lcd),
+	CLKDEV_INIT("pxa27x-camera.0", NULL, &clk_pxa27x_camera),
+	CLKDEV_INIT("pxa2xx-uart.0", NULL, &clk_pxa27x_ffuart),
+	CLKDEV_INIT("pxa2xx-uart.1", NULL, &clk_pxa27x_btuart),
+	CLKDEV_INIT("pxa2xx-uart.2", NULL, &clk_pxa27x_stuart),
+	CLKDEV_INIT("pxa2xx-i2s", NULL, &clk_pxa27x_i2s),
+	CLKDEV_INIT("pxa2xx-i2c.0", NULL, &clk_pxa27x_i2c),
+	CLKDEV_INIT("pxa27x-udc", NULL, &clk_pxa27x_usb),
+	CLKDEV_INIT("pxa2xx-mci.0", NULL, &clk_pxa27x_mmc),
+	CLKDEV_INIT("pxa2xx-ir", "UARTCLK", &clk_pxa27x_stuart),
+	CLKDEV_INIT("pxa2xx-ir", "FICPCLK", &clk_pxa27x_ficp),
+	CLKDEV_INIT("pxa27x-ohci", NULL, &clk_pxa27x_usbhost),
+	CLKDEV_INIT("pxa2xx-i2c.1", NULL, &clk_pxa27x_pwri2c),
+	CLKDEV_INIT("pxa27x-keypad", NULL, &clk_pxa27x_keypad),
+	CLKDEV_INIT("pxa27x-ssp.0", NULL, &clk_pxa27x_ssp1),
+	CLKDEV_INIT("pxa27x-ssp.1", NULL, &clk_pxa27x_ssp2),
+	CLKDEV_INIT("pxa27x-ssp.2", NULL, &clk_pxa27x_ssp3),
+	CLKDEV_INIT("pxa27x-pwm.0", NULL, &clk_pxa27x_pwm0),
+	CLKDEV_INIT("pxa27x-pwm.1", NULL, &clk_pxa27x_pwm1),
+	CLKDEV_INIT(NULL, "AC97CLK", &clk_pxa27x_ac97),
+	CLKDEV_INIT(NULL, "AC97CONFCLK", &clk_pxa27x_ac97conf),
+	CLKDEV_INIT(NULL, "MSLCLK", &clk_pxa27x_msl),
+	CLKDEV_INIT(NULL, "USIMCLK", &clk_pxa27x_usim),
+	CLKDEV_INIT(NULL, "MSTKCLK", &clk_pxa27x_memstk),
+	CLKDEV_INIT(NULL, "IMCLK", &clk_pxa27x_im),
+	CLKDEV_INIT(NULL, "MEMCLK", &clk_pxa27x_memc),
+	CLKDEV_INIT("pxa2xx-pcmcia", NULL, &clk_pxa27x_mem),
+	CLKDEV_INIT("pxa-gpio", NULL, &clk_dummy),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index 40bb165..0cdab8c 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -87,14 +87,14 @@ static DEFINE_PXA3_CKEN(common_nand, NAND, 156000000, 0);
 static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
 
 static struct clk_lookup common_clkregs[] = {
-	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
+	CLKDEV_INIT("pxa3xx-nand", NULL, &clk_common_nand),
+	CLKDEV_INIT("pxa3xx-gcu", NULL, &clk_gcu),
 };
 
 static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
 
 static struct clk_lookup pxa310_clkregs[] = {
-	INIT_CLKREG(&clk_pxa310_mmc3, "pxa2xx-mci.2", NULL),
+	CLKDEV_INIT("pxa2xx-mci.2", NULL, &clk_pxa310_mmc3),
 };
 
 static int __init pxa300_init(void)
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index 8d614ec..994e991 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -81,8 +81,8 @@ static DEFINE_PXA3_CKEN(pxa320_nand, NAND, 104000000, 0);
 static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
 
 static struct clk_lookup pxa320_clkregs[] = {
-	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
+	CLKDEV_INIT("pxa3xx-nand", NULL, &clk_pxa320_nand),
+	CLKDEV_INIT("pxa3xx-gcu", NULL, &clk_gcu),
 };
 
 static int __init pxa320_init(void)
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 3918a67..25a093e 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -64,31 +64,31 @@ static DEFINE_CK(pxa3xx_ac97, AC97, &clk_pxa3xx_ac97_ops);
 static DEFINE_CLK(pxa3xx_pout, &clk_pxa3xx_pout_ops, 13000000, 70);
 
 static struct clk_lookup pxa3xx_clkregs[] = {
-	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
+	CLKDEV_INIT(NULL, "CLK_POUT", &clk_pxa3xx_pout),
 	/* Power I2C clock is always on */
-	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
-	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
-	INIT_CLKREG(&clk_pxa3xx_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa3xx_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa3xx_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_udc, "pxa27x-udc", NULL),
-	INIT_CLKREG(&clk_pxa3xx_usbh, "pxa27x-ohci", NULL),
-	INIT_CLKREG(&clk_pxa3xx_u2d, "pxa3xx-u2d", NULL),
-	INIT_CLKREG(&clk_pxa3xx_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa27x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa27x-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp3, "pxa27x-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp4, "pxa27x-ssp.3", NULL),
-	INIT_CLKREG(&clk_pxa3xx_pwm0, "pxa27x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_pwm1, "pxa27x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa-gpio", NULL),
+	CLKDEV_INIT("pxa3xx-pwri2c.1", NULL, &clk_dummy),
+	CLKDEV_INIT("pxa2xx-fb", NULL, &clk_pxa3xx_lcd),
+	CLKDEV_INIT(NULL, "CAMCLK", &clk_pxa3xx_camera),
+	CLKDEV_INIT(NULL, "AC97CLK", &clk_pxa3xx_ac97),
+	CLKDEV_INIT("pxa2xx-uart.0", NULL, &clk_pxa3xx_ffuart),
+	CLKDEV_INIT("pxa2xx-uart.1", NULL, &clk_pxa3xx_btuart),
+	CLKDEV_INIT("pxa2xx-uart.2", NULL, &clk_pxa3xx_stuart),
+	CLKDEV_INIT("pxa2xx-ir", "UARTCLK", &clk_pxa3xx_stuart),
+	CLKDEV_INIT("pxa2xx-i2c.0", NULL, &clk_pxa3xx_i2c),
+	CLKDEV_INIT("pxa27x-udc", NULL, &clk_pxa3xx_udc),
+	CLKDEV_INIT("pxa27x-ohci", NULL, &clk_pxa3xx_usbh),
+	CLKDEV_INIT("pxa3xx-u2d", NULL, &clk_pxa3xx_u2d),
+	CLKDEV_INIT("pxa27x-keypad", NULL, &clk_pxa3xx_keypad),
+	CLKDEV_INIT("pxa27x-ssp.0", NULL, &clk_pxa3xx_ssp1),
+	CLKDEV_INIT("pxa27x-ssp.1", NULL, &clk_pxa3xx_ssp2),
+	CLKDEV_INIT("pxa27x-ssp.2", NULL, &clk_pxa3xx_ssp3),
+	CLKDEV_INIT("pxa27x-ssp.3", NULL, &clk_pxa3xx_ssp4),
+	CLKDEV_INIT("pxa27x-pwm.0", NULL, &clk_pxa3xx_pwm0),
+	CLKDEV_INIT("pxa27x-pwm.1", NULL, &clk_pxa3xx_pwm1),
+	CLKDEV_INIT("pxa2xx-mci.0", NULL, &clk_pxa3xx_mmc1),
+	CLKDEV_INIT("pxa2xx-mci.1", NULL, &clk_pxa3xx_mmc2),
+	CLKDEV_INIT("pxa2xx-pcmcia", NULL, &clk_pxa3xx_smemc),
+	CLKDEV_INIT("pxa-gpio", NULL, &clk_pxa3xx_gpio),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 5ce434b..2b29a45 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -214,23 +214,23 @@ static DEFINE_PXA3_CKEN(pxa95x_pwm1, PWM1, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_gpio, GPIO, 13000000, 0);
 
 static struct clk_lookup pxa95x_clkregs[] = {
-	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
+	CLKDEV_INIT(NULL, "CLK_POUT", &clk_pxa95x_pout),
 	/* Power I2C clock is always on */
-	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
-	INIT_CLKREG(&clk_pxa95x_lcd, "pxa2xx-fb", NULL),
-	INIT_CLKREG(&clk_pxa95x_ffuart, "pxa2xx-uart.0", NULL),
-	INIT_CLKREG(&clk_pxa95x_btuart, "pxa2xx-uart.1", NULL),
-	INIT_CLKREG(&clk_pxa95x_stuart, "pxa2xx-uart.2", NULL),
-	INIT_CLKREG(&clk_pxa95x_stuart, "pxa2xx-ir", "UARTCLK"),
-	INIT_CLKREG(&clk_pxa95x_i2c, "pxa2xx-i2c.0", NULL),
-	INIT_CLKREG(&clk_pxa95x_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa95x_ssp1, "pxa27x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa95x_ssp2, "pxa27x-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa95x_ssp3, "pxa27x-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa95x_ssp4, "pxa27x-ssp.3", NULL),
-	INIT_CLKREG(&clk_pxa95x_pwm0, "pxa27x-pwm.0", NULL),
-	INIT_CLKREG(&clk_pxa95x_pwm1, "pxa27x-pwm.1", NULL),
-	INIT_CLKREG(&clk_pxa95x_gpio, "pxa-gpio", NULL),
+	CLKDEV_INIT("pxa3xx-pwri2c.1", NULL, &clk_dummy),
+	CLKDEV_INIT("pxa2xx-fb", NULL, &clk_pxa95x_lcd),
+	CLKDEV_INIT("pxa2xx-uart.0", NULL, &clk_pxa95x_ffuart),
+	CLKDEV_INIT("pxa2xx-uart.1", NULL, &clk_pxa95x_btuart),
+	CLKDEV_INIT("pxa2xx-uart.2", NULL, &clk_pxa95x_stuart),
+	CLKDEV_INIT("pxa2xx-ir", "UARTCLK", &clk_pxa95x_stuart),
+	CLKDEV_INIT("pxa2xx-i2c.0", NULL, &clk_pxa95x_i2c),
+	CLKDEV_INIT("pxa27x-keypad", NULL, &clk_pxa95x_keypad),
+	CLKDEV_INIT("pxa27x-ssp.0", NULL, &clk_pxa95x_ssp1),
+	CLKDEV_INIT("pxa27x-ssp.1", NULL, &clk_pxa95x_ssp2),
+	CLKDEV_INIT("pxa27x-ssp.2", NULL, &clk_pxa95x_ssp3),
+	CLKDEV_INIT("pxa27x-ssp.3", NULL, &clk_pxa95x_ssp4),
+	CLKDEV_INIT("pxa27x-pwm.0", NULL, &clk_pxa95x_pwm0),
+	CLKDEV_INIT("pxa27x-pwm.1", NULL, &clk_pxa95x_pwm1),
+	CLKDEV_INIT("pxa-gpio", NULL, &clk_pxa95x_gpio),
 };
 
 void __init pxa95x_init_irq(void)
-- 
1.7.9.1
