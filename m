From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 16:16:21 +0100
Subject: Applied "spi: Document the STM32 SPI bindings" to the spi tree
In-Reply-To: <1498055526-6918-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dNhMj-0001FC-Ay@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: Document the STM32 SPI bindings

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 82a29bf9952acd1be7e76783604686abeb4e5b1d Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Wed, 21 Jun 2017 16:32:05 +0200
Subject: [PATCH] spi: Document the STM32 SPI bindings

This patch adds the documentation of device tree bindings
for the STM32 SPI controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-stm32.txt          | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
new file mode 100644
index 000000000000..3958bf6e8b37
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -0,0 +1,60 @@
+STMicroelectronics STM32 SPI Controller
+
+The STM32 SPI controller is used to communicate with external devices using
+the Serial Peripheral Interface. It supports full-duplex, half-duplex and
+simplex synchronous serial communication with external devices. It supports
+from 4 to 32-bit data size. Although it can be configured as master or slave,
+only master is supported by the driver.
+
+Required properties:
+- compatible: Must be "st,stm32-spi".
+- reg: Offset and length of the device's register set.
+- interrupts: Must contain the interrupt id.
+- clocks: Must contain an entry for spiclk (which feeds the internal clock
+	  generator).
+- #address-cells:  Number of cells required to define a chip select address.
+- #size-cells: Should be zero.
+
+Optional properties:
+- resets: Must contain the phandle to the reset controller.
+- A pinctrl state named "default" may be defined to set pins in mode of
+  operation for SPI transfer.
+- dmas: DMA specifiers for tx and rx dma. DMA fifo mode must be used. See the
+  STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt.
+- dma-names: DMA request names should include "tx" and "rx" if present.
+- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
+  Documentation/devicetree/bindings/spi/spi-bus.txt
+
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Optional properties:
+- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
+		  nanoseconds inserted between two consecutive data frames.
+
+
+Example:
+	spi2: spi at 40003800 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-spi";
+		reg = <0x40003800 0x400>;
+		interrupts = <36>;
+		clocks = <&rcc SPI2_CK>;
+		resets = <&rcc 1166>;
+		dmas = <&dmamux1 0 39 0x400 0x01>,
+		       <&dmamux1 1 40 0x400 0x01>;
+		dma-names = "rx", "tx";
+		pinctrl-0 = <&spi2_pins_b>;
+		pinctrl-names = "default";
+		status = "okay";
+		cs-gpios = <&gpioa 11 0>;
+
+		spidev at 0 {
+			compatible = "spidev";
+			reg = <0>;
+			spi-max-frequency = <4000000>;
+			st,spi-midi = <4000>;
+		};
+	};
-- 
2.11.0
