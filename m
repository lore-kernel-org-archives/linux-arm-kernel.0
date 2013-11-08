From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 18:41:37 -0500
Subject: [PATCH 01/24] mm/memblock: debug: correct displaying of upper memory
 boundary
In-Reply-To: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1383954120-24368-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

When debugging is enabled (cmdline has "memblock=debug") the memblock
will display upper memory boundary per each allocated/freed memory range
wrongly. For example:
 memblock_reserve: [0x0000009e7e8000-0x0000009e7ed000] _memblock_early_alloc_try_nid_nopanic+0xfc/0x12c

The 0x0000009e7ed000 is displayed instead of 0x0000009e7ecfff

Hence, correct this by changing formula used to calculate upper memory
boundary to (u64)base + size - 1 instead of  (u64)base + size everywhere
in the debug messages.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 mm/memblock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0ac412a..e03918e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -545,7 +545,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 {
 	memblock_dbg("   memblock_free: [%#016llx-%#016llx] %pF\n",
 		     (unsigned long long)base,
-		     (unsigned long long)base + size,
+		     (unsigned long long)base + size - 1,
 		     (void *)_RET_IP_);
 
 	return __memblock_remove(&memblock.reserved, base, size);
@@ -557,7 +557,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 
 	memblock_dbg("memblock_reserve: [%#016llx-%#016llx] %pF\n",
 		     (unsigned long long)base,
-		     (unsigned long long)base + size,
+		     (unsigned long long)base + size - 1,
 		     (void *)_RET_IP_);
 
 	return memblock_add_region(_rgn, base, size, MAX_NUMNODES);
-- 
1.7.9.5
