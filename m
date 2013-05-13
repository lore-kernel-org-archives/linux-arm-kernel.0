From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:22 +0400
Subject: [PATCH RESEND v2 2/3] ARM: clps711x: Re-add GPIO support
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_initcall was been removed from GPIO driver, so this patch
re-add support for GPIO into boards as platform_device.
Since some drivers (spi, nand, etc.) is not support deferred probe,
separate machine init calls is used in board code to make proper
loading sequence.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Makefile         |  5 +---
 arch/arm/mach-clps711x/board-autcpu12.c |  2 ++
 arch/arm/mach-clps711x/board-cdb89712.c |  2 ++
 arch/arm/mach-clps711x/board-edb7211.c  |  7 +++++
 arch/arm/mach-clps711x/board-p720t.c    | 10 ++++---
 arch/arm/mach-clps711x/devices.c        | 48 +++++++++++++++++++++++++++++++++
 arch/arm/mach-clps711x/devices.h        | 12 +++++++++
 7 files changed, 78 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/devices.c
 create mode 100644 arch/arm/mach-clps711x/devices.h

diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 992995a..f30ed2b 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -4,10 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= common.o
-obj-m			:=
-obj-n			:=
-obj-			:=
+obj-y				:= common.o devices.o
 
 obj-$(CONFIG_ARCH_AUTCPU12)	+= board-autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712)	+= board-cdb89712.o
diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f385847..1e22cb4 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -43,6 +43,7 @@
 #include <mach/autcpu12.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define AUTCPU12_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
 #define AUTCPU12_CS8900_IRQ	(IRQ_EINT3)
@@ -149,6 +150,7 @@ static struct platform_device autcpu12_mmgpio_pdev __initdata = {
 
 static void __init autcpu12_init(void)
 {
+	clps711x_devices_init();
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index baab7da..a80ae57 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define CDB89712_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
 #define CDB89712_CS8900_IRQ	(IRQ_EINT3)
@@ -127,6 +128,7 @@ static struct platform_device cdb89712_sram_pdev __initdata = {
 
 static void __init cdb89712_init(void)
 {
+	clps711x_devices_init();
 	platform_device_register(&cdb89712_flash_pdev);
 	platform_device_register(&cdb89712_bootrom_pdev);
 	platform_device_register(&cdb89712_sram_pdev);
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 5f928e9..e1c5573 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define VIDEORAM_SIZE		SZ_128K
 
@@ -151,6 +152,11 @@ fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
 
 static void __init edb7211_init(void)
 {
+	clps711x_devices_init();
+}
+
+static void __init edb7211_init_late(void)
+{
 	gpio_request_array(edb7211_gpios, ARRAY_SIZE(edb7211_gpios));
 
 	platform_device_register(&edb7211_flash_pdev);
@@ -175,6 +181,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
+	.init_late	= edb7211_init_late,
 	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 8d3ee67..48d0737 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -43,6 +43,7 @@
 #include <video/platform_lcd.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define P720T_USERLED		CLPS711X_GPIO(3, 0)
 #define P720T_NAND_CLE		CLPS711X_GPIO(4, 0)
@@ -199,6 +200,11 @@ static struct gpio_led_platform_data p720t_gpio_led_pdata __initdata = {
 
 static void __init p720t_init(void)
 {
+	clps711x_devices_init();
+}
+
+static void __init p720t_init_late(void)
+{
 	platform_device_register(&p720t_nand_pdev);
 	platform_device_register_data(&platform_bus, "platform-lcd", 0,
 				      &p720t_lcd_power_pdata,
@@ -207,10 +213,6 @@ static void __init p720t_init(void)
 				      &p720t_lcd_backlight_pdata,
 				      sizeof(p720t_lcd_backlight_pdata));
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
-}
-
-static void __init p720t_init_late(void)
-{
 	platform_device_register_data(&platform_bus, "leds-gpio", 0,
 				      &p720t_gpio_led_pdata,
 				      sizeof(p720t_gpio_led_pdata));
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
new file mode 100644
index 0000000..21161ed
--- /dev/null
+++ b/arch/arm/mach-clps711x/devices.c
@@ -0,0 +1,48 @@
+/*
+ *  CLPS711X common devices definitions
+ *
+ *  Author: Alexander Shiyan <shc_work@mail.ru>, 2013
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+
+static const phys_addr_t clps711x_gpios[][2] __initconst = {
+	{ PADR, PADDR },
+	{ PBDR, PBDDR },
+	{ PCDR, PCDDR },
+	{ PDDR, PDDDR },
+	{ PEDR, PEDDR },
+};
+
+static void __init clps711x_add_gpio(void)
+{
+	unsigned i;
+	struct resource gpio_res[2];
+
+	memset(gpio_res, 0, sizeof(gpio_res));
+
+	gpio_res[0].flags = IORESOURCE_MEM;
+	gpio_res[1].flags = IORESOURCE_MEM;
+
+	for (i = 0; i < ARRAY_SIZE(clps711x_gpios); i++) {
+		gpio_res[0].start = CLPS711X_PHYS_BASE + clps711x_gpios[i][0];
+		gpio_res[0].end = gpio_res[0].start;
+		gpio_res[1].start = CLPS711X_PHYS_BASE + clps711x_gpios[i][1];
+		gpio_res[1].end = gpio_res[1].start;
+
+		platform_device_register_simple("clps711x-gpio", i,
+						gpio_res, ARRAY_SIZE(gpio_res));
+	}
+}
+
+void __init clps711x_devices_init(void)
+{
+	clps711x_add_gpio();
+}
diff --git a/arch/arm/mach-clps711x/devices.h b/arch/arm/mach-clps711x/devices.h
new file mode 100644
index 0000000..a5efc17
--- /dev/null
+++ b/arch/arm/mach-clps711x/devices.h
@@ -0,0 +1,12 @@
+/*
+ *  CLPS711X common devices definitions
+ *
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+void clps711x_devices_init(void);
-- 
1.8.1.5
