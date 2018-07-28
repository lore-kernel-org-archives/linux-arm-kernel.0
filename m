From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 28 Jul 2018 14:13:57 +0200
Subject: [PATCH] ARM: dts: BCM5301X: Specify flash partitions
Message-ID: <20180728121357.13172-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Most devices use Broadcom standard partitions which allows them to be
described with the "brcm,bcm947xx-cfe-partitions". Exceptions are:
1) TP-LINK devices which use "os-image" partition with TRX containing
   kernel only + separated rootfs partition.
2) Asus RT-AC87U with custom "asus" partition.

This commit also removes undocumented and unsupported linux,part-probe
binding which got accidentally upstreamed while describing SPI
controller.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts | 28 +++++++++++++++++++
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 31 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 28 +++++++++++++++++++
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |  4 +++
 arch/arm/boot/dts/bcm5301x.dtsi                    |  5 +++-
 5 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index 5f663f848db1..189cc3dcd6ef 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -94,6 +94,34 @@
 
 &spi_nor {
 	status = "okay";
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		boot at 0 {
+			label = "boot";
+			reg = <0x000000 0x040000>;
+			read-only;
+		};
+
+		os-image at 100000 {
+			label = "os-image";
+			reg = <0x040000 0x200000>;
+			compatible = "brcm,trx";
+		};
+
+		rootfs at 240000 {
+			label = "rootfs";
+			reg = <0x240000 0xc00000>;
+		};
+
+		nvram at ff0000 {
+			label = "nvram";
+			reg = <0xff0000 0x010000>;
+		};
+	};
 };
 
 &usb2 {
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index 2033411240c7..4cb10f88a95e 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -66,3 +66,34 @@
 &usb3_phy {
 	status = "okay";
 };
+
+&nandcs {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		boot at 0 {
+			label = "boot";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+
+		nvram at 80000 {
+			label = "nvram";
+			reg = <0x00080000 0x00180000>;
+		};
+
+		firmware at 200000 {
+			label = "firmware";
+			reg = <0x00200000 0x07cc0000>;
+			compatible = "brcm,trx";
+		};
+
+		asus at 7ec0000 {
+			label = "asus";
+			reg = <0x07ec0000 0x00140000>;
+			read-only;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index c7143a9daa1a..b527d2ff987e 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -103,6 +103,34 @@
 
 &spi_nor {
 	status = "okay";
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		boot at 0 {
+			label = "boot";
+			reg = <0x000000 0x040000>;
+			read-only;
+		};
+
+		os-image at 100000 {
+			label = "os-image";
+			reg = <0x040000 0x200000>;
+			compatible = "brcm,trx";
+		};
+
+		rootfs at 240000 {
+			label = "rootfs";
+			reg = <0x240000 0xc00000>;
+		};
+
+		nvram at ff0000 {
+			label = "nvram";
+			reg = <0xff0000 0x010000>;
+		};
+	};
 };
 
 &usb3_phy {
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
index e5a2d62daf92..925a7c9ce5b7 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
@@ -12,6 +12,10 @@
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			partitions {
+				compatible = "brcm,bcm947xx-cfe-partitions";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 096fb7681fa2..c6f3ef5e523b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -475,8 +475,11 @@
 			compatible = "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <20000000>;
-			linux,part-probe = "ofpart", "bcm47xxpart";
 			status = "disabled";
+
+			partitions {
+				compatible = "brcm,bcm947xx-cfe-partitions";
+			};
 		};
 	};
 
-- 
2.13.7
