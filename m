From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  8 May 2011 13:51:22 +0100
Subject: [PATCH v5 03/19] ARM: LPAE: Use unsigned long for __phys_to_virt and
	__virt_to_phys
In-Reply-To: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1304859098-10760-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The !CONFIG_ARM_PATCH_PHYS_VIRT case uses macros for __phys_to_virt and
__virt_to_phys but does not use any type casting. This causes issues
with LPAE where the phys_addr_t is 64-bit. Note that these macros are
only valid for lowmem physical addresses where the range is within
32-bit.

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
 
