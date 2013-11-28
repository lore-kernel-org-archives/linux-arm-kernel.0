From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:43 +0900
Subject: [PATCH 13/16] ARM: shmobile: r8a7779: cleanup registration of sh_eth
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <be15182068582bc38281329d86d106adaca63fda.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_eth driver which needs platform data at the time of
registration is not used.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed
if DT support is completed.
Current driver registration method which needs platform data
and which is not shared complicates codes.
This means legacy C code cleanup after DT supporting
will be more complicated
This patch removes r8a7779_add_ether_device()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  2 --
 arch/arm/mach-shmobile/setup-r8a7779.c        | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 1cab247..5014145 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -3,7 +3,6 @@
 
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
-#include <linux/sh_eth.h>
 
 /* HPB-DMA slave IDs */
 enum {
@@ -39,7 +38,6 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 51a43c5..8f94531 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -598,18 +598,6 @@ static struct platform_device ohci1_device = {
 	.resource	= ohci1_resources,
 };
 
-/* Ether */
-static struct resource ether_resources[] __initdata = {
-	{
-		.start	= 0xfde00000,
-		.end	= 0xfde003ff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= gic_iid(0xb4),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
 /* HPB-DMA */
 
 /* Asynchronous mode register bits */
@@ -798,14 +786,6 @@ void __init r8a7779_add_standard_devices(void)
 	r8a7779_register_hpb_dmae();
 }
 
-void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
-- 
1.8.4
