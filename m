From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:56 +0100
Subject: [PATCH 91/97] ARM: l2c: convert highbank to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerJM-0001Zs-VI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-highbank/highbank.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 245e588859ec..8c35ae4ff176 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -66,12 +66,6 @@ static void __init highbank_init_irq(void)
 
 	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
 		highbank_scu_map_io();
-
-	/* Enable PL310 L2 Cache controller */
-	if (IS_ENABLED(CONFIG_CACHE_L2X0)) {
-		outer_cache.write_sec = highbank_l2c310_write_sec;
-		l2x0_of_init(0, ~0);
-	}
 }
 
 static void highbank_power_off(void)
@@ -185,6 +179,9 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
 #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
 	.dma_zone_size	= (4ULL * SZ_1G),
 #endif
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.l2c_write_sec	= highbank_l2c310_write_sec,
 	.init_irq	= highbank_init_irq,
 	.init_machine	= highbank_init,
 	.dt_compat	= highbank_match,
-- 
1.8.3.1
