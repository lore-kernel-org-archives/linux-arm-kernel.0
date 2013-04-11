From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 11 Apr 2013 13:24:01 +0200
Subject: [PATCH v4 5/7] ARM: mach-shmobile: sh73a0: Setup the timer CMT10
 using DT
In-Reply-To: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1365679443-25456-5-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use the Device Tree for bringing up our timer device CMT10 on
the SoC sh73a0.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v4: same. only patch 2 and 3 changed

 arch/arm/boot/dts/sh73a0.dtsi         |   11 +++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |   32 --------------------------------
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ec40bf7..67b5089 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -222,4 +222,15 @@
 		cap-sd-highspeed;
 		status = "disabled";
 	};
+
+	timer at e6138010 {
+		compatible = "renesas,cmt-timer";
+		interrupt-parent = <&gic>;
+		reg = <0xe6138010 0xc>;
+		interrupts = <0 65 0x4>;
+		renesas,device-id = <1>;
+		renesas,channel-id = <0>;
+		renesas,source-quality = <3>;
+		renesas,event-quality = <3>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index d10ded0..024b7a6 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -235,37 +235,6 @@ static struct platform_device scif8_device = {
 	},
 };
 
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.channel_offset = 0x10,
-	.timer_bit = 0,
-	.clockevent_rating = 125,
-	.clocksource_rating = 125,
-};
-
-static struct resource cmt10_resources[] = {
-	[0] = {
-		.name	= "CMT10",
-		.start	= 0xe6138010,
-		.end	= 0xe613801b,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_spi(65),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device cmt10_device = {
-	.name		= "sh_cmt",
-	.id		= 10,
-	.dev = {
-		.platform_data	= &cmt10_platform_data,
-	},
-	.resource	= cmt10_resources,
-	.num_resources	= ARRAY_SIZE(cmt10_resources),
-};
-
 /* TMU */
 static struct sh_timer_config tmu00_platform_data = {
 	.name = "TMU00",
@@ -930,7 +899,6 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
-	&cmt10_device,
 };
 
 static struct platform_device *sh73a0_early_devices[] __initdata = {
-- 
1.7.9.5
