From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Apr 2018 16:47:59 +0200
Subject: [PATCH v2 1/4] ARM: dts: armada-370-xp: update NAND node with new
 bindings
In-Reply-To: <20180425144802.15998-1-miquel.raynal@bootlin.com>
References: <20180425144802.15998-1-miquel.raynal@bootlin.com>
Message-ID: <20180425144802.15998-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new bindings of the Marvell NAND controller driver. Also adapt
the NAND controller node organization to distinguish which property is
relevant for the controller, and which one is NAND chip specific. Expose
the partitions as a subnode of the NAND chip.

Remove the 'marvell,nand-enable-arbiter' property, not needed anymore
as the new driver activates the arbiter by default for all boards which
is either needed or harmless.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/armada-370-db.dts                |  57 ++++----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 120 ++++++++--------
 arch/arm/boot/dts/armada-370-mirabox.dts           |  51 ++++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  90 ++++++------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  90 ++++++------
 arch/arm/boot/dts/armada-370-rd.dts                |  52 ++++---
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  64 +++++----
 arch/arm/boot/dts/armada-370-xp.dtsi               |   6 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |   2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 156 +++++++++++----------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  90 ++++++------
 15 files changed, 434 insertions(+), 352 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index afe46097a403..77261a2fb949 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -105,33 +105,6 @@
 			usb at 51000 {
 				status = "okay";
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0 0x800000>;
-					};
-					partition at 800000 {
-						label = "Linux";
-						reg = <0x800000 0x800000>;
-					};
-					partition at 1000000 {
-						label = "Filesystem";
-						reg = <0x1000000 0x3f000000>;
-					};
-				};
-			};
 		};
 	};
 
@@ -239,3 +212,33 @@
 	};
 };
 
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x800000>;
+			};
+			partition at 800000 {
+				label = "Linux";
+				reg = <0x800000 0x800000>;
+			};
+			partition at 1000000 {
+				label = "Filesystem";
+				reg = <0x1000000 0x3f000000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 8e46f63cbaa1..baa459dd51e4 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -44,61 +44,6 @@
 			usb at 50000 {
 				status = "okay";
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					/* 1.0 MiB */
-					reg = <0x0000000 0x100000>;
-					read-only;
-				};
-
-				partition at 100000 {
-					label = "u-boot-env";
-					/* 128 KiB */
-					reg = <0x100000 0x20000>;
-					read-only;
-				};
-
-				partition at 120000 {
-					label = "uImage";
-					/* 7 MiB */
-					reg = <0x120000 0x700000>;
-				};
-
-				partition at 820000 {
-					label = "ubifs";
-					/* ~ 84 MiB */
-					reg = <0x820000 0x54e0000>;
-				};
-
-				/* Hardcoded into stock bootloader */
-				partition at 5d00000 {
-					label = "failsafe-uImage";
-					/* 5 MiB */
-					reg = <0x5d00000 0x500000>;
-				};
-
-				partition at 6200000 {
-					label = "failsafe-fs";
-					/* 29 MiB */
-					reg = <0x6200000 0x1d00000>;
-				};
-
-				partition at 7f00000 {
-					label = "bbt";
-					/* 1 MiB for BBT */
-					reg = <0x7f00000 0x100000>;
-				};
-			};
 		};
 	};
 
@@ -319,3 +264,68 @@
 	clock-frequency = <100000>;
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				/* 1.0 MiB */
+				reg = <0x0000000 0x100000>;
+				read-only;
+			};
+
+			partition at 100000 {
+				label = "u-boot-env";
+				/* 128 KiB */
+				reg = <0x100000 0x20000>;
+				read-only;
+			};
+
+			partition at 120000 {
+				label = "uImage";
+				/* 7 MiB */
+				reg = <0x120000 0x700000>;
+			};
+
+			partition at 820000 {
+				label = "ubifs";
+				/* ~ 84 MiB */
+				reg = <0x820000 0x54e0000>;
+			};
+
+			/* Hardcoded into stock bootloader */
+			partition at 5d00000 {
+				label = "failsafe-uImage";
+				/* 5 MiB */
+				reg = <0x5d00000 0x500000>;
+			};
+
+			partition at 6200000 {
+				label = "failsafe-fs";
+				/* 29 MiB */
+				reg = <0x6200000 0x1d00000>;
+			};
+
+			partition at 7f00000 {
+				label = "bbt";
+				/* 1 MiB for BBT */
+				reg = <0x7f00000 0x100000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 996f31b00729..7c2f5a79b50d 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -108,27 +108,6 @@
 					reg = <0x25>;
 				};
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partition at 0 {
-					label = "U-Boot";
-					reg = <0 0x400000>;
-				};
-				partition at 400000 {
-					label = "Linux";
-					reg = <0x400000 0x400000>;
-				};
-				partition at 800000 {
-					label = "Filesystem";
-					reg = <0x800000 0x3f800000>;
-				};
-			};
 		};
 	};
 };
@@ -173,3 +152,33 @@
 	};
 };
 
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x400000>;
+			};
+			partition at 400000 {
+				label = "Linux";
+				reg = <0x400000 0x400000>;
+			};
+			partition at 800000 {
+				label = "Filesystem";
+				reg = <0x800000 0x3f800000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 56634803e16b..b0b640b7de40 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -81,46 +81,6 @@
 					pwm_polarity = <0>;
 				};
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				/* Use Hardware BCH ECC */
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x180000>;  /* 1.5MB */
-					read-only;
-				};
-
-				partition at 180000 {
-					label = "u-boot-env";
-					reg = <0x180000 0x20000>;    /* 128KB */
-					read-only;
-				};
-
-				partition at 200000 {
-					label = "uImage";
-					reg = <0x0200000 0x600000>;    /* 6MB */
-				};
-
-				partition at 800000 {
-					label = "minirootfs";
-					reg = <0x0800000 0x400000>;    /* 4MB */
-				};
-
-				/* Last MB is for the BBT, i.e. not writable */
-				partition at c00000 {
-					label = "ubifs";
-					reg = <0x0c00000 0x7400000>; /* 116MB */
-				};
-			};
 		};
 	};
 
@@ -264,3 +224,53 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		/* Use Hardware BCH ECC */
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x180000>;  /* 1.5MB */
+				read-only;
+			};
+
+			partition at 180000 {
+				label = "u-boot-env";
+				reg = <0x180000 0x20000>;    /* 128KB */
+				read-only;
+			};
+
+			partition at 200000 {
+				label = "uImage";
+				reg = <0x0200000 0x600000>;    /* 6MB */
+			};
+
+			partition at 800000 {
+				label = "minirootfs";
+				reg = <0x0800000 0x400000>;    /* 4MB */
+			};
+
+			/* Last MB is for the BBT, i.e. not writable */
+			partition at c00000 {
+				label = "ubifs";
+				reg = <0x0c00000 0x7400000>; /* 116MB */
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 16d0307f786a..9fd1cb9f4992 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -90,46 +90,6 @@
 					reg = <0x23>;
 				};
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				/* Use Hardware BCH ECC */
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x180000>;  /* 1.5MB */
-					read-only;
-				};
-
-				partition at 180000 {
-					label = "u-boot-env";
-					reg = <0x180000 0x20000>;    /* 128KB */
-					read-only;
-				};
-
-				partition at 200000 {
-					label = "uImage";
-					reg = <0x0200000 0x600000>;    /* 6MB */
-				};
-
-				partition at 800000 {
-					label = "minirootfs";
-					reg = <0x0800000 0x400000>;    /* 4MB */
-				};
-
-				/* Last MB is for the BBT, i.e. not writable */
-				partition at c00000 {
-					label = "ubifs";
-					reg = <0x0c00000 0x7400000>; /* 116MB */
-				};
-			};
 		};
 	};
 
@@ -276,3 +236,53 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		/* Use Hardware BCH ECC */
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x180000>;  /* 1.5MB */
+				read-only;
+			};
+
+			partition at 180000 {
+				label = "u-boot-env";
+				reg = <0x180000 0x20000>;    /* 128KB */
+				read-only;
+			};
+
+			partition at 200000 {
+				label = "uImage";
+				reg = <0x0200000 0x600000>;    /* 6MB */
+			};
+
+			partition at 800000 {
+				label = "minirootfs";
+				reg = <0x0800000 0x400000>;    /* 4MB */
+			};
+
+			/* Last MB is for the BBT, i.e. not writable */
+			partition at c00000 {
+				label = "ubifs";
+				reg = <0x0c00000 0x7400000>; /* 116MB */
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index cc2f774eb267..2bfb3108b5b2 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -112,27 +112,6 @@
 					default-state = "keep";
 				};
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partition at 0 {
-					label = "U-Boot";
-					reg = <0 0x800000>;
-				};
-				partition at 800000 {
-					label = "Linux";
-					reg = <0x800000 0x800000>;
-				};
-				partition at 1000000 {
-					label = "Filesystem";
-					reg = <0x1000000 0x3f000000>;
-				};
-			};
 		};
 	};
 
@@ -288,3 +267,34 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x800000>;
+			};
+			partition at 800000 {
+				label = "Linux";
+				reg = <0x800000 0x800000>;
+			};
+			partition at 1000000 {
+				label = "Filesystem";
+				reg = <0x1000000 0x3f000000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index a5206db0ebbd..b52634ecf1d9 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -66,33 +66,6 @@
 					interrupts = <110>;
 				};
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0 0x300000>;
-				};
-				partition at 300000 {
-					label = "device-tree";
-					reg = <0x300000 0x20000>;
-				};
-				partition at 320000 {
-					label = "linux";
-					reg = <0x320000 0x2000000>;
-				};
-				partition at 2320000 {
-					label = "rootfs";
-					reg = <0x2320000 0xdce0000>;
-				};
-			};
 		};
 
 	};
@@ -227,3 +200,40 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0 0x300000>;
+			};
+			partition at 300000 {
+				label = "device-tree";
+				reg = <0x300000 0x20000>;
+			};
+			partition at 320000 {
+				label = "linux";
+				reg = <0x320000 0x2000000>;
+			};
+			partition at 2320000 {
+				label = "rootfs";
+				reg = <0x2320000 0xdce0000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 11fc3271dad4..c15f5e92f97f 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -244,11 +244,11 @@
 				status = "disabled";
 			};
 
-			nand: nand at d0000 {
-				compatible = "marvell,armada370-nand";
+			nand_controller: nand-controller at d0000 {
+				compatible = "marvell,armada370-nand-controller";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <113>;
 				clocks = <&coredivclk 0>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index 4c64923f1c52..f42fc6118b7c 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -70,9 +70,9 @@
 
 &nand {
 	status = "okay";
+	label = "pxa3xx_nand-0";
 	num-cs = <1>;
 	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index a0ebb52683f1..8432f517e346 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -69,9 +69,9 @@
 
 &nand {
 	status = "okay";
+	label = "pxa3xx_nand-0";
 	num-cs = <1>;
 	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 73d3f5cb9828..f3ac7483afed 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -146,9 +146,9 @@
 
 			nand at d0000 {
 				status = "okay";
+				label = "pxa3xx_nand-0";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 
 				partitions {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index c143556bbb7b..1139e9469a83 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -162,9 +162,9 @@
 
 			nand at d0000 {
 				status = "okay";
+				label = "pxa3xx_nand-0";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 			};
 		};
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index def62e9e835b..bbbb38888bb8 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -83,9 +83,9 @@
 
 			nand at d0000 {
 				status = "okay";
+				label = "pxa3xx_nand-0";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 
 				partitions {
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index f8b60d937818..7a2606c3b62e 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -165,79 +165,6 @@
 			bm at c8000 {
 				status = "okay";
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x100000>;  /* 1MB */
-					read-only;
-				};
-
-				partition at 100000 {
-					label = "u_env";
-					reg = <0x100000 0x40000>;    /* 256KB */
-				};
-
-				partition at 140000 {
-					label = "s_env";
-					reg = <0x140000 0x40000>;    /* 256KB */
-				};
-
-				partition at 900000 {
-					label = "devinfo";
-					reg = <0x900000 0x100000>;   /* 1MB */
-					read-only;
-				};
-
-				/* kernel1 overlaps with rootfs1 by design */
-				partition at a00000 {
-					label = "kernel1";
-					reg = <0xa00000 0x2800000>;  /* 40MB */
-				};
-
-				partition at d00000 {
-					label = "rootfs1";
-					reg = <0xd00000 0x2500000>;  /* 37MB */
-				};
-
-				/* kernel2 overlaps with rootfs2 by design */
-				partition at 3200000 {
-					label = "kernel2";
-					reg = <0x3200000 0x2800000>; /* 40MB */
-				};
-
-				partition at 3500000 {
-					label = "rootfs2";
-					reg = <0x3500000 0x2500000>; /* 37MB */
-				};
-
-				/*
-				 * 38MB, last MB is for the BBT, not writable
-				 */
-				partition at 5a00000 {
-					label = "syscfg";
-					reg = <0x5a00000 0x2600000>;
-				};
-
-				/*
-				 * Unused area between "s_env" and "devinfo".
-				 * Moved here because otherwise the renumbered
-				 * partitions would break the bootloader
-				 * supplied bootargs
-				 */
-				partition at 180000 {
-					label = "unused_area";
-					reg = <0x180000 0x780000>;   /* 7.5MB */
-				};
-			};
 		};
 
 		bm-bppi {
@@ -434,3 +361,86 @@
 		};
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x100000>;  /* 1MB */
+				read-only;
+			};
+
+			partition at 100000 {
+				label = "u_env";
+				reg = <0x100000 0x40000>;    /* 256KB */
+			};
+
+			partition at 140000 {
+				label = "s_env";
+				reg = <0x140000 0x40000>;    /* 256KB */
+			};
+
+			partition at 900000 {
+				label = "devinfo";
+				reg = <0x900000 0x100000>;   /* 1MB */
+				read-only;
+			};
+
+			/* kernel1 overlaps with rootfs1 by design */
+			partition at a00000 {
+				label = "kernel1";
+				reg = <0xa00000 0x2800000>;  /* 40MB */
+			};
+
+			partition at d00000 {
+				label = "rootfs1";
+				reg = <0xd00000 0x2500000>;  /* 37MB */
+			};
+
+			/* kernel2 overlaps with rootfs2 by design */
+			partition at 3200000 {
+				label = "kernel2";
+				reg = <0x3200000 0x2800000>; /* 40MB */
+			};
+
+			partition at 3500000 {
+				label = "rootfs2";
+				reg = <0x3500000 0x2500000>; /* 37MB */
+			};
+
+			/*
+			 * 38MB, last MB is for the BBT, not writable
+			 */
+			partition at 5a00000 {
+				label = "syscfg";
+				reg = <0x5a00000 0x2600000>;
+			};
+
+			/*
+			 * Unused area between "s_env" and "devinfo".
+			 * Moved here because otherwise the renumbered
+			 * partitions would break the bootloader
+			 * supplied bootargs
+			 */
+			partition at 180000 {
+				label = "unused_area";
+				reg = <0x180000 0x780000>;   /* 7.5MB */
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index c350b1cf5201..8ea73587db81 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -117,46 +117,6 @@
 				nr-ports = <2>;
 				status = "okay";
 			};
-
-			nand at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				/* Use Hardware BCH ECC */
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x180000>;  /* 1.5MB */
-					read-only;
-				};
-
-				partition at 180000 {
-					label = "u-boot-env";
-					reg = <0x180000 0x20000>;    /* 128KB */
-					read-only;
-				};
-
-				partition at 200000 {
-					label = "uImage";
-					reg = <0x0200000 0x600000>;    /* 6MB */
-				};
-
-				partition at 800000 {
-					label = "minirootfs";
-					reg = <0x0800000 0x400000>;    /* 4MB */
-				};
-
-				/* Last MB is for the BBT, i.e. not writable */
-				partition at c00000 {
-					label = "ubifs";
-					reg = <0x0c00000 0x7400000>; /* 116MB */
-				};
-			};
 		};
 	};
 
@@ -345,3 +305,53 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+
+		/* Use Hardware BCH ECC */
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x180000>;  /* 1.5MB */
+				read-only;
+			};
+
+			partition at 180000 {
+				label = "u-boot-env";
+				reg = <0x180000 0x20000>;    /* 128KB */
+				read-only;
+			};
+
+			partition at 200000 {
+				label = "uImage";
+				reg = <0x0200000 0x600000>;    /* 6MB */
+			};
+
+			partition at 800000 {
+				label = "minirootfs";
+				reg = <0x0800000 0x400000>;    /* 4MB */
+			};
+
+			/* Last MB is for the BBT, i.e. not writable */
+			partition at c00000 {
+				label = "ubifs";
+				reg = <0x0c00000 0x7400000>; /* 116MB */
+			};
+		};
+	};
+};
-- 
2.14.1
