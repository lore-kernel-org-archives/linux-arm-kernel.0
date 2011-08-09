From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 21:41:22 +0200
Subject: [PATCH 1/5] mach-u300: retire odd singlemem variant
Message-ID: <1312918882-11828-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The U300 had a special variant where a memory was shared
between two CPU:s and only one part of memory was
accessible for the kernel. However it is now seriously
legacy and only create problems for kernel consolidation,
so let's retire it.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Kconfig               |   38 ------------------------------
 arch/arm/mach-u300/Makefile.boot         |   17 ++-----------
 arch/arm/mach-u300/include/mach/memory.h |   22 +---------------
 arch/arm/mach-u300/u300.c                |   16 ------------
 4 files changed, 5 insertions(+), 88 deletions(-)

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 32a7b0f..d3a9ca4 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -48,25 +48,6 @@ config MACH_U300_BS365
 
 endchoice
 
-choice
-	prompt "Memory configuration"
-	default MACH_U300_SINGLE_RAM
-	---help---
-	You have to config the kernel according to the physical memory
-	configuration.
-
-config MACH_U300_SINGLE_RAM
-	bool "Single RAM"
-	help
-		Select this if you want support for Single RAM phones.
-
-config MACH_U300_DUAL_RAM
-	bool "Dual RAM"
-	help
-		Select this if you want support for Dual RAM phones.
-		This is two RAM memories on different EMIFs.
-endchoice
-
 config U300_DEBUG
 	bool "Debug support for U300"
 	depends on PM
@@ -93,25 +74,6 @@ config MACH_U300_SPIDUMMY
 		you don't need it. Selecting this will activate the
 		SPI framework and ARM PL022 support.
 
-comment "All the settings below must match the bootloader's settings"
-
-config MACH_U300_ACCESS_MEM_SIZE
-       int "Access CPU memory allocation"
-       range 7 25
-       depends on MACH_U300_SINGLE_RAM
-       default 13
-       help
-		How much memory in MiB that the Access side CPU has allocated
-
-config MACH_U300_2MB_ALIGNMENT_FIX
-       bool "2MiB alignment fix"
-       depends on MACH_U300_SINGLE_RAM
-       default y
-       help
-		If yes and the Access side CPU has allocated an odd size in
-		MiB, this fix gives you one MiB extra that would otherwise be
-		lost due to Linux 2 MiB alignment policy.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-u300/Makefile.boot b/arch/arm/mach-u300/Makefile.boot
index 6fbfc6e..a06bb0d 100644
--- a/arch/arm/mach-u300/Makefile.boot
+++ b/arch/arm/mach-u300/Makefile.boot
@@ -1,15 +1,4 @@
-# Note: the following conditions must always be true:
-#   ZRELADDR == virt_to_phys(TEXTADDR)
-#   PARAMS_PHYS must be within 4MB of ZRELADDR
-#   INITRD_PHYS must be in RAM
-
-ifdef CONFIG_MACH_U300_SINGLE_RAM
-     zreladdr-y	:= 0x28E08000
-  params_phys-y	:= 0x28E00100
-else
-     zreladdr-y	:= 0x48008000
-  params_phys-y	:= 0x48000100
-endif
-
+   zreladdr-y	:= 0x48008000
+params_phys-y	:= 0x48000100
 # This isn't used.
-#initrd_phys-y	:= 0x29800000
+#initrd_phys-y	:= 0x48800000
diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index 888e2e3..02bd832 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -13,26 +13,8 @@
 #ifndef __MACH_MEMORY_H
 #define __MACH_MEMORY_H
 
-#ifdef CONFIG_MACH_U300_DUAL_RAM
-
-#define PLAT_PHYS_OFFSET		UL(0x48000000)
-#define BOOT_PARAMS_OFFSET	(PHYS_OFFSET + 0x100)
-
-#else
-
-#ifdef CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
-#define PLAT_PHYS_OFFSET (0x28000000 + \
-	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE - \
-	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
-#else
-#define PLAT_PHYS_OFFSET (0x28000000 + \
-	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE +	\
-	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
-#endif
-#define BOOT_PARAMS_OFFSET (0x28000000 + \
-	    (CONFIG_MACH_U300_ACCESS_MEM_SIZE +		\
-	    (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024 + 0x100)
-#endif
+#define PLAT_PHYS_OFFSET	UL(0x48000000)
+#define BOOT_PARAMS_OFFSET	(PLAT_PHYS_OFFSET + 0x100)
 
 /*
  * We enable a real big DMA buffer if need be.
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 48b3b7f..25d11ba 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -23,21 +23,6 @@
 #include <asm/mach/arch.h>
 #include <asm/memory.h>
 
-static void __init u300_reserve(void)
-{
-	/*
-	 * U300 - This platform family can share physical memory
-	 * between two ARM cpus, one running Linux and the other
-	 * running another OS.
-	 */
-#ifdef CONFIG_MACH_U300_SINGLE_RAM
-#if ((CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1) == 1) && \
-	CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
-        memblock_reserve(PHYS_OFFSET, 0x00100000);
-#endif
-#endif
-}
-
 static void __init u300_init_machine(void)
 {
 	u300_init_devices();
@@ -63,7 +48,6 @@ MACHINE_START(U300, MACH_U300_STRING)
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
 	.boot_params	= BOOT_PARAMS_OFFSET,
 	.map_io		= u300_map_io,
-	.reserve	= u300_reserve,
 	.init_irq	= u300_init_irq,
 	.timer		= &u300_timer,
 	.init_machine	= u300_init_machine,
-- 
1.7.3.2
