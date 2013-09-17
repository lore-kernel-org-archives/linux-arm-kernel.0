From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 12:44:33 -0600
Subject: [PATCH 3/3] ARM: kirkwood: Move the nand node under the mbus node
Message-ID: <20130917184433.GF21230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There should be no nodes that are not children of the mbus. Move
the nand node under the mbus, and rework the board .dts files
to use an & reference to the nand node.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/boot/dts/kirkwood-db.dtsi                 | 44 +++++------
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 76 +++++++++----------
 arch/arm/boot/dts/kirkwood-dockstar.dts            | 40 +++++-----
 arch/arm/boot/dts/kirkwood-goflexnet.dts           | 51 ++++++-------
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 40 +++++-----
 arch/arm/boot/dts/kirkwood-ib62x0.dts              | 44 +++++------
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 58 +++++++--------
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 51 ++++++-------
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         | 14 ++--
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 62 ++++++++--------
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 60 +++++++--------
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      | 86 +++++++++++-----------
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 74 +++++++++----------
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  | 42 +++++------
 arch/arm/boot/dts/kirkwood-topkick.dts             | 62 ++++++++--------
 arch/arm/boot/dts/kirkwood.dtsi                    | 31 ++++----
 16 files changed, 418 insertions(+), 417 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
index c0e2a58..053aa20 100644
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -39,28 +39,6 @@
 			status = "ok";
 		};
 
-		nand at 3000000 {
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-			chip-delay = <25>;
-			status = "okay";
-
-			partition at 0 {
-				label = "uboot";
-				reg = <0x0 0x100000>;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x100000 0x400000>;
-			};
-
-			partition at 500000 {
-				label = "root";
-				reg = <0x500000 0x1fb00000>;
-			};
-		};
-
 		sata at 80000 {
 			nr-ports = <2>;
 			status = "okay";
@@ -80,6 +58,28 @@
 	};
 };
 
+&nand {
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+	chip-delay = <25>;
+	status = "okay";
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0 0x100000>;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x100000 0x400000>;
+	};
+
+	partition at 500000 {
+		label = "root";
+		reg = <0x500000 0x1fb00000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index d544f77..aefa375 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -148,44 +148,6 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
-
-		nand at 3000000 {
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-			status = "okay";
-			chip-delay = <35>;
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x500000>;
-			};
-
-			partition at 600000 {
-				label = "ramdisk";
-				reg = <0x0600000 0x500000>;
-			};
-
-			partition at b00000 {
-				label = "image";
-				reg = <0x0b00000 0x6600000>;
-			};
-
-			partition at 7100000 {
-				label = "mini firmware";
-				reg = <0x7100000 0xa00000>;
-			};
-
-			partition at 7b00000 {
-				label = "config";
-				reg = <0x7b00000 0x500000>;
-			};
-		};
 	};
 
 	regulators {
@@ -220,6 +182,44 @@
 	};
 };
 
+&nand {
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+	status = "okay";
+	chip-delay = <35>;
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x500000>;
+	};
+
+	partition at 600000 {
+		label = "ramdisk";
+		reg = <0x0600000 0x500000>;
+	};
+
+	partition at b00000 {
+		label = "image";
+		reg = <0x0b00000 0x6600000>;
+	};
+
+	partition at 7100000 {
+		label = "mini firmware";
+		reg = <0x7100000 0xa00000>;
+	};
+
+	partition at 7b00000 {
+		label = "config";
+		reg = <0x7b00000 0x500000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 59a2117..33ff368 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -34,26 +34,6 @@
 		serial at 12000 {
 			status = "ok";
 		};
-
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x400000>;
-			};
-
-			partition at 500000 {
-				label = "data";
-				reg = <0x0500000 0xfb00000>;
-			};
-		};
 	};
 	gpio-leds {
 		compatible = "gpio-leds";
@@ -91,6 +71,26 @@
 	};
 };
 
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x400000>;
+	};
+
+	partition at 500000 {
+		label = "data";
+		reg = <0x0500000 0xfb00000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index 6f7c7d7..a43bebb 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -67,31 +67,6 @@
 			status = "ok";
 		};
 
-		nand at 3000000 {
-			chip-delay = <40>;
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x400000>;
-			};
-
-			partition at 500000 {
-				label = "pogoplug";
-				reg = <0x0500000 0x2000000>;
-			};
-
-			partition at 2500000 {
-				label = "root";
-				reg = <0x02500000 0xd800000>;
-			};
-		};
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <2>;
@@ -171,6 +146,32 @@
 	};
 };
 
+&nand {
+	chip-delay = <40>;
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x400000>;
+	};
+
+	partition at 500000 {
+		label = "pogoplug";
+		reg = <0x0500000 0x2000000>;
+	};
+
+	partition at 2500000 {
+		label = "root";
+		reg = <0x02500000 0xd800000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 6548b9d..d30a91a 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -40,26 +40,6 @@
 			status = "ok";
 		};
 
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x00000000 0x00100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x00100000 0x00400000>;
-			};
-
-			partition at 500000 {
-				label = "data";
-				reg = <0x00500000 0x1fb00000>;
-			};
-		};
-
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <1>;
@@ -97,6 +77,26 @@
 	};
 };
 
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x00000000 0x00100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x00100000 0x00400000>;
+	};
+
+	partition at 500000 {
+		label = "data";
+		reg = <0x00500000 0x1fb00000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index cb711a3..066f40f 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -51,28 +51,6 @@
 			status = "okay";
 			nr-ports = <2>;
 		};
-
-		nand at 3000000 {
-			status = "okay";
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x600000>;
-			};
-
-			partition at 700000 {
-				label = "root";
-				reg = <0x0700000 0xf900000>;
-			};
-
-		};
 	};
 
 	gpio_keys {
@@ -123,6 +101,28 @@
 
 };
 
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x600000>;
+	};
+
+	partition at 700000 {
+		label = "root";
+		reg = <0x0700000 0xf900000>;
+	};
+
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index b8150a7..4a62b20 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -82,35 +82,6 @@
 		serial at 12000 {
 			status = "ok";
 		};
-
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "uboot";
-				reg = <0x0000000 0xc0000>;
-			};
-
-			partition at a0000 {
-				label = "env";
-				reg = <0xa0000 0x20000>;
-			};
-
-			partition at 100000 {
-				label = "zImage";
-				reg = <0x100000 0x300000>;
-			};
-
-			partition at 540000 {
-				label = "initrd";
-				reg = <0x540000 0x300000>;
-			};
-
-			partition at 980000 {
-				label = "boot";
-				reg = <0x980000 0x1f400000>;
-			};
-		};
 	};
 
 	gpio-leds {
@@ -179,6 +150,35 @@
 	};
 };
 
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0000000 0xc0000>;
+	};
+
+	partition at a0000 {
+		label = "env";
+		reg = <0xa0000 0x20000>;
+	};
+
+	partition at 100000 {
+		label = "zImage";
+		reg = <0x100000 0x300000>;
+	};
+
+	partition at 540000 {
+		label = "initrd";
+		reg = <0x540000 0x300000>;
+	};
+
+	partition at 980000 {
+		label = "boot";
+		reg = <0x980000 0x1f400000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index df84474..d15395d 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -113,31 +113,6 @@
 			status = "ok";
 		};
 
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at a0000 {
-				label = "env";
-				reg = <0xa0000 0x20000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x100000 0x300000>;
-			};
-
-			partition at 400000 {
-				label = "uInitrd";
-				reg = <0x540000 0x1000000>;
-			};
-		};
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <2>;
@@ -195,6 +170,32 @@
 	};
 };
 
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at a0000 {
+		label = "env";
+		reg = <0xa0000 0x20000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x100000 0x300000>;
+	};
+
+	partition at 400000 {
+		label = "uInitrd";
+		reg = <0x540000 0x1000000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 6899408..cd44f37 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -34,13 +34,6 @@
 		serial at 12000 {
 			status = "ok";
 		};
-
-		nand at 3000000 {
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-			status = "ok";
-			chip-delay = <25>;
-		};
 	};
 
 	i2c at 0 {
@@ -51,6 +44,13 @@
 	};
 };
 
+&nand {
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+	status = "ok";
+	chip-delay = <25>;
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 26ae240..6c1ec27 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -95,37 +95,6 @@
                         pinctrl-names = "default";
                 };
 
-                nand at 3000000 {
-                        pinctrl-0 = <&pmx_nand>;
-                        pinctrl-names = "default";
-                        status = "okay";
-
-                        partition at 0 {
-                                label = "uboot";
-                                reg = <0x0000000 0x100000>;
-                        };
-
-                        partition at 100000 {
-                                label = "env";
-                                reg = <0x100000 0x80000>;
-                        };
-
-                        partition at 180000 {
-                                label = "fdt";
-                                reg = <0x180000 0x80000>;
-                        };
-
-                        partition at 200000 {
-                                label = "kernel";
-                                reg = <0x200000 0x400000>;
-                        };
-
-                        partition at 600000 {
-                                label = "rootfs";
-                                reg = <0x600000 0x1fa00000>;
-                        };
-                };
-
 		rtc at 10300 {
 			status = "disabled";
 		};
@@ -193,6 +162,37 @@
 	};
 };
 
+&nand {
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0000000 0x100000>;
+	};
+
+	partition at 100000 {
+		label = "env";
+		reg = <0x100000 0x80000>;
+	};
+
+	partition at 180000 {
+		label = "fdt";
+		reg = <0x180000 0x80000>;
+	};
+
+	partition at 200000 {
+		label = "kernel";
+		reg = <0x200000 0x400000>;
+	};
+
+	partition at 600000 {
+		label = "rootfs";
+		reg = <0x600000 0x1fa00000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index d3a5a0f..e6a102c 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -97,36 +97,6 @@
 			status = "okay";
 		};
 
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x180000>;
-				read-only;
-			};
-
-			partition at 180000 {
-				label = "u-boot-env";
-				reg = <0x180000 0x20000>;
-			};
-
-			partition at 200000 {
-				label = "uImage";
-				reg = <0x0200000 0x600000>;
-			};
-
-			partition at 800000 {
-				label = "minirootfs";
-				reg = <0x0800000 0x1000000>;
-			};
-
-			partition at 1800000 {
-				label = "jffs2";
-				reg = <0x1800000 0x6800000>;
-			};
-		};
-
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <2>;
@@ -207,6 +177,36 @@
         };
 };
 
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x180000>;
+		read-only;
+	};
+
+	partition at 180000 {
+		label = "u-boot-env";
+		reg = <0x180000 0x20000>;
+	};
+
+	partition at 200000 {
+		label = "uImage";
+		reg = <0x0200000 0x600000>;
+	};
+
+	partition at 800000 {
+		label = "minirootfs";
+		reg = <0x0800000 0x1000000>;
+	};
+
+	partition at 1800000 {
+		label = "jffs2";
+		reg = <0x1800000 0x6800000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
index 06267a9..e3f915d 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
@@ -27,49 +27,6 @@
 			nr-ports = <2>;
 		};
 
-		nand at 3000000 {
-			status = "okay";
-			chip-delay = <35>;
-
-			partition at 0 {
-				label = "uboot";
-				reg = <0x0000000 0x0100000>;
-				read-only;
-			};
-			partition at 100000 {
-				label = "uboot_env";
-				reg = <0x0100000 0x0080000>;
-			};
-			partition at 180000 {
-				label = "key_store";
-				reg = <0x0180000 0x0080000>;
-			};
-			partition at 200000 {
-				label = "info";
-				reg = <0x0200000 0x0080000>;
-			};
-			partition at 280000 {
-				label = "etc";
-				reg = <0x0280000 0x0a00000>;
-			};
-			partition at c80000 {
-				label = "kernel_1";
-				reg = <0x0c80000 0x0a00000>;
-			};
-			partition at 1680000 {
-				label = "rootfs1";
-				reg = <0x1680000 0x2fc0000>;
-			};
-			partition at 4640000 {
-				label = "kernel_2";
-				reg = <0x4640000 0x0a00000>;
-			};
-			partition at 5040000 {
-				label = "rootfs2";
-				reg = <0x5040000 0x2fc0000>;
-			};
-		};
-
 		pcie-controller {
 			status = "okay";
 
@@ -105,3 +62,46 @@
 		};
 	};
 };
+
+&nand {
+	status = "okay";
+	chip-delay = <35>;
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0000000 0x0100000>;
+		read-only;
+	};
+	partition at 100000 {
+		label = "uboot_env";
+		reg = <0x0100000 0x0080000>;
+	};
+	partition at 180000 {
+		label = "key_store";
+		reg = <0x0180000 0x0080000>;
+	};
+	partition at 200000 {
+		label = "info";
+		reg = <0x0200000 0x0080000>;
+	};
+	partition at 280000 {
+		label = "etc";
+		reg = <0x0280000 0x0a00000>;
+	};
+	partition at c80000 {
+		label = "kernel_1";
+		reg = <0x0c80000 0x0a00000>;
+	};
+	partition at 1680000 {
+		label = "rootfs1";
+		reg = <0x1680000 0x2fc0000>;
+	};
+	partition at 4640000 {
+		label = "kernel_2";
+		reg = <0x4640000 0x0a00000>;
+	};
+	partition at 5040000 {
+		label = "rootfs2";
+		reg = <0x5040000 0x2fc0000>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 85ccf8d..f0e3d21 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -29,43 +29,6 @@
 			pinctrl-names = "default";
 		};
 
-		nand at 3000000 {
-			chip-delay = <25>;
-			status = "okay";
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-
-			partition at 0 {
-				label = "uboot";
-				reg = <0x0 0x90000>;
-			};
-
-			partition at 90000 {
-				label = "env";
-				reg = <0x90000 0x44000>;
-			};
-
-			partition at d4000 {
-				label = "test";
-				reg = <0xd4000 0x24000>;
-			};
-
-			partition at f4000 {
-				label = "conf";
-				reg = <0xf4000 0x400000>;
-			};
-
-			partition at 4f4000 {
-				label = "linux";
-				reg = <0x4f4000 0x1d20000>;
-			};
-
-			partition at 2214000 {
-				label = "user";
-				reg = <0x2214000 0x1dec000>;
-			};
-		};
-
 		sata at 80000 {
 			nr-ports = <1>;
 			status = "okay";
@@ -167,6 +130,43 @@
 	};
 };
 
+&nand {
+	chip-delay = <25>;
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition at 0 {
+		label = "uboot";
+		reg = <0x0 0x90000>;
+	};
+
+	partition at 90000 {
+		label = "env";
+		reg = <0x90000 0x44000>;
+	};
+
+	partition at d4000 {
+		label = "test";
+		reg = <0xd4000 0x24000>;
+	};
+
+	partition at f4000 {
+		label = "conf";
+		reg = <0xf4000 0x400000>;
+	};
+
+	partition at 4f4000 {
+		label = "linux";
+		reg = <0x4f4000 0x1d20000>;
+	};
+
+	partition at 2214000 {
+		label = "user";
+		reg = <0x2214000 0x1dec000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index 5696b63..1173d7f 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -48,27 +48,6 @@
 			pinctrl-names = "default";
 			status = "okay";
 		};
-
-		nand at 3000000 {
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x400000>;
-			};
-
-			partition at 500000 {
-				label = "root";
-				reg = <0x0500000 0x1fb00000>;
-			};
-		};
 	};
 
 	regulators {
@@ -92,6 +71,27 @@
 	};
 };
 
+&nand {
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x400000>;
+	};
+
+	partition at 500000 {
+		label = "root";
+		reg = <0x0500000 0x1fb00000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 30842b4..320da67 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -90,37 +90,6 @@
 			pinctrl-names = "default";
 		};
 
-		nand at 3000000 {
-			status = "okay";
-			pinctrl-0 = <&pmx_nand>;
-			pinctrl-names = "default";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x180000>;
-			};
-
-			partition at 180000 {
-				label = "u-boot env";
-				reg = <0x0180000 0x20000>;
-			};
-
-			partition at 200000 {
-				label = "uImage";
-				reg = <0x0200000 0x600000>;
-			};
-
-			partition at 800000 {
-				label = "uInitrd";
-				reg = <0x0800000 0x1000000>;
-			};
-
-			partition at 1800000 {
-				label = "rootfs";
-				reg = <0x1800000 0xe800000>;
-			};
-		};
-
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <1>;
@@ -204,6 +173,37 @@
 	};
 };
 
+&nand {
+	status = "okay";
+	pinctrl-0 = <&pmx_nand>;
+	pinctrl-names = "default";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x180000>;
+	};
+
+	partition at 180000 {
+		label = "u-boot env";
+		reg = <0x0180000 0x20000>;
+	};
+
+	partition at 200000 {
+		label = "uImage";
+		reg = <0x0200000 0x600000>;
+	};
+
+	partition at 800000 {
+		label = "uInitrd";
+		reg = <0x0800000 0x1000000>;
+	};
+
+	partition at 1800000 {
+		label = "rootfs";
+		reg = <0x1800000 0xe800000>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 76b1627..632b647 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -45,12 +45,25 @@
 			clocks = <&gate_clk 17>;
 			status = "okay";
 		};
+
+		nand: nand at 012f {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cle = <0>;
+			ale = <1>;
+			bank-width = <1>;
+			compatible = "marvell,orion-nand";
+			reg = <MBUS_ID(0x01, 0x2f) 0 0x400>;
+			chip-delay = <25>;
+			/* set partition map and/or chip-delay in board dts */
+			clocks = <&gate_clk 7>;
+			status = "disabled";
+		};
 	};
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0xf1000000 0x0100000
-		          0xf4000000 0xf4000000 0x0000400>;
+		ranges = <0x00000000 0xf1000000 0x0100000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -206,20 +219,6 @@
 			status = "okay";
 		};
 
-		nand at 3000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cle = <0>;
-			ale = <1>;
-			bank-width = <1>;
-			compatible = "marvell,orion-nand";
-			reg = <0xf4000000 0x400>;
-			chip-delay = <25>;
-			/* set partition map and/or chip-delay in board dts */
-			clocks = <&gate_clk 7>;
-			status = "disabled";
-		};
-
 		i2c at 11000 {
 			compatible = "marvell,mv64xxx-i2c";
 			reg = <0x11000 0x20>;
-- 
1.8.1.2
