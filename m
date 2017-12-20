From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:26 +1030
Subject: [PATCH v3 18/20] ARM: dts: aspeed-romulus: Update Romulus system
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-19-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Fix incorrect RAM size
 - Remove alias; these are now specified in the dtsi
 - Add newly upstreamed devices
 - Include OpenBMC flash layout

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 v3:
  - Add GPIO include
  - Fix duplicate fmc and spi nodes
  - Add unit name for memory node to fix warning
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 133 +++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index a7a9386f964d..623b6ab42021 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -1,23 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0+
 /dts-v1/;
-
 #include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "Romulus BMC";
 	compatible = "ibm,romulus-bmc", "aspeed,ast2500";
 
-	aliases {
-		serial4 = &uart5;
-	};
-
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
-		reg = <0x80000000 0x40000000>;
+	memory at 80000000 {
+		reg = <0x80000000 0x20000000>;
 	};
 
 	reserved-memory {
@@ -29,6 +25,49 @@
 			no-map;
 			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
+
+		flash_memory: region at 98000000 {
+			no-map;
+			reg = <0x98000000 0x04000000>; /* 64M */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(N, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		power {
+			gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	fsi: gpio-fsi {
+		compatible = "fsi-master-gpio", "fsi-master";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
+		data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
+		mux-gpios = <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
+		trans-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		checkstop {
+			label = "checkstop";
+			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 2)>;
+		};
 	};
 };
 
@@ -38,6 +77,7 @@
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
+#include "openbmc-flash-layout.dtsi"
 	};
 };
 
@@ -53,6 +93,12 @@
 	};
 };
 
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi1>;
+};
+
 &uart1 {
 	/* Rear RS-232 connector */
 	status = "okay";
@@ -81,6 +127,10 @@
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
 
+&i2c1 {
+	status = "okay";
+};
+
 &i2c2 {
 	status = "okay";
 };
@@ -133,8 +183,77 @@
 
 &i2c12 {
 	status = "okay";
+
+	max31785 at 52 {
+		compatible = "maxim,max31785";
+		reg = <0x52>;
+	};
+};
+
+&gpio {
+	nic_func_mode0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "nic_func_mode0";
+	};
+	nic_func_mode1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "nic_func_mode1";
+	};
 };
 
 &vuart {
 	status = "okay";
 };
+
+&gfx {
+	status = "okay";
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08>;
+	};
+
+	fan at 1 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x09>;
+	};
+
+	fan at 2 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
+	};
+
+	fan at 3 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
+	};
+
+	fan at 4 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
+	};
+
+	fan at 5 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
+	};
+
+	fan at 6 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0e>;
+	};
+};
-- 
2.15.1
