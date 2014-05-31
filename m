From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 22:00:06 +0400
Subject: [PATCH RFC] ARM: clps711x: Partial multiplatform support
Message-ID: <1401559206-23767-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provide initial partial multiplatform support for CLPS711X CPUs.
Not intended for apply, just for comments at now.
---
 arch/arm/Kconfig                               | 10 ++--------
 arch/arm/mach-clps711x/Kconfig                 | 21 +++++++++++++++++++++
 arch/arm/mach-clps711x/common.c                |  2 +-
 arch/arm/mach-clps711x/devices.c               |  2 +-
 arch/arm/mach-clps711x/include/mach/hardware.h |  2 +-
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 899afa4..aced2fb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -385,15 +385,9 @@ config ARCH_AT91
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
-config ARCH_CLPS711X
+config CLPS711X_SINGLE
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select ARCH_REQUIRE_GPIOLIB
-	select AUTO_ZRELADDR
-	select CLKSRC_MMIO
-	select COMMON_CLK
-	select CPU_ARM720T
-	select GENERIC_CLOCKEVENTS
-	select MFD_SYSCON
+	select ARCH_CLPS711X
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index f711498..1802562 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -1,15 +1,34 @@
+config ARCH_CLPS711X
+	bool
+	depends on CLPS711X_SINGLE || CLPS711X_MULTI
+	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select CPU_ARM720T
+	select GENERIC_CLOCKEVENTS
+	select MFD_SYSCON
+
+config CLPS711X_MULTI
+	bool "Cirrus Logic CLPS711X" if ARCH_MULTI_V4T
+	select ARCH_CLPS711X
+	help
+	  Support for Cirrus Logic CLPS711X-based family of processors.
+
 if ARCH_CLPS711X
 
 menu "CLPS711X/EP721X/EP731X Implementations"
 
 config ARCH_AUTCPU12
 	bool "AUTCPU12"
+	depends on CLPS711X_SINGLE
 	help
 	  Say Y if you intend to run the kernel on the autronix autcpu12
 	  board. This board is based on a Cirrus Logic CS89712.
 
 config ARCH_CDB89712
 	bool "CDB89712"
+	depends on CLPS711X_SINGLE
 	help
 	  This is an evaluation board from Cirrus for the CS89712 processor.
 	  The board includes 2 serial ports, Ethernet, IRDA, and expansion
@@ -22,6 +41,7 @@ config ARCH_CLEP7312
 
 config ARCH_EDB7211
 	bool "EDB7211"
+	depends on CLPS711X_SINGLE
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
 	  Say Y here if you intend to run this kernel on a Cirrus Logic EDB-7211
@@ -29,6 +49,7 @@ config ARCH_EDB7211
 
 config ARCH_P720T
 	bool "P720T"
+	depends on CLPS711X_SINGLE
 	help
 	  Say Y here if you intend to run this kernel on the ARM Prospector
 	  720T.
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 2a6323b..a230989 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -35,7 +35,7 @@
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
-#include <mach/hardware.h>
+#include "include/mach/hardware.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 0c689d3..08562d5 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
-#include <mach/hardware.h>
+#include "include/mach/hardware.h"
 
 static const struct resource clps711x_cpuidle_res __initconst =
 	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + HALT, SZ_128);
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 833129c..e507a60 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -22,7 +22,7 @@
 #ifndef __MACH_HARDWARE_H
 #define __MACH_HARDWARE_H
 
-#include <mach/clps711x.h>
+#include "clps711x.h"
 
 #define CLPS711X_VIRT_BASE	IOMEM(0xfeff0000)
 
-- 
1.8.5.5
