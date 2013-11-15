From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:53:56 -0700
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to DT
 bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Many of the Tegra DT binding documents say nothing about the clocks or
clock-names properties, yet those are present and required in DT files.
This patch simply updates the documentation file to match the implicit
definition of the binding, based on real-world DT content.

All Tegra bindings that mention clocks are updated to have consistent
wording and formatting of the clock-related properties.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  1 +
 .../devicetree/bindings/dma/tegra20-apbdma.txt     |  3 ++
 .../bindings/gpu/nvidia,tegra20-host1x.txt         | 61 ++++++++++++++++++++++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt | 14 ++---
 .../bindings/input/nvidia,tegra20-kbc.txt          |  3 ++
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  3 ++
 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  8 +++
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 16 +++---
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |  3 ++
 .../devicetree/bindings/rtc/nvidia,tegra20-rtc.txt |  3 ++
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  3 ++
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |  7 +--
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |  7 +--
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |  7 +--
 .../bindings/sound/nvidia,tegra-audio-wm8903.txt   |  7 +--
 .../bindings/sound/nvidia,tegra-audio-wm9712.txt   |  7 +--
 .../bindings/sound/nvidia,tegra20-ac97.txt         |  4 ++
 .../bindings/sound/nvidia,tegra20-i2s.txt          |  3 ++
 .../bindings/sound/nvidia,tegra30-ahub.txt         | 21 ++++++--
 .../bindings/sound/nvidia,tegra30-i2s.txt          |  5 +-
 .../bindings/spi/nvidia,tegra114-spi.txt           |  8 ++-
 .../bindings/spi/nvidia,tegra20-sflash.txt         |  4 +-
 .../bindings/spi/nvidia,tegra20-slink.txt          |  4 +-
 .../bindings/timer/nvidia,tegra20-timer.txt        |  3 ++
 .../bindings/timer/nvidia,tegra30-timer.txt        |  3 ++
 .../bindings/usb/nvidia,tegra20-ehci.txt           |  3 +-
 26 files changed, 172 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 1608a54e90e1..68ac65f82a1c 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible : Should contain "nvidia,tegra<chip>-pmc".
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
   "pclk" (The Tegra clock of that name),
   "clk32k_in" (The 32KHz clock input to Tegra).
diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
index 90fa7da525b8..74bfc54bb184 100644
--- a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
+++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
@@ -5,6 +5,8 @@ Required properties:
 - reg: Should contain DMA registers location and length. This shuld include
   all of the per-channel registers.
 - interrupts: Should contain all of the per-channel DMA interrupts.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Examples:
 
@@ -27,4 +29,5 @@ apbdma: dma at 6000a000 {
 		       0 149 0x04
 		       0 150 0x04
 		       0 151 0x04 >;
+	clocks = <&tegra_car 34>;
 };
diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
index b4fa934ae3a2..c9a715a75f60 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
@@ -9,6 +9,8 @@ Required properties:
 - #size-cells: The number of cells used to represent the size of an address
   range in the host1x address space. Should be 1.
 - ranges: The mapping of the host1x address space to the CPU address space.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 The host1x top-level node defines a number of children, each representing one
 of the following host1x client modules:
@@ -19,6 +21,8 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-mpe"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - vi: video input
 
@@ -26,6 +30,8 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-vi"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - epp: encoder pre-processor
 
@@ -33,6 +39,8 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-epp"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - isp: image signal processor
 
@@ -40,6 +48,8 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-isp"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - gr2d: 2D graphics engine
 
@@ -47,12 +57,23 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-gr2d"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - gr3d: 3D graphics engine
 
   Required properties:
   - compatible: "nvidia,tegra<chip>-gr3d"
   - reg: Physical base address and length of the controller's registers.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
+  - clocks : Must contain an entry for each entry in clock-names.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names : Must include the following entries:
+    (This property may be omitted if the only clock in the list is "3d")
+    - 3d
+      This MUST be the first entry.
+    - 3d2 (Only required on SoCs with two 3D clocks)
 
 - dc: display controller
 
@@ -60,6 +81,12 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-dc"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain an entry for each entry in clock-names.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names : Must include the following entries:
+    - disp1 or disp2 (depending on the controller instance)
+      This MUST be the first entry.
+    - parent
 
   Each display controller node has a child node, named "rgb", that represents
   the RGB output associated with the controller. It can take the following
@@ -76,6 +103,12 @@ of the following host1x client modules:
   - interrupts: The interrupt outputs from the controller.
   - vdd-supply: regulator for supply voltage
   - pll-supply: regulator for PLL
+  - clocks : Must contain an entry for each entry in clock-names.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names : Must include the following entries:
+    - hdmi
+      This MUST be the first entry.
+    - parent
 
   Optional properties:
   - nvidia,ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
@@ -88,12 +121,22 @@ of the following host1x client modules:
   - compatible: "nvidia,tegra<chip>-tvo"
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
 
 - dsi: display serial interface
 
   Required properties:
   - compatible: "nvidia,tegra<chip>-dsi"
   - reg: Physical base address and length of the controller's registers.
+  - clocks : Must contain one entry, for the module clock.
+    See ../clocks/clock-bindings.txt for details.
+  - clocks : Must contain an entry for each entry in clock-names.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names : Must include the following entries:
+    - dsi
+      This MUST be the first entry.
+    - parent
 
 Example:
 
@@ -105,6 +148,7 @@ Example:
 		reg = <0x50000000 0x00024000>;
 		interrupts = <0 65 0x04   /* mpcore syncpt */
 			      0 67 0x04>; /* mpcore general */
+		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -115,41 +159,50 @@ Example:
 			compatible = "nvidia,tegra20-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <0 68 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_MPE>;
 		};
 
 		vi {
 			compatible = "nvidia,tegra20-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <0 69 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_VI>;
 		};
 
 		epp {
 			compatible = "nvidia,tegra20-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <0 70 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_EPP>;
 		};
 
 		isp {
 			compatible = "nvidia,tegra20-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <0 71 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_ISP>;
 		};
 
 		gr2d {
 			compatible = "nvidia,tegra20-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <0 72 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 		};
 
 		gr3d {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
+			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 		};
 
 		dc at 54200000 {
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <0 73 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_DISP1>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>;
+			clock-names = "disp1", "parent";
 
 			rgb {
 				status = "disabled";
@@ -160,6 +213,9 @@ Example:
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <0 74 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_DISP2>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>;
+			clock-names = "disp2", "parent";
 
 			rgb {
 				status = "disabled";
@@ -170,6 +226,9 @@ Example:
 			compatible = "nvidia,tegra20-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <0 75 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_HDMI>,
+				 <&tegra_car TEGRA20_CLK_PLL_D_OUT0>;
+			clock-names = "hdmi", "parent";
 			status = "disabled";
 		};
 
@@ -177,12 +236,14 @@ Example:
 			compatible = "nvidia,tegra20-tvo";
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <0 76 0x04>;
+			clocks = <&tegra_car TEGRA20_CLK_TVO>;
 			status = "disabled";
 		};
 
 		dsi {
 			compatible = "nvidia,tegra20-dsi";
 			reg = <0x54300000 0x00040000>;
+			clocks = <&tegra_car TEGRA20_CLK_DSI>;
 			status = "disabled";
 		};
 	};
diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index ef77cc7a0e46..96ab40131ae1 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -39,12 +39,14 @@ Required properties:
 - interrupts: Should contain I2C controller interrupts.
 - address-cells: Address cells for I2C device address.
 - size-cells: Size of the I2C device address.
-- clocks: Clock ID as per
-		Documentation/devicetree/bindings/clock/tegra<chip-id>.txt
-	for I2C controller.
-- clock-names: Name of the clock:
-	Tegra20/Tegra30 I2C controller: "div-clk and "fast-clk".
-	Tegra114 I2C controller: "div-clk".
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  Tegra20/Tegra30:
+  - div-clk
+  - fast-clk
+  Tegra114:
+  - div-clk
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
index 2995fae7ee47..cc28d2194c37 100644
--- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
@@ -13,6 +13,8 @@ Required properties:
   array of pin numbers which is used as column.
 - linux,keymap: The keymap for keys as described in the binding document
   devicetree/bindings/input/matrix-keymap.txt.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Optional properties, in addition to those specified by the shared
 matrix-keyboard bindings:
@@ -31,6 +33,7 @@ keyboard: keyboard {
 	compatible = "nvidia,tegra20-kbc";
 	reg = <0x7000e200 0x100>;
 	interrupts = <0 85 0x04>;
+	clocks = <&tegra_car 36>;
 	nvidia,ghost-filter;
 	nvidia,debounce-delay-ms = <640>;
 	nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index c6d7b11db9eb..f727902a9e8d 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -8,6 +8,8 @@ by mmc.txt and the properties used by the sdhci-tegra driver.
 
 Required properties:
 - compatible : Should be "nvidia,<chip>-sdhci"
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Optional properties:
 - power-gpios : Specify GPIOs for power control
@@ -18,6 +20,7 @@ sdhci at c8000200 {
 	compatible = "nvidia,tegra20-sdhci";
 	reg = <0xc8000200 0x200>;
 	interrupts = <47>;
+	clocks = <&tegra_car 14>;
 	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
 	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
index 5aeee53ff9f4..a97fe575ca29 100644
--- a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
+++ b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
@@ -7,3 +7,11 @@ Required properties:
 - clock-frequency : the frequency of the i2c bus
 - gpios : the gpio used for ec request
 - slave-addr: the i2c address of the slave controller
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  Tegra20/Tegra30:
+  - div-clk
+  - fast-clk
+  Tegra114:
+  - div-clk
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 6b7510775c50..ad2eb9804afa 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -42,14 +42,14 @@ Required properties:
     - 0xc2000000: prefetchable memory region
   Please refer to the standard PCI bus binding document for a more detailed
   explanation.
-- clocks: List of clock inputs of the controller. Must contain an entry for
-  each entry in the clock-names property.
-- clock-names: Must include the following entries:
-  "pex": The Tegra clock of that name
-  "afi": The Tegra clock of that name
-  "pcie_xclk": The Tegra clock of that name
-  "pll_e": The Tegra clock of that name
-  "cml": The Tegra clock of that name (not required for Tegra20)
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - pex
+  - afi
+  - pcie_xclk
+  - pll_e
+  - cml (not required for Tegra20)
 
 Root ports are defined as subnodes of the PCIe controller node.
 
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index c3fc57af8772..0d608d34fed0 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -7,6 +7,8 @@ Required properties:
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
   the cells format.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Example:
 
@@ -14,4 +16,5 @@ Example:
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
+		clocks = <&tegra_car 17>;
 	};
diff --git a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt b/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
index 93f45e9dce7c..652d1ff2e8be 100644
--- a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
@@ -9,6 +9,8 @@ Required properties:
 - compatible : should be "nvidia,tegra20-rtc".
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A single interrupt specifier.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Example:
 
@@ -16,4 +18,5 @@ timer {
 	compatible = "nvidia,tegra20-rtc";
 	reg = <0x7000e000 0x100>;
 	interrupts = <0 2 0x04>;
+	clocks = <&tegra_car 4>;
 };
diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index 392a4493eebd..39148b6236a1 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -6,6 +6,8 @@ Required properties:
 - interrupts: Should contain UART controller interrupts.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this UART controller.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Optional properties:
 - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
@@ -20,5 +22,6 @@ serial at 70006000 {
 	interrupts = <0 36 0x04>;
 	nvidia,dma-request-selector = <&apbdma 8>;
 	nvidia,enable-modem-interrupt;
+	clocks = <&tegra_car 6>;
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
index 8b8903ef0800..57f40f93453e 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
@@ -3,10 +3,11 @@ NVIDIA Tegra audio complex
 Required properties:
 - compatible : "nvidia,tegra-audio-alc5632"
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+  - pll_a
+  - pll_a_out0
+  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
index dc6224994d69..7788808dcd0b 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
@@ -3,10 +3,11 @@ NVIDIA Tegra audio complex, with RT5640 CODEC
 Required properties:
 - compatible : "nvidia,tegra-audio-rt5640"
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+  - pll_a
+  - pll_a_out0
+  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
index aab6ce0ad2fc..96f6a57dd6b4 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
@@ -3,10 +3,11 @@ NVIDIA Tegra audio complex
 Required properties:
 - compatible : "nvidia,tegra-audio-wm8753"
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+  - pll_a
+  - pll_a_out0
+  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index 4b44dfb6ca0d..b795d282818d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -3,10 +3,11 @@ NVIDIA Tegra audio complex
 Required properties:
 - compatible : "nvidia,tegra-audio-wm8903"
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+  - pll_a
+  - pll_a_out0
+  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
index ad589b163639..436f6cd9d07c 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
@@ -3,10 +3,11 @@ NVIDIA Tegra audio complex
 Required properties:
 - compatible : "nvidia,tegra-audio-wm9712"
 - clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+  - pll_a
+  - pll_a_out0
+  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
 - nvidia,model : The user-visible name of this sound complex.
 - nvidia,audio-routing : A list of the connections between audio components.
   Each entry is a pair of strings, the first being the connection's sink,
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
index c1454979c1ef..37f4ebf5b184 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
@@ -4,12 +4,15 @@ Required properties:
 - compatible : "nvidia,tegra20-ac97"
 - reg : Should contain AC97 controller registers location and length
 - interrupts : Should contain AC97 interrupt
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for the AC97 controller
 - nvidia,codec-reset-gpio : The Tegra GPIO controller's phandle and the number
   of the GPIO used to reset the external AC97 codec
 - nvidia,codec-sync-gpio : The Tegra GPIO controller's phandle and the number
   of the GPIO corresponding with the AC97 DAP _FS line
+
 Example:
 
 ac97 at 70002000 {
@@ -19,4 +22,5 @@ ac97 at 70002000 {
 	nvidia,dma-request-selector = <&apbdma 12>;
 	nvidia,codec-reset-gpio = <&gpio 170 0>;
 	nvidia,codec-sync-gpio = <&gpio 120 0>;
+	clocks = <&tegra_car 3>;
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
index 0df2b5c816e3..ba0c9452916d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
@@ -4,6 +4,8 @@ Required properties:
 - compatible : "nvidia,tegra20-i2s"
 - reg : Should contain I2S registers location and length
 - interrupts : Should contain I2S interrupt
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this I2S controller
 
@@ -14,4 +16,5 @@ i2s at 70002800 {
 	reg = <0x70002800 0x200>;
 	interrupts = < 45 >;
 	nvidia,dma-request-selector = < &apbdma 2 >;
+	clocks = <&tegra_car 11>;
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
index 0e5c12c66523..7299eeadd588 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -12,11 +12,24 @@ Required properties:
   If a single entry is present, the request selectors for the channels are
   assumed to be contiguous, and increment from this value.
   If multiple values are given, one value must be given per channel.
-- clocks : Must contain an entry for each required entry in clock-names.
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
-  - Tegra30: Requires d_audio, apbif, i2s0, i2s1, i2s2, i2s3, i2s4, dam0,
-    dam1, dam2, spdif_in.
-  - Tegra114: Additionally requires amx, adx.
+  Tegra30 and later:
+  - d_audio
+  - apbif
+  - i2s0
+  - i2s1
+  - i2s2
+  - i2s3
+  - i2s4
+  - dam0
+  - dam1
+  - dam2
+  - spdif_in
+  Tegra114 and later additionally require:
+  - amx
+  - adx
 - ranges : The bus address mapping for the configlink register bus.
   Can be empty since the mapping is 1:1.
 - #address-cells : For the configlink bus. Should be <1>;
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
index dfa6c037124a..7a3112bc135c 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
@@ -3,13 +3,16 @@ NVIDIA Tegra30 I2S controller
 Required properties:
 - compatible : "nvidia,tegra30-i2s"
 - reg : Should contain I2S registers location and length
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 - nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
   first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
 
 Example:
 
-i2s at 70002800 {
+i2s at 70080300 {
 	compatible = "nvidia,tegra30-i2s";
 	reg = <0x70080300 0x100>;
 	nvidia,ahub-cif-ids = <4 4>;
+	clocks = <&tegra_car 11>;
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 91ff771c7e77..d4f2d534934b 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -6,8 +6,10 @@ Required properties:
 - interrupts: Should contain SPI interrupts.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this SPI controller.
-- This is also require clock named "spi" as per binding document
-  Documentation/devicetree/bindings/clock/clock-bindings.txt
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - spi
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -22,5 +24,7 @@ spi at 7000d600 {
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clocks = <&tegra_car 44>;
+	clock-names = "spi";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
index 7b53da5cb75b..66e16c7f5939 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
@@ -6,6 +6,8 @@ Required properties:
 - interrupts: Should contain SFLASH interrupts.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this SFLASH controller.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -21,6 +23,6 @@ spi at 7000c380 {
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clocks = <&tegra_car 43>;
 	status = "disabled";
 };
-
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
index eefe15e3d95e..0e6e94eb2b2a 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
@@ -6,6 +6,8 @@ Required properties:
 - interrupts: Should contain SLINK interrupts.
 - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
   request selector for this SLINK controller.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -21,6 +23,6 @@ spi at 7000d600 {
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clocks = <&tegra_car 44>;
 	status = "disabled";
 };
-
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
index e019fdc38773..4a864bd10d3d 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible : should be "nvidia,tegra20-timer".
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A list of 4 interrupts; one per timer channel.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Example:
 
@@ -18,4 +20,5 @@ timer {
 			0 1 0x04
 			0 41 0x04
 			0 42 0x04>;
+	clocks = <&tegra_car 132>;
 };
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
index 906109d4c593..b5082a1cf461 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
@@ -10,6 +10,8 @@ Required properties:
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A list of 6 interrupts; one per each of timer channels 1
     through 5, and one for the shared interrupt for the remaining channels.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 timer {
 	compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
@@ -20,4 +22,5 @@ timer {
 		      0 42 0x04
 		      0 121 0x04
 		      0 122 0x04>;
+	clocks = <&tegra_car 214>;
 };
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
index df0933043a5b..b98d0bdfa248 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
@@ -8,7 +8,8 @@ and additions :
 Required properties :
  - compatible : Should be "nvidia,tegra20-ehci".
  - nvidia,phy : phandle of the PHY that the controller is connected to.
- - clocks : Contains a single entry which defines the USB controller's clock.
+ - clocks : Must contain one entry, for the module clock.
+   See ../clocks/clock-bindings.txt for details.
 
 Optional properties:
  - nvidia,needs-double-reset : boolean is to be set for some of the Tegra20
-- 
1.8.1.5
