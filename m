From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:32:55 +0100
Subject: [PATCH 4/4] ARM64: dts: meson-gxbb-vega-s95: enable the Bluetooth
 module
In-Reply-To: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170115223255.10350-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This takes the Bluetooth module out of reset (the reset line is
connected to GPIOX_20) and enables uart_A which is used to configure the
module. This is common for all Vega S95 boards.
The device can then be initialized by running the hciattach tool:
hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index ab497126c9a3..9e0a13b1ac93 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -47,6 +47,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 	};
 
 	chosen {
@@ -100,6 +101,14 @@
 	};
 };
 
+/* This is connected to the Bluetooth module of the wifi/BT combo chip: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins &uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.11.0
