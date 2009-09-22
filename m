From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 22 Sep 2009 12:57:09 -0400
Subject: [PATCH] ep93xx: add remaining phys offset selections and update micro9
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42257@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing Kconfig options for the first SDRAM bank address
on ep93xx boards.  The Micro9-Mid and Micro9-Slim boards need this to
create valid images which boot from 0xf0000000.

The Micro9 information has also been updated at the request of the
maintainer.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>

---

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index d7291c6..9167c3d 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -17,13 +17,31 @@ config EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	bool "0x00000000 - SDCE3/SyncBoot"
 	help
 	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0x00000000
+	  first SDRAM bank at 0x00000000.
 
 config EP93XX_SDCE0_PHYS_OFFSET
 	bool "0xc0000000 - SDCEO"
 	help
 	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0xc0000000
+	  first SDRAM bank at 0xc0000000.
+
+config EP93XX_SDCE1_PHYS_OFFSET
+	bool "0xd0000000 - SDCE1"
+	help
+	  Select this option if you want support for EP93xx boards with the
+	  first SDRAM bank at 0xd0000000.
+
+config EP93XX_SDCE2_PHYS_OFFSET
+	bool "0xe0000000 - SDCE2"
+	help
+	  Select this option if you want support for EP93xx boards with the
+	  first SDRAM bank at 0xe0000000.
+
+config EP93XX_SDCE3_ASYNC_PHYS_OFFSET
+	bool "0xf0000000 - SDCE3/AsyncBoot"
+	help
+	  Select this option if you want support for EP93xx boards with the
+	  first SDRAM bank at 0xf0000000.
 
 endchoice
 
@@ -112,28 +130,36 @@ config MACH_MICRO9
 	bool
 
 config MACH_MICRO9H
-	bool "Support Contec Hypercontrol Micro9-H"
+	bool "Support Contec Micro9-High"
 	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Contec Hypercontrol Micro9-H board.
+	  Contec Micro9-High board.
 
 config MACH_MICRO9M
-	bool "Support Contec Hypercontrol Micro9-M"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	bool "Support Contec Micro9-Mid"
+	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Contec Hypercontrol Micro9-M board.
+	  Contec Micro9-Mid board.
 
 config MACH_MICRO9L
-	bool "Support Contec Hypercontrol Micro9-L"
+	bool "Support Contec Micro9-Lite"
 	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Contec Hypercontrol Micro9-L board.
+	  Contec Micro9-Lite board.
+
+config MACH_MICRO9S
+	bool "Support Contec Micro9-Slim"
+	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
+	select MACH_MICRO9
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Contec Micro9-Slim board.
 
 config MACH_TS72XX
 	bool "Support Technologic Systems TS-72xx SBC"
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
index 27a085a..0ad33f1 100644
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ b/arch/arm/mach-ep93xx/Makefile.boot
@@ -3,3 +3,12 @@ params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
 
    zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
 params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
+
+   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
+params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
+
+   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
+params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
+
+   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
+params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
index 925b12e..554064e 100644
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ b/arch/arm/mach-ep93xx/include/mach/memory.h
@@ -9,6 +9,12 @@
 #define PHYS_OFFSET		UL(0x00000000)
 #elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
 #define PHYS_OFFSET		UL(0xc0000000)
+#elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
+#define PHYS_OFFSET		UL(0xd0000000)
+#elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
+#define PHYS_OFFSET		UL(0xe0000000)
+#elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
+#define PHYS_OFFSET		UL(0xf0000000)
 #else
 #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
 #endif 
