From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu,  7 Jul 2016 12:17:51 -0500
Subject: [RFC] [PATCH v3 4/4] ARM: dts: am335x-icev2: Add SPI based NOR
In-Reply-To: <1467911871-4508-1-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Message-ID: <1467911871-4508-5-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for W25Q64CVSSIG which is a Winbond 64 Mbit SPI NOR.

At boot you will see the following message:
m25p80 spi1.0: found s25fl064k, expected w25q64

This is because the JEDEC ID for this chip is the same as s25fl064k.
However, this should be harmless since both chips are essentially the
same.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index e271013..e4d2d13 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -208,6 +208,45 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_default>;
+
+	spi_nor: flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q64", "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition at 0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition at 1 {
+			label = "u-boot";
+			reg = <0x80000 0x100000>;
+			read-only;
+		};
+
+		partition at 2 {
+			label = "u-boot-env";
+			reg = <0x180000 0x20000>;
+			read-only;
+		};
+
+		partition at 3 {
+			label = "misc";
+			reg = <0x1A0000 0x660000>;
+		};
+	};
+
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
2.7.0
