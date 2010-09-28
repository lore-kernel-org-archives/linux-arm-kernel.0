From: arun.murthy@stericsson.com (Arun Murthy)
Date: Tue, 28 Sep 2010 16:05:33 +0530
Subject: [PATCH 6/7] pwm: move existing pwm driver to drivers/pwm
In-Reply-To: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
Message-ID: <1285670134-18063-7-git-send-email-arun.murthy@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of now only ab8500 and twl6030 are moved.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mfd/Kconfig                              |    9 ---------
 drivers/mfd/Makefile                             |    1 -
 drivers/misc/Kconfig                             |    9 ---------
 drivers/misc/Makefile                            |    1 -
 drivers/pwm/Kconfig                              |   18 ++++++++++++++++++
 drivers/pwm/Makefile                             |    3 +++
 drivers/{misc/ab8500-pwm.c => pwm/pwm-ab8500.c}  |    0
 drivers/{mfd/twl6030-pwm.c => pwm/pwm-twl6040.c} |    0
 8 files changed, 21 insertions(+), 20 deletions(-)
 rename drivers/{misc/ab8500-pwm.c => pwm/pwm-ab8500.c} (100%)
 rename drivers/{mfd/twl6030-pwm.c => pwm/pwm-twl6040.c} (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 256fabd..ab1d376 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -186,15 +186,6 @@ config TWL4030_CODEC
 	select MFD_CORE
 	default n
 
-config TWL6030_PWM
-	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
-	depends on TWL4030_CORE
-	select HAVE_PWM
-	default n
-	help
-	  Say yes here if you want support for TWL6030 PWM.
-	  This is used to control charging LED brightness.
-
 config MFD_STMPE
 	bool "Support STMicroelectronics STMPE"
 	depends on I2C=y && GENERIC_HARDIRQS
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d5968cd..1a89dbf 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
 obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
-obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13783)	+= mc13783-core.o
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ff8ea55..2c38d4e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -62,15 +62,6 @@ config ATMEL_PWM
 	  purposes including software controlled power-efficient backlights
 	  on LCD displays, motor control, and waveform generation.
 
-config AB8500_PWM
-	bool "AB8500 PWM support"
-	depends on AB8500_CORE
-	select HAVE_PWM
-	help
-	  This driver exports functions to enable/disble/config/free Pulse
-	  Width Modulation in the Analog Baseband Chip AB8500.
-	  It is used by led and backlight driver to control the intensity.
-
 config ATMEL_TCLIB
 	bool "Atmel AT32/AT91 Timer/Counter Library"
 	depends on (AVR32 || ARCH_AT91)
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5da82965..21b4761 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -35,5 +35,4 @@ obj-y				+= eeprom/
 obj-y				+= cb710/
 obj-$(CONFIG_VMWARE_BALLOON)	+= vmware_balloon.o
 obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
-obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
 obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a88640c..e347365 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -14,4 +14,22 @@ menuconfig PWM_DEVICES
 
 if PWM_DEVICES
 
+config AB8500_PWM
+	bool "AB8500 PWM support"
+	depends on AB8500_CORE
+	select HAVE_PWM
+	help
+	  This driver exports functions to enable/disble/config/free Pulse
+	  Width Modulation in the Analog Baseband Chip AB8500.
+	  It is used by led and backlight driver to control the intensity.
+
+config TWL6030_PWM
+	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
+	depends on TWL4030_CORE
+	select HAVE_PWM
+	default n
+	help
+	  Say yes here if you want support for TWL6030 PWM.
+	  This is used to control charging LED brightness.
+
 endif # PWM_DEVICES
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 552f969..f35afb4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_PWM_DEVICES)	+= pwm-core.o
+
+obj-$(CONFIG_AB8500_PWM)	+= pwm-ab8500.o
+obj-$(CONFIG_TWL6030_PWM)	+= pwm-twl6030.o
diff --git a/drivers/misc/ab8500-pwm.c b/drivers/pwm/pwm-ab8500.c
similarity index 100%
rename from drivers/misc/ab8500-pwm.c
rename to drivers/pwm/pwm-ab8500.c
diff --git a/drivers/mfd/twl6030-pwm.c b/drivers/pwm/pwm-twl6040.c
similarity index 100%
rename from drivers/mfd/twl6030-pwm.c
rename to drivers/pwm/pwm-twl6040.c
-- 
1.7.2.dirty
