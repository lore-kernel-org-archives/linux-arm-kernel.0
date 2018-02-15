From: kbingham@kernel.org (Kieran Bingham)
Date: Thu, 15 Feb 2018 08:38:23 +0000
Subject: [PATCH 8/8] [PoC] arm64: dts: renesas: r8a77995-draak: Add ADV7612
In-Reply-To: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
Message-ID: <1518683903-10681-9-git-send-email-kbingham@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Provide a node for the ADV7612. There is no VIN support yet, so this
node will only instantiate the device on the I2C bus for I2C address
testing.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index df0c7773cb7d..d7dd471c9fde 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -27,6 +27,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-in {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&adv7612_in>;
+			};
+		};
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -168,6 +179,38 @@
 			};
 		};
 	};
+
+	hdmi-in at 4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>, <0x5a>, <0x5b>, <0x5c>, <0x5d>, <0x5e>, <0x5f>,
+		      <0x6a>, <0x6b>, <0x6c>, <0x6d>, <0x6e>, <0x6f>;
+		reg-names = "main", "avlink", "cec", "infoframe", "esdp",
+			    "dpp", "afe", "rep", "edid", "hdmi", "test",
+			    "cp", "vdp";
+
+		/* ADV7612_INTn connected only to test point CP56. */
+
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port at 2 {
+				reg = <2>;
+				adv7612_out: endpoint {
+					// remote-endpoint = <&vin0ep2>;
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
-- 
2.7.4
