From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 16:09:19 +0100
Subject: [PATCH] ARM: make CONFIG_DEBUG_WX depend on MMU
Message-ID: <20180220150932.3285766-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without CONFIG_MMU, this results in a build failure:

./arch/arm/include/asm/memory.h:92:23: error: initializer element is not constant
 #define VECTORS_BASE  vectors_base
arch/arm/mm/dump.c:32:4: note: in expansion of macro 'VECTORS_BASE'
  { VECTORS_BASE, "Vectors" },

arch/arm/mm/dump.c:71:11: error: 'L_PTE_USER' undeclared here (not in a function); did you mean 'VTIME_USER'?
   .mask = L_PTE_USER,
           ^~~~~~~~~~

Obviously the feature only makes sense with an MMU, so let's add the
dependency here.

Fixes: a8e53c151fe7 ("ARM: 8737/1: mm: dump: add checking for writable and executable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 7b3d9c5c73bb..6db106b5b9e9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -22,6 +22,7 @@ config ARM_PTDUMP_DEBUGFS
 
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
+	depends on MMU
 	select ARM_PTDUMP_CORE
 	---help---
 		Generate a warning if any W+X mappings are found at boot.
-- 
2.9.0
