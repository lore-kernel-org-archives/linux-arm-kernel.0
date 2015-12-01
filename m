From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue,  1 Dec 2015 15:54:59 +0200
Subject: [PATCH V2 04/14] ARM: dts: am437x: cm-t43: add spi-flash support
In-Reply-To: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448978109-5614-5-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CM-T43 has an on-board 2MB SPI-flash which stores U-Boot and the U-Boot
environment. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
Changes in V2:
	- Removed unnecessary line break after pinmux_spi0_pins section.

 arch/arm/boot/dts/am437x-cm-t43.dts | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 27b748a..27e5948 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -44,6 +44,15 @@
 			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
 		>;
 	};
+
+	spi0_pins: pinmux_spi0_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM4372_IOPAD(0x954, PIN_INPUT | MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM4372_IOPAD(0x958, PIN_OUTPUT | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM4372_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+		>;
+	};
 };
 
 &i2c0 {
@@ -146,6 +155,37 @@
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	dmas = <&edma 16
+		&edma 17>;
+	dma-names = "tx0", "rx0";
+
+	flash: w25q64cvzpig at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
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
+			reg = <0x100000 0x100000>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
