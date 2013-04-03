From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 03 Apr 2013 15:33:28 +0900
Subject: [PATCH 04/04] ARM: shmobile: sh73a0 pinmux platform device cleanup
In-Reply-To: <20130403063246.2500.65318.sendpatchset@w520>
References: <20130403063246.2500.65318.sendpatchset@w520>
Message-ID: <20130403063328.2500.86264.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use DEFINE_RES_MEM() and platform_device_register_simple()
to save a couple of lines of code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-04-03 15:19:37.000000000 +0900
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
+static const struct resource pfc_resources[] = {
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
