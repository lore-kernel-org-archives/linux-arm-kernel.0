From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:51 +0200
Subject: [PATCH 14/16] ARM: dts: lpc4350-hitex-eval: add spifi and flash device
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-15-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hitex LPC4350 eval board has a Spansion S25SL064P SPI-NOR Flash connected
to the SPIFI perherial.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 32bc7ff4eb2a..c1dd76e5fc45 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -186,6 +186,35 @@
 		};
 	};
 
+	spifi_pins: spifi-pins {
+		spifi_clk_cfg {
+			pins = "p3_3";
+			function = "spifi";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		spifi_mosi_miso_sio2_3_cfg {
+			pins = "p3_7", "p3_6", "p3_5", "p3_4";
+			function = "spifi";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		spifi_cs_cfg {
+			pins = "p3_8";
+			function = "spifi";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		uart0_rx_cfg {
 			pins = "pf_11";
@@ -278,6 +307,34 @@
 	pinctrl-0 = <&enet_mii_pins>;
 };
 
+&spifi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spifi_pins>;
+
+	flash at 0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "bootloader";
+			reg = <0x000000 0x040000>; /* 256 KiB */
+		};
+
+		partition at 1 {
+			label = "kernel";
+			reg = <0x040000 0x2c0000>; /* 2.75 MiB */
+		};
+
+		partition at 2 {
+			label = "rootfs";
+			reg = <0x300000 0x500000>; /* 5 MiB */
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.0
