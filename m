From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  7 Oct 2017 18:29:39 +0200
Subject: [PATCH 1/2] ARM: dts: meson: add the SDIO MMC controller
In-Reply-To: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
References: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171007162940.14595-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Meson6, Meson8 and Meson8b are using the same MMC controller IP. This
adds the MMC controller node to meson.dtsi so it can be used by all
SoCs.

The controller itself is a bit special, because it has multiple slots.
Each slot is accessed through a sub-node of the controller. However,
currently the driver for this hardware only supports one slot.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 9 +++++++++
 arch/arm/boot/dts/meson8.dtsi  | 6 ++++++
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 7ae30e780506..290a183e87c5 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -165,6 +165,15 @@
 				status = "disabled";
 			};
 
+			sdio: mmc at 8c20 {
+				compatible = "amlogic,meson-mx-sdio";
+				reg = <0x8c20 0x20>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			spifc: spi at 8c80 {
 				compatible = "amlogic,meson6-spifc";
 				reg = <0x8c80 0x80>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index ada26f8116a8..e6abcc7a1084 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -299,6 +299,12 @@
 	clock-names = "clkin", "core", "sana";
 };
 
+&sdio {
+	compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
+	clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
+	clock-names = "core", "clkin";
+};
+
 &spifc {
 	clocks = <&clkc CLKID_CLK81>;
 };
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index bc4d4a237ea5..283c68c6b1f4 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -207,6 +207,12 @@
 	clock-names = "clkin", "core", "sana";
 };
 
+&sdio {
+	compatible = "amlogic,meson8b-sdio", "amlogic,meson-mx-sdio";
+	clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
+	clock-names = "core", "clkin";
+};
+
 &uart_AO {
 	clocks = <&clkc CLKID_CLK81>;
 };
-- 
2.14.2
