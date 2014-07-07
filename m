From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:42 +0200
Subject: [PATCH v2 17/30] ARM: shmobile: armadillo800eva-reference: Initialise
 SCIF device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF device using DT when booting armadillo800eva
using DT reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 14 +++++++++++---
 arch/arm/mach-shmobile/setup-r8a7740.c                  |  8 ++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index f6ef73f..f47ab76 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -19,6 +19,10 @@
 	model = "armadillo 800 eva reference";
 	compatible = "renesas,armadillo800eva-reference", "renesas,r8a7740";
 
+	aliases {
+		serial1 = &scifa1;
+	};
+
 	chosen {
 		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
@@ -202,9 +206,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa1_pins>;
-	pinctrl-names = "default";
-
 	ether_pins: ether {
 		renesas,groups = "gether_mii", "gether_int";
 		renesas,function = "gether";
@@ -256,6 +257,13 @@
 	status = "okay";
 };
 
+&scifa1 {
+	pinctrl-0 = <&scifa1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 348af35..3d5eaca 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -312,6 +312,10 @@ static struct platform_device ipmmu_device = {
 };
 
 static struct platform_device *r8a7740_devices_dt[] __initdata = {
+	&cmt1_device,
+};
+
+static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -321,10 +325,6 @@ static struct platform_device *r8a7740_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
-	&cmt1_device,
-};
-
-static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&irqpin0_device,
 	&irqpin1_device,
 	&irqpin2_device,
-- 
2.0.0.rc2
