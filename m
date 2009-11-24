From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 17:00:39 +0000
Subject: [PATCH] Flush the D-cache during copy_user_highpage()
Message-ID: <20091124170039.17891.52999.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I and D caches for copy-on-write pages on processors with
write-allocate caches become incoherent causing problems on application
relying on CoW for text pages (dynamic linker relocating symbols in a
text page). This patch flushes the D-cache for such pages.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mm/copypage-v6.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 4127a7b..841f355 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,6 +41,14 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	kfrom = kmap_atomic(from, KM_USER0);
 	kto = kmap_atomic(to, KM_USER1);
 	copy_page(kto, kfrom);
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * kmap_atomic() doesn't set the page virtual address, and
+	 * kunmap_atomic() takes care of cache flushing already.
+	 */
+	if (page_address(to) != NULL)
+#endif
+		__cpuc_flush_dcache_page(kto);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
 }
