From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:14 +0100
Subject: [PATCH 01/10] ARM: realview: remove sparsemem hack
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The realview-pbx platform has an elaborate way of avoiding the use of highmem
by redefining its phys_to_virt function. In practice this doesn't help all
that much, and it gets in the way of doing multiplatform builds for
realview.

This removes the feature and kills off the mach/memory.h file for realview.
We also lose the ability to do sparsemem with this patch, but that should
be put back into place for generic multiplatform configurations, to save
a little memory on PBX.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                             |  2 -
 arch/arm/mach-realview/Kconfig               |  5 +--
 arch/arm/mach-realview/include/mach/memory.h | 64 ----------------------------
 3 files changed, 2 insertions(+), 69 deletions(-)
 delete mode 100644 arch/arm/mach-realview/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f08306499a82..05e0bb54d3cd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -238,7 +238,6 @@ config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime" if EMBEDDED
 	default y
 	depends on !XIP_KERNEL && MMU
-	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
 	  Patch phys-to-virt and virt-to-phys translation functions at
 	  boot and module load time according to the position of the
@@ -353,7 +352,6 @@ config ARCH_REALVIEW
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select ICST
-	select NEED_MACH_MEMORY_H
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_SCHED_CLOCK
 	help
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 565925f37dc5..0fe63b543f5b 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -102,14 +102,13 @@ config MACH_REALVIEW_PBA8
 
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
-	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select ZONE_DMA if SPARSEMEM
+	select ZONE_DMA
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
 	  Explore.
@@ -124,6 +123,6 @@ config REALVIEW_HIGH_PHYS_OFFSET
 	  the board supports 512MB of RAM, this option allows the
 	  memory to be accessed contiguously at the high physical
 	  offset. On the PBX board, disabling this option allows 1GB of
-	  RAM to be used with SPARSEMEM.
+	  RAM to be used with HIGHMEM.
 
 endmenu
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
deleted file mode 100644
index 23e7a313f75d..000000000000
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/memory.h
- *
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#ifdef CONFIG_SPARSEMEM
-
-/*
- * Sparsemem definitions for RealView PBX.
- *
- * The RealView PBX board has another block of 512MB of RAM at 0x20000000,
- * however only the block at 0x70000000 (or the 256MB mirror at 0x00000000)
- * may be used for DMA.
- *
- * The macros below define a section size of 256MB and a non-linear virtual to
- * physical mapping:
- *
- * 256MB @ 0x00000000 -> PAGE_OFFSET
- * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
- * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000
- */
-#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-#error "SPARSEMEM not available with REALVIEW_HIGH_PHYS_OFFSET"
-#endif
-
-#define MAX_PHYSMEM_BITS	32
-#define SECTION_SIZE_BITS	28
-
-/* bank page offsets */
-#define PAGE_OFFSET1	(PAGE_OFFSET + 0x10000000)
-#define PAGE_OFFSET2	(PAGE_OFFSET + 0x30000000)
-
-#define PHYS_OFFSET PLAT_PHYS_OFFSET
-
-#define __phys_to_virt(phys)						\
-	((phys) >= 0x80000000 ?	(phys) - 0x80000000 + PAGE_OFFSET2 :	\
-	 (phys) >= 0x20000000 ?	(phys) - 0x20000000 + PAGE_OFFSET1 :	\
-	 (phys) + PAGE_OFFSET)
-
-#define __virt_to_phys(virt)						\
-	 ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 :	\
-	  (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 :	\
-	  (virt) - PAGE_OFFSET)
-
-#endif	/* CONFIG_SPARSEMEM */
-
-#endif
-- 
2.1.0.rc2
