From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 16:33:32 +0800
Subject: [PATCH 2/2] regulator: rename function regulator_register_fixed
In-Reply-To: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
References: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1333182812-423-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function regulator_register_fixed() is only meant for registering
fixed dummy regulators.  Rename it to regulator_register_fixed_dummy()
for the explicit meaning, so that people do not attempt to register
those real fixed regulators with this function.

It also removes the kernel doc for @name which is not a parameter for
the function at all.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-pcm037.c    |    3 ++-
 arch/arm/plat-mxc/3ds_debugboard.c |    3 ++-
 drivers/regulator/fixed-helper.c   |    5 ++---
 include/linux/regulator/fixed.h    |    4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 5fddf94..d8ceaba 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -586,7 +586,8 @@ static void __init pcm037_init(void)
 
 	imx31_soc_init();
 
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed_dummy(0, dummy_supplies,
+				       ARRAY_SIZE(dummy_supplies));
 
 	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
 
diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index d1e31fa..5e3cdf1 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -195,7 +195,8 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	irq_set_chained_handler(p_irq, mxc_expio_irq_handler);
 
 	/* Register Lan device on the debugboard */
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed_dummy(0, dummy_supplies,
+				       ARRAY_SIZE(dummy_supplies));
 
 	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
 	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index efb52dc..b24c90b 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -17,13 +17,12 @@ static void regulator_fixed_release(struct device *dev)
 }
 
 /**
- * regulator_register_fixed - register a no-op fixed regulator
- * @name: supply name
+ * regulator_register_fixed_dummy - register a dummy no-op fixed regulator
  * @id: platform device id
  * @supplies: consumers for this regulator
  * @num_supplies: number of consumers
  */
-struct platform_device *regulator_register_fixed(int id,
+struct platform_device *regulator_register_fixed_dummy(int id,
 		struct regulator_consumer_supply *supplies, int num_supplies)
 {
 	struct fixed_regulator_data *data;
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index 936a7d8..2a956a9 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -51,10 +51,10 @@ struct fixed_voltage_config {
 struct regulator_consumer_supply;
 
 #if IS_ENABLED(CONFIG_REGULATOR)
-struct platform_device *regulator_register_fixed(int id,
+struct platform_device *regulator_register_fixed_dummy(int id,
 		struct regulator_consumer_supply *supplies, int num_supplies);
 #else
-static inline struct platform_device *regulator_register_fixed(int id,
+static inline struct platform_device *regulator_register_fixed_dummy(int id,
 		struct regulator_consumer_supply *supplies, int num_supplies)
 {
 	return NULL;
-- 
1.7.5.4
