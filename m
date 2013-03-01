From: hechtb@gmail.com (Bastian Hecht)
Date: Fri,  1 Mar 2013 11:45:32 -0600
Subject: [PATCH 3/3] ARM: mach-shmobile: sh73a0: Setup the timer device CMT10
 using DT
In-Reply-To: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1362159932-18533-4-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use the Device Tree for bringing up our timer device CMT10.
We move it out of the DT devices list into the early_devices list by
the non-reference board code. And we add the device to the
kzm9g-reference .dts file.

Not-yet-signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
I wonder if this should go to arch/arm/boot/dts/sh73a0.dtsi.

The moving to the early_devices is a bit hackish - I will cook up a better
patch when I know into which .dts(i) file things go.

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   11 +++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 7fad4b9..fef12f0 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -69,6 +69,17 @@
 		toshiba,mmc-wrprotect-disable;
 		toshiba,mmc-has-idle-wait;
 	};
+
+	cmt at 0xe6138010 {
+		compatible = "renesas,cmt";
+		reg = <0xe6138010 0xc>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 65 0x4>;
+		renesas,timer-device-id = <1>;
+		renesas,timer-channel-id = <0>;
+		renesas,clocksource-rating = <125>;
+		renesas,clockevent-rating = <125>;
+	};
 };
 
 &mmcif {
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 6259e07..b7fdec0 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -913,10 +913,10 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
-	&cmt10_device,
 };
 
 static struct platform_device *sh73a0_early_devices[] __initdata = {
+	&cmt10_device,
 	&tmu00_device,
 	&tmu01_device,
 };
-- 
1.7.9.5
