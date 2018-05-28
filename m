From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 28 May 2018 23:14:07 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: condor: add I2C0 support
In-Reply-To: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
References: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
Message-ID: <61f6f4a4-e55c-06e0-cba1-7d90a556950a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Condor board dependent part of the I2C0 device node.

The I2C0 bus is populated by 2 ON Semiconductor PCA9654 I/O expanders
and Analog Devices  ADV7511W HDMI transmitter (but we're only describing
the former chips now).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -80,6 +80,28 @@
 	clock-frequency = <32768>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	io_expander0: gpio at 20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	io_expander1: gpio at 21 {
+		compatible = "onnn,pca9654";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &mmc0 {
 	pinctrl-0 = <&mmc_pins>;
 	pinctrl-1 = <&mmc_pins_uhs>;
@@ -104,6 +126,11 @@
 		function = "canfd0";
 	};
 
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	mmc_pins: mmc {
 		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
 		function = "mmc";
