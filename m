From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Feb 2014 12:05:31 +0400
Subject: [PATCH 2/4] ARM: clps711x: Remove EP72XX_ROM_BOOT option
In-Reply-To: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
References: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
Message-ID: <1392451533-12858-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLPS711X CPUs have 128 bytes of on-chip Boot ROM with an
instruction sequence that configure UART1 to receive up to
2 Kbytes of serial data which is then placed in the on-chip
SRAM. Once the download is complete, the program counter
jumps to SRAM to begin executed the downloaded data.
The purpose of this mode is to allow the downloaded code to
facilitate programming of FLASH or other ROM device. Selection
of the internal Boot ROM is accomplished at power-on-reset time.
No reason to keep this special (develop only) mode in the kernel.
This patch removes EP72XX_ROM_BOOT kernel symbol.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig                 | 14 --------------
 arch/arm/mach-clps711x/include/mach/hardware.h | 17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index bea6295..f711498 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -33,20 +33,6 @@ config ARCH_P720T
 	  Say Y here if you intend to run this kernel on the ARM Prospector
 	  720T.
 
-config EP72XX_ROM_BOOT
-	bool "EP721x/EP731x ROM boot"
-	help
-	  If you say Y here, your CLPS711x-based kernel will use the bootstrap
-	  mode memory map instead of the normal memory map.
-
-	  Processors derived from the Cirrus CLPS711X core support two boot
-	  modes.  Normal mode boots from the external memory device at CS0.
-	  Bootstrap mode rearranges parts of the memory map, placing an
-	  internal 128 byte bootstrap ROM at CS0.  This option performs the
-	  address map changes required to support booting in this mode.
-
-	  You almost surely want to say N here.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index c5a8ea6..5d6afda 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -38,13 +38,6 @@
 #define clps_writel(val,off)	writel(val, CLPS711X_VIRT_BASE + (off))
 #endif
 
-/*
- * The physical addresses that the external chip select signals map to is
- * dependent on the setting of the nMEDCHG signal on EP7211 and EP7212
- * processors.  CONFIG_EP72XX_BOOT_ROM is only available if these
- * processors are in use.
- */
-#ifndef CONFIG_EP72XX_ROM_BOOT
 #define CS0_PHYS_BASE		(0x00000000)
 #define CS1_PHYS_BASE		(0x10000000)
 #define CS2_PHYS_BASE		(0x20000000)
@@ -53,16 +46,6 @@
 #define CS5_PHYS_BASE		(0x50000000)
 #define CS6_PHYS_BASE		(0x60000000)
 #define CS7_PHYS_BASE		(0x70000000)
-#else
-#define CS0_PHYS_BASE		(0x70000000)
-#define CS1_PHYS_BASE		(0x60000000)
-#define CS2_PHYS_BASE		(0x50000000)
-#define CS3_PHYS_BASE		(0x40000000)
-#define CS4_PHYS_BASE		(0x30000000)
-#define CS5_PHYS_BASE		(0x20000000)
-#define CS6_PHYS_BASE		(0x10000000)
-#define CS7_PHYS_BASE		(0x00000000)
-#endif
 
 #define CLPS711X_SRAM_BASE	CS6_PHYS_BASE
 #define CLPS711X_SRAM_SIZE	(48 * 1024)
-- 
1.8.3.2
