From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 10 Dec 2013 17:23:02 -0800
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
References: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of virt_addr_valid is that virt_addr_valid should
return true if and only if virt_to_page returns a valid pointer.
The current definition of virt_addr_valid only checks against the
virtual address range. There's no guarantee that just because a
virtual address falls bewteen PAGE_OFFSET and high_memory the
associated physical memory has a valid backing struct page. Follow
the example of other architectures and convert to pfn_valid to
verify that the virtual address is actually valid.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/memory.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 3776217..9dc5dc3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -146,8 +146,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
-				 ((void *)(kaddr) < (void *)high_memory))
+#define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
