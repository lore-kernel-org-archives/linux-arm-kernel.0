From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:31 +0400
Subject: [PATCH 01/15] ARM: clps711x: Load serial driver from boards
Message-ID: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently serial driver for CLPS711X is autoloaded if it compiled in kernel.
Since we may have multiple platforms into single kernel we should avoid
this. This patch removes this trick and adds registration of serial driver
into board support code.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/autcpu12.c |    6 +++---
 arch/arm/mach-clps711x/cdb89712.c |    9 ++++++++-
 arch/arm/mach-clps711x/clep7312.c |    9 +++++++--
 arch/arm/mach-clps711x/edb7211.c  |   11 +++++++++--
 arch/arm/mach-clps711x/fortunet.c |    9 ++++++++-
 arch/arm/mach-clps711x/p720t.c    |   11 +++++++++--
 drivers/tty/serial/clps711x.c     |   16 ----------------
 7 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index 214547b..f4f122d 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -68,16 +68,16 @@ static struct platform_device autcpu12_nvram_pdev __initdata = {
 
 static void __init autcpu12_init(void)
 {
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
 	platform_device_register(&autcpu12_nvram_pdev);
 }
 
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
-	.init_machine	= autcpu12_init,
 	.map_io		= autcpu12_map_io,
+	.init_machine	= autcpu12_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
-
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
index d90d25c..5a03888 100644
--- a/arch/arm/mach-clps711x/cdb89712.c
+++ b/arch/arm/mach-clps711x/cdb89712.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <asm/pgtable.h>
@@ -53,11 +54,17 @@ static void __init cdb89712_map_io(void)
 	iotable_init(cdb89712_io_desc, ARRAY_SIZE(cdb89712_io_desc));
 }
 
+static void __init cdb89712_init(void)
+{
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+}
+
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
 	.map_io		= cdb89712_map_io,
+	.init_machine	= cdb89712_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/clep7312.c
index dbc7842..0301b2c 100644
--- a/arch/arm/mach-clps711x/clep7312.c
+++ b/arch/arm/mach-clps711x/clep7312.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -33,14 +34,18 @@ fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
 	mi->bank[0].size = 0x01000000;
 }
 
+static void __init clep7312_init(void)
+{
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+}
 
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
 	.atag_offset	= 0x0100,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
+	.init_machine	= clep7312_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
-
diff --git a/arch/arm/mach-clps711x/edb7211.c b/arch/arm/mach-clps711x/edb7211.c
index 88f4690..119610b 100644
--- a/arch/arm/mach-clps711x/edb7211.c
+++ b/arch/arm/mach-clps711x/edb7211.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
 
 #include <asm/setup.h>
 #include <asm/mach/map.h>
@@ -76,13 +77,19 @@ fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
 	mi->nr_banks = 2;
 }
 
+static void __init edb7211_init(void)
+{
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+}
+
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
 	.atag_offset	= VIDEORAM_SIZE + 0x100,
 	.fixup		= fixup_edb7211,
-	.map_io		= edb7211_map_io,
 	.reserve	= edb7211_reserve,
+	.map_io		= edb7211_map_io,
+	.init_machine	= edb7211_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/fortunet.c
index 3a3f0b7..a7f8305 100644
--- a/arch/arm/mach-clps711x/fortunet.c
+++ b/arch/arm/mach-clps711x/fortunet.c
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <asm/setup.h>
@@ -72,11 +73,17 @@ fortunet_fixup(struct tag *tags, char **cmdline, struct meminfo *mi)
 	*mi = memmap;
 }
 
+static void __init fortunet_init(void)
+{
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+}
+
 MACHINE_START(FORTUNET, "ARM-FortuNet")
 	/* Maintainer: FortuNet Inc. */
 	.fixup		= fortunet_fixup,
 	.map_io		= clps711x_map_io,
+	.init_machine	= fortunet_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index dd89950..96d54d4 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <asm/pgtable.h>
@@ -161,13 +162,19 @@ static int __init p720t_leds_init(void)
 fs_initcall(p720t_leds_init);
 #endif
 
+static void __init p720t_init(void)
+{
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+}
+
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
 	.fixup		= fixup_p720t,
-	.init_early	= p720t_init_early,
 	.map_io		= p720t_map_io,
+	.init_early	= p720t_init_early,
+	.init_machine	= p720t_init,
 	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
 	.restart	= clps711x_restart,
+	.timer		= &clps711x_timer,
 MACHINE_END
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index a0a6db5..06f0e91 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -516,22 +516,6 @@ static struct platform_driver clps711x_uart_driver = {
 };
 module_platform_driver(clps711x_uart_driver);
 
-static struct platform_device clps711x_uart_device = {
-	.name	= UART_CLPS711X_NAME,
-};
-
-static int __init uart_clps711x_init(void)
-{
-	return platform_device_register(&clps711x_uart_device);
-}
-module_init(uart_clps711x_init);
-
-static void __exit uart_clps711x_exit(void)
-{
-	platform_device_unregister(&clps711x_uart_device);
-}
-module_exit(uart_clps711x_exit);
-
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
 MODULE_DESCRIPTION("CLPS711X serial driver");
 MODULE_LICENSE("GPL");
-- 
1.7.8.6
