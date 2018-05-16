From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 16 May 2018 17:52:03 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-axg: remove incorrect i2c ao clock
In-Reply-To: <20180516155203.24922-1-jbrunet@baylibre.com>
References: <20180516155203.24922-1-jbrunet@baylibre.com>
Message-ID: <20180516155203.24922-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock specified for the i2c AO controller is the one from
the EE domain, which is incorrect as this controller needs the
clock from AO clock controller.

Replace with xtal to avoid claiming an unrelated gate until the
required clock controller becomes available.

Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b59f341104d7..b82b9d79ec49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1110,7 +1110,12 @@
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x05000 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
+
+				/*
+				 * FIXME: replace with the correct clock when
+				 * the controller is available
+				 */
+				clocks = <&xtal>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.14.3
