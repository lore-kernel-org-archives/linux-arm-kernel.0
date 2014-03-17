From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:04 +0000
Subject: [PATCH 30/44] ARM: l2c: remove obsolete l2x0 ops for non-OF init
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDo-0002dt-Hu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

non-OF initialisation has never been used with any cache controller
which isn't an ARM cache controller, so we can safely get rid of the
old (and buggy) l2x0_*-based operations structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 29d12ae05c39..606f9eed1b23 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -363,19 +363,6 @@ static void l2x0_resume(void)
 		l2x0_enable(base, l2x0_saved_regs.aux_ctrl);
 }
 
-static const struct l2c_init_data l2x0_init_fns __initconst = {
-	.enable = l2x0_enable,
-	.outer_cache = {
-		.inv_range = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all = l2x0_flush_all,
-		.disable = l2x0_disable,
-		.sync = l2x0_cache_sync,
-		.resume = l2x0_resume,
-	},
-};
-
 /*
  * L2C-210 specific code.
  *
@@ -974,9 +961,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	default:
-		data = &l2x0_init_fns;
-		break;
-
 	case L2X0_CACHE_ID_PART_L210:
 		data = &l2c210_data;
 		break;
-- 
1.8.3.1
