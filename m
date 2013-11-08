From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 18:41:47 -0500
Subject: [PATCH 11/24] mm/printk: Use memblock apis for early memory
 allocations
In-Reply-To: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1383954120-24368-12-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to memblock interfaces for early memory allocator instead of
bootmem allocator. No functional change in beahvior than what it is
in current code from bootmem users points of view.

Archs already converted to NO_BOOTMEM now directly use memblock
interfaces instead of bootmem wrappers build on top of memblock. And the
archs which still uses bootmem, these new apis just fallback to exiting
bootmem APIs.
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 kernel/printk/printk.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b4e8500..706295e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -757,14 +757,10 @@ void __init setup_log_buf(int early)
 		return;
 
 	if (early) {
-		unsigned long mem;
-
-		mem = memblock_alloc(new_log_buf_len, PAGE_SIZE);
-		if (!mem)
-			return;
-		new_log_buf = __va(mem);
+		new_log_buf =
+			memblock_virt_alloc_align(new_log_buf_len, PAGE_SIZE);
 	} else {
-		new_log_buf = alloc_bootmem_nopanic(new_log_buf_len);
+		new_log_buf = memblock_virt_alloc_nopanic(new_log_buf_len);
 	}
 
 	if (unlikely(!new_log_buf)) {
-- 
1.7.9.5
