From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 16 Dec 2013 11:01:44 -0800
Subject: [PATCHv2 1/2] arm: Correct virt_addr_valid
Message-ID: <1387220505-9799-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of virt_addr_valid is that virt_addr_valid should
return true if and only if virt_to_page returns a valid pointer.
The current definition of virt_addr_valid only checks against the
virtual address range. There's no guarantee that just because a
virtual address falls bewteen PAGE_OFFSET and high_memory the
associated physical memory has a valid backing struct page. Follow
the example of other architectures and convert to pfn_valid to
verify that the virtual address is actually valid. The check for
an address between PAGE_OFFSET and high_memory is still necessary
as vmalloc/highmem addresses are not valid with virt_to_page.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/memory.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 9ecccc8..6211df0 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -350,7 +350,8 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
+#define virt_addr_valid(kaddr)	(pfn_valid(__pa(kaddr) >> PAGE_SHIFT) && \
+	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory))
 
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
