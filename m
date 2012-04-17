From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:44:06 +0100
Subject: [PATCH 14/16] ARM: ux500: Fork cpu-db8500 platform_devs for
 sequential DT enablement
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in sequential one-by-one Device Tree enablement, we split
cpu-db8500's platform_devs structure into normal platform boot, where
we leave all devices to be added in tact and a DT version where we
will remove the devices as they are DT enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 58768d9..c97eab7 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -121,6 +121,12 @@ static struct platform_device *platform_devs[] __initdata = {
 	&db8500_prcmu_device,
 };
 
+static struct platform_device *of_platform_devs[] __initdata = {
+	&u8500_dma40_device,
+	&db8500_pmu_device,
+	&db8500_prcmu_device,
+};
+
 static resource_size_t __initdata db8500_gpio_base[] = {
 	U8500_GPIOBANK0_BASE,
 	U8500_GPIOBANK1_BASE,
@@ -221,10 +227,16 @@ struct device * __init u8500_of_init_devices(void)
 	platform_device_register_data(parent,
 		"cpufreq-u8500", -1, NULL, 0);
 
-	for (i = 0; i < ARRAY_SIZE(platform_devs); i++)
-		platform_devs[i]->dev.parent = parent;
+	for (i = 0; i < ARRAY_SIZE(of_platform_devs); i++)
+		of_platform_devs[i]->dev.parent = parent;
 
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+	/*
+	 * Devices to be DT:ed:
+	 *   u8500_dma40_device  = todo
+	 *   db8500_pmu_device   = todo
+	 *   db8500_prcmu_device = todo
+	 */
+	platform_add_devices(of_platform_devs, ARRAY_SIZE(of_platform_devs));
 
 	return parent;
 }
-- 
1.7.9.1
