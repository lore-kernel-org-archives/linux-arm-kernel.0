From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue, 12 Jan 2016 15:22:35 -0800
Subject: [PATCHv2] arm64: Allow vmalloc regions to be set with set_memory_*
Message-ID: <1452640955-25491-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The range of set_memory_* is currently restricted to the module address
range because of difficulties in breaking down larger block sizes.
vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
function ranges and add a comment explaining why the range is restricted
the way it is.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
v2: Old version was sent out with vmalloc warnings. Sorry for the noise.
---
 arch/arm64/mm/pageattr.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 3571c73..88c8e54 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -36,6 +36,26 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
 	return 0;
 }
 
+static bool validate_addr(unsigned long start, unsigned long end)
+{
+	/*
+	 * This check explicitly excludes most kernel memory. Most kernel
+	 * memory is mapped with a larger page size and breaking down the
+	 * larger page size without causing TLB conflicts is very difficult.
+	 *
+	 * If you need to call set_memory_* on a range, the recommendation is
+	 * to use vmalloc since that range is mapped with pages.
+	 */
+	if (start >= MODULES_VADDR && start < MODULES_END &&
+	    end >= MODULES_VADDR && end < MODULES_END)
+		return true;
+
+	if (is_vmalloc_addr((void *)start) && is_vmalloc_addr((void *)end))
+		return true;
+
+	return false;
+}
+
 static int change_memory_common(unsigned long addr, int numpages,
 				pgprot_t set_mask, pgprot_t clear_mask)
 {
@@ -51,10 +71,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 		WARN_ON_ONCE(1);
 	}
 
-	if (start < MODULES_VADDR || start >= MODULES_END)
-		return -EINVAL;
-
-	if (end < MODULES_VADDR || end >= MODULES_END)
+	if (!validate_addr(start, end))
 		return -EINVAL;
 
 	data.set_mask = set_mask;
-- 
2.5.0
