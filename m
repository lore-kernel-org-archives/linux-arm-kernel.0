From: john@metanate.com (John Keeping)
Date: Sun, 18 Feb 2018 17:03:35 +0000
Subject: [PATCH 2/3] ARM: dts: rockchip: add recovery button for Rock2 Square
In-Reply-To: <20180218170336.31819-1-john@metanate.com>
References: <20180218170336.31819-1-john@metanate.com>
Message-ID: <20180218170336.31819-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recovery button is connected to ADC1.  This is the same setup as the
Firefly board, but for Rock2 the power supply is connected on the module
and all of the inputs are wired up to the edge connector, so use of the
ADC depends on the carrier board.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi   |  4 ++++
 arch/arm/boot/dts/rk3288-rock2-square.dts | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index b9c471fcbd42..51f36a1b698e 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -280,6 +280,10 @@
 	};
 };
 
+&saradc {
+	vref-supply = <&vcc_18>;
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 6adeb331452f..0ea2a3a1fa51 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -50,6 +50,19 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -281,6 +294,10 @@
 	};
 };
 
+&saradc {
+	status = "okay";
+};
+
 &spdif {
 	status = "okay";
 };
-- 
2.16.1
