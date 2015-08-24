From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 24 Aug 2015 10:20:01 +0300
Subject: [PATCH 05/11] ARM: DTS: dra7-evm: Enable pcf8575 (0x26 address) on
 i2c2 bus
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1440400807-32274-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO expander is used for controlling various muxes on the board.
By default select audio functionality over VIN6 by setting the P1
(vin6_sel_s0) pin to low.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index add77ac4f302..3694046c29eb 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -438,6 +438,20 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
+
+	pcf_hdmi: gpio at 26 {
+		compatible = "nxp,pcf8575";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		p1 {
+			/* vin6_sel_s0: high: VIN6, low: audio */
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "vin6_sel_s0";
+		};
+	};
 };
 
 &i2c3 {
-- 
2.5.0
