From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 5 Oct 2018 09:43:02 +0200
Subject: [PATCH 1/2] dt-bindings: spi: add stm32 qspi controller
In-Reply-To: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
References: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1538725383-19781-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds the documentation of device tree bindings
for the STM32 QSPI controller. It is a specialized communication
interface targeting single, dual or quad SPI Flash memories (NOR/NAND).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
new file mode 100644
index 0000000..adeeb63
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
@@ -0,0 +1,44 @@
+* STMicroelectronics Quad Serial Peripheral Interface(QSPI)
+
+Required properties:
+- compatible: should be "st,stm32f469-qspi"
+- reg: the first contains the register location and length.
+       the second contains the memory mapping address and length
+- reg-names: should contain the reg names "qspi" "qspi_mm"
+- interrupts: should contain the interrupt for the device
+- clocks: the phandle of the clock needed by the QSPI controller
+- A pinctrl must be defined to set pins in mode of operation for QSPI transfer
+
+Optional properties:
+- resets: must contain the phandle to the reset controller.
+
+A spi flash (NOR/NAND) must be a child of spi node and could have some
+properties. Also see jedec,spi-nor.txt.
+
+Required properties:
+- reg: chip-Select number (QSPI controller may connect 2 flashes)
+- spi-max-frequency: max frequency of spi bus
+
+Optional property:
+- spi-rx-bus-width: see ./spi-bus.txt for the description
+
+Example:
+
+qspi: spi at a0001000 {
+	compatible = "st,stm32f469-qspi";
+	reg = <0xa0001000 0x1000>, <0x90000000 0x10000000>;
+	reg-names = "qspi", "qspi_mm";
+	interrupts = <91>;
+	resets = <&rcc STM32F4_AHB3_RESET(QSPI)>;
+	clocks = <&rcc 0 STM32F4_AHB3_CLOCK(QSPI)>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+
+	flash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		...
+	};
+};
-- 
2.7.4
