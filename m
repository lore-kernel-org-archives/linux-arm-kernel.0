From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sun, 4 Oct 2009 20:52:45 -0400
Subject: [PATCH] ep93xx: add remaining phys offset selections and
	updatemicro9
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D423B7@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901D42257@mi8nycmail19.Mi8.com><75467E8A2C28434DA9302761D4D2B6FDB02DC7@coexs.contec-int.at>
	<BD79186B4FD85F4B8E60E381CAEE190901D423B7@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB75B0@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing Kconfig options for the first SDRAM bank address
on ep93xx boards.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>

---

V2 - removed micro9 Kconfig changes, this will be a separate patch

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index d7291c6..6675c05 100644
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
