From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 May 2017 10:32:48 +0200
Subject: [PATCH 3/5] ARM: dts: at91: Update board dts to use the new EBI/NAND
 bindings
In-Reply-To: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1496133171-4787-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller bindings have been changed to match the hardware
topology (where the NAND controller is under the EBI bus).

This new representation is needed in order to define non-NAND devices
under the EBI bus (otherwise we face pinmux conflicts).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox2.dts          | 45 ++++++++-----
 arch/arm/boot/dts/at91-linea.dtsi           | 25 +++++---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 97 +++++++++++++++++------------
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 83 ++++++++++++++----------
 arch/arm/boot/dts/at91-sama5d4ek.dts        | 83 ++++++++++++++----------
 arch/arm/boot/dts/at91-tse850-3.dts         | 70 +++++++++++----------
 arch/arm/boot/dts/sama5d3xcm.dtsi           | 76 +++++++++++++---------
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi       | 77 ++++++++++++++---------
 8 files changed, 339 insertions(+), 217 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
index 50a14568f094..4372c0287c1c 100644
--- a/arch/arm/boot/dts/at91-kizbox2.dts
+++ b/arch/arm/boot/dts/at91-kizbox2.dts
@@ -141,23 +141,40 @@
 			status = "okay";
 		};
 
-		nand0: nand at 60000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;
-			atmel,pmecc-cap = <4>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			bootstrap at 0 {
-				label = "bootstrap";
-				reg = <0x0 0x20000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
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
 
-			ubi at 20000 {
-				label = "ubi";
-				reg = <0x20000 0x7fe0000>;
+						ubi at 20000 {
+							label = "ubi";
+							reg = <0x20000 0x7fe0000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
index 0721c8472509..14094af90719 100644
--- a/arch/arm/boot/dts/at91-linea.dtsi
+++ b/arch/arm/boot/dts/at91-linea.dtsi
@@ -37,13 +37,24 @@
 	};
 };
 
-&nand0 {
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
 	status = "okay";
+};
+
 
-	nand-bus-width = <8>;
-	nand-ecc-mode = "hw";
-	atmel,has-pmecc;
-	atmel,pmecc-cap = <4>;
-	atmel,pmecc-sector-size = <512>;
-	nand-on-flash-bbt;
+&nand_controller {
+	status = "okay";
+
+	nand: nand at 3 {
+		reg = <0x3 0x0 0x2>;
+		atmel,rb = <0>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-on-flash-bbt;
+		label = "atmel_nand";
+	};
 };
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 5a53fcf542ab..3af088d2cba7 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -235,46 +235,6 @@
 			};
 		};
 
-		nand0: nand at 60000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;
-			atmel,pmecc-cap = <4>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
-			status = "okay";
-
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
-			};
-		};
-
 		usb0: gadget at 00500000 {
 			atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;	/* PE9, conflicts with A9 */
 			pinctrl-names = "default";
@@ -294,6 +254,63 @@
 		usb2: ehci at 00700000 {
 			status = "okay";
 		};
+
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+			pinctrl-names = "default";
+			status = "okay";
+
+			nand_controller: nand-controller {
+				status = "okay";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
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
+			};
+		};
 	};
 
 	vcc_mmc0_reg: fixedregulator_mmc0 {
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 5ab14cedb1db..cf712444b2c2 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -190,41 +190,60 @@
 			status = "okay";
 		};
 
-		nand0: nand at 80000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			nand-on-flash-bbt;
-			atmel,has-pmecc;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_cs3 &pinctrl_ebi_nrd_nandoe
+				     &pinctrl_ebi_nwe_nandwe &pinctrl_ebi_nandrdy
+				     &pinctrl_ebi_data_0_7 &pinctrl_ebi_nand_addr>;
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
 
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "hw";
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
 	};
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index f8b96cef5e1a..bae5248f126e 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -236,41 +236,60 @@
 			status = "okay";
 		};
 
-		nand0: nand at 80000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			nand-on-flash-bbt;
-			atmel,has-pmecc;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_cs3 &pinctrl_ebi_nrd_nandoe
+				     &pinctrl_ebi_nwe_nandwe &pinctrl_ebi_nandrdy
+				     &pinctrl_ebi_data_0_7 &pinctrl_ebi_nand_addr>;
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
 
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
+					nand-bus-width = <8>;
+					nand-ecc-mode = "hw";
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
 	};
diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 498fba3e52b5..2c4bfefa3f71 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -161,45 +161,51 @@
 	};
 };
 
-&nand0 {
-	at91bootstrap at 0 {
-		label = "at91bootstrap";
-		reg = <0x0 0x40000>;
-	};
+&nand {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		at91bootstrap at 0 {
+			label = "at91bootstrap";
+			reg = <0x0 0x40000>;
+		};
 
-	barebox at 40000 {
-		label = "bootloader";
-		reg = <0x40000 0x60000>;
-	};
+		barebox at 40000 {
+			label = "bootloader";
+			reg = <0x40000 0x60000>;
+		};
 
-	bareboxenv at c0000 {
-		label = "bareboxenv";
-		reg = <0xc0000 0x40000>;
-	};
+		bareboxenv at c0000 {
+			label = "bareboxenv";
+			reg = <0xc0000 0x40000>;
+		};
 
-	bareboxenv2 at 100000 {
-		label = "bareboxenv2";
-		reg = <0x100000 0x40000>;
-	};
+		bareboxenv2 at 100000 {
+			label = "bareboxenv2";
+			reg = <0x100000 0x40000>;
+		};
 
-	oftree at 180000 {
-		label = "oftree";
-		reg = <0x180000 0x20000>;
-	};
+		oftree at 180000 {
+			label = "oftree";
+			reg = <0x180000 0x20000>;
+		};
 
-	kernel at 200000 {
-		label = "kernel";
-		reg = <0x200000 0x500000>;
-	};
+		kernel at 200000 {
+			label = "kernel";
+			reg = <0x200000 0x500000>;
+		};
 
-	rootfs at 800000 {
-		label = "rootfs";
-		reg = <0x800000 0x0f800000>;
-	};
+		rootfs at 800000 {
+			label = "rootfs";
+			reg = <0x800000 0x0f800000>;
+		};
 
-	ovlfs at 10000000 {
-		label = "ovlfs";
-		reg = <0x10000000 0x10000000>;
+		ovlfs at 10000000 {
+			label = "ovlfs";
+			reg = <0x10000000 0x10000000>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index b5e111b29da1..4606e1d7e6f2 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -36,43 +36,59 @@
 			};
 		};
 
-		nand0: nand at 60000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;
-			atmel,pmecc-cap = <4>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
 
-			bootloader at 40000 {
-				label = "bootloader";
-				reg = <0x40000 0x80000>;
-			};
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
+					nand-ecc-mode = "hw";
+					nand-ecc-strength = <4>;
+					nand-ecc-step-size = <512>;
+					nand-on-flash-bbt;
+					label = "atmel_nand";
 
-			bootloaderenv at c0000 {
-				label = "bootloader env";
-				reg = <0xc0000 0xc0000>;
-			};
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
 
-			dtb at 180000 {
-				label = "device tree";
-				reg = <0x180000 0x80000>;
-			};
+						at91bootstrap at 0 {
+							label = "at91bootstrap";
+							reg = <0x0 0x40000>;
+						};
 
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
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
 
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x0f800000>;
+						};
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
index dc7572bc7ff0..75cbf4d4ab1a 100644
--- a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
@@ -148,43 +148,60 @@
 			};
 		};
 
-		nand0: nand at 60000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "hw";
-			atmel,has-pmecc;
-			atmel,pmecc-cap = <4>;
-			atmel,pmecc-sector-size = <512>;
-			nand-on-flash-bbt;
+		ebi: ebi at 10000000 {
+			pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+			pinctrl-names = "default";
 			status = "okay";
 
-			at91bootstrap at 0 {
-				label = "at91bootstrap";
-				reg = <0x0 0x40000>;
-			};
+			nand_controller: nand-controller {
+				status = "okay";
+
+				nand at 3 {
+					reg = <0x3 0x0 0x2>;
+					atmel,rb = <0>;
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
 
-			bootloader at 40000 {
-				label = "bootloader";
-				reg = <0x40000 0x80000>;
-			};
+						bootloader at 40000 {
+							label = "bootloader";
+							reg = <0x40000 0x80000>;
+						};
 
-			bootloaderenv at c0000 {
-				label = "bootloader env";
-				reg = <0xc0000 0xc0000>;
-			};
+						bootloaderenv at c0000 {
+							label = "bootloader env";
+							reg = <0xc0000 0xc0000>;
+						};
 
-			dtb at 180000 {
-				label = "device tree";
-				reg = <0x180000 0x80000>;
-			};
+						dtb at 180000 {
+							label = "device tree";
+							reg = <0x180000 0x80000>;
+						};
 
-			kernel at 200000 {
-				label = "kernel";
-				reg = <0x200000 0x600000>;
-			};
+						kernel at 200000 {
+							label = "kernel";
+							reg = <0x200000 0x600000>;
+						};
 
-			rootfs at 800000 {
-				label = "rootfs";
-				reg = <0x800000 0x0f800000>;
+						rootfs at 800000 {
+							label = "rootfs";
+							reg = <0x800000 0x0f800000>;
+						};
+					};
+				};
 			};
 		};
 	};
-- 
2.7.4
