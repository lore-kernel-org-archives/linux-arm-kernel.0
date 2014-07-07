From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:34 +0200
Subject: [PATCH v2 09/30] ARM: shmobile: ape6evm-reference: Initialise SCIF
 device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF device using DT when booting ape6evm
using DT reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 14 +++++++++++---
 arch/arm/mach-shmobile/setup-r8a73a4.c          | 12 ++++++------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 70b1fff..a860f32 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -16,6 +16,10 @@
 	model = "APE6EVM";
 	compatible = "renesas,ape6evm-reference", "renesas,r8a73a4";
 
+	aliases {
+		serial0 = &scifa0;
+	};
+
 	chosen {
 		bootargs = "console=ttySC0,115200 ignore_loglevel rw";
 	};
@@ -90,9 +94,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa0_pins>;
-	pinctrl-names = "default";
-
 	scifa0_pins: serial0 {
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
@@ -123,6 +124,13 @@
 	status = "okay";
 };
 
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	vmmc-supply = <&vcc_sdhi0>;
 	bus-width = <4>;
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index f470b3c..2e1ec5e 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -189,12 +189,6 @@ static struct resource cmt1_resources[] = {
 
 void __init r8a73a4_add_dt_devices(void)
 {
-	r8a73a4_register_scif(0);
-	r8a73a4_register_scif(1);
-	r8a73a4_register_scif(2);
-	r8a73a4_register_scif(3);
-	r8a73a4_register_scif(4);
-	r8a73a4_register_scif(5);
 	r8a7790_register_cmt(1);
 }
 
@@ -289,6 +283,12 @@ static struct resource dma_resources[] = {
 void __init r8a73a4_add_standard_devices(void)
 {
 	r8a73a4_add_dt_devices();
+	r8a73a4_register_scif(0);
+	r8a73a4_register_scif(1);
+	r8a73a4_register_scif(2);
+	r8a73a4_register_scif(3);
+	r8a73a4_register_scif(4);
+	r8a73a4_register_scif(5);
 	r8a73a4_register_irqc(0);
 	r8a73a4_register_irqc(1);
 	r8a73a4_register_thermal();
-- 
2.0.0.rc2
