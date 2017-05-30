From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 May 2017 10:32:49 +0200
Subject: [PATCH 4/5] ARM: dts: at91: Get rid of old NAND definitions
In-Reply-To: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1496133171-4787-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new EBI/NAND bindings to declare NAND chips and remove old NAND
nodes along the way.

Note that we keep using old bindings in at91rm9200.dtsi because this
SoC is not supported by the EBI driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/aks-cdu.dts               |  56 ++++++++-------
 arch/arm/boot/dts/animeo_ip.dts             |  53 +++++++++-----
 arch/arm/boot/dts/at91-cosino.dtsi          |  83 ++++++++++++++--------
 arch/arm/boot/dts/at91-kizbox.dts           |  42 +++++++++---
 arch/arm/boot/dts/at91-kizboxmini.dts       |  52 +++++++++++---
 arch/arm/boot/dts/at91-qil_a9260.dts        | 103 ++++++++++++++++------------
 arch/arm/boot/dts/at91sam9260.dtsi          |  28 ++------
 arch/arm/boot/dts/at91sam9261.dtsi          |  24 ++-----
 arch/arm/boot/dts/at91sam9261ek.dts         |  83 +++++++++++++---------
 arch/arm/boot/dts/at91sam9263.dtsi          |  28 ++------
 arch/arm/boot/dts/at91sam9263ek.dts         | 103 ++++++++++++++++------------
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 103 ++++++++++++++++------------
 arch/arm/boot/dts/at91sam9g45.dtsi          |  29 ++------
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  49 +++++++++----
 arch/arm/boot/dts/at91sam9n12.dtsi          |  32 ++-------
 arch/arm/boot/dts/at91sam9n12ek.dts         |  26 +++++--
 arch/arm/boot/dts/at91sam9rl.dtsi           |  42 ++++--------
 arch/arm/boot/dts/at91sam9rlek.dts          |  85 ++++++++++++++---------
 arch/arm/boot/dts/at91sam9x5.dtsi           |  92 ++++++++++++-------------
 arch/arm/boot/dts/at91sam9x5cm.dtsi         |  83 ++++++++++++++--------
 arch/arm/boot/dts/ethernut5.dts             |  47 ++++++++-----
 arch/arm/boot/dts/ge863-pro3.dtsi           |  41 ++++++++---
 arch/arm/boot/dts/pm9g45.dts                |  99 ++++++++++++++------------
 arch/arm/boot/dts/sama5d3.dtsi              |  32 ---------
 arch/arm/boot/dts/sama5d4.dtsi              |  31 ---------
 arch/arm/boot/dts/tny_a9260_common.dtsi     |  89 ++++++++++++++----------
 arch/arm/boot/dts/tny_a9263.dts             | 103 ++++++++++++++++------------
 arch/arm/boot/dts/usb_a9260_common.dtsi     | 103 ++++++++++++++++------------
 arch/arm/boot/dts/usb_a9263.dts             | 103 ++++++++++++++++------------
 29 files changed, 1029 insertions(+), 815 deletions(-)

diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/aks-cdu.dts
index 5b1bf92d927c..888bfcd4a402 100644
--- a/arch/arm/boot/dts/aks-cdu.dts
+++ b/arch/arm/boot/dts/aks-cdu.dts
@@ -62,32 +62,36 @@
 			status = "okay";
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
-			status = "okay";
-
-			bootstrap at 0 {
-				label = "bootstrap";
-				reg = <0x0 0x40000>;
-			};
-
-			uboot at 40000 {
-				label = "uboot";
-				reg = <0x40000 0x80000>;
-			};
-			ubootenv at c0000 {
-				label = "ubootenv";
-				reg = <0xc0000 0x40000>;
-			};
-			kernel at 100000 {
-				label = "kernel";
-				reg = <0x100000 0x400000>;
-			};
-			rootfs at 500000 {
-				label = "rootfs";
-				reg = <0x500000 0x7b00000>;
+		ebi: ebi at 10000000 {
+			nand_controller: nand-controller {
+				nand: nand at 3 {
+					partitions {
+						bootstrap at 0 {
+							label = "bootstrap";
+							reg = <0x0 0x40000>;
+						};
+
+						uboot at 40000 {
+							label = "uboot";
+							reg = <0x40000 0x80000>;
+						};
+
+						ubootenv at c0000 {
+							label = "ubootenv";
+							reg = <0xc0000 0x40000>;
+						};
+
+						kernel at 100000 {
+							label = "kernel";
+							reg = <0x100000 0x400000>;
+						};
+
+						rootfs at 500000 {
+							label = "rootfs";
+							reg = <0x500000 0x7b00000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 9cc372b9fb9b..26ade8c0a960 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -83,25 +83,44 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			barebox at 0 {
-				label = "barebox";
-				reg = <0x0 0x58000>;
-			};
-
-			u_boot_env at 58000 {
-				label = "u_boot_env";
-				reg = <0x58000 0x8000>;
-			};
-
-			ubi at 60000 {
-				label = "ubi";
-				reg = <0x60000 0x1FA0000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						barebox at 0 {
+							label = "barebox";
+							reg = <0x0 0x58000>;
+						};
+
+						u_boot_env at 58000 {
+							label = "u_boot_env";
+							reg = <0x58000 0x8000>;
+						};
+
+						ubi at 60000 {
+							label = "ubi";
+							reg = <0x60000 0x1FA0000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index 02d8ef43de3a..89cde175154e 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -82,38 +82,61 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;	/* Enable PMECC */
-			atmel,pmecc-cap = <4>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_addr_nand
+				     &pinctrl_ebi_data_0_7>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
-
-			uboot at 40000 {
-				label = "u-boot";
-				reg = <0x40000 0x80000>;
-			};
-
-			ubootenv at c0000 {
-				label = "U-Boot Env";
-				reg = <0xc0000 0x140000>;
-			};
-
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
-
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_oe_we
+					     &pinctrl_nand_cs
+					     &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "hw";
+					nand-ecc-strength = <4>;
+					nand-ecc-step-size = <512>;
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x40000>;
+						};
+
+						uboot at 40000 {
+							label = "u-boot";
+							reg = <0x40000 0x80000>;
+						};
+
+						ubootenv at c0000 {
+							label = "U-Boot Env";
+							reg = <0xc0000 0x140000>;
+						};
+
+						kernel at 200000 {
+							label = "kernel";
+							reg = <0x200000 0x600000>;
+						};
+
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x0f800000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index b4f147c193fd..1f31df846d61 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -59,19 +59,39 @@
 			status = "okay";
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			bootstrap at 0 {
-				label = "bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			ubi at 20000 {
-				label = "ubi";
-				reg = <0x20000 0x7fe0000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						bootstrap at 0 {
+							label = "bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						ubi at 20000 {
+							label = "ubi";
+							reg = <0x20000 0x7fe0000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-kizboxmini.dts b/arch/arm/boot/dts/at91-kizboxmini.dts
index 9682d105d4d8..33238fcb6d0b 100644
--- a/arch/arm/boot/dts/at91-kizboxmini.dts
+++ b/arch/arm/boot/dts/at91-kizboxmini.dts
@@ -68,6 +68,49 @@
 			status = "okay";
 		};
 
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_addr_nand
+				     &pinctrl_ebi_data_0_7>;
+			pinctrl-names = "default";
+			status = "okay";
+
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_oe_we
+					     &pinctrl_nand_cs
+					     &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "hw";
+					nand-ecc-strength = <4>;
+					nand-ecc-step-size = <512>;
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						bootstrap at 0 {
+							label = "bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						ubi at 20000 {
+							label = "ubi";
+							reg = <0x20000 0x7fe0000>;
+						};
+					};
+				};
+			};
+		};
+
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
 			nand-ecc-mode = "hw";
@@ -77,15 +120,6 @@
 			nand-on-flash-bbt;
 			status = "okay";
 
-			bootstrap at 0 {
-				label = "bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			ubi at 20000 {
-				label = "ubi";
-				reg = <0x20000 0x7fe0000>;
-			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 8f019184fccf..f46352790a41 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -107,50 +107,69 @@
 			status = "okay";
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at a0000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at c0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4c0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7cc0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at a0000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at c0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4c0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7cc0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index ab0e73374567..6582f3cca929 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -532,10 +532,14 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOC 13 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PC13 gpio RDY pin pull_up */
-							 AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PC14 gpio enable pin pull_up */
+							<AT91_PIOC 13 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							 <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -995,24 +999,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000
-			       0xffffe800 0x200
-			      >;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioC 13 GPIO_ACTIVE_HIGH
-				 &pioC 14 GPIO_ACTIVE_HIGH
-				 0
-				>;
-			status = "disabled";
-		};
-
 		usb0: ohci at 500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 3ab0c21134f1..a05353f96151 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -118,22 +118,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000>;
-			atmel,nand-addr-offset = <22>;
-			atmel,nand-cmd-offset = <21>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-
-			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>,
-				<&pioC 14 GPIO_ACTIVE_HIGH>,
-				<0>;
-			status = "disabled";
-		};
-
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -394,9 +378,13 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
+						atmel,pins =
+							<AT91_PIOC 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
 						atmel,pins =
-							<AT91_PIOC 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 55bd51f07fa6..157e1493e6eb 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -68,40 +68,59 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
-
-			bootloader at 40000 {
-				label = "bootloader";
-				reg = <0x40000 0x80000>;
-			};
-
-			bootloaderenv at c0000 {
-				label = "bootloader env";
-				reg = <0xc0000 0xc0000>;
-			};
-
-			dtb at 180000 {
-				label = "device tree";
-				reg = <0x180000 0x80000>;
-			};
-
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
-
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x40000>;
+						};
+
+						bootloader at 40000 {
+							label = "bootloader";
+							reg = <0x40000 0x80000>;
+						};
+
+						bootloaderenv at c0000 {
+							label = "bootloader env";
+							reg = <0xc0000 0xc0000>;
+						};
+
+						dtb at 180000 {
+							label = "device tree";
+							reg = <0x180000 0x80000>;
+						};
+
+						kernel at 200000 {
+							label = "kernel";
+							reg = <0x200000 0x600000>;
+						};
+
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x0f800000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index db9f3a02f2fa..ed4b564f8de5 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -487,10 +487,14 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOA 22 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PA22 gpio RDY pin pull_up*/
-							 AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PD15 gpio enable pin pull_up */
+							<AT91_PIOA 22 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							 <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -1006,24 +1010,6 @@
 			status = "disabled";
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000
-			       0xffffe000 0x200
-			      >;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioA 22 GPIO_ACTIVE_HIGH
-				 &pioD 15 GPIO_ACTIVE_HIGH
-				 0
-				>;
-			status = "disabled";
-		};
-
 		usb0: ohci at 00a00000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 127cc42e9e29..10a0925da10e 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -125,50 +125,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt = <1>;
+		ebi0: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 27847a47c108..ac9a1511e239 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -123,50 +123,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 392dcfb79b57..a4808c4fbc05 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -611,10 +611,14 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PC8 gpio RDY pin pull_up*/
-							 AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PC14 gpio enable pin pull_up */
+							<AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							 <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -1288,25 +1292,6 @@
 			status = "disabled";
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000
-			       0xffffe200 0x200
-			      >;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioC 8 GPIO_ACTIVE_HIGH
-				 &pioC 14 GPIO_ACTIVE_HIGH
-				 0
-				>;
-			status = "disabled";
-		};
-
 		usb0: ohci at 00700000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00700000 0x100000>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 2400c99134f7..2522c3308305 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -245,25 +245,44 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			boot at 0 {
-				label = "bootstrap/uboot/kernel";
-				reg = <0x0 0x400000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
 
-			rootfs at 400000 {
-				label = "rootfs";
-				reg = <0x400000 0x3C00000>;
-			};
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 8 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						boot at 0 {
+							label = "bootstrap/uboot/kernel";
+							reg = <0x0 0x400000>;
+						};
 
-			data at 4000000 {
-				label = "data";
-				reg = <0x4000000 0xC000000>;
+						rootfs at 400000 {
+							label = "rootfs";
+							reg = <0x400000 0x3C00000>;
+						};
+
+						data at 4000000 {
+							label = "data";
+							reg = <0x4000000 0xC000000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index df06a66ace07..06516d02d351 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -643,10 +643,14 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PD5 gpio RDY pin pull_up*/
-							 AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PD4 gpio enable pin pull_up */
+							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
+						atmel,pins =
+							 <AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -1014,28 +1018,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = < 0x40000000 0x10000000
-				0xffffe000 0x00000600
-				0xffffe600 0x00000200
-				0x00108000 0x00018000
-			       >;
-			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioD 5 GPIO_ACTIVE_HIGH
-				 &pioD 4 GPIO_ACTIVE_HIGH
-				 0
-				>;
-			status = "disabled";
-		};
-
 		usb0: ohci at 00500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 626c67d66626..5bea8c59b115 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -147,14 +147,26 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;
-			atmel,pmecc-cap = <2>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
+
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-ecc-strength = <2>;
+					nand-ecc-step-size = <512>;
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+				};
+			};
 		};
 
 		usb0: ohci at 00500000 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index d373400cddcd..7768342a6638 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -117,23 +117,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000>,
-			      <0xffffe800 0x200>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>,
-				<&pioB 6 GPIO_ACTIVE_HIGH>,
-				<0>;
-			status = "disabled";
-		};
-
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -478,6 +461,14 @@
 					};
 				};
 
+				ebi {
+					pinctrl_ebi_addr_nand: ebi-addr-0 {
+						atmel,pins =
+							<AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
 				fb {
 					pinctrl_fb: fb-0 {
 						atmel,pins =
@@ -542,28 +533,21 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOB 6 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+							<AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 
-					pinctrl_nand0_ale_cle: nand_ale_cle-0 {
+					pinctrl_nand_cs: nand-cs-0 {
 						atmel,pins =
-							<AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE>,
-							<AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOB 6 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 
-					pinctrl_nand0_oe_we: nand_oe_we-0 {
+					pinctrl_nand_oe_we: nand-oe-we-0 {
 						atmel,pins =
 							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE>,
 							<AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
-
-					pinctrl_nand0_cs: nand_cs-0 {
-						atmel,pins =
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE>;
-					};
 				};
 
 				pwm0 {
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 2e567d90fba8..9047c168298a 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -63,40 +63,63 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt = <1>;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_addr_nand>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
-
-			bootloader at 40000 {
-				label = "bootloader";
-				reg = <0x40000 0x80000>;
-			};
-
-			bootloaderenv at c0000 {
-				label = "bootloader env";
-				reg = <0xc0000 0xc0000>;
-			};
-
-			dtb at 180000 {
-				label = "device tree";
-				reg = <0x180000 0x80000>;
-			};
-
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_oe_we
+					     &pinctrl_nand_cs
+					     &pinctrl_nand_rb>;
+				pinctrl-names = "default";
 
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x40000>;
+						};
+
+						bootloader at 40000 {
+							label = "bootloader";
+							reg = <0x40000 0x80000>;
+						};
+
+						bootloaderenv at c0000 {
+							label = "bootloader env";
+							reg = <0xc0000 0xc0000>;
+						};
+
+						dtb at 180000 {
+							label = "device tree";
+							reg = <0x180000 0x80000>;
+						};
+
+						kernel at 200000 {
+							label = "kernel";
+							reg = <0x200000 0x600000>;
+						};
+
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x0f800000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7723e8b02880..57f307541d2e 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -481,6 +481,38 @@
 					};
 				};
 
+				ebi {
+					pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
+						atmel,pins =
+							<AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_data_8_15: ebi-data-msb-0 {
+						atmel,pins =
+							<AT91_PIOD 14 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 15 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_ebi_addr_nand: ebi-addr-0 {
+						atmel,pins =
+							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
@@ -567,34 +599,20 @@
 				};
 
 				nand {
-					pinctrl_nand: nand-0 {
+					pinctrl_nand_oe_we: nand-oe-we-0 {
 						atmel,pins =
-							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD0 periph A Read Enable */
-							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD1 periph A Write Enable */
-							 AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD2 periph A Address Latch Enable */
-							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD3 periph A Command Latch Enable */
-							 AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PD4 gpio Chip Enable pin pull_up */
-							 AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PD5 gpio RDY/BUSY pin pull_up */
-							 AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD6 periph A Data bit 0 */
-							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD7 periph A Data bit 1 */
-							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD8 periph A Data bit 2 */
-							 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD9 periph A Data bit 3 */
-							 AT91_PIOD 10 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD10 periph A Data bit 4 */
-							 AT91_PIOD 11 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD11 periph A Data bit 5 */
-							 AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD12 periph A Data bit 6 */
-							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD13 periph A Data bit 7 */
-					};
-
-					pinctrl_nand_16bits: nand_16bits-0 {
+							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+
+					pinctrl_nand_rb: nand-rb-0 {
+						atmel,pins =
+							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_nand_cs: nand-cs-0 {
 						atmel,pins =
-							<AT91_PIOD 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD14 periph A Data bit 8 */
-							 AT91_PIOD 15 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD15 periph A Data bit 9 */
-							 AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD16 periph A Data bit 10 */
-							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD17 periph A Data bit 11 */
-							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD18 periph A Data bit 12 */
-							 AT91_PIOD 19 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD19 periph A Data bit 13 */
-							 AT91_PIOD 20 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD20 periph A Data bit 14 */
-							 AT91_PIOD 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD21 periph A Data bit 15 */
+							<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -1213,28 +1231,6 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x40000000 0x10000000
-			       0xffffe000 0x600		/* PMECC Registers */
-			       0xffffe600 0x200		/* PMECC Error Location Registers */
-			       0x00108000 0x18000	/* PMECC looup table in ROM code  */
-			      >;
-			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			gpios = <&pioD 5 GPIO_ACTIVE_HIGH
-				 &pioD 4 GPIO_ACTIVE_HIGH
-				 0
-				>;
-			status = "disabled";
-		};
-
 		usb0: ohci at 00600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index b098ad8cd93a..bdeaa0b64a5b 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -37,38 +37,61 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;	/* Enable PMECC */
-			atmel,pmecc-cap = <2>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_addr_nand
+				     &pinctrl_ebi_data_0_7>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
-
-			uboot at 40000 {
-				label = "u-boot";
-				reg = <0x40000 0x80000>;
-			};
-
-			ubootenv at c0000 {
-				label = "U-Boot Env";
-				reg = <0xc0000 0x140000>;
-			};
-
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
-
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x1f800000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_oe_we
+					     &pinctrl_nand_cs
+					     &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "hw";
+					nand-ecc-strength = <2>;
+					nand-ecc-step-size = <512>;
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x40000>;
+						};
+
+						uboot at 40000 {
+							label = "u-boot";
+							reg = <0x40000 0x80000>;
+						};
+
+						ubootenv at c0000 {
+							label = "U-Boot Env";
+							reg = <0xc0000 0x140000>;
+						};
+
+						kernel at 200000 {
+							label = "kernel";
+							reg = <0x200000 0x600000>;
+						};
+
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x1f800000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/ethernut5.dts
index 4687229a3ab9..123b203be06c 100644
--- a/arch/arm/boot/dts/ethernut5.dts
+++ b/arch/arm/boot/dts/ethernut5.dts
@@ -55,25 +55,38 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			gpios = <0
-				 &pioC 14 GPIO_ACTIVE_HIGH
-				 0
-				>;
-
-			root at 0 {
-				label = "root";
-				reg = <0x0 0x08000000>;
-			};
-
-			data at 20000 {
-				label = "data";
-				reg = <0x08000000 0x38000000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs>;
+				pinctrl-names = "default";
+
+				nand: nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						root at 0 {
+							label = "root";
+							reg = <0x0 0x08000000>;
+						};
+
+						data at 20000 {
+							label = "data";
+							reg = <0x08000000 0x38000000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
index 4aee5cc75fa4..8613944ea5c5 100644
--- a/arch/arm/boot/dts/ge863-pro3.dtsi
+++ b/arch/arm/boot/dts/ge863-pro3.dtsi
@@ -23,20 +23,39 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			boot at 0 {
-				label = "boot";
-				reg = <0x0 0x7c0000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						boot at 0 {
+							label = "boot";
+							reg = <0x0 0x7c0000>;
+						};
 
-			root at 07c0000 {
-				label = "root";
-				reg = <0x7c0000 0x7840000>;
+						root at 07c0000 {
+							label = "root";
+							reg = <0x7c0000 0x7840000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 0abd7bf17568..3139221737ee 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -37,12 +37,10 @@
 			};
 
 			pinctrl at fffff200 {
-
-				board {
-					pinctrl_board_nand: nand0-board {
+				nand {
+					pinctrl_nand_rb: nand-rb-0 {
 						atmel,pins =
-							<AT91_PIOD 3 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP	/* PD3 gpio RDY pin pull_up*/
-							 AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PC14 gpio enable pin pull_up */
+							<AT91_PIOD 3 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
@@ -71,50 +69,61 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
-
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
-			pinctrl-0 = <&pinctrl_board_nand>;
-
-			gpios = <&pioD 3 GPIO_ACTIVE_HIGH
-				 &pioC 14 GPIO_ACTIVE_HIGH
-				 0
-				>;
-
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x1A0000>;
-			};
-
-			kernel at 200000 {
-				label = "bareboxenv2";
-				reg = <0x200000 0x300000>;
-			};
-
-			kernel at 500000 {
-				label = "root";
-				reg = <0x500000 0x400000>;
-			};
-
-			data at 900000 {
-				label = "data";
-				reg = <0x900000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioD 3 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x1A0000>;
+						};
+
+						kernel at 200000 {
+							label = "bareboxenv2";
+							reg = <0x200000 0x300000>;
+						};
+
+						kernel at 500000 {
+							label = "root";
+							reg = <0x500000 0x400000>;
+						};
+
+						data at 900000 {
+							label = "data";
+							reg = <0x900000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 3925f83f58a6..554d0bdedc7a 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1569,38 +1569,6 @@
 			};
 		};
 
-		nand0: nand at 60000000 {
-			compatible = "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			reg = <	0x60000000 0x01000000	/* EBI CS3 */
-				0xffffc070 0x00000490	/* SMC PMECC regs */
-				0xffffc500 0x00000100	/* SMC PMECC Error Location regs */
-				0x00110000 0x00018000	/* ROM code */
-				>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
-			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
-			status = "disabled";
-
-			nfc at 70000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <
-					0x70000000 0x08000000	/* NFC Command Registers */
-					0xffffc000 0x00000070	/* NFC HSMC regs */
-					0x00200000 0x00100000	/* NFC SRAM banks */
-					>;
-				clocks = <&hsmc_clk>;
-			};
-		};
-
 		nfc_io: nfc-io at 70000000 {
 			compatible = "atmel,sama5d3-nfc-io", "syscon";
 			reg = <0x70000000 0x8000000>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index de6bcff87745..2fa36c525957 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -312,37 +312,6 @@
 			};
 		};
 
-		nand0: nand at 80000000 {
-			compatible = "atmel,sama5d4-nand", "atmel,at91rm9200-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			reg = <	0x80000000 0x08000000	/* EBI CS3 */
-				0xfc05c070 0x00000490	/* SMC PMECC regs */
-				0xfc05c500 0x00000100	/* SMC PMECC Error Location regs */
-				>;
-			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 6>;
-			atmel,nand-addr-offset = <21>;
-			atmel,nand-cmd-offset = <22>;
-			atmel,nand-has-dma;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_nand>;
-			status = "disabled";
-
-			nfc at 90000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <
-					0x90000000 0x08000000	/* NFC Command Registers */
-					0xfc05c000 0x00000070	/* NFC HSMC regs */
-					0x00100000 0x00100000	/* NFC SRAM banks */
-                                         >;
-				clocks = <&hsmc_clk>;
-				atmel,write-by-sram;
-			};
-		};
-
 		nfc_io: nfc-io at 90000000 {
 			compatible = "atmel,sama5d3-nfc-io", "syscon";
 			reg = <0x90000000 0x8000000>;
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index f9dc463b9e48..5d83df4675a1 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -32,50 +32,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
 
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
 
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
 
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
 
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
 
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
 
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
 
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 9161cd9889b4..8cf0a9e08571 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -42,50 +42,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi0: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 7514b347cdd2..34a49995eda3 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -34,50 +34,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index bfc48a272417..482381c1c962 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -62,50 +62,69 @@
 			};
 		};
 
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			nand-on-flash-bbt;
+		ebi0: ebi at 10000000 {
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x20000>;
-			};
-
-			barebox at 20000 {
-				label = "barebox";
-				reg = <0x20000 0x40000>;
-			};
-
-			bareboxenv at 60000 {
-				label = "bareboxenv";
-				reg = <0x60000 0x20000>;
-			};
-
-			bareboxenv2 at 80000 {
-				label = "bareboxenv2";
-				reg = <0x80000 0x20000>;
-			};
-
-			oftree at 80000 {
-				label = "oftree";
-				reg = <0xa0000 0x20000>;
-			};
-
-			kernel at a0000 {
-				label = "kernel";
-				reg = <0xc0000 0x400000>;
-			};
-
-			rootfs at 4a0000 {
-				label = "rootfs";
-				reg = <0x4c0000 0x7800000>;
-			};
-
-			data at 7ca0000 {
-				label = "data";
-				reg = <0x7cc0000 0x8340000>;
+			nand_controller: nand-controller {
+				status = "okay";
+				pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb>;
+				pinctrl-names = "default";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x800000>;
+					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "soft";
+					nand-on-flash-bbt;
+					label = "atmel_nand";
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x20000>;
+						};
+
+						barebox at 20000 {
+							label = "barebox";
+							reg = <0x20000 0x40000>;
+						};
+
+						bareboxenv at 60000 {
+							label = "bareboxenv";
+							reg = <0x60000 0x20000>;
+						};
+
+						bareboxenv2 at 80000 {
+							label = "bareboxenv2";
+							reg = <0x80000 0x20000>;
+						};
+
+						oftree at 80000 {
+							label = "oftree";
+							reg = <0xa0000 0x20000>;
+						};
+
+						kernel at a0000 {
+							label = "kernel";
+							reg = <0xc0000 0x400000>;
+						};
+
+						rootfs at 4a0000 {
+							label = "rootfs";
+							reg = <0x4c0000 0x7800000>;
+						};
+
+						data at 7ca0000 {
+							label = "data";
+							reg = <0x7cc0000 0x8340000>;
+						};
+					};
+				};
 			};
 		};
 
-- 
2.7.4
