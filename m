From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 19 Dec 2016 15:16:09 +0100
Subject: [PATCH 4/4] arm64: dts: marvell: Add ethernet switch definition for
 the EXPRESSObin
In-Reply-To: <20161219141610.30934-1-romain.perier@free-electrons.com>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
Message-ID: <20161219141610.30934-5-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines and enables the Marvell ethernet switch MVE886341 on the
Marvell EXPRESSObin board.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 .../boot/dts/marvell/armada-3720-espressobin.dts   | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 83178d9..8ba6c0b 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -80,3 +80,70 @@
 &usb3 {
 	status = "okay";
 };
+
+&mdio {
+	switch0: switch0 at 0 {
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
+			reg = <1>;
+
+			switch0phy0: switch0phy0 at 0 {
+				reg = <0x11>;
+			};
+			switch0phy1: switch0phy1 at 1 {
+				reg = <0x12>;
+			};
+			switch0phy2: switch0phy2 at 2 {
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
