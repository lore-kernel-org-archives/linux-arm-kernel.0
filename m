From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 30 Dec 2009 09:31:47 -0500
Subject: [PATCH] [ARM] pxa: unable to enable L2 in outer cache
Message-ID: <mailman.110.1262158053.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Outer cache checked whether L2 is enabled or not. If L2 isn't enabled in XSC3,
it would enable L2. This operation is evil that would make system hang.

In XSC3 core document, these words are mentioned in below.

"Following reset, the L2 Unified Cache Enable bit is cleared. To enable the L2
Cache, software may set the bit to a '1' before or at the same time as enabling
the MMU. Enabling the L2 Cache after the MMU has been enabled or disabling the
L2 Cache after the L2 Cache has been enabled, may result in unpredictable
behavior of the processor."

When outer cache is initialized, the MMU is already enabled. We couldn't enable
L2 after MMU enabled.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mm/cache-xsc3l2.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-xsc3l2.c b/arch/arm/mm/cache-xsc3l2.c
index 5d180cb..c315492 100644
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -221,15 +221,14 @@ static int __init xsc3_l2_init(void)
 	if (!cpu_is_xsc3() || !xsc3_l2_present())
 		return 0;

-	if (!(get_cr() & CR_L2)) {
+	if (get_cr() & CR_L2) {
 		pr_info("XScale3 L2 cache enabled.\n");
-		adjust_cr(CR_L2, CR_L2);
 		xsc3_l2_inv_all();
-	}

-	outer_cache.inv_range = xsc3_l2_inv_range;
-	outer_cache.clean_range = xsc3_l2_clean_range;
-	outer_cache.flush_range = xsc3_l2_flush_range;
+		outer_cache.inv_range = xsc3_l2_inv_range;
+		outer_cache.clean_range = xsc3_l2_clean_range;
+		outer_cache.flush_range = xsc3_l2_flush_range;
+	}

 	return 0;
 }
-- 
1.5.6.5
