From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:53:58 -0700
Subject: [PATCH 03/31] ARM: tegra: document use of standard DMA DT bindings
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Update all the Tegra DT bindings to require the standard dmas/dma-names
properties rather than non-standard nvidia,dma-request-selector property.

This is a DT-ABI-incompatible change. It is the second of two changes
required for me to consider the Tegra DT bindings as stable, the other
being the previous conversion to the common reset bindings.

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
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt     |  7 +++++++
 .../bindings/serial/nvidia,tegra20-hsuart.txt          | 10 +++++++---
 .../devicetree/bindings/sound/nvidia,tegra20-ac97.txt  | 14 +++++++++-----
 .../devicetree/bindings/sound/nvidia,tegra20-i2s.txt   | 14 +++++++++-----
 .../devicetree/bindings/sound/nvidia,tegra30-ahub.txt  | 18 +++++++++++++-----
 .../devicetree/bindings/spi/nvidia,tegra114-spi.txt    | 14 +++++++++-----
 .../devicetree/bindings/spi/nvidia,tegra20-sflash.txt  | 10 +++++++---
 .../devicetree/bindings/spi/nvidia,tegra20-slink.txt   | 10 +++++++---
 8 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index 2b3af72dfb9c..13a7f9dc1681 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -51,6 +51,11 @@ Required properties:
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - i2c
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
 
 Example:
 
@@ -64,5 +69,7 @@ Example:
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 12>;
 		reset-names = "i2c";
+		dmas = <&apbdma 16>, <&apbdma 16>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index 69ccdbe3760e..e2b18972a674 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -4,14 +4,17 @@ Required properties:
 - compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this UART controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - serial
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
 
 Optional properties:
 - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
@@ -24,10 +27,11 @@ serial at 70006000 {
 	reg = <0x70006000 0x40>;
 	reg-shift = <2>;
 	interrupts = <0 36 0x04>;
-	nvidia,dma-request-selector = <&apbdma 8>;
 	nvidia,enable-modem-interrupt;
 	clocks = <&tegra_car 6>;
 	resets = <&tegra_car 6>;
 	reset-names = "serial";
+	dmas = <&apbdma 8>, <&apbdma 8>;
+	dma-names = "rx", "tx";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
index 2b6817f6e40e..eaf00102d92c 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
@@ -4,14 +4,17 @@ Required properties:
 - compatible : "nvidia,tegra20-ac97"
 - reg : Should contain AC97 controller registers location and length
 - interrupts : Should contain AC97 interrupt
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - ac97
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for the AC97 controller
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 - nvidia,codec-reset-gpio : The Tegra GPIO controller's phandle and the number
   of the GPIO used to reset the external AC97 codec
 - nvidia,codec-sync-gpio : The Tegra GPIO controller's phandle and the number
@@ -23,10 +26,11 @@ ac97 at 70002000 {
 	compatible = "nvidia,tegra20-ac97";
 	reg = <0x70002000 0x200>;
 	interrupts = <0 81 0x04>;
-	nvidia,dma-request-selector = <&apbdma 12>;
 	nvidia,codec-reset-gpio = <&gpio 170 0>;
 	nvidia,codec-sync-gpio = <&gpio 120 0>;
 	clocks = <&tegra_car 3>;
 	resets = <&tegra_car 3>;
 	reset-names = "ac97";
+	dmas = <&apbdma 12>, <&apbdma 12>;
+	dma-names = "rx", "tx";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
index 8b070aeca3db..dc30c6bfbe95 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
@@ -4,14 +4,17 @@ Required properties:
 - compatible : "nvidia,tegra20-i2s"
 - reg : Should contain I2S registers location and length
 - interrupts : Should contain I2S interrupt
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - i2s
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this I2S controller
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
 
 Example:
 
@@ -19,8 +22,9 @@ i2s at 70002800 {
 	compatible = "nvidia,tegra20-i2s";
 	reg = <0x70002800 0x200>;
 	interrupts = < 45 >;
-	nvidia,dma-request-selector = < &apbdma 2 >;
 	clocks = <&tegra_car 11>;
 	resets = <&tegra_car 11>;
 	reset-names = "i2s";
+	dmas = <&apbdma 21>, <&apbdma 21>;
+	dma-names = "rx", "tx";
 };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
index 60d59a54ca07..3376ba42a209 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -7,11 +7,6 @@ Required properties:
   - Tegra30 requires 2 entries, for the APBIF and AHUB/AUDIO register blocks.
   - Tegra114 requires an additional entry, for the APBIF2 register block.
 - interrupts : Should contain AHUB interrupt
-- nvidia,dma-request-selector : A list of the DMA channel specifiers. Each
-  entry contains the Tegra DMA controller's phandle and request selector.
-  If a single entry is present, the request selectors for the channels are
-  assumed to be contiguous, and increment from this value.
-  If multiple values are given, one value must be given per channel.
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
@@ -36,6 +31,14 @@ Required properties:
   - amx
   - adx
 - ranges : The bus address mapping for the configlink register bus.
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx0 .. rx<n>
+  - tx0 .. tx<n>
+  ... where n is:
+  Tegra30: 3
+  Tegra114, Tegra124: 9
   Can be empty since the mapping is 1:1.
 - #address-cells : For the configlink bus. Should be <1>;
 - #size-cells : For the configlink bus. Should be <1>.
@@ -62,6 +65,11 @@ ahub at 70080000 {
 	reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 		"i2s3", "i2s4", "dam0", "dam1", "dam2",
 		"spdif";
+	dmas = <&apbdma 1>, <&apbdma 1>;
+	       <&apbdma 2>, <&apbdma 2>;
+	       <&apbdma 3>, <&apbdma 3>;
+	       <&apbdma 4>, <&apbdma 4>;
+	dma-names = "rx0", "tx0", "rx1", "tx1", "rx2", "tx2", "rx3", "tx3";
 	ranges;
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index fcd9f67999de..7ea701e07dc2 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -4,16 +4,19 @@ Required properties:
 - compatible : should be "nvidia,tegra114-spi".
 - reg: Should contain SPI registers location and length.
 - interrupts: Should contain SPI interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this SPI controller.
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
   - spi
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - spi
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -24,7 +27,6 @@ spi at 7000d600 {
 	compatible = "nvidia,tegra114-spi";
 	reg = <0x7000d600 0x200>;
 	interrupts = <0 82 0x04>;
-	nvidia,dma-request-selector = <&apbdma 16>;
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -32,5 +34,7 @@ spi at 7000d600 {
 	clock-names = "spi";
 	resets = <&tegra_car 44>;
 	reset-names = "spi";
+	dmas = <&apbdma 16>, <&apbdma 16>;
+	dma-names = "rx", "tx";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
index e144f144717f..bdf08e6dec9b 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
@@ -4,14 +4,17 @@ Required properties:
 - compatible : should be "nvidia,tegra20-sflash".
 - reg: Should contain SFLASH registers location and length.
 - interrupts: Should contain SFLASH interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this SFLASH controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - spi
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -23,12 +26,13 @@ spi at 7000c380 {
 	compatible = "nvidia,tegra20-sflash";
 	reg = <0x7000c380 0x80>;
 	interrupts = <0 39 0x04>;
-	nvidia,dma-request-selector = <&apbdma 16>;
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clocks = <&tegra_car 43>;
 	resets = <&tegra_car 43>;
 	reset-names = "spi";
+	dmas = <&apbdma 11>, <&apbdma 11>;
+	dma-names = "rx", "tx";
 	status = "disabled";
 };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
index 9393e28f444b..5db9144a33c8 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
@@ -4,14 +4,17 @@ Required properties:
 - compatible : should be "nvidia,tegra20-slink", "nvidia,tegra30-slink".
 - reg: Should contain SLINK registers location and length.
 - interrupts: Should contain SLINK interrupts.
-- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
-  request selector for this SLINK controller.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - spi
+- dmas : Must contain an entry for each entry in clock-names.
+  See ../dma/dma.txt for details.
+- dma-names : Must include the following entries:
+  - rx
+  - tx
 
 Recommended properties:
 - spi-max-frequency: Definition as per
@@ -23,12 +26,13 @@ spi at 7000d600 {
 	compatible = "nvidia,tegra20-slink";
 	reg = <0x7000d600 0x200>;
 	interrupts = <0 82 0x04>;
-	nvidia,dma-request-selector = <&apbdma 16>;
 	spi-max-frequency = <25000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	clocks = <&tegra_car 44>;
 	resets = <&tegra_car 44>;
 	reset-names = "spi";
+	dmas = <&apbdma 16>, <&apbdma 16>;
+	dma-names = "rx", "tx";
 	status = "disabled";
 };
-- 
1.8.1.5
