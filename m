From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 Feb 2012 18:28:29 +0100
Subject: [PATCH] ARM: ux500: solve some Kconfig mess
Message-ID: <1330536509-13590-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

First rename the config option MACH_U8500 to MACH_MOP500
because that is what it's obviously all about, this has
confused me for the last time. Fix some whitespace in the
process.

Since the machine descriptors for HREFv60 and snowball
are clearly in the file board-mop500.c which only
compiles if MACH_MOP500 (former MACH_U8500) is set,
select this for the board variants and nothing else.

For the MOP500 variants the UIB (user interface board)
is probed using I2C so select I2C and I2C_NOMADIK so
we know that this probe will always be successful.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig             |   23 +++++++++++++----------
 arch/arm/mach-ux500/Makefile            |    2 +-
 arch/arm/mach-ux500/include/mach/irqs.h |    2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index d008812..d205de4 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -22,21 +22,24 @@ config UX500_SOC_DB8500
 
 menu "Ux500 target platform (boards)"
 
-config MACH_U8500
-	bool "U8500 Development platform"
+config MACH_MOP500
+	bool "U8500 Development platform, MOP500 versions"
 	select UX500_SOC_DB8500
+	select I2C
+	select I2C_NOMADIK
 	help
-	  Include support for the mop500 development platform.
+	  Include support for the MOP500 development platform.
 
 config MACH_HREFV60
-       bool "U85000 Development platform, HREFv60 version"
-       select UX500_SOC_DB8500
-       help
-         Include support for the HREFv60 new development platform.
+	bool "U8500 Development platform, HREFv60 version"
+	select MACH_MOP500
+	help
+	  Include support for the HREFv60 new development platform.
+	  Includes HREFv70, v71 etc.
 
 config MACH_SNOWBALL
 	bool "U8500 Snowball platform"
-	select MACH_U8500
+	select MACH_MOP500
 	help
 	  Include support for the snowball development platform.
 
@@ -49,11 +52,11 @@ config MACH_U5500
 config UX500_AUTO_PLATFORM
 	def_bool y
 	depends on !MACH_U5500
-	select MACH_U8500
+	select MACH_MOP500
 	help
 	  At least one platform needs to be selected in order to build
 	  a working kernel. If everything else is disabled, this
-	  automatically enables MACH_U8500.
+	  automatically enables MACH_MOP500.
 endmenu
 
 config UX500_DEBUG_UART
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 6bd2f45..8dd75f2 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -7,7 +7,7 @@ obj-y				:= clock.o cpu.o devices.o devices-common.o \
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
-obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
+obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index c4e3beb..7da9ec5 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -43,7 +43,7 @@
 /* This will be overridden by board-specific irq headers */
 #define IRQ_BOARD_END		IRQ_BOARD_START
 
-#ifdef CONFIG_MACH_U8500
+#ifdef CONFIG_MACH_MOP500
 #include <mach/irqs-board-mop500.h>
 #endif
 
-- 
1.7.8
