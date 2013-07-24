From: b44548@freescale.com (Chao Fu)
Date: Wed, 24 Jul 2013 13:32:22 +0800
Subject: [PATCH v2 3/4] Documentation: DT: Add DSPI driver
In-Reply-To: <1374643943-3324-1-git-send-email-b44548@freescale.com>
References: <1374643943-3324-1-git-send-email-b44548@freescale.com>
Message-ID: <1374643943-3324-4-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

This patch adds the document for DSPI driver
under Documentation/devicetree/bindings/spi/.

Signed-off-by: Chao Fu <b44548@freescale.com>
---
Changes in v2: New
- Add this document for DSPI driver.

.../devicetree/bindings/spi/spi-fsl-dspi.txt       | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
new file mode 100644
index 0000000..8911348
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -0,0 +1,73 @@
+ARM Freescale DSPI controller
+
+Required properties:
+- compatible : "fsl,vf610-dspi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain SPI controller interrupt
+- clocks: from common clock binding: handle to dspi clock.
+- clock-names: from common clock binding: Shall be "dspi".
+- pinctrl-0: pin control group to be used for this controller.
+- pinctrl-names: must contain a "default" entry.
+- spi-num-chipselects : the number of the chipselect signals.
+- bus-num : the slave chip chipselect signal number.
+
+SPI slave nodes must be children of the SPI master node and can
+contain the following properties.
+
+-dspi,ctar-dbr : Double baud rate
+Doubles the effective baud rate of the Serial Communications Clock (SCK). This field is used only in
+master mode. It effectively halves the Baud Rate division ratio, supporting faster frequencies, and odd
+division ratios for the Serial Communications Clock (SCK). When the DBR bit is set, the duty cycle of the
+Serial Communications Clock (SCK) depends on the value in the Baud Rate Prescaler and the Clock
+Phase bit as listed in the following table.
+	DBR CPHA PBR SCK Duty Cycle
+	0   any  any 50/50
+	1   0    00  50/50
+	1   0    01  33/66
+	1   0    10  40/60
+	1   0    11  43/57
+	1   1    00  50/50
+	1   1    01  66/33
+	1   1    10  60/40
+	1   1    11  57/43
+0: The baud rate is computed normally with a 50/50 duty cycle.
+1: The baud rate is doubled with the duty cycle depending on the Baud Rate Prescaler.
+
+-dspi,ctar-pbr : Baud Rate Prescaler
+	0: Baud Rate Prescaler value is 2.
+	1: Baud Rate Prescaler value is 3.
+	2: Baud Rate Prescaler value is 5.
+	3: Baud Rate Prescaler value is 7.
+
+Example:
+
+dspi0 at 4002c000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,vf610-dspi";
+	reg = <0x4002c000 0x1000>;
+	interrupts = <0 67 0x04>;
+	clocks = <&clks VF610_CLK_DSPI0>;
+	clock-names = "dspi";
+	spi-num-chipselects = <5>;
+	bus-num = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi0_1>;
+	status = "okay";
+
+	sflash: at26df081a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at26df081a";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		dspi,ctar-dbr = <0>;
+		dspi,ctar-pbr = <0>;
+		reg = <0>;
+		linux,modalias = "m25p80";
+		modal = "at26df081a";
+	};
+};
+
+
-- 
1.8.0
