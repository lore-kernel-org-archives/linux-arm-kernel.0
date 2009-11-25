From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:27 +0100
Subject: [PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-14-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   56 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 1516990..1b54778 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -34,6 +34,7 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/lis3lv02d.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -45,6 +46,7 @@
 #include <mach/pxa3xx_nand.h>
 #include <mach/ohci.h>
 #include <mach/pxafb.h>
+#include <mach/mmc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -116,6 +118,14 @@ static mfp_cfg_t raumfeld_pin_config[] __initdata = {
 	GPIO34_GPIO,	/* SPDIF_CS */
 	GPIO96_GPIO,	/* MCLK_CS */
 	GPIO125_GPIO,	/* ACCEL_CS */
+
+	/* MMC */
+	GPIO3_MMC1_DAT0,
+	GPIO4_MMC1_DAT1,
+	GPIO5_MMC1_DAT2,
+	GPIO6_MMC1_DAT3,
+	GPIO7_MMC1_CLK,
+	GPIO8_MMC1_CMD,
 };
 
 /*
@@ -620,6 +630,51 @@ static mfp_cfg_t raumfeld_ssp2_pin_config[] = {
 	GPIO29_SSP2_EXTCLK,
 };
 
+/**
+ * MMC for Marvell Libertas 8688 via SDIO
+ */
+
+#define WIFI_VOLTAGE	3300000
+
+static void raumfeld_mci_setpower(struct device *dev, unsigned int on)
+{
+	int ret = 0;
+	struct regulator *regulator = regulator_get(dev, "vcc_wifi");
+
+	/* bring up V6 for SDIO/WLAN */
+	if (IS_ERR(regulator)) {
+		printk(KERN_ERR "%s(): unable to get regulator. err = %ld\n",
+			__func__, PTR_ERR(regulator));
+		return;
+	}
+
+	if (on && !regulator_is_enabled(regulator)) {
+		ret = regulator_enable(regulator);
+		if (!ret)
+			ret = regulator_set_voltage(regulator,
+					WIFI_VOLTAGE, WIFI_VOLTAGE);
+	} else if (!on && regulator_is_enabled(regulator))
+		ret = regulator_disable(regulator);
+
+	if (ret)
+		printk(KERN_ERR "%s: unable to %sable regulator: ret = %d\n",
+				__func__, on ? "en" : "dis", ret);
+
+	regulator_put(regulator);
+
+	gpio_set_value(mfp_to_gpio(GPIO_W2W_RESET), on);
+	gpio_set_value(mfp_to_gpio(GPIO_W2W_PDN), on);
+}
+
+static struct pxamci_platform_data raumfeld_mci_platform_data = {
+	.detect_delay		= 20,
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.setpower		= raumfeld_mci_setpower,
+	.gpio_card_detect	= -1,
+	.gpio_card_ro		= -1,
+	.gpio_power		= -1,
+};
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
@@ -654,6 +709,7 @@ static void __init raumfeld_common_init(void)
 	pxa_set_ohci_info(&raumfeld_ohci_info);
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_common_devices));
 	pxa3xx_set_nand_info(&raumfeld_nand_info);
+	pxa_set_mci_info(&raumfeld_mci_platform_data);
 }
 
 static void __init raumfeld_controller_init(void)
-- 
1.6.5.2
