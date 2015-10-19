From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:18 +0530
Subject: [PATCH 11/11] pinctrl: Rename gpio driver from cygnus to iproc
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-12-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename gpio driver file name from pinctrl-cygnus-gpio.c to
pinctrl-iproc-gpio.c to make it more generic so that all
iproc based future SoCs using the same gpio block could
use this driver.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pinctrl/bcm/Kconfig                        | 30 ++++++++++++++++------
 drivers/pinctrl/bcm/Makefile                       |  2 +-
 ...{pinctrl-cygnus-gpio.c => pinctrl-iproc-gpio.c} |  3 +--
 3 files changed, 24 insertions(+), 11 deletions(-)
 rename drivers/pinctrl/bcm/{pinctrl-cygnus-gpio.c => pinctrl-iproc-gpio.c} (99%)

diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
index cd11d4d..5949547 100644
--- a/drivers/pinctrl/bcm/Kconfig
+++ b/drivers/pinctrl/bcm/Kconfig
@@ -20,27 +20,41 @@ config PINCTRL_BCM2835
 	select PINMUX
 	select PINCONF
 
-config PINCTRL_CYGNUS_GPIO
-	bool "Broadcom Cygnus GPIO (with PINCONF) driver"
-	depends on OF_GPIO && ARCH_BCM_CYGNUS
+config PINCTRL_IPROC_GPIO
+	bool "Broadcom iProc GPIO (with PINCONF) driver"
+	depends on OF_GPIO && (ARCH_BCM_IPROC || COMPILE_TEST)
 	select GPIOLIB_IRQCHIP
 	select PINCONF
 	select GENERIC_PINCONF
-	default ARCH_BCM_CYGNUS
+	default ARCH_BCM_IPROC
 	help
-	  Say yes here to enable the Broadcom Cygnus GPIO driver.
+	  Say yes here to enable the Broadcom iProc GPIO driver.
+
+	  The Broadcom iProc based SoCs- Cygnus, NS2, NSP and Stingray, use
+	  same GPIO Controller IP hence this driver could be used for all.
 
 	  The Broadcom Cygnus SoC has 3 GPIO controllers including the ASIU
 	  GPIO controller (ASIU), the chipCommonG GPIO controller (CCM), and
 	  the always-ON GPIO controller (CRMU/AON). All 3 GPIO controllers are
 	  supported by this driver.
 
-	  All 3 Cygnus GPIO controllers support basic PINCONF functions such
+	  The Broadcom NSP has two GPIO controllers including the ChipcommonA
+	  GPIO, the ChipcommonB GPIO. Later controller is supported by this
+	  driver.
+
+	  The Broadcom NS2 has two GPIO controller including the CRMU GPIO,
+	  the ChipcommonG GPIO. Both controllers are supported by this driver.
+
+	  The Broadcom Stingray GPIO controllers are supported by this driver.
+
+	  All above SoCs GPIO controllers support basic PINCONF functions such
 	  as bias pull up, pull down, and drive strength configurations, when
 	  these pins are muxed to GPIO.
 
-	  Pins from the ASIU GPIO can be individually muxed to GPIO function,
-	  through interaction with the Cygnus IOMUX controller.
+	  It provides the framework where pins from the individual GPIO can be
+	  individually muxed to GPIO function, through interaction with the
+	  SoCs IOMUX controller. This features could be used only on SoCs which
+	  support individual pin muxing.
 
 config PINCTRL_CYGNUS_MUX
 	bool "Broadcom Cygnus IOMUX driver"
diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
index 2b2f70e..9ac6370 100644
--- a/drivers/pinctrl/bcm/Makefile
+++ b/drivers/pinctrl/bcm/Makefile
@@ -2,5 +2,5 @@
 
 obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
 obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
-obj-$(CONFIG_PINCTRL_CYGNUS_GPIO)	+= pinctrl-cygnus-gpio.o
+obj-$(CONFIG_PINCTRL_IPROC_GPIO)	+= pinctrl-iproc-gpio.o
 obj-$(CONFIG_PINCTRL_CYGNUS_MUX)	+= pinctrl-cygnus-mux.o
diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
similarity index 99%
rename from drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
rename to drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index ed21ab2..de09859 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -531,8 +531,7 @@ static int iproc_pin_config_get(struct pinctrl_dev *pctldev, unsigned pin,
 		ret = iproc_gpio_get_strength(chip, gpio, &arg);
 		if (ret)
 			return ret;
-		else
-			*config = pinconf_to_config_packed(param, arg);
+		*config = pinconf_to_config_packed(param, arg);
 
 		return 0;
 
-- 
1.9.1
