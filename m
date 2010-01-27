From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Wed, 27 Jan 2010 14:58:58 +0900
Subject: [PATCHv2 03/10] ARM: S3C24XX: Update AC97 platform resources
Message-ID: <1264571938-15054-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Modify the AC97 platform backend so that the controller can be run
by the s3c-ac97.c

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c/include/plat/audio.h |    4 +++
 arch/arm/plat-s3c24xx/devs.c           |   45 ++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/audio.h b/arch/arm/plat-s3c/include/plat/audio.h
index e07c941..ac56821 100644
--- a/arch/arm/plat-s3c/include/plat/audio.h
+++ b/arch/arm/plat-s3c/include/plat/audio.h
@@ -16,6 +16,10 @@
 #define S3C64XX_AC97_GPE  1
 extern void s3c64xx_ac97_setup_gpio(int);
 
+#define S3C24XX_AC97_GPE0  0 /* gpe0-4 as AC97 */
+#define S3C24XX_AC97_GPE5  0 /* gpe5-9 as AC97 */
+extern void s3c24xx_ac97_setup_gpio(int);
+
 /**
  * struct s3c_audio_pdata - common platform data for audio device drivers
  * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 986d4e5..3805317 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -20,6 +20,7 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -34,9 +35,11 @@
 #include <plat/udc.h>
 #include <plat/mci.h>
 
+#include <plat/audio.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-spi.h>
+#include <mach/regs-gpio.h>
 
 #include <mach/ts.h>
 
@@ -459,6 +462,10 @@ struct platform_device s3c_device_camif = {
 
 EXPORT_SYMBOL(s3c_device_camif);
 
+#endif /* CONFIG_CPU_S32440 */
+
+#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2443)
+
 /* AC97 */
 
 static struct resource s3c_ac97_resource[] = {
@@ -494,17 +501,51 @@ static struct resource s3c_ac97_resource[] = {
 
 static u64 s3c_device_ac97_dmamask = 0xffffffffUL;
 
+static int s3c24xx_ac97_cfg_gpe0(struct platform_device *pdev)
+{
+	s3c2410_gpio_cfgpin(S3C2410_GPE0, S3C2443_GPE0_AC_nRESET);
+	s3c2410_gpio_cfgpin(S3C2410_GPE1, S3C2443_GPE1_AC_SYNC);
+	s3c2410_gpio_cfgpin(S3C2410_GPE2, S3C2443_GPE2_AC_BITCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE3, S3C2443_GPE3_AC_SDI);
+	s3c2410_gpio_cfgpin(S3C2410_GPE4, S3C2443_GPE4_AC_SDO);
+
+	return 0;
+}
+
+static int s3c24xx_ac97_cfg_gpe5(struct platform_device *pdev)
+{
+	s3c2410_gpio_cfgpin(S3C2410_GPE5, S3C2443_GPE5_AC_BITCLK);
+	s3c2410_gpio_cfgpin(S3C2410_GPE6, S3C2443_GPE6_AC_SDI);
+	s3c2410_gpio_cfgpin(S3C2410_GPE7, S3C2443_GPE7_AC_SDO);
+	s3c2410_gpio_cfgpin(S3C2410_GPE8, S3C2443_GPE8_AC_SYNC);
+	s3c2410_gpio_cfgpin(S3C2410_GPE9, S3C2443_GPE9_AC_nRESET);
+
+	return 0;
+}
+
+static struct s3c_audio_pdata s3c_ac97_pdata = {
+	.cfg_gpio = s3c24xx_ac97_cfg_gpe0,
+};
+
 struct platform_device s3c_device_ac97 = {
 	.name		  = "s3c-ac97",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c_ac97_resource),
 	.resource	  = s3c_ac97_resource,
 	.dev              = {
+		.platform_data = &s3c_ac97_pdata,
 		.dma_mask = &s3c_device_ac97_dmamask,
 		.coherent_dma_mask = 0xffffffffUL
 	}
 };
-
 EXPORT_SYMBOL(s3c_device_ac97);
 
-#endif // CONFIG_CPU_S32440
+void __init s3c24xx_ac97_setup_gpio(int num)
+{
+	if (num == S3C24XX_AC97_GPE0)
+		s3c_ac97_pdata.cfg_gpio = s3c24xx_ac97_cfg_gpe0;
+	else
+		s3c_ac97_pdata.cfg_gpio = s3c24xx_ac97_cfg_gpe5;
+}
+
+#endif
-- 
1.6.2.5
