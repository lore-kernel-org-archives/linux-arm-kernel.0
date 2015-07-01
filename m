From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 01 Jul 2015 22:45:44 +0100
Subject: [PATCH] ARM: fix DEBUG_SET_MODULE_RONX build dependencies
Message-ID: <E1ZAPpA-0003NT-8H@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

randconfig testing reveals that DEBUG_SET_MODULE_RONX needs to depend on
MMU otherwise these build errors are observed:

kernel/built-in.o: In function `set_section_ro_nx':
kernel/module.c:1738: undefined reference to `set_memory_nx'
kernel/built-in.o: In function `set_page_attributes':
kernel/module.c:1709: undefined reference to `set_memory_ro'

This is because the pageattr functions are not built for !MMU configs as
they don't have page tables.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c12ffb155a2..dfa21cb58f36 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1590,7 +1590,7 @@ config PID_IN_CONTEXTIDR
 
 config DEBUG_SET_MODULE_RONX
 	bool "Set loadable kernel module data as NX and text as RO"
-	depends on MODULES
+	depends on MODULES && MMU
 	---help---
 	  This option helps catch unintended modifications to loadable
 	  kernel module's text and read-only data. It also prevents execution
-- 
2.1.0
