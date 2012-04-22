From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 Apr 2012 23:24:00 +0200
Subject: [PATCH] arch/arm: mioa701 add camera output enable gpio
Message-ID: <1335129840-25387-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Micron MT9M111 camera chip needs its output enable to be
activated in order to work. The bootloader is not required to
activate it, so do it in machine code.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/include/mach/mioa701.h |    3 +++
 arch/arm/mach-pxa/mioa701.c              |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mioa701.h b/arch/arm/mach-pxa/include/mach/mioa701.h
index 0286844..e57f5c7 100644
--- a/arch/arm/mach-pxa/include/mach/mioa701.h
+++ b/arch/arm/mach-pxa/include/mach/mioa701.h
@@ -61,6 +61,9 @@
 #define GPIO93_KEY_VOLUME_UP			93
 #define GPIO94_KEY_VOLUME_DOWN			94
 
+/* Camera */
+#define GPIO56_MT9M111_nOE			56
+
 extern struct input_dev *mioa701_evdev;
 extern void mioa701_gpio_lpm_set(unsigned long mfp_pin);
 
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 061d570..929c62b 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -103,6 +103,7 @@ static unsigned long mioa701_pin_config[] = {
 	GPIO82_CIF_DD_5,
 	GPIO84_CIF_FV,
 	GPIO85_CIF_LV,
+	MIO_CFG_OUT(GPIO56_MT9M111_nOE, AF0, DRIVE_LOW),
 
 	/* Bluetooth */
 	MIO_CFG_IN(GPIO14_BT_nACTIVITY, AF0),
@@ -705,6 +706,7 @@ static struct gpio global_gpios[] = {
 	{ GPIO9_CHARGE_EN, GPIOF_OUT_INIT_HIGH, "Charger enable" },
 	{ GPIO18_POWEROFF, GPIOF_OUT_INIT_LOW, "Power Off" },
 	{ GPIO87_LCD_POWER, GPIOF_OUT_INIT_LOW, "LCD Power" },
+	{ GPIO56_MT9M111_nOE, GPIOF_OUT_INIT_LOW, "Camera nOE" },
 };
 
 static void __init mioa701_machine_init(void)
-- 
1.7.5.4
