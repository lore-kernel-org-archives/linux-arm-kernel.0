From: leoy@marvell.com (Leo Yan)
Date: Tue, 26 Jul 2011 15:19:01 +0800
Subject: [PATCH] lib/genalloc: fix gen_pool_virt_to_phys locking
Message-ID: <1311664741-21336-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The func gen_pool_virt_to_phys will iterate the chunk list;
if find the correct chunk it should need release pool's lock.

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 lib/genalloc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 577ddf8..e625df5 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -92,8 +92,10 @@ phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long addr)
 	list_for_each(_chunk, &pool->chunks) {
 		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
 
-		if (addr >= chunk->start_addr && addr < chunk->end_addr)
+		if (addr >= chunk->start_addr && addr < chunk->end_addr) {
+			read_unlock(&pool->lock);
 			return chunk->phys_addr + addr - chunk->start_addr;
+		}
 	}
 	read_unlock(&pool->lock);
 
-- 
1.7.4.1
