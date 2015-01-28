From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:16 +0100
Subject: [PATCH 09/15] ARM: disable CONFIG_PTDUMP on !MMU
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's obviously pointless to dump page tables when the MMU is disabled,
and even trying to build this code results in numerous build errors
like these:

../arch/arm/mm/dump.c:56:11: error: 'L_PTE_USER' undeclared here (not in a function)
   .mask = L_PTE_USER,
           ^
../arch/arm/mm/dump.c:61:11: error: 'L_PTE_RDONLY' undeclared here (not in a function)
   .mask = L_PTE_RDONLY,
           ^
../arch/arm/mm/dump.c:66:11: error: 'L_PTE_XN' undeclared here (not in a function)
   .mask = L_PTE_XN,
           ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index aa5464044b07..24b649186014 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -5,6 +5,7 @@ source "lib/Kconfig.debug"
 config ARM_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
+	depends on MMU
 	select DEBUG_FS
 	---help---
 	  Say Y here if you want to show the kernel pagetable layout in a
-- 
2.1.0.rc2
