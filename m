From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 15:14:44 +0100
Subject: [PATCH] ARM: ARM_KERNMEM_PERMS only works with MMU enabled
Message-ID: <1976703.4VfV2sWda0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added ARM_KERNMEM_PERMS feature works by manipulating
the kernel page tables, which obviously requires an MMU. Trying
to enable this feature when the MMU is disabled results in a lot
of compile errors in mm/init.c, so let's add a Kconfig dependency
to avoid that case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index eaaf196fe4e1..0051cd924fb1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1010,6 +1010,7 @@ config ARCH_SUPPORTS_BIG_ENDIAN
 
 config ARM_KERNMEM_PERMS
 	bool "Restrict kernel memory permissions"
+	depends on MMU
 	help
 	  If this is set, kernel memory other than kernel text (and rodata)
 	  will be made non-executable. The tradeoff is that each region is
