From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 15 Feb 2012 18:37:37 +0100
Subject: [PATCH 4/4] arm/dts: omap4-sdp: Add ks8851 ethernet SPI device
In-Reply-To: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
Message-ID: <1329327457-2121-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an ethernet SPI chip in the OMAP4 SDP/Blaze board DTS file.

Add a fixed regulator node controlled by a GPIO line to supply
the ethernet chip.

Based on original code from Rajendra.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 01db8b7..31938c1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -17,6 +17,16 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	vdd_eth: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_ETH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 16 0>;  /* gpio line 48 */
+		enable-active-high;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
@@ -70,3 +80,14 @@
 		reg = <0x1e>;
 	};
 };
+
+&mcspi1 {
+	eth at 0 {
+		compatible = "ks8851";
+		spi-max-frequency = <24000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <2>; /* gpio line 34 */
+		vdd-supply = <&vdd_eth>;
+	};
+};
-- 
1.7.0.4
