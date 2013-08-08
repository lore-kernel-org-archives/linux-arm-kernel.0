From: csd@broadcom.com (Christian Daudt)
Date: Thu, 8 Aug 2013 12:19:54 -0700
Subject: [PATCH] ARM: bcm: Make secure API call optional
Message-ID: <1375989594-12193-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current bcm_kona_smc_init function throws a BUG_ON if there's no SMC
device node defined in the device tree.

Since secure API access is optional depending the chip configuration,
fix this by allowing the rest of the code to run even if there's no SMC
device node defined

Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 56d9d19..e32c1b3 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -41,13 +41,14 @@ static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
 };
 
 /* Map in the bounce area */
-void __init bcm_kona_smc_init(void)
+int __init bcm_kona_smc_init(void)
 {
 	struct device_node *node;
 
 	/* Read buffer addr and size from the device tree node */
 	node = of_find_matching_node(NULL, bcm_kona_smc_ids);
-	BUG_ON(!node);
+	if (!node)
+		return -ENODEV;
 
 	/* Don't care about size or flags of the DT node */
 	bridge_data.buffer_addr =
@@ -59,7 +60,9 @@ void __init bcm_kona_smc_init(void)
 
 	bridge_data.initialized = 1;
 
-	pr_info("Secure API initialized!\n");
+	pr_info("Kona Secure API initialized\n");
+
+	return 0;
 }
 
 /* __bcm_kona_smc() should only run on CPU 0, with pre-emption disabled */
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.h b/arch/arm/mach-bcm/bcm_kona_smc.h
index 3bedbed1..d098a7e 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.h
+++ b/arch/arm/mach-bcm/bcm_kona_smc.h
@@ -64,7 +64,7 @@
 #define SSAPI_BRCM_START_VC_CORE	0x0E000008
 
 #ifndef	__ASSEMBLY__
-extern void bcm_kona_smc_init(void);
+extern int __init bcm_kona_smc_init(void);
 
 extern unsigned bcm_kona_smc(unsigned service_id,
 			     unsigned arg0,
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 2859932..70cc44f 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -29,15 +29,18 @@ static int __init kona_l2_cache_init(void)
 	if (!IS_ENABLED(CONFIG_CACHE_L2X0))
 		return 0;
 
+	if (bcm_kona_smc_init() < 0) {
+		pr_info("Kona secure API not available. Skipping L2 init\n");
+		return 0;
+	}
+
 	bcm_kona_smc(SSAPI_ENABLE_L2_CACHE, 0, 0, 0, 0);
 
 	/*
 	 * The aux_val and aux_mask have no effect since L2 cache is already
 	 * enabled.  Pass 0s for aux_val and 1s for aux_mask for default value.
 	 */
-	l2x0_of_init(0, ~0);
-
-	return 0;
+	return l2x0_of_init(0, ~0);
 }
 
 static void __init board_init(void)
@@ -45,8 +48,6 @@ static void __init board_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL,
 		&platform_bus);
 
-	bcm_kona_smc_init();
-
 	kona_l2_cache_init();
 }
 
-- 
1.7.10.4
