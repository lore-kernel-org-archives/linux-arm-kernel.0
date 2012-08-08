From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:50 +0200
Subject: [PATCH 02/10] ARM: ks8695: __arch_virt_to_dma type handling
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__arch_virt_to_dma expects a virtual address pointer, but
the ks8695 implementation of this macro treats it as an
integer. Adding a type cast avoids hundreds of identical
warning messages.

Without this patch, building acs5k_defconfig results in:

arch/arm/include/asm/dma-mapping.h: In function 'virt_to_dma':
arch/arm/include/asm/dma-mapping.h:60:2: warning: passing argument 1 of '__virt_to_phys' makes integer from pointer without a cast [enabled by default]
arch/arm/include/asm/memory.h:172:60: note: expected 'long unsigned int' but argument is of type 'void *'
In file included from include/linux/dma-mapping.h:73:0,
                 from include/linux/skbuff.h:33,
                 from security/commoncap.c:21:

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/include/mach/memory.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index f7e1b9b..95e731a 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -34,7 +34,8 @@ extern struct bus_type platform_bus_type;
 #define __arch_dma_to_virt(dev, x)	({ (void *) (is_lbus_device(dev) ? \
 					__phys_to_virt(x) : __bus_to_virt(x)); })
 #define __arch_virt_to_dma(dev, x)	({ is_lbus_device(dev) ? \
-					(dma_addr_t)__virt_to_phys(x) : (dma_addr_t)__virt_to_bus(x); })
+					(dma_addr_t)__virt_to_phys((unsigned long)x) \
+					: (dma_addr_t)__virt_to_bus(x); })
 #define __arch_pfn_to_dma(dev, pfn)	\
 	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
 	   if (!is_lbus_device(dev)) \
-- 
1.7.10
