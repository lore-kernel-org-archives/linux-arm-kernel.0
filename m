From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:27 +0900
Subject: [PATCH 3/9] ARM: shmobile: r8a7778: fixup Ether setup code position
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Ether setup code position was scattering.
This patch fixes it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 30b4a33..d6ee521 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -80,12 +80,6 @@ static struct sh_timer_config sh_tmu1_platform_data = {
 	.clocksource_rating	= 200,
 };
 
-/* Ether */
-static struct resource ether_resources[] = {
-	DEFINE_RES_MEM(0xfde00000, 0x400),
-	DEFINE_RES_IRQ(gic_iid(0x89)),
-};
-
 #define r8a7778_register_tmu(idx)			\
 	platform_device_register_resndata(		\
 		&platform_bus, "sh_tmu", idx,		\
@@ -94,6 +88,20 @@ static struct resource ether_resources[] = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
+/* Ether */
+static struct resource ether_resources[] = {
+	DEFINE_RES_MEM(0xfde00000, 0x400),
+	DEFINE_RES_IRQ(gic_iid(0x89)),
+};
+
+void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
+{
+	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  pdata, sizeof(*pdata));
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
@@ -118,14 +126,6 @@ void __init r8a7778_add_standard_devices(void)
 	r8a7778_register_tmu(1);
 }
 
-void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  pdata, sizeof(*pdata));
-}
-
 static struct renesas_intc_irqpin_config irqpin_platform_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 	.sense_bitfield_width = 2,
-- 
1.7.10.4
