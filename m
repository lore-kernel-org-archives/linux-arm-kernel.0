From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:43 +0900
Subject: [PATCH 02/12] ARM: shmobile: r8a7740 pinmux platform device cleanup
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 326a4ab..3a6b6fe 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
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
-- 
1.7.10.4
