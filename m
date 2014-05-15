From: gioh.kim@lge.com (Gioh Kim)
Date: Thu, 15 May 2014 14:49:35 +0900
Subject: [PATCH] ARM: cache-l2x0: add error message when fail to enable cache
Message-ID: <1400132976-5872-1-git-send-email-gioh.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add error message when fail to enable cache

Signed-off-by: Gioh Kim <gioh.kim@lge.com>
---
 arch/arm/mm/cache-l2x0.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7abde2c..5102c62 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -418,7 +418,11 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		outer_cache.disable = l2x0_disable;
 	}
 
-	pr_info("%s cache controller enabled\n", type);
+	if (readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)
+		pr_info("l2x0: %s cache controller enabled\n", type);
+	else
+		pr_err("l2x0: failed to enable %s cache controller\n", type);
+
 	pr_info("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d kB\n",
 		ways, cache_id, aux, l2x0_size >> 10);
 }
-- 
1.7.9.5
