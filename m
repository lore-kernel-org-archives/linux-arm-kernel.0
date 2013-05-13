From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:20 +0400
Subject: [PATCH 01/15] ARM: clps711x: Remove NEED_MACH_MEMORY_H dependency
Message-ID: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes dependency of NEED_MACH_MEMORY_H for CLPS711X-target.
Since some board may have memory holes, define ARCH_HAS_HOLES_MEMORYMODEL
for these boards.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                             |  1 -
 arch/arm/mach-clps711x/Kconfig               |  3 +-
 arch/arm/mach-clps711x/include/mach/memory.h | 41 ----------------------------
 3 files changed, 1 insertion(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95674a..10cdfa9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -371,7 +371,6 @@ config ARCH_CLPS711X
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index 2d00165..01ad4d4 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -22,8 +22,7 @@ config ARCH_CLEP7312
 
 config ARCH_EDB7211
 	bool "EDB7211"
-	select ARCH_SELECT_MEMORY_MODEL
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
 	  Say Y here if you intend to run this kernel on a Cirrus Logic EDB-7211
 	  evaluation board.
diff --git a/arch/arm/mach-clps711x/include/mach/memory.h b/arch/arm/mach-clps711x/include/mach/memory.h
deleted file mode 100644
index fc0e028..0000000
--- a/arch/arm/mach-clps711x/include/mach/memory.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/memory.h
- *
- *  Copyright (C) 1999 ARM Limited
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
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0xc0000000)
-
-/*
- * The PS7211 allows up to 256MB max per DRAM bank, but the EDB7211
- * uses only one of the two banks (bank #1).  However, even within
- * bank #1, memory is discontiguous.
- *
- * The EDB7211 has two 8MB DRAM areas with 8MB of empty space between
- * them, so we use 24 for the node max shift to get 16MB node sizes.
- */
-
-#define SECTION_SIZE_BITS	24
-#define MAX_PHYSMEM_BITS	32
-
-#endif
-
-- 
1.8.1.5
