From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 03 Apr 2013 15:32:58 +0900
Subject: [PATCH 01/04] ARM: shmobile: r8a7740 pinmux platform device cleanup
In-Reply-To: <20130403063246.2500.65318.sendpatchset@w520>
References: <20130403063246.2500.65318.sendpatchset@w520>
Message-ID: <20130403063258.2500.17414.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7740.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-04-03 15:01:50.000000000 +0900
@@ -70,29 +70,15 @@ void __init r8a7740_map_io(void)
 }
 
 /* PFC */
-static struct resource r8a7740_pfc_resources[] = {
-	[0] = {
-		.start	= 0xe6050000,
-		.end	= 0xe6057fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0xe605800c,
-		.end	= 0xe605802b,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device r8a7740_pfc_device = {
-	.name		= "pfc-r8a7740",
-	.id		= -1,
-	.resource	= r8a7740_pfc_resources,
-	.num_resources	= ARRAY_SIZE(r8a7740_pfc_resources),
+static const struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xe6050000, 0x8000),
+	DEFINE_RES_MEM(0xe605800c, 0x0020),
 };
 
 void __init r8a7740_pinmux_init(void)
 {
-	platform_device_register(&r8a7740_pfc_device);
+	platform_device_register_simple("pfc-r8a7740", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
 }
 
 static struct renesas_intc_irqpin_config irqpin0_platform_data = {
