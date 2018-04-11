From: hejianet@gmail.com (Jia He)
Date: Wed, 11 Apr 2018 00:21:56 -0700
Subject: [PATCH v8 5/6] arm: arm64: introduce pfn_valid_region()
In-Reply-To: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
Message-ID: <1523431317-30612-6-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), we can record
the last returned memblock region. If current pfn and last pfn are in the
same memory region, we needn't do the unnecessary binary searches because
memblock_is_nomap is the same result for whole memory region.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/early_pfn.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/early_pfn.h b/include/linux/early_pfn.h
index f9e40c3..9609391 100644
--- a/include/linux/early_pfn.h
+++ b/include/linux/early_pfn.h
@@ -51,5 +51,29 @@ ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
 	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
+
+int pfn_valid_region(ulong pfn)
+{
+	ulong start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
+
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+					regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(
+					&regions[early_region_idx]);
+	}
+
+	early_region_idx = memblock_search_pfn_regions(pfn);
+	if (early_region_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&regions[early_region_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
 #endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
 #endif /*__EARLY_PFN_H*/
-- 
2.7.4
