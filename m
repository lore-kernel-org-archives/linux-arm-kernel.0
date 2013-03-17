From: hechtb@gmail.com (Bastian Hecht)
Date: Sun, 17 Mar 2013 16:43:51 +0100
Subject: [PATCH v3 7/7] ARM: mach-shmobile: r8a7740: Setup the timer CMT10
 using DT
In-Reply-To: <1363535031-21402-1-git-send-email-hechtb+renesas@gmail.com>
References: <1363535031-21402-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1363535031-21402-7-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use the Device Tree for bringing up our timer device CMT10 on
the SoC r8a7740.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v3: same (only patch 0003 changed)

 arch/arm/boot/dts/r8a7740.dtsi         |   11 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |   33 --------------------------------
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..72f4c80 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -18,4 +18,15 @@
 			compatible = "arm,cortex-a9";
 		};
 	};
+
+	timer at e6138010 {
+		compatible = "renesas,cmt-timer";
+		interrupt-parent = <&intca>;
+		reg = <0xe6138010 0xc>;
+		interrupts = <0x0b00>;
+		renesas,device-id = <1>;
+		renesas,channel-id = <0>;
+		renesas,source-quality = <3>;
+		renesas,event-quality = <3>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 30ac79c..9db61a6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -255,38 +255,6 @@ static struct platform_device scifb_device = {
 	},
 };
 
-/* CMT */
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
-		.start	= evt2irq(0x0b00),
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
@@ -388,7 +356,6 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scifb_device,
-	&cmt10_device,
 	&tmu00_device,
 	&tmu01_device,
 	&tmu02_device,
-- 
1.7.9.5
