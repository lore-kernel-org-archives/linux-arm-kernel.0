From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Sep 2018 18:29:11 +0200
Subject: [PATCH 1/2] ARM: dts: vf610-zii-cfu1: Add SFF interface to switch
In-Reply-To: <1535905752-17730-1-git-send-email-andrew@lunn.ch>
References: <1535905752-17730-1-git-send-email-andrew@lunn.ch>
Message-ID: <1535905752-17730-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch has an SFF attached to port 5. Add the SFF device, the
pinmux for its GPIOs, and list the port in the switch configuration.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 37777cf22e67..de3ed03ec0e7 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -66,6 +66,15 @@
 		 regulator-min-microvolt = <3300000>;
 		 regulator-max-microvolt = <3300000>;
 	};
+
+	sff: sfp {
+		compatible = "sff,sff";
+		pinctrl-0 = <&pinctrl_optical>;
+		pinctrl-names = "default";
+		i2c-bus = <&i2c0>;
+		los-gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &adc0 {
@@ -170,6 +179,14 @@
 					label = "eth_cu_1000_3";
 				};
 
+				port at 5 {
+					reg = <5>;
+					label = "eth_fc_1000_1";
+					phy-mode = "1000base-x";
+					managed = "in-band-status";
+					sfp = <&sff>;
+				};
+
 				port at 6 {
 					reg = <6>;
 					label = "cpu";
@@ -289,6 +306,16 @@
 		>;
 	};
 
+	pinctrl_optical: optical-grp {
+		fsl,pins = <
+		/* SFF SD input */
+		VF610_PAD_PTE27__GPIO_132	0x3061
+
+		/* SFF Transmit disable output */
+		VF610_PAD_PTE13__GPIO_118	0x3043
+		>;
+	};
+
 	pinctrl_switch: switch-grp {
 		fsl,pins = <
 			VF610_PAD_PTB28__GPIO_98		0x3061
-- 
2.19.0.rc1
