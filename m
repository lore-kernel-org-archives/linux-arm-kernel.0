From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat,  5 Mar 2016 16:32:38 +0100
Subject: [PATCH] memremap: check pfn validity before passing to pfn_to_page()
Message-ID: <1457191958-5263-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In memremap's helper function try_ram_remap(), we dereference a struct page
pointer that was derived from a PFN that is known to be covered by a
'System RAM' iomem region, and is thus assumed to be a 'valid' PFN, i.e., a
PFN that has a struct page associated with it and is covered by the kernel
direct mapping.
However, the assumption that there is a 1:1 relation between the System RAM
iomem region and the kernel direct mapping is not universally valid on all
architectures, and on ARM and arm64, 'System RAM' may include regions for
which pfn_valid() returns false.

Generally speaking, both __va() and pfn_to_page() should only ever be called
on PFNs/physical addresses for which pfn_valid() returns true, so add that
check to try_ram_remap().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/memremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index b981a7b023f0..03fa254f61f6 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -29,10 +29,10 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 
 static void *try_ram_remap(resource_size_t offset, size_t size)
 {
-	struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
+	unsigned long pfn = PHYS_PFN(offset);
 
 	/* In the simple case just return the existing linear address */
-	if (!PageHighMem(page))
+	if (pfn_valid(pfn) && !PageHighMem(pfn_to_page(pfn)))
 		return __va(offset);
 	return NULL; /* fallback to ioremap_cache */
 }
-- 
1.9.1
