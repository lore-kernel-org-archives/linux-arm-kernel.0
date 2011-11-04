From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:04 +0000
Subject: [PATCHv4 07/13] ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-8-git-send-email-jamie@jamieiles.com>
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
index 149fd45..32929ef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -787,6 +787,7 @@ config ARCH_S3C64XX
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
index d164a28..37d1cb1 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -30,6 +30,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -236,6 +237,7 @@ MACHINE_START(ANW6410, "A&W6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 8065803..1d8d6d0 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -37,6 +37,7 @@
 #include <linux/mfd/wm831x/irq.h>
 #include <linux/mfd/wm831x/gpio.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -765,6 +766,7 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 19a0887..281ce99 100644
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
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index fb8969a..073c66c 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -24,6 +24,7 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -345,6 +346,7 @@ MACHINE_START(MINI6410, "MINI6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index c30f2e5..b7a6edd 100644
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
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 93170d4..71486a0 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -326,6 +327,7 @@ MACHINE_START(REAL6410, "REAL6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index cbb57de..0c0481d 100644
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
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 04f914b..1c1ddad 100644
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
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 6fd5e95..6acccfe 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -22,6 +22,7 @@
 
 #include <asm/mach-types.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -88,6 +89,7 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6400_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 5f147c3..23bfba7 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -43,6 +43,7 @@
 
 #include <video/platform_lcd.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -700,6 +701,7 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
 	.timer		= &s3c24xx_timer,
-- 
1.7.5.4
