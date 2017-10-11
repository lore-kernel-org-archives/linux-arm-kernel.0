From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Oct 2017 15:48:55 +0200
Subject: [PATCH] ARM: don't discard memblock for kexec
Message-ID: <20171011134925.3251410-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Discarding the memblock arrays usually works, but causes problems
with kexec, as pointed out by this kbuild warning:

WARNING: vmlinux.o(.text+0x7c60): Section mismatch in reference from the function machine_kexec_prepare() to the function .meminit.text:memblock_is_region_memory()

This lets us keep the memblock structures around whenever kexec
is enabled, but otherwise still drops them.

Fixes: cf1b09908a23 ("ARM: 8693/1: discard memblock arrays when possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 75b8c7e79ebc..90922a090501 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2,7 +2,7 @@ config ARM
 	bool
 	default y
 	select ARCH_CLOCKSOURCE_DATA
-	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID
+	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID && !KEXEC
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
-- 
2.9.0
