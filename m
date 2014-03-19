From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:38 +0100
Subject: [PATCH 41/62] ARM: realview: fix sparsemem build
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-42-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b713aa0b15 "ARM: fix asm/memory.h build error" broke some
configurations on mach-realview with sparsemem enabled, which
is missing a definition of PHYS_OFFSET:

arch/arm/include/asm/memory.h:268:42: error: 'PHYS_OFFSET' undeclared (first use in this function)
 #define PHYS_PFN_OFFSET ((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
arch/arm/include/asm/dma-mapping.h:104:9: note: in expansion of macro 'PHYS_PFN_OFFSET'
  return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);

An easy workaround is for realview to define PHYS_OFFSET itself,
in the same way we define it for platforms that don't have a private
__virt_to_phys function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/include/mach/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index 2022e09..db09170 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -56,6 +56,8 @@
 #define PAGE_OFFSET1	(PAGE_OFFSET + 0x10000000)
 #define PAGE_OFFSET2	(PAGE_OFFSET + 0x30000000)
 
+#define PHYS_OFFSET PLAT_PHYS_OFFSET
+
 #define __phys_to_virt(phys)						\
 	((phys) >= 0x80000000 ?	(phys) - 0x80000000 + PAGE_OFFSET2 :	\
 	 (phys) >= 0x20000000 ?	(phys) - 0x20000000 + PAGE_OFFSET1 :	\
-- 
1.8.3.2
