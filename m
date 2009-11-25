From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:26 +0100
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-13-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   68 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 43a8195..1516990 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -33,6 +33,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/lis3lv02d.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -561,6 +562,64 @@ static struct spi_board_info controller_spi_devices[] __initdata = {
 	SPI_LIS3,
 };
 
+/**
+ * Audio related things
+ */
+void raumfeld_enable_audio(bool en)
+{
+	if (!machine_is_raumfeld_speaker() &&
+	    !machine_is_raumfeld_connector())
+		return;
+
+	if (en) {
+		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 1);
+		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 1);
+
+		/* wait some time to let VA and the clocks become stable */
+		schedule_timeout(HZ/10);
+
+		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 1);
+		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 1);
+	} else {
+		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 0);
+		gpio_set_value(mfp_to_gpio(GPIO_SPDIF_RESET), 0);
+		gpio_set_value(mfp_to_gpio(GPIO_CODEC_RESET), 0);
+		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 0);
+	}
+}
+
+static void raumfeld_claim_audio_gpios(void)
+{
+	gpio_request(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), "Audio VA enable");
+	gpio_direction_output(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 0);
+
+	gpio_request(mfp_to_gpio(GPIO_MCLK_RESET), "MCLK reset");
+	gpio_direction_output(mfp_to_gpio(GPIO_MCLK_RESET), 0);
+
+	gpio_request(mfp_to_gpio(GPIO_CODEC_RESET), "cs4270 codec reset");
+	gpio_direction_output(mfp_to_gpio(GPIO_CODEC_RESET), 0);
+
+	gpio_request(mfp_to_gpio(GPIO_SPDIF_RESET), "ak4104 s/pdif reset");
+	gpio_direction_output(mfp_to_gpio(GPIO_SPDIF_RESET), 0);
+}
+
+static mfp_cfg_t raumfeld_ssp1_pin_config[] = {
+	/* SSP for I2S */
+	GPIO85_SSP1_SCLK,
+	GPIO89_SSP1_EXTCLK,
+	GPIO86_SSP1_FRM,
+	GPIO87_SSP1_TXD,
+	GPIO88_SSP1_RXD,
+	GPIO90_SSP1_SYSCLK,
+};
+
+static mfp_cfg_t raumfeld_ssp2_pin_config[] = {
+	GPIO25_SSP2_SCLK,
+	GPIO26_SSP2_FRM,
+	GPIO27_SSP2_TXD,
+	GPIO29_SSP2_EXTCLK,
+};
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
@@ -613,9 +672,14 @@ static void __init raumfeld_controller_init(void)
 
 static void __init raumfeld_connector_init(void)
 {
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp1_pin_config));
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp2_pin_config));
 	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
 	raumfeld_common_init();
 	raumfeld_eth_init();
+
+	raumfeld_claim_audio_gpios();
+	raumfeld_enable_audio(true);
 }
 
 static void __init raumfeld_speaker_init(void)
@@ -624,11 +688,15 @@ static void __init raumfeld_speaker_init(void)
 		&rotary_encoder_device,
 	};
 
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_ssp1_pin_config));
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_speaker_devices));
 	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
 
 	raumfeld_common_init();
 	raumfeld_eth_init();
+
+	raumfeld_claim_audio_gpios();
+	raumfeld_enable_audio(true);
 }
 
 /* physical memory regions */
-- 
1.6.5.2
