From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 12:03:01 +0100
Subject: [PATCH 1/3] ARM: sa1100/assabet: add gpio keys support for right-hand
 two buttons
In-Reply-To: <20160829110157.GE1041@n2100.armlinux.org.uk>
References: <20160829110157.GE1041@n2100.armlinux.org.uk>
Message-ID: <E1beKLF-00016u-Tz@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio keys support for the right-hand two buttons on the Assabet,
which can be used to wake up the CPU after PM.  This facilities S2R
testing.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 5c9a1e115847..0d473aa23a6c 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio_keys.h>
 #include <linux/gpio-reg.h>
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
@@ -493,6 +494,30 @@ static int assabet_register_fixed_regulator(int n,
 	return 0;
 }
 
+static struct gpio_keys_button assabet_keys_buttons[] = {
+	{
+		.gpio = 0,
+		.irq = IRQ_GPIO0,
+		.desc = "gpio0",
+		.wakeup = 1,
+		.can_disable = 1,
+		.debounce_interval = 5,
+	}, {
+		.gpio = 1,
+		.irq = IRQ_GPIO1,
+		.desc = "gpio1",
+		.wakeup = 1,
+		.can_disable = 1,
+		.debounce_interval = 5,
+	},
+};
+
+static const struct gpio_keys_platform_data assabet_keys_pdata = {
+	.buttons = assabet_keys_buttons,
+	.nbuttons = ARRAY_SIZE(assabet_keys_buttons),
+	.rep = 0,
+};
+
 static void __init assabet_init(void)
 {
 	/*
@@ -539,6 +564,11 @@ static void __init assabet_init(void)
 			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
 	} else {
+		platform_device_register_resndata(NULL, "gpio-keys", 0,
+						  NULL, 0,
+						  &assabet_keys_pdata,
+						  sizeof(assabet_keys_pdata));
+
 		assabet_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
 					 assabet_cf_vcc_consumers,
 					 ARRAY_SIZE(assabet_cf_vcc_consumers));
-- 
2.1.0
