From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  5 Mar 2013 19:50:20 -0700
Subject: [PATCH 1/2] ARM: bcm2835: add SPI device to DT
Message-ID: <1362538221-19296-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2835 has a single instance of the "SPI0"-type SPI master
controller. Instantiate it in the SoC .dtsi file, Don't enable it in
the Raspberry Pi board .dts file, since we have no idea what is actually
connected, and hence no idea what to set the bus clock rate to.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 7e0481e..1b88cea 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -64,6 +64,16 @@
 			#interrupt-cells = <2>;
 		};
 
+		spi: spi at 20204000 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7e204000 0x1000>;
+			interrupts = <2 22>;
+			clocks = <&clk_spi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 20205000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e205000 0x1000>;
@@ -107,5 +117,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <250000000>;
 		};
+
+		clk_spi: spi {
+			compatible = "fixed-clock";
+			reg = <2>;
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+		};
 	};
 };
-- 
1.7.10.4
