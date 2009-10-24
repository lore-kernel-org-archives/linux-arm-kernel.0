From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:30:56 +0400
Subject: [PATCH 18/20] SA1100: h3100/h3600: add support for gpio-keys
In-Reply-To: <1256416257-23003-1-git-send-email-mad_soft@inbox.ru>
References: <1256415979-22930-1-git-send-email-mad_soft@inbox.ru>
	<1256416257-23003-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256416257-23003-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for "Power" and "Action" (joystick center) buttons -
the only buttons on iPaq h3100/h3600 connected to GPIOs
(other buttons are controlled by microcontroller)
Also remove setting PWER for wakeup on Power button press -
gpio-keys driver will handle it.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3xxx.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index 2f85d1d..ec9d9db 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -12,6 +12,8 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -212,8 +214,44 @@ static struct platform_device h3xxx_egpio = {
 	},
 };
 
+/*
+ * GPIO keys
+ */
+
+static struct gpio_keys_button h3xxx_button_table[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= H3XXX_GPIO_PWR_BUTTON,
+		.desc		= "Power Button",
+		.active_low	= 1,
+		.type		= EV_KEY,
+		.wakeup		= 1,
+	}, {
+		.code		= KEY_ENTER,
+		.gpio		= H3XXX_GPIO_ACTION_BUTTON,
+		.active_low	= 1,
+		.desc		= "Action button",
+		.type		= EV_KEY,
+		.wakeup		= 0,
+	},
+};
+
+static struct gpio_keys_platform_data h3xxx_keys_data = {
+	.buttons  = h3xxx_button_table,
+	.nbuttons = ARRAY_SIZE(h3xxx_button_table),
+};
+
+static struct platform_device h3xxx_keys = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &h3xxx_keys_data,
+	},
+};
+
 static struct platform_device *h3xxx_devices[] = {
 	&h3xxx_egpio,
+	&h3xxx_keys,
 };
 
 void __init h3xxx_mach_init(void)
@@ -260,7 +298,6 @@ void __init h3xxx_map_io(void)
 
 	/* Configure suspend conditions */
 	PGSR = 0;
-	PWER = PWER_GPIO0;
 	PCFR = PCFR_OPDE;
 	PSDR = 0;
 
-- 
1.6.5.1.63.ga9d7.dirty
