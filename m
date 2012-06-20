From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:49 +0100
Subject: [PATCH 13/15] ARM: ux500: Remove temporary snowball_of_platform_devs
 enablement structure
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Device Tree enablement for Snowball's Platform  devices; LEDs, Keys,
Ethernet and all associated AB8500 Multi-Functional Devices are now
complete, so here we remove any trace of adding those devices when Device
Tree is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 3871162..0c5a69b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -783,10 +783,6 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_UX500_DT
 
-static struct platform_device *snowball_of_platform_devs[] __initdata = {
-	&snowball_key_dev,
-};
-
 struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires DMA and call-back bindings. */
 	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
@@ -840,8 +836,6 @@ static void __init u8500_init_machine(void)
 
 	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
 		mop500_platform_devs[i]->dev.parent = parent;
-	for (i = 0; i < ARRAY_SIZE(snowball_platform_devs); i++)
-		snowball_platform_devs[i]->dev.parent = parent;
 
 	/* automatically probe child nodes of db8500 device */
 	of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
@@ -860,17 +854,6 @@ static void __init u8500_init_machine(void)
 
 		mop500_uib_init();
 
-	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
-		/*
-		 * Devices to be DT:ed:
-		 *   snowball_led_dev   = done
-		 *   snowball_key_dev   = todo
-		 *   snowball_sbnet_dev = done
-		 *   ab8500_device      = done
-		 */
-		platform_add_devices(snowball_of_platform_devs,
-				ARRAY_SIZE(snowball_of_platform_devs));
-
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
 		/*
 		 * The HREFv60 board removed a GPIO expander and routed
-- 
1.7.9.5
