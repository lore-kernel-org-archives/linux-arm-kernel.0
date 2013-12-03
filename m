From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Dec 2013 21:27:22 -0500
Subject: [PATCH v2 07/23] mm/memblock: drop WARN and use SMP_CACHE_BYTES as a
 default alignment
In-Reply-To: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386037658-3161-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

drop WARN and use SMP_CACHE_BYTES as a default alignment in
memblock_alloc_base_nid() as recommended by Tejun Heo in
https://lkml.org/lkml/2013/10/13/117.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 mm/memblock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 53da534..1d15e07 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -883,8 +883,8 @@ static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
 {
 	phys_addr_t found;
 
-	if (WARN_ON(!align))
-		align = __alignof__(long long);
+	if (!align)
+		align = SMP_CACHE_BYTES;
 
 	/* align @size to avoid excessive fragmentation on reserved array */
 	size = round_up(size, align);
-- 
1.7.9.5
