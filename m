From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 07 Dec 2011 17:21:59 +0800
Subject: [PATCH] highmem: fix missed kmap_atomic update in
 arch/arm/include/asm/highmem.h
Message-ID: <1323249719.27710.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 37bfbb "highmem: kill all __kmap_atomic()" missed the update to
arch/arm/include/asm/highmem.h.

This patch fixes below build error:
  CC      init/main.o
In file included from include/linux/pagemap.h:10,
                 from include/linux/mempolicy.h:70,
                 from init/main.c:49:
include/linux/highmem.h: In function 'kmap_atomic_deprecated':
include/linux/highmem.h:127: error: implicit declaration of function 'kmap_atomic'
include/linux/highmem.h:127: warning: return makes pointer from integer without a cast
include/linux/highmem.h: In function 'clear_highpage':
include/linux/highmem.h:218: warning: initialization makes pointer from integer without a cast
include/linux/highmem.h: In function 'zero_user_segments':
include/linux/highmem.h:227: warning: initialization makes pointer from integer without a cast
include/linux/highmem.h: In function 'copy_highpage':
include/linux/highmem.h:279: warning: assignment makes pointer from integer without a cast
include/linux/highmem.h:280: warning: assignment makes pointer from integer without a cast
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error by "make tegra_defconfig;make" on linux-next 20111207.
Thus this patch is against linux-next tree.

BTW, why commit 37bfbb "highmem: kill all __kmap_atomic()" does not have any
Signed-off-by?

Axel
 arch/arm/include/asm/highmem.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index a4edd19..8c5e828 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -57,7 +57,7 @@ static inline void *kmap_high_get(struct page *page)
 #ifdef CONFIG_HIGHMEM
 extern void *kmap(struct page *page);
 extern void kunmap(struct page *page);
-extern void *__kmap_atomic(struct page *page);
+extern void *kmap_atomic(struct page *page);
 extern void __kunmap_atomic(void *kvaddr);
 extern void *kmap_atomic_pfn(unsigned long pfn);
 extern struct page *kmap_atomic_to_page(const void *ptr);
-- 
1.7.5.4
