From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 26 Jul 2013 10:18:05 -0300
Subject: [PATCH v9 28/30] ARM: kirkwood: Relocate PCIe device tree nodes
In-Reply-To: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374844687-19981-29-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mbus has been added to the device tree, it's possible to
move the PCIe nodes out of the ocp node, placing it directly
below the mbus. This is a more accurate representation of the hardware.

Moving the PCIe nodes, we now need to introduce an extra cell to
encode the window target ID and attribute. Since this depends on
the PCIe port, we split the ranges translation entries, to
correspond to each MBus window.

In addition, we encode the PCIe memory and I/O apertures in the MBus
node, according to the MBus DT binding specification. The choice made
is 0xe0000000-0xf0000000 for memory space, and 0xf200000-0xf2100000 for
I/O space. These apertures can be changed in each per-board DT file.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  66 ++++++-------
 arch/arm/boot/dts/kirkwood-6282.dtsi               | 102 +++++++++++----------
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   3 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |   3 +-
 arch/arm/boot/dts/kirkwood-db.dtsi                 |   8 --
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  19 ++--
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  19 ++--
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  19 ++--
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  19 ++--
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  19 ++--
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  17 ++--
 arch/arm/boot/dts/kirkwood.dtsi                    |   5 +-
 12 files changed, 163 insertions(+), 136 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index 1e5bef0..650ef30 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -1,4 +1,39 @@
 / {
+	mbus {
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			compatible = "marvell,88f6281-pinctrl";
@@ -41,37 +76,6 @@
 			};
 		};
 
-		pcie-controller {
-			compatible = "marvell,kirkwood-pcie";
-			status = "disabled";
-			device_type = "pci";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			bus-range = <0x00 0xff>;
-
-			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
-				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
-
-			pcie at 1,0 {
-				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
-				reg = <0x0800 0 0 0 0>;
-				#address-cells = <3>;
-				#size-cells = <2>;
-				#interrupt-cells = <1>;
-				ranges;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
-				marvell,pcie-port = <0>;
-				marvell,pcie-lane = <0>;
-				clocks = <&gate_clk 2>;
-				status = "disabled";
-			};
-		};
-
 		rtc at 10300 {
 			compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
 			reg = <0x10300 0x20>;
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index a63a111..3933a33 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -1,4 +1,59 @@
 / {
+	mbus {
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+			        0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
+				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */
+				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0       1 0 /* Port 1.0 MEM */
+				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0       1 0 /* Port 1.0 IO  */>;
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
+					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 10>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 18>;
+				status = "disabled";
+			};
+		};
+	};
 	ocp at f1000000 {
 
 		pinctrl: pinctrl at 10000 {
@@ -94,52 +149,5 @@
 			status = "disabled";
 		};
 
-		pcie-controller {
-			compatible = "marvell,kirkwood-pcie";
-			status = "disabled";
-			device_type = "pci";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			bus-range = <0x00 0xff>;
-
-			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
-			          0x82000000 0 0x00044000 0x00044000 0 0x00002000   /* Port 1.0 registers */
-				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
-
-			pcie at 1,0 {
-				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
-				reg = <0x0800 0 0 0 0>;
-				#address-cells = <3>;
-				#size-cells = <2>;
-				#interrupt-cells = <1>;
-				ranges;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 9>;
-				marvell,pcie-port = <0>;
-				marvell,pcie-lane = <0>;
-				clocks = <&gate_clk 2>;
-				status = "disabled";
-			};
-
-			pcie at 2,0 {
-				device_type = "pci";
-				assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
-				reg = <0x1000 0 0 0 0>;
-				#address-cells = <3>;
-				#size-cells = <2>;
-				#interrupt-cells = <1>;
-				ranges;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 10>;
-				marvell,pcie-port = <1>;
-				marvell,pcie-lane = <0>;
-				clocks = <&gate_clk 18>;
-				status = "disabled";
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
index f420cbe..72c4b0a 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -18,7 +18,8 @@
 	model = "Marvell DB-88F6281-BP Development Board";
 	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-	ocp at f1000000 {
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
index c5df866..36c411d 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -18,7 +18,8 @@
 	model = "Marvell DB-88F6282-BP Development Board";
 	compatible = "marvell,db-88f6282-bp", "marvell,kirkwood-88f6282", "marvell,kirkwood";
 
-	ocp at f1000000 {
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
 		pcie-controller {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
index 29bd98e..45c1bf7 100644
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -77,13 +77,5 @@
 			cd-gpios = <&gpio1 6 0>;
 			status = "okay";
 		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 1a98487..8314118 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -18,6 +18,17 @@
 		linux,initrd-end   = <0x4800000>;
 	};
 
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			pmx_button_reset: pmx-button-reset {
@@ -101,14 +112,6 @@
 				reg = <0x980000 0x1f400000>;
 			};
 		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 382ad99..21f1954 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -16,6 +16,17 @@
                 bootargs = "console=ttyS0,115200n8 earlyprintk";
         };
 
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			pmx_led_health: pmx-led-health {
@@ -134,14 +145,6 @@
 			cd-gpios = <&gpio1 15 1>;
 			/* No WP GPIO */
 		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 8be68bd..84ff31c 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -16,6 +16,17 @@
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
 	};
 
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			pmx_button_power: pmx-button-power {
@@ -101,14 +112,6 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 8fd683c..bd7f05f 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -16,6 +16,17 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			pinctrl-0 = <&pmx_unknown>;
@@ -162,14 +173,6 @@
 				reg = <0x5040000 0x2fc0000>;
 			};
 		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 7d6cc86..04f6fe1 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -5,6 +5,17 @@
 #include "kirkwood-ts219.dtsi"
 
 / {
+	mbus {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>;
+		pcie-controller {
+			status = "okay";
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
@@ -30,14 +41,6 @@
 				marvell,function = "gpio";
 			};
 		};
-		pcie-controller {
-			status = "okay";
-
-			pcie at 2,0 {
-				status = "okay";
-			};
-		};
-
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 0c9a94c..7019cf6 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -11,6 +11,16 @@
 		bootargs = "console=ttyS0,115200n8";
 	};
 
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
 	ocp at f1000000 {
 		i2c at 11000 {
 			status = "okay";
@@ -87,12 +97,5 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 5003c83..70f414d 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -32,13 +32,16 @@
 
 	mbus {
 		compatible = "marvell,kirkwood-mbus", "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
 		controller = <&mbusc>;
+		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
+		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
 	};
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf1000000 0x0100000
-		          0xe0000000 0xe0000000 0x8100000 /* PCIE */
 		          0xf4000000 0xf4000000 0x0000400
 		          0xf5000000 0xf5000000 0x0000400>;
 		#address-cells = <1>;
-- 
1.8.1.5
