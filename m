From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:32:54 +0100
Subject: [PATCH 3/4] ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth
 module
In-Reply-To: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170115223255.10350-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This takes the Bluetooth module out of reset (the reset line is
connected to GPIOX_17) and enables uart_A which is used to configure the
module.
This is identical for all boards which inherit meson-gx-p23x-q20x:
- GXL S905D P230
- GXL S905D P231
- GXM S912 Q200
- GXM S912 Q201

To get the HCI interface up one has to install bluez-utils and run:
hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 7a078bef04cd..7db779048091 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -48,6 +48,7 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 	};
 
 	chosen {
@@ -94,12 +95,21 @@
 
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
+			      <&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
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
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
2.11.0
