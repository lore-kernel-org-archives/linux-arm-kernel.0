From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 18 Oct 2017 16:36:24 +0200
Subject: [RFC 07/12] ARM: dts: armada-370-xp: use reworked NAND controller
 driver
In-Reply-To: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
Message-ID: <20171018143629.29302-8-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the bindings to use the reworked Marvell NAND controller driver.
Also adapt the nand controller node organization to distinguish which
property is relevant for the controller, and which one is NAND chip
specific. Expose the partitions as a subnode of the NAND chip.

Remove the 'marvell,nand-enable-arbiter' property, inefective with
Armada boards.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                |  56 ++++----
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 119 ++++++++--------
 arch/arm/boot/dts/armada-370-mirabox.dts           |  50 ++++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  89 ++++++------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  89 ++++++------
 arch/arm/boot/dts/armada-370-rd.dts                |  51 ++++---
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  63 +++++----
 arch/arm/boot/dts/armada-370-xp.dtsi               |   6 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   1 -
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   1 -
 arch/arm/boot/dts/armada-xp-db.dts                 |   1 -
 arch/arm/boot/dts/armada-xp-gp.dts                 |   1 -
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   1 -
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      | 155 +++++++++++----------
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  89 ++++++------
 15 files changed, 420 insertions(+), 352 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index c4eef7323367..76c433c29731 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -142,33 +142,6 @@
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
 
@@ -276,3 +249,32 @@
 	};
 };
 
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index db7f3aa38670..0cc3285a40b3 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -81,61 +81,6 @@
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
 
@@ -356,3 +301,67 @@
 	clock-frequency = <100000>;
 	status = "okay";
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index 702f58c9642d..9e13a83cf057 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -145,27 +145,6 @@
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
@@ -210,3 +189,32 @@
 	};
 };
 
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index b1a96e95e921..e4fb1d7cf009 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -118,46 +118,6 @@
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
 
@@ -301,3 +261,52 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index d67e7aa42b54..f639838ce27d 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -127,46 +127,6 @@
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
 
@@ -313,3 +273,52 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index 8b2fa9a49967..d949cc6da1d6 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -148,27 +148,6 @@
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
 
@@ -293,3 +272,33 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index e9a5b952afc0..8f4b556e8fbf 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -69,33 +69,6 @@
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
@@ -230,3 +203,39 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index 09495e87b038..b6bead81c438 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -281,11 +281,11 @@
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
index 1b1ff17fdd9c..ba3ecf3d2481 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -109,7 +109,6 @@
 	status = "okay";
 	num-cs = <1>;
 	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 06fce35d7491..42f939dd9fdc 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -108,7 +108,6 @@
 	status = "okay";
 	num-cs = <1>;
 	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 065282c21789..311d6af25118 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -184,7 +184,6 @@
 				status = "okay";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 
 				partitions {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index ac9eab8ac186..a3053d176262 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -201,7 +201,6 @@
 				status = "okay";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 			};
 		};
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index ce0afba1ce58..a0ace4c92a8d 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -122,7 +122,6 @@
 				status = "okay";
 				num-cs = <1>;
 				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 
 				partitions {
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 6d705f518254..3ec10054d5a3 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -196,79 +196,6 @@
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
@@ -465,3 +392,85 @@
 		};
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
index 40c6fe21e720..0027f34b3666 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -154,46 +154,6 @@
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
 
@@ -382,3 +342,52 @@
 		marvell,function = "gpio";
 	};
 };
+
+&nand_controller {
+	status = "okay";
+
+	nand at 0 {
+		reg = <0>;
+		marvell,rb = <0>;
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
2.11.0
