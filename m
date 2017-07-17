From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Jul 2017 22:25:01 +0200
Subject: [PATCH 2/5] ARM: dts: imx6: RDU2: Add DSA support for the Marvell
 88E6352
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <1500323104-11583-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RDU2 has a Marvell 88E6352 switch. Both the FEC and the i210
Ethernet interfaces are connected to the switch. Make the FEC the DSA
"CPU" port, and the i210 as a regular port on the switch.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index d7328e9166e9..add53277379d 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -624,6 +624,56 @@
 	phy-reset-duration = <100>;
 	phy-supply = <&reg_3p3v>;
 	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch at 0 {
+			compatible = "marvell,mv88e6085";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			dsa,member = <0 0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					label = "gigabit_proc";
+				};
+
+				port at 1 {
+					reg = <1>;
+					label = "netaux";
+				};
+
+				port at 2 {
+					reg = <2>;
+					label = "cpu";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port at 3 {
+					reg = <3>;
+					label = "netright";
+				};
+
+				port at 4 {
+					reg = <4>;
+					label = "netleft";
+				};
+			};
+		};
+	};
 };
 
 &usbh1 {
-- 
2.13.2
