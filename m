From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:50 +0200
Subject: [PATCH 01/13] ARM: dts: armada-385-linksys: flatten dtsi
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-2-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the addition of the spi reference two styles are used. Use
references instead of recreating the same structure over and over again.

This helps to distinguish which are changes to the underlying nodes and
which are new additions and helps helps maintainability in general.

Verified the resulting dtb to be binary identical.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Notes:

  Care has been taken to change nothing but flatten and sorting
  references by name.

  Sorting by internal reg no longer makes sense, would be a pain to
  maintain order at least.

  Comments have at least one level of indentation, they aren't really
  meta comments anyway.

  The armada-xp-linksys-mamba.dts already makes much better use of this
  style.
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 414 +++++++++++++++---------------
 1 file changed, 206 insertions(+), 208 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 2306c45..481e4a3 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -61,214 +61,6 @@
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
-
-		internal-regs {
-			i2c at 11000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins>;
-				status = "okay";
-
-				tmp421 at 4c {
-					compatible = "ti,tmp421";
-					reg = <0x4c>;
-				};
-
-				pca9635 at 68 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "nxp,pca9635";
-					reg = <0x68>;
-				};
-			};
-
-			/* J10: VCC, NC, RX, NC, TX, GND  */
-			serial at 12000 {
-				status = "okay";
-			};
-
-			ethernet at 70000 {
-				status = "okay";
-				phy-mode = "rgmii-id";
-				buffer-manager = <&bm>;
-				bm,pool-long = <2>;
-				bm,pool-short = <3>;
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			ethernet at 34000 {
-				status = "okay";
-				phy-mode = "sgmii";
-				buffer-manager = <&bm>;
-				bm,pool-long = <0>;
-				bm,pool-short = <1>;
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-
-			mdio at 72004 {
-				status = "okay";
-
-				switch at 0 {
-					compatible = "marvell,mv88e6085";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					ports {
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						port at 0 {
-							reg = <0>;
-							label = "lan4";
-						};
-
-						port at 1 {
-							reg = <1>;
-							label = "lan3";
-						};
-
-						port at 2 {
-							reg = <2>;
-							label = "lan2";
-						};
-
-						port at 3 {
-							reg = <3>;
-							label = "lan1";
-						};
-
-						port at 4 {
-							reg = <4>;
-							label = "wan";
-						};
-
-						port at 5 {
-							reg = <5>;
-							label = "cpu";
-							ethernet = <&eth2>;
-
-							fixed-link {
-								speed = <1000>;
-								full-duplex;
-							};
-						};
-					};
-				};
-			};
-
-			sata at a8000 {
-				status = "okay";
-			};
-
-			bm at c8000 {
-				status = "okay";
-			};
-
-			/* USB part of the eSATA/USB 2.0 port */
-			usb at 58000 {
-				status = "okay";
-			};
-
-			usb3 at f8000 {
-				status = "okay";
-				usb-phy = <&usb3_phy>;
-			};
-
-			flash at d0000 {
-				status = "okay";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				marvell,nand-enable-arbiter;
-				nand-on-flash-bbt;
-
-				partition at 0 {
-					label = "u-boot";
-					reg = <0x0000000 0x200000>;  /* 2MB */
-					read-only;
-				};
-
-				partition at 100000 {
-					label = "u_env";
-					reg = <0x200000 0x40000>;    /* 256KB */
-				};
-
-				partition at 140000 {
-					label = "s_env";
-					reg = <0x240000 0x40000>;    /* 256KB */
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
-				partition at 1000000 {
-					label = "rootfs1";
-					reg = <0x1000000 0x2200000>;  /* 34MB */
-				};
-
-				/* kernel2 overlaps with rootfs2 by design */
-				partition at 3200000 {
-					label = "kernel2";
-					reg = <0x3200000 0x2800000>; /* 40MB */
-				};
-
-				partition at 3800000 {
-					label = "rootfs2";
-					reg = <0x3800000 0x2200000>; /* 34MB */
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
-					reg = <0x280000 0x680000>;   /* 6.5MB */
-				};
-			};
-		};
-
-		bm-bppi {
-			status = "okay";
-		};
-
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				/* Marvell 88W8864, 5GHz-only */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Marvell 88W8864, 2GHz-only */
-				status = "okay";
-			};
-		};
 	};
 
 	usb3_phy: usb3_phy {
@@ -372,6 +164,197 @@
 	};
 };
 
+&ahci0 {
+	status = "okay";
+};
+
+&bm {
+	status = "okay";
+};
+
+&bm_bppi {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	buffer-manager = <&bm>;
+	bm,pool-long = <2>;
+	bm,pool-short = <3>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&eth2 {
+	status = "okay";
+	phy-mode = "sgmii";
+	buffer-manager = <&bm>;
+	bm,pool-long = <0>;
+	bm,pool-short = <1>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	tmp421 at 4c {
+		compatible = "ti,tmp421";
+		reg = <0x4c>;
+	};
+
+	pca9635 at 68 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,pca9635";
+		reg = <0x68>;
+	};
+};
+
+&nand {
+	status = "okay";
+	num-cs = <1>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MB */
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "u_env";
+		reg = <0x200000 0x40000>;    /* 256KB */
+	};
+
+	partition at 140000 {
+		label = "s_env";
+		reg = <0x240000 0x40000>;    /* 256KB */
+	};
+
+	partition at 900000 {
+		label = "devinfo";
+		reg = <0x900000 0x100000>;   /* 1MB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x2800000>;  /* 40MB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x2200000>;  /* 34MB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 3200000 {
+		label = "kernel2";
+		reg = <0x3200000 0x2800000>; /* 40MB */
+	};
+
+	partition at 3800000 {
+		label = "rootfs2";
+		reg = <0x3800000 0x2200000>; /* 34MB */
+	};
+
+	/*
+	 * 38MB, last MB is for the BBT, not writable
+	 */
+	partition at 5a00000 {
+		label = "syscfg";
+		reg = <0x5a00000 0x2600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x280000 0x680000>;   /* 6.5MB */
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	switch at 0 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan4";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "lan3";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan2";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan1";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "wan";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&eth2>;
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie1 {
+	/* Marvell 88W8864, 5GHz-only */
+	status = "okay";
+};
+
+&pcie2 {
+	/* Marvell 88W8864, 2GHz-only */
+	status = "okay";
+};
+
 &pinctrl {
 	keys_pin: keys-pin {
 		marvell,pins = "mpp24", "mpp29";
@@ -397,3 +380,18 @@
 &spi0 {
 	status = "disabled";
 };
+
+&uart0 {
+	/* J10: VCC, NC, RX, NC, TX, GND  */
+	status = "okay";
+};
+
+&usb0 {
+	/* USB part of the eSATA/USB 2.0 port */
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
-- 
2.10.2
