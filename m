From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:42 -0000
Subject: [PATCH 11/11] dt: Exynos: add Snow SPI NOR node.
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <3234c12c90eabbeeb6d33604a324231937e309ec.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Snow has onboard SPI NOR flash which contains the bootloader.

Add DT node for this flash chip. The flash is rated 133MHz but the pl330
controller can transfer only up to 128 bytes at this speed so use more
conservative settings. Even at 40MHz pl330 can transfer at most 64k with
the current driver.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1fa72cf..38e4cda 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -691,6 +691,18 @@
 	num-cs = <1>;
 	cs-gpios = <&gpa2 5 0>;
 	status = "okay";
+		flash: m25p80 at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			linux,max_tx_len = <65536>;
+			m25p,fast-read;
+			controller-data {
+				samsung,spi-feedback-delay = <0>;
+			};
+		};
 };
 
 &usbdrd_dwc3 {
-- 
2.1.4
