From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:35:33 +0200
Subject: [PATCH] [media] cobalt: add VIDEO_V4L2_SUBDEV_API dependency
Message-ID: <25194020.Fs8hi1GXzI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cobalt driver uses various encoders that require the VIDEO_V4L2_SUBDEV_API
code, but it does not have the dependency itself, so we get a build error
when it's not enabled:

warning: (VIDEO_COBALT) selects VIDEO_ADV7511 which has unmet direct dependencies (MEDIA_SUPPORT && VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API)
warning: (VIDEO_COBALT) selects VIDEO_ADV7604 which has unmet direct dependencies (MEDIA_SUPPORT && VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && (GPIOLIB || COMPILE_TEST))
warning: (VIDEO_COBALT) selects VIDEO_ADV7842 which has unmet direct dependencies (MEDIA_SUPPORT && VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API)
drivers/media/i2c/adv7604.c: In function 'adv76xx_get_format':
drivers/media/i2c/adv7604.c:1878:9: error: implicit declaration of function 'v4l2_subdev_get_try_format' [-Werror=implicit-function-declaration]

This adds an explicit dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on ARM randconfig builds

diff --git a/drivers/media/pci/cobalt/Kconfig b/drivers/media/pci/cobalt/Kconfig
index 1f88ccc174da..a7f750520757 100644
--- a/drivers/media/pci/cobalt/Kconfig
+++ b/drivers/media/pci/cobalt/Kconfig
@@ -1,6 +1,7 @@
 config VIDEO_COBALT
 	tristate "Cisco Cobalt support"
 	depends on VIDEO_V4L2 && I2C && MEDIA_CONTROLLER
+	depends on VIDEO_V4L2_SUBDEV_API
 	depends on PCI_MSI && MTD_COMPLEX_MAPPINGS
 	depends on GPIOLIB || COMPILE_TEST
 	depends on SND
