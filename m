From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:36 +0900
Subject: [PATCH 23/24] ARM: shmobile: marzen: Initialise SCIF devices using DT
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <6d4abd79c80742629477479b01077bb92eccdd53.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF devices using DT when booting marzen
using multiplatform.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts   | 22 +++++++++++++++++++---
 arch/arm/mach-shmobile/setup-r8a7779.c |  8 ++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 3212908..20b1768 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -18,6 +18,11 @@
 	model = "marzen";
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
+	aliases {
+		serial2 = &scif2;
+		serial4 = &scif4;
+	};
+
 	chosen {
 		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
 	};
@@ -74,9 +79,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins &scif4_pins>;
-	pinctrl-names = "default";
-
 	lan0_pins: lan0 {
 		intc {
 			renesas,groups = "intc_irq1_b";
@@ -109,6 +111,20 @@
 	};
 };
 
+&scif2 {
+       pinctrl-0 = <&scif2_pins>;
+       pinctrl-names = "default";
+
+       status = "okay";
+};
+
+&scif4 {
+       pinctrl-0 = <&scif4_pins>;
+       pinctrl-names = "default";
+
+       status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index f96a304..2f59b99 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -640,16 +640,16 @@ static void __init r8a7779_register_hpb_dmae(void)
 }
 
 static struct platform_device *r8a7779_devices_dt[] __initdata = {
+	&tmu0_device,
+};
+
+static struct platform_device *r8a7779_standard_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
 	&scif3_device,
 	&scif4_device,
 	&scif5_device,
-	&tmu0_device,
-};
-
-static struct platform_device *r8a7779_standard_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
 	&i2c2_device,
-- 
2.0.0.rc2
