From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:43 +0100
Subject: [PATCHv2 06/10] ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317206507-18867-7-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for s3c64xx to help building multi platform kernels.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-s3c64xx/include/mach/entry-macro.S |    7 ++++---
 arch/arm/mach-s3c64xx/mach-anw6410.c             |    2 ++
 arch/arm/mach-s3c64xx/mach-crag6410.c            |    2 ++
 arch/arm/mach-s3c64xx/mach-hmt.c                 |    2 ++
 arch/arm/mach-s3c64xx/mach-mini6410.c            |    2 ++
 arch/arm/mach-s3c64xx/mach-ncp.c                 |    2 ++
 arch/arm/mach-s3c64xx/mach-real6410.c            |    2 ++
 arch/arm/mach-s3c64xx/mach-smartq5.c             |    2 ++
 arch/arm/mach-s3c64xx/mach-smartq7.c             |    2 ++
 arch/arm/mach-s3c64xx/mach-smdk6400.c            |    2 ++
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |    2 ++
 12 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8d131a2..0b9a984 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -734,6 +734,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_GPIOLIB_4BIT
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S3C64XX series based systems
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/entry-macro.S b/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
index dd36260..dc2bc15 100644
--- a/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-s3c64xx/include/mach/entry-macro.S
@@ -12,7 +12,8 @@
  * warranty of any kind, whether express or implied.
 */
 
-#include <mach/map.h>
-#include <mach/irqs.h>
+		.macro  disable_fiq
+		.endm
 
-#include <asm/entry-macro-vic2.S>
+		.macro  arch_ret_to_user, tmp1, tmp2
+		.endm
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index cb88643..714a8cc 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -30,6 +30,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -236,6 +237,7 @@ MACHINE_START(ANW6410, "A&W6410")
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index af0c2fe..ae74fe1 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -37,6 +37,7 @@
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -768,6 +769,7 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index b3d93cc..6b60f50 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -267,6 +268,7 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	/* Maintainer: Peter Korsgaard <jacmet@sunsite.dk> */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 527f49b..f23ff04 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -24,6 +24,7 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -351,6 +352,7 @@ MACHINE_START(MINI6410, "MINI6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 01c6857..8190cd2 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -25,6 +25,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -99,6 +100,7 @@ MACHINE_START(NCP, "NCP")
 	/* Maintainer: Samsung Electronics */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 95b04b1..79bbf3c 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -332,6 +333,7 @@ MACHINE_START(REAL6410, "REAL6410")
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 342e8df..6ea050a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -148,6 +149,7 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 5796397..bd3168c 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -164,6 +165,7 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 3cca642..64560b2 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -22,6 +22,7 @@
 
 #include <asm/mach-types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -88,6 +89,7 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6400_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index ecbea92..47a835b 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -43,6 +43,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -745,6 +746,7 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
 	.timer		= &s3c24xx_timer,
-- 
1.7.4.1
