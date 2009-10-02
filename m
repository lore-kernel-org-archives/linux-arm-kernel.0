From: tony@atomide.com (Tony Lindgren)
Date: Fri, 02 Oct 2009 15:42:50 -0700
Subject: [PATCH 5/8] omap: iovmm: Add missing mutex_unlock
In-Reply-To: <20091002223510.11962.21751.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
Message-ID: <20091002224250.11962.58393.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <dwalker@fifo99.com>

I was using Coccinelle with the mutex_unlock semantic patch, and it
unconvered this problem. It appears to be a valid missing unlock issue.
This change should correct it by moving the unlock below the label.

This patch is against the mainline kernel.

Cc: Julia Lawall <julia@diku.dk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 0e5573d..dc3fac3 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -363,8 +363,9 @@ void *da_to_va(struct iommu *obj, u32 da)
 		goto out;
 	}
 	va = area->va;
-	mutex_unlock(&obj->mmap_lock);
 out:
+	mutex_unlock(&obj->mmap_lock);
+
 	return va;
 }
 EXPORT_SYMBOL_GPL(da_to_va);
