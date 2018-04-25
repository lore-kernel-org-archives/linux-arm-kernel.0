From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Apr 2018 16:48:01 +0200
Subject: [PATCH v2 3/4] ARM: dts: armada-38x: update NAND node with new
 bindings
In-Reply-To: <20180425144802.15998-1-miquel.raynal@bootlin.com>
References: <20180425144802.15998-1-miquel.raynal@bootlin.com>
Message-ID: <20180425144802.15998-4-miquel.raynal@bootlin.com>
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
 arch/arm/boot/dts/armada-385-db-ap.dts          |  69 +++++++------
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 127 ++++++++++++------------
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 127 ++++++++++++------------
 arch/arm/boot/dts/armada-385-linksys-rango.dts  | 119 +++++++++++-----------
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 127 ++++++++++++------------
 arch/arm/boot/dts/armada-385-linksys.dtsi       |  16 ++-
 arch/arm/boot/dts/armada-388-db.dts             |  55 +++++-----
 arch/arm/boot/dts/armada-38x.dtsi               |   6 +-
 8 files changed, 342 insertions(+), 304 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index d294f24281a5..0e4613bb56ee 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -135,39 +135,6 @@
 				status = "okay";
 			};
 
-			nfc: flash at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
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
-						reg = <0x00000000 0x00800000>;
-						read-only;
-					};
-
-					partition at 800000 {
-						label = "uImage";
-						reg = <0x00800000 0x00400000>;
-						read-only;
-					};
-
-					partition at c00000 {
-						label = "Root";
-						reg = <0x00c00000 0x3f400000>;
-					};
-				};
-			};
-
 			usb3 at f0000 {
 				status = "okay";
 				usb-phy = <&usb3_phy>;
@@ -233,3 +200,39 @@
 		spi-max-frequency = <54000000>;
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
+				label = "U-Boot";
+				reg = <0x00000000 0x00800000>;
+				read-only;
+			};
+
+			partition at 800000 {
+				label = "uImage";
+				reg = <0x00800000 0x00400000>;
+				read-only;
+			};
+
+			partition at c00000 {
+				label = "Root";
+				reg = <0x00c00000 0x3f400000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index 1f30993af405..a03050c97084 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -73,67 +73,72 @@
 
 &nand {
 	/* 128MiB */
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	partition at 0 {
-		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MiB */
-		read-only;
-	};
-
-	partition at 100000 {
-		label = "u_env";
-		reg = <0x200000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 140000 {
-		label = "s_env";
-		reg = <0x240000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 900000 {
-		label = "devinfo";
-		reg = <0x900000 0x100000>;   /* 1MiB */
-		read-only;
-	};
-
-	/* kernel1 overlaps with rootfs1 by design */
-	partition at a00000 {
-		label = "kernel1";
-		reg = <0xa00000 0x2800000>;  /* 40MiB */
-	};
-
-	partition at 1000000 {
-		label = "rootfs1";
-		reg = <0x1000000 0x2200000>;  /* 34MiB */
-	};
-
-	/* kernel2 overlaps with rootfs2 by design */
-	partition at 3200000 {
-		label = "kernel2";
-		reg = <0x3200000 0x2800000>; /* 40MiB */
-	};
-
-	partition at 3800000 {
-		label = "rootfs2";
-		reg = <0x3800000 0x2200000>; /* 34MiB */
-	};
-
-	/*
-	 * 38MiB, last MiB is for the BBT, not writable
-	 */
-	partition at 5a00000 {
-		label = "syscfg";
-		reg = <0x5a00000 0x2600000>;
-	};
-
-	/*
-	 * Unused area between "s_env" and "devinfo".
-	 * Moved here because otherwise the renumbered
-	 * partitions would break the bootloader
-	 * supplied bootargs
-	 */
-	partition at 180000 {
-		label = "unused_area";
-		reg = <0x280000 0x680000>;   /* 6.5MiB */
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0000000 0x200000>;  /* 2MiB */
+			read-only;
+		};
+
+		partition at 100000 {
+			label = "u_env";
+			reg = <0x200000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 140000 {
+			label = "s_env";
+			reg = <0x240000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 900000 {
+			label = "devinfo";
+			reg = <0x900000 0x100000>;   /* 1MiB */
+			read-only;
+		};
+
+		/* kernel1 overlaps with rootfs1 by design */
+		partition at a00000 {
+			label = "kernel1";
+			reg = <0xa00000 0x2800000>;  /* 40MiB */
+		};
+
+		partition at 1000000 {
+			label = "rootfs1";
+			reg = <0x1000000 0x2200000>;  /* 34MiB */
+		};
+
+		/* kernel2 overlaps with rootfs2 by design */
+		partition at 3200000 {
+			label = "kernel2";
+			reg = <0x3200000 0x2800000>; /* 40MiB */
+		};
+
+		partition at 3800000 {
+			label = "rootfs2";
+			reg = <0x3800000 0x2200000>; /* 34MiB */
+		};
+
+		/*
+		 * 38MiB, last MiB is for the BBT, not writable
+		 */
+		partition at 5a00000 {
+			label = "syscfg";
+			reg = <0x5a00000 0x2600000>;
+		};
+
+		/*
+		 * Unused area between "s_env" and "devinfo".
+		 * Moved here because otherwise the renumbered
+		 * partitions would break the bootloader
+		 * supplied bootargs
+		 */
+		partition at 180000 {
+			label = "unused_area";
+			reg = <0x280000 0x680000>;   /* 6.5MiB */
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index bc34802ce6bc..e3e4877a6f49 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -73,67 +73,72 @@
 
 &nand {
 	/* 128MiB */
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	partition at 0 {
-		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MiB */
-		read-only;
-	};
-
-	partition at 100000 {
-		label = "u_env";
-		reg = <0x200000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 140000 {
-		label = "s_env";
-		reg = <0x240000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 900000 {
-		label = "devinfo";
-		reg = <0x900000 0x100000>;   /* 1MiB */
-		read-only;
-	};
-
-	/* kernel1 overlaps with rootfs1 by design */
-	partition at a00000 {
-		label = "kernel1";
-		reg = <0xa00000 0x2800000>;  /* 40MiB */
-	};
-
-	partition at 1000000 {
-		label = "rootfs1";
-		reg = <0x1000000 0x2200000>;  /* 34MiB */
-	};
-
-	/* kernel2 overlaps with rootfs2 by design */
-	partition at 3200000 {
-		label = "kernel2";
-		reg = <0x3200000 0x2800000>; /* 40MiB */
-	};
-
-	partition at 3800000 {
-		label = "rootfs2";
-		reg = <0x3800000 0x2200000>; /* 34MiB */
-	};
-
-	/*
-	 * 38MiB, last MiB is for the BBT, not writable
-	 */
-	partition at 5a00000 {
-		label = "syscfg";
-		reg = <0x5a00000 0x2600000>;
-	};
-
-	/*
-	 * Unused area between "s_env" and "devinfo".
-	 * Moved here because otherwise the renumbered
-	 * partitions would break the bootloader
-	 * supplied bootargs
-	 */
-	partition at 180000 {
-		label = "unused_area";
-		reg = <0x280000 0x680000>;   /* 6.5MiB */
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0000000 0x200000>;  /* 2MiB */
+			read-only;
+		};
+
+		partition at 100000 {
+			label = "u_env";
+			reg = <0x200000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 140000 {
+			label = "s_env";
+			reg = <0x240000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 900000 {
+			label = "devinfo";
+			reg = <0x900000 0x100000>;   /* 1MiB */
+			read-only;
+		};
+
+		/* kernel1 overlaps with rootfs1 by design */
+		partition at a00000 {
+			label = "kernel1";
+			reg = <0xa00000 0x2800000>;  /* 40MiB */
+		};
+
+		partition at 1000000 {
+			label = "rootfs1";
+			reg = <0x1000000 0x2200000>;  /* 34MiB */
+		};
+
+		/* kernel2 overlaps with rootfs2 by design */
+		partition at 3200000 {
+			label = "kernel2";
+			reg = <0x3200000 0x2800000>; /* 40MiB */
+		};
+
+		partition at 3800000 {
+			label = "rootfs2";
+			reg = <0x3800000 0x2200000>; /* 34MiB */
+		};
+
+		/*
+		 * 38MiB, last MiB is for the BBT, not writable
+		 */
+		partition at 5a00000 {
+			label = "syscfg";
+			reg = <0x5a00000 0x2600000>;
+		};
+
+		/*
+		 * Unused area between "s_env" and "devinfo".
+		 * Moved here because otherwise the renumbered
+		 * partitions would break the bootloader
+		 * supplied bootargs
+		 */
+		partition at 180000 {
+			label = "unused_area";
+			reg = <0x280000 0x680000>;   /* 6.5MiB */
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/armada-385-linksys-rango.dts
index 5b745a0ccce5..3c4af57ec2b9 100644
--- a/arch/arm/boot/dts/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-rango.dts
@@ -81,74 +81,79 @@
 
 &nand {
 	/* AMD/Spansion S34ML02G2 256MiB, OEM Layout */
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	partition at 0 {
-		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MiB */
-		read-only;
-	};
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0000000 0x200000>;  /* 2MiB */
+			read-only;
+		};
 
-	partition at 200000 {
-		label = "u_env";
-		reg = <0x200000 0x20000>;    /* 128KiB */
-	};
+		partition at 200000 {
+			label = "u_env";
+			reg = <0x200000 0x20000>;    /* 128KiB */
+		};
 
-	partition at 220000 {
-		label = "s_env";
-		reg = <0x220000 0x40000>;    /* 256KiB */
-	};
+		partition at 220000 {
+			label = "s_env";
+			reg = <0x220000 0x40000>;    /* 256KiB */
+		};
 
-	partition at 7e0000 {
-		label = "devinfo";
-		reg = <0x7e0000 0x40000>;   /* 256KiB */
-		read-only;
-	};
+		partition at 7e0000 {
+			label = "devinfo";
+			reg = <0x7e0000 0x40000>;   /* 256KiB */
+			read-only;
+		};
 
-	partition at 820000 {
-		label = "sysdiag";
-		reg = <0x820000 0x1e0000>;   /* 1920KiB */
-		read-only;
-	};
+		partition at 820000 {
+			label = "sysdiag";
+			reg = <0x820000 0x1e0000>;   /* 1920KiB */
+			read-only;
+		};
 
-	/* kernel1 overlaps with rootfs1 by design */
-	partition at a00000 {
-		label = "kernel1";
-		reg = <0xa00000 0x5000000>;  /* 80MiB */
-	};
+		/* kernel1 overlaps with rootfs1 by design */
+		partition at a00000 {
+			label = "kernel1";
+			reg = <0xa00000 0x5000000>;  /* 80MiB */
+		};
 
-	partition at 1000000 {
-		label = "rootfs1";
-		reg = <0x1000000 0x4a00000>;  /* 74MiB */
-	};
+		partition at 1000000 {
+			label = "rootfs1";
+			reg = <0x1000000 0x4a00000>;  /* 74MiB */
+		};
 
-	/* kernel2 overlaps with rootfs2 by design */
-	partition at 5a00000 {
-		label = "kernel2";
-		reg = <0x5a00000 0x5000000>; /* 80MiB */
-	};
+		/* kernel2 overlaps with rootfs2 by design */
+		partition at 5a00000 {
+			label = "kernel2";
+			reg = <0x5a00000 0x5000000>; /* 80MiB */
+		};
 
-	partition at 6000000 {
-		label = "rootfs2";
-		reg = <0x6000000 0x4a00000>; /* 74MiB */
-	};
+		partition at 6000000 {
+			label = "rootfs2";
+			reg = <0x6000000 0x4a00000>; /* 74MiB */
+		};
 
-	/*
-	 * 86MiB, last MiB is for the BBT, not writable
-	 */
-	partition at aa00000 {
-		label = "syscfg";
-		reg = <0xaa00000 0x5600000>;
-	};
+		/*
+		 * 86MiB, last MiB is for the BBT, not writable
+		 */
+		partition at aa00000 {
+			label = "syscfg";
+			reg = <0xaa00000 0x5600000>;
+		};
 
-	/*
-	 * Unused area between "s_env" and "devinfo".
-	 * Moved here because otherwise the renumbered
-	 * partitions would break the bootloader
-	 * supplied bootargs
-	 */
-	partition at 180000 {
-		label = "unused_area";
-		reg = <0x260000 0x5c0000>;   /* 5.75MiB */
+		/*
+		 * Unused area between "s_env" and "devinfo".
+		 * Moved here because otherwise the renumbered
+		 * partitions would break the bootloader
+		 * supplied bootargs
+		 */
+		partition at 180000 {
+			label = "unused_area";
+			reg = <0x260000 0x5c0000>;   /* 5.75MiB */
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
index 44f5aeb5fc33..3451cd3e5dff 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
@@ -73,67 +73,72 @@
 
 &nand {
 	/* 128MiB */
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	partition at 0 {
-		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MiB */
-		read-only;
-	};
-
-	partition at 100000 {
-		label = "u_env";
-		reg = <0x200000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 140000 {
-		label = "s_env";
-		reg = <0x240000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 900000 {
-		label = "devinfo";
-		reg = <0x900000 0x100000>;   /* 1MiB */
-		read-only;
-	};
-
-	/* kernel1 overlaps with rootfs1 by design */
-	partition at a00000 {
-		label = "kernel1";
-		reg = <0xa00000 0x2800000>;  /* 40MiB */
-	};
-
-	partition at 1000000 {
-		label = "rootfs1";
-		reg = <0x1000000 0x2200000>;  /* 34MiB */
-	};
-
-	/* kernel2 overlaps with rootfs2 by design */
-	partition at 3200000 {
-		label = "kernel2";
-		reg = <0x3200000 0x2800000>; /* 40MiB */
-	};
-
-	partition at 3800000 {
-		label = "rootfs2";
-		reg = <0x3800000 0x2200000>; /* 34MiB */
-	};
-
-	/*
-	 * 38MiB, last MiB is for the BBT, not writable
-	 */
-	partition at 5a00000 {
-		label = "syscfg";
-		reg = <0x5a00000 0x2600000>;
-	};
-
-	/*
-	 * Unused area between "s_env" and "devinfo".
-	 * Moved here because otherwise the renumbered
-	 * partitions would break the bootloader
-	 * supplied bootargs
-	 */
-	partition at 180000 {
-		label = "unused_area";
-		reg = <0x280000 0x680000>;   /* 6.5MiB */
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0000000 0x200000>;  /* 2MiB */
+			read-only;
+		};
+
+		partition at 100000 {
+			label = "u_env";
+			reg = <0x200000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 140000 {
+			label = "s_env";
+			reg = <0x240000 0x40000>;    /* 256KiB */
+		};
+
+		partition at 900000 {
+			label = "devinfo";
+			reg = <0x900000 0x100000>;   /* 1MiB */
+			read-only;
+		};
+
+		/* kernel1 overlaps with rootfs1 by design */
+		partition at a00000 {
+			label = "kernel1";
+			reg = <0xa00000 0x2800000>;  /* 40MiB */
+		};
+
+		partition at 1000000 {
+			label = "rootfs1";
+			reg = <0x1000000 0x2200000>;  /* 34MiB */
+		};
+
+		/* kernel2 overlaps with rootfs2 by design */
+		partition at 3200000 {
+			label = "kernel2";
+			reg = <0x3200000 0x2800000>; /* 40MiB */
+		};
+
+		partition at 3800000 {
+			label = "rootfs2";
+			reg = <0x3800000 0x2200000>; /* 34MiB */
+		};
+
+		/*
+		 * 38MiB, last MiB is for the BBT, not writable
+		 */
+		partition at 5a00000 {
+			label = "syscfg";
+			reg = <0x5a00000 0x2600000>;
+		};
+
+		/*
+		 * Unused area between "s_env" and "devinfo".
+		 * Moved here because otherwise the renumbered
+		 * partitions would break the bootloader
+		 * supplied bootargs
+		 */
+		partition at 180000 {
+			label = "unused_area";
+			reg = <0x280000 0x680000>;   /* 6.5MiB */
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 4a0d7360110b..827e82be2201 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -138,13 +138,19 @@
 	};
 };
 
-&nand {
+&nand_controller {
 	/* 128MiB or 256MiB */
 	status = "okay";
-	num-cs = <1>;
-	marvell,nand-keep-config;
-	marvell,nand-enable-arbiter;
-	nand-on-flash-bbt;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	nand: nand at 0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+	};
 };
 
 &mdio {
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index 05250d426dc4..a2bec07bf4c5 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -91,29 +91,6 @@
 				status = "okay";
 			};
 
-			flash at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-				nand-ecc-strength = <4>;
-				nand-ecc-step-size = <512>;
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
-
 			sdhci at d8000 {
 				broken-cd;
 				wp-inverted;
@@ -165,3 +142,35 @@
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
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
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
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 4cc09e43eea2..651d9edb91e6 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -551,11 +551,11 @@
 				status = "okay";
 			};
 
-			nand: flash at d0000 {
-				compatible = "marvell,armada370-nand";
+			nand_controller: nand-controller at d0000 {
+				compatible = "marvell,armada370-nand-controller";
 				reg = <0xd0000 0x54>;
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&coredivclk 0>;
 				status = "disabled";
-- 
2.14.1
