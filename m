From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 11 Feb 2014 21:34:38 +0100
Subject: [PATCH v4 2/2] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial
 ports in DT
In-Reply-To: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392150878-10436-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Koelsch reference board
file.

As a side effect of switching to DT-based serial port instantiation,
ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
source if now shared between koelsch and koelsch-reference, we need to
update the serial ports in C code as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 24 ++++++++++++++---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 18 ++-----------
 arch/arm/mach-shmobile/clock-r8a7791.c           | 24 ++++++++---------
 arch/arm/mach-shmobile/setup-r8a7791.c           | 34 ++++++++++++------------
 4 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d4b9bba..42fd5eb 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -17,8 +17,13 @@
 	model = "Koelsch";
 	compatible = "renesas,koelsch", "renesas,r8a7791";
 
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
@@ -109,9 +114,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
@@ -132,6 +134,20 @@
 	status = "okay";
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
 &spi {
 	pinctrl-0 = <&qspi_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index feb8d97..46879d6 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -32,24 +32,10 @@ static void __init koelsch_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to the CMT
+	 * device until they get moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1", "scifb2", "scifa2",
-		"scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scifa3",
-		"scifa4", "scifa5",
-	};
 	struct clk *clk;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
-		clk = clk_get(NULL, scif_names[i]);
-		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
-			clk_put(clk);
-		}
-	}
 
 	clk = clk_get(NULL, "cmt0");
 	if (!IS_ERR(clk)) {
diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index c8227b3..fc9248d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -209,18 +209,18 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7791", &mstp_clks[MSTP726]),
 	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7791", &mstp_clks[MSTP724]),
 	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7791", &mstp_clks[MSTP723]),
-	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
-	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
-	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]), /* SCIFB0 */
-	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]), /* SCIFB1 */
-	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]), /* SCIFB2 */
-	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]), /* SCIFA2 */
-	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]), /* SCIF0 */
-	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]), /* SCIF1 */
-	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP719]), /* SCIF2 */
-	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP718]), /* SCIF3 */
-	CLKDEV_DEV_ID("sh-sci.10", &mstp_clks[MSTP715]), /* SCIF4 */
-	CLKDEV_DEV_ID("sh-sci.11", &mstp_clks[MSTP714]), /* SCIF5 */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP721]), /* SCIF0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP720]), /* SCIF1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP719]), /* SCIF2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP718]), /* SCIF3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP715]), /* SCIF4 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP714]), /* SCIF5 */
+	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP204]), /* SCIFA0 */
+	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP203]), /* SCIFA1 */
+	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB0 */
+	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP207]), /* SCIFB1 */
+	CLKDEV_DEV_ID("sh-sci.10", &mstp_clks[MSTP216]), /* SCIFB2 */
+	CLKDEV_DEV_ID("sh-sci.11", &mstp_clks[MSTP202]), /* SCIFA2 */
 	CLKDEV_DEV_ID("sh-sci.12", &mstp_clks[MSTP1105]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.13", &mstp_clks[MSTP1106]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.14", &mstp_clks[MSTP1107]), /* SCIFA5 */
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index e28404e..605f4cf 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -105,18 +105,18 @@ static struct resource scif##index##_resources[] = {			\
 #define R8A7791_SCIFB(index, baseaddr, irq)				\
 	__R8A7791_SCIF(PORT_SCIFB, index, baseaddr, irq)
 
-R8A7791_SCIFA(0,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
-R8A7791_SCIFA(1,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
-R8A7791_SCIFB(2,  0xe6c20000, gic_spi(148)); /* SCIFB0 */
-R8A7791_SCIFB(3,  0xe6c30000, gic_spi(149)); /* SCIFB1 */
-R8A7791_SCIFB(4,  0xe6ce0000, gic_spi(150)); /* SCIFB2 */
-R8A7791_SCIFA(5,  0xe6c60000, gic_spi(151)); /* SCIFA2 */
-R8A7791_SCIF(6,   0xe6e60000, gic_spi(152)); /* SCIF0 */
-R8A7791_SCIF(7,   0xe6e68000, gic_spi(153)); /* SCIF1 */
-R8A7791_SCIF(8,   0xe6e58000, gic_spi(22)); /* SCIF2 */
-R8A7791_SCIF(9,   0xe6ea8000, gic_spi(23)); /* SCIF3 */
-R8A7791_SCIF(10,  0xe6ee0000, gic_spi(24)); /* SCIF4 */
-R8A7791_SCIF(11,  0xe6ee8000, gic_spi(25)); /* SCIF5 */
+R8A7791_SCIF(0,   0xe6e60000, gic_spi(152)); /* SCIF0 */
+R8A7791_SCIF(1,   0xe6e68000, gic_spi(153)); /* SCIF1 */
+R8A7791_SCIF(2,   0xe6e58000, gic_spi(22)); /* SCIF2 */
+R8A7791_SCIF(3,   0xe6ea8000, gic_spi(23)); /* SCIF3 */
+R8A7791_SCIF(4,   0xe6ee0000, gic_spi(24)); /* SCIF4 */
+R8A7791_SCIF(5,   0xe6ee8000, gic_spi(25)); /* SCIF5 */
+R8A7791_SCIFA(6,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
+R8A7791_SCIFA(7,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
+R8A7791_SCIFB(8,  0xe6c20000, gic_spi(148)); /* SCIFB0 */
+R8A7791_SCIFB(9,  0xe6c30000, gic_spi(149)); /* SCIFB1 */
+R8A7791_SCIFB(10, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
+R8A7791_SCIFA(11, 0xe6c60000, gic_spi(151)); /* SCIFA2 */
 R8A7791_SCIFA(12, 0xe6c70000, gic_spi(29)); /* SCIFA3 */
 R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
 R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
@@ -185,6 +185,11 @@ static const struct resource thermal_resources[] __initconst = {
 
 void __init r8a7791_add_dt_devices(void)
 {
+	r8a7791_register_cmt(00);
+}
+
+void __init r8a7791_add_standard_devices(void)
+{
 	r8a7791_register_scif(0);
 	r8a7791_register_scif(1);
 	r8a7791_register_scif(2);
@@ -200,11 +205,6 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_scif(12);
 	r8a7791_register_scif(13);
 	r8a7791_register_scif(14);
-	r8a7791_register_cmt(00);
-}
-
-void __init r8a7791_add_standard_devices(void)
-{
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
-- 
1.8.3.2
