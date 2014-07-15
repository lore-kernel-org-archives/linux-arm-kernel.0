From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:16:38 +0900
Subject: [PATCH 8/8] ARM: shmobile: kzm9g-reference: Initialise SCIF device
 using DT
In-Reply-To: <cover.1405398515.git.horms+renesas@verge.net.au>
References: <cover.1405398515.git.horms+renesas@verge.net.au>
Message-ID: <700ce7c2bb2a4963472d95eba1436d6b0945918e.1405398515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF device using DT when booting armadillo800eva
using DT reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 14 +++++++++++---
 arch/arm/mach-shmobile/setup-sh73a0.c        |  8 ++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 838f93e4..18662ae 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -21,6 +21,10 @@
 	model = "KZM-A9-GT";
 	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
 
+	aliases {
+		serial4 = &scifa4;
+	};
+
 	cpus {
 		cpu at 0 {
 			cpu0-supply = <&vdd_dvfs>;
@@ -276,9 +280,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa4_pins>;
-	pinctrl-names = "default";
-
 	i2c3_pins: i2c3 {
 		renesas,groups = "i2c3_1";
 		renesas,function = "i2c3";
@@ -318,6 +319,13 @@
 	};
 };
 
+&scifa4 {
+	pinctrl-0 = <&scifa4_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index ad00724..2e1e289 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -696,6 +696,10 @@ static struct platform_device irqpin3_device = {
 };
 
 static struct platform_device *sh73a0_devices_dt[] __initdata = {
+	&cmt1_device,
+};
+
+static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -705,10 +709,6 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
-	&cmt1_device,
-};
-
-static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&tmu0_device,
 	&ipmmu_device,
 };
-- 
2.0.0
