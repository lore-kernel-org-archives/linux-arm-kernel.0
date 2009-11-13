From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Nov 2009 16:08:01 -0800
Subject: [PATCH 04/14] omap: iovmm: remove cache flush operation
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Message-ID: <20091113000801.9034.78473.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Cache flush operation is handled in the upper client layer and iovmm
modules doesn't have to care about it. This patch will improve some
performance with current camera isp driver.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 577d8c0..544772e 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -392,7 +392,6 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 	}
 
 	va_end = _va + PAGE_SIZE * i;
-	flush_cache_vmap((unsigned long)_va, (unsigned long)va_end);
 }
 
 static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
@@ -427,8 +426,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, size_t len)
 		len -= bytes;
 	}
 	BUG_ON(len);
-
-	clean_dcache_area(va, len);
 }
 
 static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
