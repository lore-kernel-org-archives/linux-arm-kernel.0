From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 11 Feb 2014 21:34:37 +0100
Subject: [PATCH v4 1/2] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial
 ports in DT
In-Reply-To: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392150878-10436-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392150878-10436-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Lager reference board file.

As a side effect of switching to DT-based serial port instantiation,
ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
source if now shared between lager and lager-reference, we need to
update the serial ports in C code as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 24 ++++++++++++++++++++----
 arch/arm/mach-shmobile/board-lager-reference.c | 18 ++----------------
 arch/arm/mach-shmobile/clock-r8a7790.c         | 16 ++++++++--------
 arch/arm/mach-shmobile/setup-r8a7790.c         | 26 +++++++++++++-------------
 4 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..4199ae4 100644
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
@@ -63,9 +68,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
@@ -95,3 +97,17 @@
 &sata1 {
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
index dc8d76b..35fc0f2 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -31,24 +31,10 @@ static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to the CMT
+	 * device until it gets moved to DT.
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
-		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
-			clk_put(clk);
-		}
-	}
 
 	clk = clk_get(NULL, "cmt0");
 	if (!IS_ERR(clk)) {
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 08a2803..4b276ef 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -318,14 +318,14 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP */
 	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP1005]),
-	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
-	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
-	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
-	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]),
-	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
-	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
-	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
-	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP721]),
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c4616f0..b237268 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -221,14 +221,14 @@ static struct resource scif##index##_resources[] = {			\
 	__R8A7790_SCIF(PORT_HSCIF, SCSCR_RE | SCSCR_TE,			\
 		       index, baseaddr, irq)
 
-R8A7790_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
-R8A7790_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
-R8A7790_SCIFB(2, 0xe6c20000, gic_spi(148)); /* SCIFB0 */
-R8A7790_SCIFB(3, 0xe6c30000, gic_spi(149)); /* SCIFB1 */
-R8A7790_SCIFB(4, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
-R8A7790_SCIFA(5, 0xe6c60000, gic_spi(151)); /* SCIFA2 */
-R8A7790_SCIF(6,  0xe6e60000, gic_spi(152)); /* SCIF0 */
-R8A7790_SCIF(7,  0xe6e68000, gic_spi(153)); /* SCIF1 */
+R8A7790_SCIF(0,  0xe6e60000, gic_spi(152)); /* SCIF0 */
+R8A7790_SCIF(1,  0xe6e68000, gic_spi(153)); /* SCIF1 */
+R8A7790_SCIFA(2, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
+R8A7790_SCIFA(3, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
+R8A7790_SCIFB(4, 0xe6c20000, gic_spi(148)); /* SCIFB0 */
+R8A7790_SCIFB(5, 0xe6c30000, gic_spi(149)); /* SCIFB1 */
+R8A7790_SCIFB(6, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
+R8A7790_SCIFA(7, 0xe6c60000, gic_spi(151)); /* SCIFA2 */
 R8A7790_HSCIF(8, 0xe62c0000, gic_spi(154)); /* HSCIF0 */
 R8A7790_HSCIF(9, 0xe62c8000, gic_spi(155)); /* HSCIF1 */
 
@@ -290,6 +290,11 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_register_cmt(00);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
@@ -300,11 +305,6 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_register_cmt(00);
-}
-
-void __init r8a7790_add_standard_devices(void)
-{
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
-- 
1.8.3.2
