From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  2 Mar 2015 13:35:58 +0100
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
Message-ID: <1425299763-4066822-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another prerequisite for enabling multiplatform
support, and it is the part I am least certain about.

I assume it will cause the extra boot message "Cannot
allocate irq_descs @ IRQ%d, assuming pre-allocated" to
be printed, but otherwise work ok. This definitely needs
to be tested on real hardware to see if it works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                             |  1 +
 arch/arm/mach-s3c64xx/common.c               |  1 +
 arch/arm/mach-s3c64xx/dev-uart.c             |  1 +
 arch/arm/mach-s3c64xx/include/mach/irqs.h    | 20 +++-----------------
 arch/arm/mach-s3c64xx/include/mach/pm-core.h |  1 +
 arch/arm/mach-s3c64xx/mach-anw6410.c         |  3 ++-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  2 ++
 arch/arm/mach-s3c64xx/mach-crag6410.c        |  2 ++
 arch/arm/mach-s3c64xx/mach-hmt.c             |  2 ++
 arch/arm/mach-s3c64xx/mach-mini6410.c        |  2 ++
 arch/arm/mach-s3c64xx/mach-ncp.c             |  2 ++
 arch/arm/mach-s3c64xx/mach-real6410.c        |  3 ++-
 arch/arm/mach-s3c64xx/mach-smartq5.c         |  2 ++
 arch/arm/mach-s3c64xx/mach-smartq7.c         |  2 ++
 arch/arm/mach-s3c64xx/mach-smdk6400.c        |  3 ++-
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |  3 ++-
 arch/arm/plat-samsung/gpio-samsung.c         |  1 +
 17 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98f113833465..a6f71e402b38 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -709,6 +709,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_ATAGS
 	select SAMSUNG_WAKEMASK
 	select SAMSUNG_WDT_RESET
+	select SPARSE_IRQ
 	help
 	  Samsung S3C64XX series based systems
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index cca29aa49fd3..971b4799f16d 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -40,6 +40,7 @@
 #include <asm/system_misc.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index 46e18d77ea93..a0b4f0329811 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -23,6 +23,7 @@
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <plat/devs.h>
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index 67bbd1dd04c2..3ceb00b5de07 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -156,25 +156,11 @@
 
 #define IRQ_EINT_GROUP(group, no)	(IRQ_EINT_GROUP##group##_BASE + (no))
 
-/* Define a group of interrupts for board-specific use (eg, for MFD
- * interrupt controllers). */
+/* Some boards have their own IRQs behind this */
 #define IRQ_BOARD_START (IRQ_EINT_GROUP9_BASE + IRQ_EINT_GROUP9_NR + 1)
 
-#ifdef CONFIG_MACH_WLF_CRAGG_6410
-#define IRQ_BOARD_NR 160
-#elif defined(CONFIG_SMDK6410_WM1190_EV1)
-#define IRQ_BOARD_NR 64
-#elif defined(CONFIG_SMDK6410_WM1192_EV1)
-#define IRQ_BOARD_NR 64
-#else
-#define IRQ_BOARD_NR 16
-#endif
-
-#define IRQ_BOARD_END (IRQ_BOARD_START + IRQ_BOARD_NR)
-
-/* Set the default NR_IRQS */
-
-#define NR_IRQS	(IRQ_BOARD_END + 1)
+/* Set the default nr_irqs, boards can override if necessary */
+#define S3C64XX_NR_IRQS	IRQ_BOARD_START
 
 /* Compatibility */
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index a30a1e3ffc6a..32d2ff54f82d 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -18,6 +18,7 @@
 #include <linux/serial_s3c.h>
 
 #include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
 
 static inline void s3c_pm_debug_init_uart(void)
 {
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 6224c67f5061..347ce6009a8c 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -47,6 +47,7 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <mach/irqs.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 #include <plat/samsung-time.h>
@@ -229,7 +230,7 @@ static void __init anw6410_machine_init(void)
 MACHINE_START(ANW6410, "A&W6410")
 	/* Maintainer: Kwangwoo Lee <kwangwoo.lee@gmail.com> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index be21f06e6b3f..571f95cc5a53 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -30,6 +30,8 @@
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #include <plat/cpu.h>
+#include <mach/irqs.h>
+
 #include "crag6410.h"
 
 static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 10b913baab28..f395a5617142 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -51,6 +51,7 @@
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 
 #include <plat/fb.h>
 #include <plat/sdhci.h>
@@ -854,6 +855,7 @@ static void __init crag6410_machine_init(void)
 MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS + 160,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index e4b087c58ee6..74f67c49f364 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -30,6 +30,7 @@
 #include <video/samsung_fimd.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -274,6 +275,7 @@ static void __init hmt_machine_init(void)
 MACHINE_START(HMT, "Airgoo-HMT")
 	/* Maintainer: Peter Korsgaard <jacmet@sunsite.dk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index ab61af50bfb9..3ce5842ed51b 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -41,6 +41,7 @@
 #include <linux/platform_data/mmc-sdhci-s3c.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
+#include <mach/irqs.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
@@ -363,6 +364,7 @@ static void __init mini6410_machine_init(void)
 MACHINE_START(MINI6410, "MINI6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 80cb1446f69f..23baaa04318c 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -31,6 +31,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
 
@@ -100,6 +101,7 @@ static void __init ncp_machine_init(void)
 MACHINE_START(NCP, "NCP")
 	/* Maintainer: Samsung Electronics */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 85fa9598b980..ca6548a1ed3b 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -33,6 +33,7 @@
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 
 #include <plat/adc.h>
 #include <plat/cpu.h>
@@ -331,7 +332,7 @@ static void __init real6410_machine_init(void)
 MACHINE_START(REAL6410, "REAL6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 33224ab36fac..0972b6ce0ef6 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 
 #include <video/samsung_fimd.h>
+#include <mach/irqs.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
@@ -153,6 +154,7 @@ static void __init smartq5_machine_init(void)
 MACHINE_START(SMARTQ5, "SmartQ 5")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index fc7fece22fb0..51ac1c6c654a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 
 #include <video/samsung_fimd.h>
+#include <mach/irqs.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
@@ -169,6 +170,7 @@ static void __init smartq7_machine_init(void)
 MACHINE_START(SMARTQ7, "SmartQ 7")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 6f425126a735..7d8a74fd8915 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -27,6 +27,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
 
@@ -88,7 +89,7 @@ static void __init smdk6400_machine_init(void)
 MACHINE_START(SMDK6400, "SMDK6400")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6400_init_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 661eb662d051..e160eded69e1 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -51,6 +51,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/map.h>
 
 #include <asm/irq.h>
@@ -701,7 +702,7 @@ static void __init smdk6410_machine_init(void)
 MACHINE_START(SMDK6410, "SMDK6410")
 	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.atag_offset	= 0x100,
-
+	.nr_irqs	= S3C64XX_NR_IRQS + 64,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
diff --git a/arch/arm/plat-samsung/gpio-samsung.c b/arch/arm/plat-samsung/gpio-samsung.c
index 37faa8eab78f..287c3df8b4c6 100644
--- a/arch/arm/plat-samsung/gpio-samsung.c
+++ b/arch/arm/plat-samsung/gpio-samsung.c
@@ -30,6 +30,7 @@
 
 #include <asm/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
-- 
2.1.0.rc2
