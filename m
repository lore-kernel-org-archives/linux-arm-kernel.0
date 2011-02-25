From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 13:49:58 +0100
Subject: [PATCH 2/2] mx3/eukrea_mbimxsd-baseboard: add SD card detect support
In-Reply-To: <1298638198-4175-1-git-send-email-eric@eukrea.com>
References: <1298638198-4175-1-git-send-email-eric@eukrea.com>
Message-ID: <1298638198-4175-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 3f67eb6..2e288b3 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -43,6 +43,7 @@
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/audmux.h>
+#include <mach/esdhc.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -163,11 +164,14 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
 	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* SD1 CD */
+	MX35_PAD_LD18__GPIO3_24,
 };
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 29)
 #define GPIO_SWITCH1	IMX_GPIO_NR(3, 25)
 #define GPIO_LCDPWR	IMX_GPIO_NR(1, 4)
+#define GPIO_SD1CD	IMX_GPIO_NR(3, 24)
 
 static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
@@ -254,6 +258,11 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.cd_gpio = GPIO_SD1CD,
+	.wp_gpio = -EINVAL,
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx35 init.
  *
@@ -289,7 +298,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx35_add_flexcan1(NULL);
-	imx35_add_sdhci_esdhc_imx(0, NULL);
+	imx35_add_sdhci_esdhc_imx(0, &sd1_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
-- 
1.7.4
