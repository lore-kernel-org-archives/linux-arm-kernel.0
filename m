From: syin@broadcom.com (Sherman Yin)
Date: Tue, 23 Apr 2013 16:55:40 -0700
Subject: [PATCH v2] ARM: Fix l2x0_init log message
In-Reply-To: <5ddc968feee3af6c462b24ca53eeeb11bbb7b7a3>
References: <5ddc968feee3af6c462b24ca53eeeb11bbb7b7a3>
Message-ID: <1366761340-6550-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the log at the end of l2x0_init(), "ways" and "l2x0_size" should be derived
from the most recently read value from the AUX register.  Previously, these
were derived from the earlier value of the AUX register with modifications by
the function paramters aux_val and aux_mask.

Signed-off-by: Sherman Yin <syin@broadcom.com>
---
v2: Corrected switch statement

arch/arm/mm/cache-l2x0.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c465fac..ca50099 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -376,14 +376,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
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
@@ -417,6 +409,37 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		outer_cache.disable = l2x0_disable;
 	}
 
+	/* Update number of ways based on aux ctrl register value */
+	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
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
