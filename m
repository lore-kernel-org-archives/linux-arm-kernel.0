From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  3 Sep 2012 14:43:52 +0200
Subject: [PATCH] arm: mm: fix DMA pool affiliation check
Message-ID: <1346676232-3566-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __free_from_pool() function was changed in
e9da6e9905e639b0f842a244bc770b48ad0523e9. Unfortunately, the test that
checks whether the provided (start,size) is within the DMA pool has
been improperly modified. It used to be:

  if (start < coherent_head.vm_start || end > coherent_head.vm_end)

Where coherent_head.vm_end was non-inclusive (i.e, it did not include
the first byte after the pool). The test has been changed to:

  if (start < pool->vaddr || start > pool->vaddr + pool->size)

So now pool->vaddr + pool->size is inclusive (i.e, it includes the
first byte after the pool), so the test should be >= instead of >.

This bug causes the following message when freeing the *first* DMA
coherent buffer that has been allocated, because its virtual address
is exactly equal to pool->vaddr + pool->size :

WARNING: at /home/thomas/projets/linux-2.6/arch/arm/mm/dma-mapping.c:463 __free_from_pool+0xa4/0xc0()
freeing wrong coherent size from pool

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Maen Suleiman <maen@marvell.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>
Cc: Shadi Ammouri <shadi@marvell.com>
Cc: Eran Ben-Avi <benavi@marvell.com>
Cc: Yehuda Yitschak <yehuday@marvell.com>
Cc: Nadav Haklai <nadavh@marvell.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4e7d118..59d9062 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -456,7 +456,7 @@ static int __free_from_pool(void *start, size_t size)
 	unsigned long pageno, count;
 	unsigned long flags;
 
-	if (start < pool->vaddr || start > pool->vaddr + pool->size)
+	if (start < pool->vaddr || start >= pool->vaddr + pool->size)
 		return 0;
 
 	if (start + size > pool->vaddr + pool->size) {
-- 
1.7.9.5
