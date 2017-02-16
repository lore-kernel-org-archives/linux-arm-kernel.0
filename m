From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:40 +1300
Subject: [PATCH v3 6/6] ARM: dts: mvebu: Move mv98dx3236 clock bindings
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-7-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the coreclk binding for the 98dx3236 SoC was inherited from
the armada-370/xp. This block is present in as much as it is possible to
read from the register location without causing any harm. However the
actual sampled at reset values are reflected in the DFX block.

Moving the binding to the DFX block enables support for different clock
strapping options in hardware.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - New. Split out from "clk: mvebu: Expand mv98dx3236-core-clock support"
    Changes in v3:
    - Clarify why the old location was wrong (but worked).

 .../devicetree/bindings/clock/mvebu-core-clock.txt         |  7 +++++++
 .../devicetree/bindings/clock/mvebu-gated-clock.txt        | 11 +++++++++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 14 +++++++-------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index eb985a633d59..796c260c183d 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -31,6 +31,12 @@ The following is a list of provided IDs and clock names on Armada 39x:
  4 = dclk    (SDRAM Interface Clock)
  5 = refclk  (Reference Clock)
 
+The following is a list of provided IDs and clock names on 98dx3236:
+ 0 = tclk    (Internal Bus clock)
+ 1 = cpuclk  (CPU clock)
+ 2 = ddrclk   (DDR clock)
+ 3 = mpll    (MPLL Clock)
+
 The following is a list of provided IDs and clock names on Kirkwood and Dove:
  0 = tclk   (Internal Bus clock)
  1 = cpuclk (CPU0 clock)
@@ -49,6 +55,7 @@ Required properties:
 	"marvell,armada-380-core-clock" - For Armada 380/385 SoC core clocks
 	"marvell,armada-390-core-clock" - For Armada 39x SoC core clocks
 	"marvell,armada-xp-core-clock" - For Armada XP SoC core clocks
+	"marvell,mv98dx3236-core-clock" - For 98dx3236 family SoC core clocks
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
 	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 5142efc8099d..de562da2ae77 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -119,6 +119,16 @@ ID	Clock	Peripheral
 29	sata1lnk
 30	sata1	SATA Host 1
 
+The following is a list of provided IDs for 98dx3236:
+ID	Clock	Peripheral
+-----------------------------------
+3	ge1	Gigabit Ethernet 1
+4	ge0	Gigabit Ethernet 0
+5	pex0	PCIe Cntrl 0
+17	sdio	SDHCI Host
+18	usb0	USB Host 0
+22	xor0	XOR DMA 0
+
 The following is a list of provided IDs for Dove:
 ID	Clock	Peripheral
 -----------------------------------
@@ -169,6 +179,7 @@ Required properties:
 	"marvell,armada-380-gating-clock" - for Armada 380/385 SoC clock gating
 	"marvell,armada-390-gating-clock" - for Armada 39x SoC clock gating
 	"marvell,armada-xp-gating-clock" - for Armada XP SoC clock gating
+	"marvell,mv98dx3236-gating-clock" - for 98dx3236 SoC clock gating
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
 - reg : shall be the register address of the Clock Gating Control register
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 6b81f7363d53..fe60a751c786 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -176,18 +176,12 @@
 			};
 
 			gateclk: clock-gating-control at 18220 {
-				compatible = "marvell,armada-xp-gating-clock";
+				compatible = "marvell,mv98dx3236-gating-clock";
 				reg = <0x18220 0x4>;
 				clocks = <&coreclk 0>;
 				#clock-cells = <1>;
 			};
 
-			coreclk: mvebu-sar at 18230 {
-				compatible = "marvell,mv98dx3236-core-clock";
-				reg = <0x18230 0x08>;
-				#clock-cells = <1>;
-			};
-
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,mv98dx3236-cpu-clock";
@@ -264,6 +258,12 @@
 			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
 			reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
 
+			coreclk: mvebu-sar at f8204 {
+				compatible = "marvell,mv98dx3236-core-clock";
+				reg = <0xf8204 0x4>;
+				#clock-cells = <1>;
+			};
+
 			soc-id at f8244 {
 				compatible = "marvell,mv98dx3236-soc-id";
 				reg = <0xf8244 0x4>;
-- 
2.11.0.24.ge6920cf
