From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 14:09:24 +0000
Subject: [PATCH 1/3] ARM: sa1100/assabet: add gpio keys support for right-hand
 two buttons
In-Reply-To: <20181128140842.GH30658@n2100.armlinux.org.uk>
References: <20181128140842.GH30658@n2100.armlinux.org.uk>
Message-ID: <E1gS0Wq-0000qk-Se@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio keys support for the right-hand two buttons on the Assabet,
which can be used to wake up the CPU after PM.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 3e8c0948abcc..53afea52a961 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio_keys.h>
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/regulator/fixed.h>
@@ -479,6 +480,30 @@ static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
 	},
 };
 
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
@@ -533,6 +558,11 @@ static void __init assabet_init(void)
 
 	}
 
+	platform_device_register_resndata(NULL, "gpio-keys", 0,
+					  NULL, 0,
+					  &assabet_keys_pdata,
+					  sizeof(assabet_keys_pdata));
+
 #ifndef ASSABET_PAL_VIDEO
 	sa11x0_register_lcd(&lq039q2ds54_info);
 #else
-- 
2.7.4
