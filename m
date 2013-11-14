From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Nov 2013 14:37:43 -0500
Subject: [PATCH 3/6] ARM: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
References: <y>
 <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slab allocator can allocate memory beyond the lowmem watermark
which can lead to false failure of virt_addr_valid().

So drop the check. The issue was seen with percpu_alloc()
in KVM code which was allocating memory beyond lowmem watermark.

Am not completly sure whether this is the right fix and if it could
impact any other user of virt_addr_valid(). Without this fix as
pointed out the KVM init was failing in my testing.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4dd2145..412da47 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -343,8 +343,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
-
+#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET)
 #endif
 
 #include <asm-generic/memory_model.h>
-- 
1.7.9.5
