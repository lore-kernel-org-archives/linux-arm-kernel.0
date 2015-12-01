From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:08 +0200
Subject: [PATCH V3 06/19] ARM: dts: am57xx: cl-som-am57x: add spi-flash support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board spi-flash chip is used as a main boot device.
Add spi-flash chip support (over QSPI bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
  v3:

   * Modify "compatible" property to match a proper flash driver
   * Drop RX/TX bus with properties
   * Reformat subject

  v2: 

   * Add "spi-max-frequency" property for &qspi node.

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index ef94845..f7e163a 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -93,6 +93,17 @@
 			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
+
+	qspi1_pins: pinmux_qspi1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)	/* gpmc_a13.qspi1_rtclk */
+			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_d0 */
+			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_d1 */
+			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)	/* qpmc_a18.qspi1_sclk */
+			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_cs3.qspi1_cs1 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -331,3 +342,34 @@
 	ti,non-removable;
 	cap-mmc-dual-data-rate;
 };
+
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_pins>;
+
+	spi-max-frequency = <20000000>;
+
+	spi_flash: spi_flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80", "jedec,spi-nor";
+		reg = <0>;				/* CS0 */
+		spi-max-frequency = <20000000>;
+
+		partition at 0 {
+			label = "uboot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition at c0000 {
+			label = "uboot environment";
+			reg = <0xc0000 0x40000>;
+		};
+
+		partition at 100000 {
+			label = "reserved";
+			reg = <0x100000 0x0>;
+		};
+	};
+};
-- 
1.9.1
