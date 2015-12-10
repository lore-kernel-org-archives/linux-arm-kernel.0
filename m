From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 17:39:59 +0000
Subject: [PATCH] arm64: mm: ensure that the zero page is visible to the page
 table walker
Message-ID: <1449769199-31361-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In paging_init, we allocate the zero page, memset it to zero and then
point TTBR0 to it in order to avoid speculative fetches through the
identity mapping.

In order to guarantee that the freshly zeroed page is indeed visible to
the page table walker, we need to execute a dsb instruction prior to
writing the TTBR.

Cc: <stable@vger.kernel.org> # v3.14+, for older kernels need to drop the 'ishst'
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c04def90f3e4..c5bd5bca8e3d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -464,6 +464,9 @@ void __init paging_init(void)
 
 	empty_zero_page = virt_to_page(zero_page);
 
+	/* Ensure the zero page is visible to the page table walker */
+	dsb(ishst);
+
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
 	 * point to zero page to avoid speculatively fetching new entries.
-- 
2.1.4
