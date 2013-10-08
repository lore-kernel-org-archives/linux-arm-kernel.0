From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Oct 2013 18:05:41 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a7778: cleanup registration of sh_eth
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
Message-ID: <cd4ab0420fd6233766fd87fa295d6e3cfb719c01.1381222967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_eth driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed
if DT support is completed.
Current driver registration method which needs platform data
and which is not shared complicates codes.
This means legacy C code cleanup after DT supporting
will be more complicated
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c          | 14 +++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        | 14 --------------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 4b696ce..f2bf61b 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -101,6 +101,12 @@ static struct resource sdhi0_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x77)),
 };
 
+/* Ether */
+static struct resource ether_resources[] __initdata = {
+	DEFINE_RES_MEM(0xfde00000, 0x400),
+	DEFINE_RES_IRQ(gic_iid(0x89)),
+};
+
 static struct sh_eth_plat_data ether_platform_data __initdata = {
 	.phy		= 0x01,
 	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
@@ -255,7 +261,13 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
-	r8a7778_add_ether_device(&ether_platform_data);
+
+	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_platform_data,
+					  sizeof(ether_platform_data));
+
 	platform_device_register_full(&vin0_info);
 	/* VIN1 has a pin conflict with Ether */
 	if (!IS_ENABLED(CONFIG_SH_ETH))
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 9838608..48933def 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 604cf36..f5e15c9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -174,20 +174,6 @@ static struct platform_device_info hci##_info __initdata = {	\
 USB_PLATFORM_INFO(ehci);
 USB_PLATFORM_INFO(ohci);
 
-/* Ether */
-static struct resource ether_resources[] __initdata = {
-	DEFINE_RES_MEM(0xfde00000, 0x400),
-	DEFINE_RES_IRQ(gic_iid(0x89)),
-};
-
-void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* PFC/GPIO */
 static struct resource pfc_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfffc0000, 0x118),
-- 
1.8.4
