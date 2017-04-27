From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Apr 2017 11:19:00 -0700
Subject: [PATCH v3 1/3] mm: Silence vmap() allocation failures based on caller
 gfp_flags
In-Reply-To: <20170427181902.28829-1-f.fainelli@gmail.com>
References: <20170427181902.28829-1-f.fainelli@gmail.com>
Message-ID: <20170427181902.28829-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the caller has set __GFP_NOWARN don't print the following message:
vmap allocation for size 15736832 failed: use vmalloc=<size> to increase
size.

This can happen with the ARM/Linux or ARM64/Linux module loader built
with CONFIG_ARM{,64}_MODULE_PLTS=y which does a first attempt at loading
a large module from module space, then falls back to vmalloc space.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0b057628a7ba..b74f1d01ef76 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -521,7 +521,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		}
 	}
 
-	if (printk_ratelimit())
+	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
 	kfree(va);
-- 
2.9.3
