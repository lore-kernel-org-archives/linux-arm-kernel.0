From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:44 +0200
Subject: [PATCH 09/16] arm/mx2/mbimx27: compile fixes with
	CONFIG_TOUCHSCREEN_ADS7846=y
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:166: error: expected identifier or '(' before '||' token
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:204: error: variable 'eukrea_mbimx27_spi_0_data' has initializer but incomplete type
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: error: unknown field 'chipselect' specified in initializer
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: warning: excess elements in struct initializer
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:205: warning: (near initialization for 'eukrea_mbimx27_spi_0_data')
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: error: unknown field 'num_chipselect' specified in initializer
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: warning: excess elements in struct initializer
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:206: warning: (near initialization for 'eukrea_mbimx27_spi_0_data')
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c: In function 'eukrea_mbimx27_baseboard_init':
	arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c:239: error: implicit declaration of function 'ads7846_dev_init'

While at it add TOUCHSCREEN_ADS7846=m to mx27_defconfig.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx27_defconfig              |    2 +-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index b4c1366..ceab3f9 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -623,7 +623,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
 CONFIG_INPUT_TOUCHSCREEN=y
-# CONFIG_TOUCHSCREEN_ADS7846 is not set
+CONFIG_TOUCHSCREEN_ADS7846=m
 # CONFIG_TOUCHSCREEN_AD7877 is not set
 # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
 # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index f3b169d..9e607a2 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -33,6 +33,7 @@
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/imx-uart.h>
+#include <mach/spi.h>
 
 #include "devices.h"
 
@@ -162,7 +163,7 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-#if defined(CONFIG_TOUCHSCREEN_ADS7846)
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
 #define ADS7846_PENDOWN (GPIO_PORTD | 25)
@@ -228,7 +229,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, NULL);
 
-#if defined(CONFIG_TOUCHSCREEN_ADS7846)
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 	/* SPI and ADS7846 Touchscreen controler init */
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
-- 
1.7.0
