From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Oct 2014 23:13:31 +0100
Subject: [PATCH 2/4] ARM: Kirkwood: DIR665: Instantiate Distributed Switch
 Architecture
In-Reply-To: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
Message-ID: <1414793613-11798-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DIR665 has an 8 port Ethernet Switch, a Marvell mv88e6171. Add a
DSA node in DT, to instantiate DSA support for the 4 back panel ports,
the Internet port, and the port to the CPU which is connected to eth0.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dir665.dts | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index ac945ea49940..656e61ce414d 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -202,6 +202,51 @@
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	dsa at 0 {
+		compatible = "marvell,dsa";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		dsa,ethernet = <&eth0port>;
+		dsa,mii-bus = <&mdio>;
+
+		switch at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0>;	/* MDIO address 0, switch 0 in tree */
+
+			port at 0 {
+				reg = <0>;
+				label = "lan4";
+			};
+
+			port at 1 {
+			       reg = <1>;
+			       label = "lan3";
+			};
+
+			port at 2 {
+			       reg = <2>;
+			       label = "lan2";
+			};
+
+			port at 3 {
+			       reg = <3>;
+			       label = "lan1";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "wan";
+			};
+
+			port at 6 {
+			       reg = <6>;
+			       label = "cpu";
+			};
+		};
+	};
 };
 
 &mdio {
-- 
2.1.1
