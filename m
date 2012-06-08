From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  8 Jun 2012 17:02:02 +0300
Subject: [PATCH 4/7] arm/dts: omap4-sdp: Add support for twl6040
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339164125-32534-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The twl6040 provides the audio and vibra support on OMAP4 SDP boards.
It is connected to i2c1 bus with 0x4b address.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 4b51611..f09d1f5 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -99,6 +99,31 @@
 		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
 		interrupt-parent = <&gic>;
 	};
+
+	twl6040: twl at 4b {
+		compatible = "ti,twl6040";
+		reg = <0x4b>;
+		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
+		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
+		interrupt-parent = <&gic>;
+		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
+
+		vio-supply = <&v1v8>;
+		v2v1-supply = <&v2v1>;
+		enable-active-high;
+
+		/* regulators for vibra motor */
+		vddvibl-supply = <&vbat>;
+		vddvibr-supply = <&vbat>;
+
+		vibra {
+			/* Vibra driver, motor resistance parameters */
+			ti,vibldrv-res = <8>;
+			ti,vibrdrv-res = <3>;
+			ti,viblmotor-res = <10>;
+			ti,vibrmotor-res = <10>;
+		};
+	};
 };
 
 /include/ "twl6030.dtsi"
-- 
1.7.8.6
