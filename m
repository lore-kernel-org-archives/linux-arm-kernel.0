From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Apr 2017 10:38:58 -0700
Subject: [PATCH v2 1/3] mm: Silence vmap() allocation failures based on caller
 gfp_flags
In-Reply-To: <20170427173900.2538-1-f.fainelli@gmail.com>
References: <20170427173900.2538-1-f.fainelli@gmail.com>
Message-ID: <20170427173900.2538-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the caller has set __GFP_NOWARN don't print the following message:
vmap allocation for size 15736832 failed: use vmalloc=<size> to increase
size.

This can happen with the ARM/Linux or ARM64/Linux module loader built
with CONFIG_ARM{,64}_MODULE_PLTS=y which does a first attempt at loading
a large module from module space, then falls back to vmalloc space.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 mm/vmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0b057628a7ba..d8a851634674 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -521,9 +521,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		}
 	}
 
+	if (gfp_mask & __GFP_NOWARN)
+		goto out;
+
 	if (printk_ratelimit())
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
+out:
 	kfree(va);
 	return ERR_PTR(-EBUSY);
 }
-- 
2.9.3
