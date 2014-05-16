From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:08 +0900
Subject: [PATCH 1/2] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports
 in DT
In-Reply-To: <cover.1400201670.git.horms+renesas@verge.net.au>
References: <cover.1400201670.git.horms+renesas@verge.net.au>
Message-ID: <4e9c4877aacc134b568e480eb8998de58b43d63e.1400201670.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Lager reference board file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: updated changelog to remove references to
                             device renaming]
[horms+renesas at verge.net.au: resolved conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 21 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c | 10 ----------
 arch/arm/mach-shmobile/setup-r8a7790.c         | 10 +++++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..25e0485 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -17,6 +17,11 @@
 	model = "Lager";
 	compatible = "renesas,lager", "renesas,r8a7790";
 
+	aliases {
+		serial6 = &scif0;
+		serial7 = &scif1;
+	};
+
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -112,7 +117,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
 
 	du_pins: du {
@@ -221,6 +226,20 @@
 	};
 };
 
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1bca2748..749832e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -91,16 +91,6 @@ static void __init lager_add_du_device(void)
  */
 static const struct clk_name clk_names[] __initconst = {
 	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
-	{ "scifa0", NULL, "sh-sci.0" },
-	{ "scifa1", NULL, "sh-sci.1" },
-	{ "scifb0", NULL, "sh-sci.2" },
-	{ "scifb1", NULL, "sh-sci.3" },
-	{ "scifb2", NULL, "sh-sci.4" },
-	{ "scifa2", NULL, "sh-sci.5" },
-	{ "scif0", NULL, "sh-sci.6" },
-	{ "scif1", NULL, "sh-sci.7" },
-	{ "hscif0", NULL, "sh-sci.8" },
-	{ "hscif1", NULL, "sh-sci.9" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 87327f3..5fc9b17 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -287,6 +287,11 @@ static struct resource cmt0_resources[] = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_register_cmt(0);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
@@ -297,11 +302,6 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_register_cmt(0);
-}
-
-void __init r8a7790_add_standard_devices(void)
-{
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
-- 
1.8.5.2
