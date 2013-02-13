From: syin@broadcom.com (Sherman Yin)
Date: Wed, 13 Feb 2013 11:14:53 -0800
Subject: [PATCH] ARM: Fix up l2x0_init log message
In-Reply-To: <1360782893-20969-1-git-send-email-syin@broadcom.com>
References: <1360782893-20969-1-git-send-email-syin@broadcom.com>
Message-ID: <1360782893-20969-2-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The log at the end of l2x0_init() should print L2 cache info based on current
register value instead of function argument.
---
 arch/arm/mm/cache-l2x0.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c2f3739..011a584 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -377,14 +377,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	l2x0_way_mask = (1 << ways) - 1;
 
 	/*
-	 * L2 cache Size =  Way size * Number of ways
-	 */
-	way_size = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
-	way_size = 1 << (way_size + way_size_shift);
-
-	l2x0_size = ways * way_size * SZ_1K;
-
-	/*
 	 * Check if l2x0 controller is already enabled.
 	 * If you are booting from non-secure mode
 	 * accessing the below registers will fault.
@@ -418,6 +410,37 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		outer_cache.disable = l2x0_disable;
 	}
 
+	/* Update number of ways based on aux ctrl register value */
+	switch (cache_id) {
+	case L2X0_CACHE_ID_PART_L310:
+		if (aux & (1 << 16))
+			ways = 16;
+		else
+			ways = 8;
+		break;
+	case L2X0_CACHE_ID_PART_L210:
+		ways = (aux >> 13) & 0xf;
+		break;
+
+	case AURORA_CACHE_ID:
+		ways = (aux >> 13) & 0xf;
+		ways = 2 << ((ways + 1) >> 2);
+		way_size_shift = AURORA_WAY_SIZE_SHIFT;
+		break;
+	default:
+		/* Assume unknown chips have 8 ways */
+		ways = 8;
+		break;
+	}
+
+	/*
+	 * L2 cache Size =  Way size * Number of ways
+	 */
+	way_size = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
+	way_size = 1 << (way_size + way_size_shift);
+
+	l2x0_size = ways * way_size * SZ_1K;
+
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
 			ways, cache_id, aux, l2x0_size);
-- 
1.7.9.5
