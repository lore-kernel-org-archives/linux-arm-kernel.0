From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 16 May 2013 11:26:10 +0800
Subject: [PATCH v2] arm: prima2: use of_platform_populate instead of
 of_platform_bus_probe
Message-ID: <1368674770-18845-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use of_platform_populate to populate platform devices, it is suitable
for creating devices which are children of the root node, then makes
things like pcm work.

this patch removes sirfsoc_mach_init() function and lets arm core do
of_platform_populate:

    static int __init customize_machine(void)
    {
            /*
             * customizes platform devices, or adds new ones
             * On DT based machines, we fall back to populating the
             * machine from the device tree, if no callback is provided,
             * otherwise we would always need an init_machine callback.
             */
            if (machine_desc->init_machine)
                    machine_desc->init_machine();
            else
                    of_platform_populate(NULL, of_default_bus_match_table,
                                            NULL, NULL);
            return 0;
    }

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
---
 -v2: removes sirfsoc_mach_init() function as Arnd's comments

 arch/arm/mach-prima2/common.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 4f94cd8..5ae029f 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -17,16 +17,6 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
-static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{},
-};
-
-void __init sirfsoc_mach_init(void)
-{
-	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
-}
-
 void __init sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
@@ -57,7 +47,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
-	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 	.restart	= sirfsoc_restart,
@@ -77,7 +66,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
 	.dma_zone_size	= SZ_256M,
-	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
 	.restart	= sirfsoc_restart,
@@ -96,7 +84,6 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
-	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
 	.restart	= sirfsoc_restart,
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
