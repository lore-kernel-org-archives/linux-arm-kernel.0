From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:25 +0100
Subject: [PATCH 25/40] ARM: ux500: Do not register the PMU device if booting
 with ATAGs
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-26-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.h |  1 -
 arch/arm/mach-ux500/cpu-db8500.c   | 32 +-------------------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 3b35a73..2cced8b 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -87,7 +87,6 @@ extern struct msp_i2s_platform_data msp0_platform_data;
 extern struct msp_i2s_platform_data msp1_platform_data;
 extern struct msp_i2s_platform_data msp2_platform_data;
 extern struct msp_i2s_platform_data msp3_platform_data;
-extern struct arm_pmu_platdata db8500_pmu_platdata;
 extern struct amba_pl011_data uart0_plat;
 extern struct amba_pl011_data uart1_plat;
 extern struct amba_pl011_data uart2_plat;
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 1289a67..0ec6ddf 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -93,14 +93,6 @@ void __init u8500_map_io(void)
 		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 }
 
-static struct resource db8500_pmu_resources[] = {
-	[0] = {
-		.start		= IRQ_DB8500_PMU,
-		.end		= IRQ_DB8500_PMU,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
 /*
  * The PMU IRQ lines of two cores are wired together into a single interrupt.
  * Bounce the interrupt to the other core if it's not ours.
@@ -125,18 +117,6 @@ struct arm_pmu_platdata db8500_pmu_platdata = {
 	.handle_irq		= db8500_pmu_handler,
 };
 
-static struct platform_device db8500_pmu_device = {
-	.name			= "arm-pmu",
-	.id			= -1,
-	.num_resources		= ARRAY_SIZE(db8500_pmu_resources),
-	.resource		= db8500_pmu_resources,
-	.dev.platform_data	= &db8500_pmu_platdata,
-};
-
-static struct platform_device *platform_devs[] __initdata = {
-	&db8500_pmu_device,
-};
-
 static const char *db8500_read_soc_id(void)
 {
 	void __iomem *uid = __io_address(U8500_BB_UID_BASE);
@@ -161,17 +141,7 @@ static struct device * __init db8500_soc_device_init(void)
  */
 struct device * __init u8500_init_devices(void)
 {
-	struct device *parent;
-	int i;
-
-	parent = db8500_soc_device_init();
-
-	for (i = 0; i < ARRAY_SIZE(platform_devs); i++)
-		platform_devs[i]->dev.parent = parent;
-
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
-
-	return parent;
+	return db8500_soc_device_init();
 }
 
 #ifdef CONFIG_MACH_UX500_DT
-- 
1.8.1.2
