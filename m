From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 29 Sep 2016 15:34:11 +0800
Subject: [PATCH] mm/vmalloc: reduce the number of lazy_max_pages to reduce
 latency
Message-ID: <20160929073411.3154-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell berlin arm64 platforms, I see the preemptoff tracer report
a max 26543 us latency at __purge_vmap_area_lazy, this latency is an
awfully bad for STB. And the ftrace log also shows __free_vmap_area
contributes most latency now. I noticed that Joel mentioned the same
issue[1] on x86 platform and gave two solutions, but it seems no patch
is sent out for this purpose.

This patch adopts Joel's first solution, but I use 16MB per core
rather than 8MB per core for the number of lazy_max_pages. After this
patch, the preemptoff tracer reports a max 6455us latency, reduced to
1/4 of original result.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1603.2/04803.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 91f44e7..66f377a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -596,7 +596,7 @@ static unsigned long lazy_max_pages(void)
 
 	log = fls(num_online_cpus());
 
-	return log * (32UL * 1024 * 1024 / PAGE_SIZE);
+	return log * (16UL * 1024 * 1024 / PAGE_SIZE);
 }
 
 static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
-- 
2.9.3
