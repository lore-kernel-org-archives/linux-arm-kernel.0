From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 17 Feb 2012 09:57:22 +0800
Subject: [PATCH RESNED] pxa/hx4700: add platform device and I2C info for
 AK4641 codec
Message-ID: <1329443842.3284.4.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio on hx4700 needs this to properly work.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Marek Vasut <marek.vasut@gmail.com>
Tested-by: Paul Parsons <lost.distance@yahoo.com>
Cc: stable at vger.kernel.org [3.0+]
---
Hi Eric, Haojian,
The audio on hx4700 needs this patch to properly work.
Any chance to apply it for 3.3?
I also add CC stable for 3.0+ in the commit log, this patch is required
since commit c26f64 "ASoC: add iPAQ hx4700 machine driver".

Regards,
Axel
 arch/arm/mach-pxa/hx4700.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index fb9b62d..208eef1 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -45,6 +45,7 @@
 #include <mach/hx4700.h>
 #include <mach/irda.h>
 
+#include <sound/ak4641.h>
 #include <video/platform_lcd.h>
 #include <video/w100fb.h>
 
@@ -765,6 +766,28 @@ static struct i2c_board_info __initdata pi2c_board_info[] = {
 };
 
 /*
+ * Asahi Kasei AK4641 on I2C
+ */
+
+static struct ak4641_platform_data ak4641_info = {
+	.gpio_power = GPIO27_HX4700_CODEC_ON,
+	.gpio_npdn  = GPIO109_HX4700_CODEC_nPDN,
+};
+
+static struct i2c_board_info i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("ak4641", 0x12),
+		.platform_data = &ak4641_info,
+	},
+};
+
+static struct platform_device audio = {
+	.name	= "hx4700-audio",
+	.id	= -1,
+};
+
+
+/*
  * PCMCIA
  */
 
@@ -790,6 +813,7 @@ static struct platform_device *devices[] __initdata = {
 	&gpio_vbus,
 	&power_supply,
 	&strataflash,
+	&audio,
 	&pcmcia,
 };
 
@@ -827,6 +851,7 @@ static void __init hx4700_init(void)
 	pxa_set_ficp_info(&ficp_info);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(i2c_board_info));
 	i2c_register_board_info(1, ARRAY_AND_SIZE(pi2c_board_info));
 	pxa2xx_set_spi_info(2, &pxa_ssp2_master_info);
 	spi_register_board_info(ARRAY_AND_SIZE(tsc2046_board_info));
-- 
1.7.5.4
