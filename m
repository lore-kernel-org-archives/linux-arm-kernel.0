From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 16:23:13 +0100
Subject: [PATCH 3/3] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports
 in DT
In-Reply-To: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383060193-1505-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383060193-1505-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Lager reference board file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 24 ++++++++++++++++++++----
 arch/arm/mach-shmobile/board-lager-reference.c | 18 ++----------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a923ab6..9830c87 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -16,8 +16,13 @@
 	model = "Lager";
 	compatible = "renesas,lager", "renesas,r8a7790";
 
+	aliases {
+		serial0 = &scif0;
+		serial1 = &scif1;
+	};
+
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "console=ttySC0,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
 
 	memory at 40000000 {
@@ -58,9 +63,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: scif0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
@@ -86,3 +88,17 @@
 	non-removable;
 	status = "okay";
 };
+
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
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index bc3d0d2..1f5d6e2 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -36,24 +36,10 @@ static void __init lager_init_time(void)
 static void __init lager_add_standard_devices(void)
 {
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to the CMT
+	 * CMT device until it gets moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1",
-		"scifb2", "scifa2", "scif0", "scif1",
-		"hscif0", "hscif1",
-	};
 	struct clk *clk;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
-		clk = clk_get(NULL, scif_names[i]);
-		if (clk) {
-			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
-			clk_put(clk);
-		}
-	}
 
 	clk = clk_get(NULL, "cmt0");
 	if (clk) {
-- 
1.8.1.5
