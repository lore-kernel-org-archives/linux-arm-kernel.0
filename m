From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:44:00 -0700
Subject: [PATCH/RFT 2/3] ARM: dts: da850-evm.dts: add mt9v032 camera sensor
In-Reply-To: <20170602234401.24721-1-khilman@baylibre.com>
References: <20170602234401.24721-1-khilman@baylibre.com>
Message-ID: <20170602234401.24721-3-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes to support camera input via UI board connector. Includes;

- i2c-mux used to connect VPIF input peripherals

- camera-sensor on the On-Semi camera board[1], which provides
  and aptina,mt9v032 sensor.  Note that this board provides
  a way to change the i2c addr via a switch, and this series
  assumes 0x4c

- clock-controler for the master clock provided to camera.  Note that
  this node is FYI only.  The upstream driver for ti,cdce913 requires
  CCF, which davinci does not support, so a subsequent patch/hack
  will create a basic clock driver so the camera driver can work

- VPIF endpoint nodes to connect VPIF input and camera sensor

- GPIO hog changes to switch VPIF input from composite to camera

[1] http://www.mouser.com/search/ProductDetail.aspx?R=0virtualkey0virtualkeyMT9V032C12STCH-GEVB
---
 arch/arm/boot/dts/da850-evm.dts | 56 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index cbbf2c0d0269..c428d1d99ef6 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -297,10 +297,62 @@
 	};
 };
 
+/*
+ * Extentions provided on UI board
+ */
+&i2c0 {
+	/* clock generator used for camera input */
+	cdce913: clock-controller at 65 {
+		compatible = "ti,cdce913";
+		reg = <0x65>;
+		#clock-cells = <1>;
+	};
+
+	pca9543: i2c-mux at 73 {
+		compatible = "nxp,pca9543";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pca9543_i2c1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+	};
+};
+
+&pca9543_i2c1 {
+	mt9v032: camera at 4c {
+		compatible = "aptina,mt9v032";
+		reg = <0x4c>;
+		port {
+		     mt9v032_out: endpoint {
+			 remote-endpoint = <&vpif_input_ch0>;
+		     };	
+		};
+	};
+};
+
 &vpif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
 	status = "okay";
+
+	/* VPIF capture port */
+	port at 0 {
+		vpif_input_ch0: endpoint at 0 {
+			reg = <0>;
+			bus-width = <8>;
+			remote-endpoint = <&mt9v032_out>;
+		};
+
+		vpif_input_ch1: endpoint at 1 {
+			reg = <1>;
+			bus-width = <8>;
+			data-shift = <8>;
+		};
+	};
 };
 
 /* UI board: VPIF input selection */
@@ -316,13 +368,13 @@
 	 sel_b {
 		gpio-hog;
 		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-high;
+		output-low;
 		line-name = "CAMERA_ENn";
 	 };
 	 sel_c {
 		gpio-hog;
 		gpios = <5 GPIO_ACTIVE_HIGH>;
-		output-low;
+		output-high;
 		line-name = "VIDEO_IN_ENn";
 	 };
 };
-- 
2.9.3
