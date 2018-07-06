From: hejianet@gmail.com (Jia He)
Date: Fri,  6 Jul 2018 17:01:15 +0800
Subject: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
Message-ID: <1530867675-9018-7-git-send-email-hejianet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check whether pfn++ is still in the same
region.

Currently it only improve the performance on arm/arm64 and will have no
impact on other arches.

For the performance improvement, after this set, I can see the time
overhead of memmap_init() is reduced from 27956us to 13537us in my
armv8a server(QDF2400 with 96G memory, pagesize 64k).

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 57cdc42..83b1d11 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1267,11 +1267,16 @@ static inline int pfn_present(unsigned long pfn)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
 extern ulong memblock_next_valid_pfn(ulong pfn);
 #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
-#endif
+
+extern int pfn_valid_region(ulong pfn);
+#define early_pfn_valid(pfn)	pfn_valid_region(pfn)
+#else
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
1.8.3.1
