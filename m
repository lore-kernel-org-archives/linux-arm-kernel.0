From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Sep 2009 16:40:37 -0700
Subject: [PATCH 07/12] omap: iovmm: Fix compiler warning
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Message-ID: <20090924234037.6065.73752.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sanjeev Premi <premi@ti.com>

This patch fixes these compiler warnings:

arch/arm/plat-omap/iovmm.c: In function 'vmap_sg':
arch/arm/plat-omap/iovmm.c:202: warning: passing argument 1 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c:202: warning: passing argument 2 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c: In function 'sgtable_fill_vmalloc':
arch/arm/plat-omap/iovmm.c:393: warning: passing argument 1 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c:393: warning: passing argument 2 of
 'flush_cache_vmap' makes integer from pointer without a cast

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 6fc52fc..57f7122 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -199,7 +199,8 @@ static void *vmap_sg(const struct sg_table *sgt)
 		va += bytes;
 	}
 
-	flush_cache_vmap(new->addr, new->addr + total);
+	flush_cache_vmap((unsigned long)new->addr,
+				(unsigned long)(new->addr + total));
 	return new->addr;
 
 err_out:
@@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 	}
 
 	va_end = _va + PAGE_SIZE * i;
-	flush_cache_vmap(_va, va_end);
+	flush_cache_vmap((unsigned long)_va, (unsigned long)va_end);
 }
 
 static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
