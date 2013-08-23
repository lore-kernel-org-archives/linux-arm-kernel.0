From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:19 +0100
Subject: [PATCH 19/40] ARM: ux500: Rip out keypad initialisation which is no
 longer used
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-20-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of the ux500 conversion over to Device Tree only
booting, but this stuff haven't been used for years.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/devices-db8500.c | 20 --------------------
 arch/arm/mach-ux500/devices-db8500.h | 15 ---------------
 arch/arm/mach-ux500/devices.h        |  1 -
 3 files changed, 36 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 516a6f5..3c5393b 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -56,26 +56,6 @@ struct platform_device u8500_dma40_device = {
 	.resource = dma40_resources
 };
 
-struct resource keypad_resources[] = {
-	[0] = {
-		.start = U8500_SKE_BASE,
-		.end = U8500_SKE_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_DB8500_KB,
-		.end = IRQ_DB8500_KB,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device u8500_ske_keypad_device = {
-	.name = "nmk-ske-keypad",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(keypad_resources),
-	.resource = keypad_resources,
-};
-
 struct prcmu_pdata db8500_prcmu_pdata = {
 	.ab_platdata	= &ab8500_platdata,
 	.ab_irq		= IRQ_DB8500_AB8500,
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index e47039b..be1d538 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -13,7 +13,6 @@
 #include "db8500-regs.h"
 #include "devices-common.h"
 
-struct ske_keypad_platform_data;
 struct pl022_ssp_controller;
 struct platform_device;
 
@@ -21,20 +20,6 @@ extern struct ab8500_platform_data ab8500_platdata;
 extern struct prcmu_pdata db8500_prcmu_pdata;
 extern struct platform_device db8500_prcmu_device;
 
-static inline struct platform_device *
-db8500_add_ske_keypad(struct device *parent,
-		      struct ske_keypad_platform_data *pdata,
-		      size_t size)
-{
-	struct resource resources[] = {
-		DEFINE_RES_MEM(U8500_SKE_BASE, SZ_4K),
-		DEFINE_RES_IRQ(IRQ_DB8500_KB),
-	};
-
-	return platform_device_register_resndata(parent, "nmk-ske-keypad", -1,
-						 resources, 2, pdata, size);
-}
-
 static inline struct amba_device *
 db8500_add_ssp(struct device *parent, const char *name, resource_size_t base,
 	       int irq, struct pl022_ssp_controller *pdata)
diff --git a/arch/arm/mach-ux500/devices.h b/arch/arm/mach-ux500/devices.h
index 9b5eb69..eafb07a 100644
--- a/arch/arm/mach-ux500/devices.h
+++ b/arch/arm/mach-ux500/devices.h
@@ -15,6 +15,5 @@ extern struct platform_device u8500_gpio_devs[];
 extern struct amba_device ux500_pl031_device;
 
 extern struct platform_device u8500_dma40_device;
-extern struct platform_device ux500_ske_keypad_device;
 
 #endif
-- 
1.8.1.2
