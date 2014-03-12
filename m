From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Mar 2014 16:50:20 +0100
Subject: [PATCH] ARM: always define CONFIG_PHYS_OFFSET on !MMU
Message-ID: <4902708.0QMcK2ajbq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with 006fa2599bf0 "ARM: fix noMMU kallsyms symbol filtering", we
use CONFIG_PHYS_OFFSET to calculate PAGE_OFFSET and have that passed
into kallsyms as the start address.

However, CONFIG_PHYS_OFFSET is defined only for platforms that don't
set NEED_MACH_MEMORY_H. It is possible to build a noMMU kernel for
these platforms by setting CONFIG_DRAM_BASE to the same value as the
PLAT_PHYS_OFFSET. This means we can in fact rely on DRAM_BASE to be
correct already, and implicitly define PHYS_OFFSET to the same value.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72129f3..67314cb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -271,7 +271,7 @@ config NEED_MACH_MEMORY_H
 
 config PHYS_OFFSET
 	hex "Physical address of main memory" if MMU
-	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
+	depends on (!ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H) || !MMU
 	default DRAM_BASE if !MMU
 	help
 
