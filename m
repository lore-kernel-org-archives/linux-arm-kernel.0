From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 27 Jun 2013 17:09:01 +0900
Subject: [PATCH v2] ARM: shmobile: sh73a0 pinmux platform device cleanup
Message-ID: <1372320541-32698-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[ remove const from resource pfc_resources to avoid section miss-match
  reported by 4.4.5 ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 96e7ca1..79a6040 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -61,29 +61,16 @@ void __init sh73a0_map_io(void)
 	iotable_init(sh73a0_io_desc, ARRAY_SIZE(sh73a0_io_desc));
 }
 
-static struct resource sh73a0_pfc_resources[] = {
-	[0] = {
-		.start	= 0xe6050000,
-		.end	= 0xe6057fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0xe605801c,
-		.end	= 0xe6058027,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device sh73a0_pfc_device = {
-	.name		= "pfc-sh73a0",
-	.id		= -1,
-	.resource	= sh73a0_pfc_resources,
-	.num_resources	= ARRAY_SIZE(sh73a0_pfc_resources),
+/* PFC */
+static struct resource pfc_resources[] __initdata = {
+	DEFINE_RES_MEM(0xe6050000, 0x8000),
+	DEFINE_RES_MEM(0xe605801c, 0x000c),
 };
 
 void __init sh73a0_pinmux_init(void)
 {
-	platform_device_register(&sh73a0_pfc_device);
+	platform_device_register_simple("pfc-sh73a0", -1, pfc_resources,
+					ARRAY_SIZE(pfc_resources));
 }
 
 static struct plat_sci_port scif0_platform_data = {
-- 
1.8.2.1
