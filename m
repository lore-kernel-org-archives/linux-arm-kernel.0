From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 10:00:45 +0100
Subject: [PATCH v3 net-next 3/3] arm64: dts: marvell: Add ethernet switch
 definition for the ESPRESSObin
In-Reply-To: <20161221090045.474-1-romain.perier@free-electrons.com>
References: <20161221090045.474-1-romain.perier@free-electrons.com>
Message-ID: <20161221090045.474-4-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines and enables the Marvell ethernet switch MVE886341 on the
Marvell ESPRESSObin board.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---

Changes in v3:
 - Changed the node switch0 to be at 1
 - Removed reg=<1> from the mdio node, finally that's not required

Changes in v2:
 - EXPRESSObin -> ESPRESSObin
 - phy nodes definition must contain the internal bus address after the @

 .../boot/dts/marvell/armada-3720-espressobin.dts   | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 83178d9..12d9f65 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -80,3 +80,69 @@
 &usb3 {
 	status = "okay";
 };
+
+&mdio {
+	switch0: switch0 at 1 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+
+		dsa,member = <0 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "cpu";
+				ethernet = <&eth0>;
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "wan";
+				phy-handle = <&switch0phy0>;
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan0";
+				phy-handle = <&switch0phy1>;
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan1";
+				phy-handle = <&switch0phy2>;
+			};
+
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: switch0phy0 at 11 {
+				reg = <0x11>;
+			};
+			switch0phy1: switch0phy1 at 12 {
+				reg = <0x12>;
+			};
+			switch0phy2: switch0phy2 at 13 {
+				reg = <0x13>;
+			};
+		};
+	};
+};
+
+&eth0 {
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
-- 
2.9.3
