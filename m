From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:52 +0200
Subject: [PATCH v2 27/30] ARM: shmobile: kzm9g-reference: Initialise SCIF
 device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-28-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF device using DT when booting armadillo800eva
using DT reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 14 +++++++++++---
 arch/arm/mach-shmobile/setup-sh73a0.c        |  8 ++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index a99171c..df2ae46 100644
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
index 2248821..2c802ae 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -697,6 +697,10 @@ static struct platform_device irqpin3_device = {
 };
 
 static struct platform_device *sh73a0_devices_dt[] __initdata = {
+	&cmt1_device,
+};
+
+static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -706,10 +710,6 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
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
2.0.0.rc2
