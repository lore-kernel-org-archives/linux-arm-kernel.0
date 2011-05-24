From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 May 2011 22:39:09 +0100
Subject: [PATCH v6 03/18] ARM: LPAE: Use unsigned long for __phys_to_virt and
	__virt_to_phys
In-Reply-To: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1306273164-18217-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The !CONFIG_ARM_PATCH_PHYS_VIRT case uses macros for __phys_to_virt and
__virt_to_phys but does not use any type casting. This causes compiler
warnings with LPAE where the phys_addr_t and dma_addr_t are 64-bit:

  CC      arch/arm/mm/dma-mapping.o
In file included from /work/Linux/linux-marc/include/linux/dma-mapping.h:93:0,
                 from /work/Linux/linux-marc/arch/arm/mm/dma-mapping.c:19:
/work/Linux/linux-marc/arch/arm/include/asm/dma-mapping.h: In function 'dma_to_virt':
/work/Linux/linux-marc/arch/arm/include/asm/dma-mapping.h:35:9: warning:
        cast to pointer from integer of different size

Note that these macros are only valid for lowmem physical addresses
where the range is within 32-bit address range.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/memory.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 431077c..10e4b4c 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -194,8 +194,8 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 	return t;
 }
 #else
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+#define __virt_to_phys(x)	((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __phys_to_virt(x)	((unsigned long)(x) - PHYS_OFFSET + PAGE_OFFSET)
 #endif
 #endif
 
