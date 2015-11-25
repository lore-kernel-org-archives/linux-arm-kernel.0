From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:38 +0200
Subject: [PATCH 06/18] ARM: am57xx: cl-som-am57x: dts: add spi-flash support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-7-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board spi-flash chip is used as a main boot device.
Add spi-flash chip support (over QSPI bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index ed50a75..cf2328d 100644
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
@@ -331,3 +342,33 @@
 	cap-mmc-dual-data-rate;
 };
 
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi1_pins>;
+
+	spi_flash: spi_flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;				/* CS0 */
+		spi-max-frequency = <20000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
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
