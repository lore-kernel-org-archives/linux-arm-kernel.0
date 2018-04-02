From: hejianet@gmail.com (Jia He)
Date: Sun,  1 Apr 2018 19:30:36 -0700
Subject: [PATCH v5 5/5] mm: page_alloc: reduce unnecessary binary search in
 early_pfn_valid()
In-Reply-To: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
Message-ID: <1522636236-12625-6-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check check pfn++ is still in the same region.

Currently it only improve the performance on arm64 and will have no
impact on other arches.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f9c0c46..079f468 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1268,9 +1268,14 @@ static inline int pfn_present(unsigned long pfn)
 })
 #else
 #define pfn_to_nid(pfn)		(0)
-#endif
+#endif /*CONFIG_NUMA*/
 
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+#define early_pfn_valid(pfn) pfn_valid_region(pfn)
+#else
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
2.7.4
