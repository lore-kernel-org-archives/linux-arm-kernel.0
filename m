From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:20 +0200
Subject: [PATCH 06/16] mm/slob: use min_t() to compare ARCH_SLAB_MINALIGN
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Message-ID: <1349448930-23976-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of ARCH_SLAB_MINALIGN is architecture dependent
and can be either of type size_t or int. Comparing that value
with ARCH_KMALLOC_MINALIGN can cause harmless warnings on
platforms where they are different. Since both are always
small positive integer numbers, using the size_t type to compare
them is safe and gets rid of the warning.

Without this patch, building ARM collie_defconfig results in:

mm/slob.c: In function '__kmalloc_node':
mm/slob.c:431:152: warning: comparison of distinct pointer types lacks a cast [enabled by default]
mm/slob.c: In function 'kfree':
mm/slob.c:484:153: warning: comparison of distinct pointer types lacks a cast [enabled by default]
mm/slob.c: In function 'ksize':
mm/slob.c:503:153: warning: comparison of distinct pointer types lacks a cast [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
---
 mm/slob.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slob.c b/mm/slob.c
index 45d4ca7..497c55e 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -428,7 +428,7 @@ out:
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
 	unsigned int *m;
-	int align = max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
 
 	gfp &= gfp_allowed_mask;
@@ -481,7 +481,7 @@ void kfree(const void *block)
 
 	sp = virt_to_page(block);
 	if (PageSlab(sp)) {
-		int align = max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 		unsigned int *m = (unsigned int *)(block - align);
 		slob_free(m, *m + align);
 	} else
@@ -500,7 +500,7 @@ size_t ksize(const void *block)
 
 	sp = virt_to_page(block);
 	if (PageSlab(sp)) {
-		int align = max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 		unsigned int *m = (unsigned int *)(block - align);
 		return SLOB_UNITS(*m) * SLOB_UNIT;
 	} else
-- 
1.7.10
