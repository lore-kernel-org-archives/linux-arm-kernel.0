From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 13 Feb 2018 13:53:35 +0100
Subject: [PATCH v3 09/11] ARM: dts: STi: Update sound related nodes location
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1518526417-11919-10-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Move sound node outside soc node and sti_sasg_codec node
as child of syscfg_core node.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 0 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 1 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 2 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 0 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 1 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 2 has a unit name, but no reg property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sound missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (unit_address_vs_reg):
Node /soc/sound/simple-audio-card,dai-link at 0 has a unit name, but no reg property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/sound missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/sti-sasg-codec missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ update location of sound related node and remove the fake reg property
v2: _ add a fake reg property to node without reg property.

 arch/arm/boot/dts/stih407-family.dtsi | 14 ++---
 arch/arm/boot/dts/stih410-b2260.dts   | 38 +++++++-------
 arch/arm/boot/dts/stihxxx-b2120.dtsi  | 98 ++++++++++++++++++-----------------
 3 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5df827b00eb6..f7362c31de29 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -178,6 +178,13 @@
 		syscfg_core: core-syscfg at 92b0000 {
 			compatible = "st,stih407-core-syscfg", "syscon";
 			reg = <0x92b0000 0x1000>;
+
+			sti_sasg_codec: sti-sasg-codec {
+				compatible = "st,stih407-sas-codec";
+				#sound-dai-cells = <1>;
+				status = "disabled";
+				st,syscfg = <&syscfg_core>;
+			};
 		};
 
 		syscfg_lpm: lpm-syscfg at 94b5100 {
@@ -894,13 +901,6 @@
 			status = "disabled";
 		};
 
-		sti_sasg_codec: sti-sasg-codec {
-			compatible = "st,stih407-sas-codec";
-			#sound-dai-cells = <1>;
-			status = "disabled";
-			st,syscfg = <&syscfg_core>;
-		};
-
 		sti_uni_player0: sti-uni-player at 8d80000 {
 			compatible = "st,stih407-uni-player-hdmi";
 			#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 8bcd58118dba..5ccc6bb050df 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -57,6 +57,25 @@
 		};
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "STI-B2260";
+		status = "okay";
+
+		simple-audio-card,dai-link0 {
+			/* DAC */
+			format = "i2s";
+			mclk-fs = <128>;
+			cpu {
+				sound-dai = <&sti_uni_player0>;
+			};
+
+			codec {
+				sound-dai = <&sti_hdmi>;
+			};
+		};
+	};
+
 	soc {
 		/* Low speed expansion connector */
 		uart0: serial at 9830000 {
@@ -181,25 +200,6 @@
 			status = "okay";
 		};
 
-		sound {
-			compatible = "simple-audio-card";
-			simple-audio-card,name = "STI-B2260";
-			status = "okay";
-
-			simple-audio-card,dai-link at 0 {
-				/* DAC */
-				format = "i2s";
-				mclk-fs = <128>;
-				cpu {
-					sound-dai = <&sti_uni_player0>;
-				};
-
-				codec {
-					sound-dai = <&sti_hdmi>;
-				};
-			};
-		};
-
 		miphy28lp_phy: miphy28lp at 0 {
 
 			phy_port1: port at 9b2a000 {
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 66c1c6a5eb76..c67edb1a8121 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -23,6 +23,52 @@
 		};
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "STI-B2120";
+		status = "okay";
+
+		simple-audio-card,dai-link0 {
+			/* HDMI */
+			format = "i2s";
+			mclk-fs = <128>;
+			cpu {
+				sound-dai = <&sti_uni_player0>;
+			};
+
+			codec {
+				sound-dai = <&sti_hdmi>;
+			};
+		};
+
+		simple-audio-card,dai-link1 {
+			/* DAC */
+			format = "i2s";
+			mclk-fs = <256>;
+			frame-inversion = <1>;
+			cpu {
+				sound-dai = <&sti_uni_player2>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 1>;
+			};
+		};
+
+		simple-audio-card,dai-link2 {
+			/* SPDIF */
+			format = "left_j";
+			mclk-fs = <128>;
+			cpu {
+				sound-dai = <&sti_uni_player3>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 0>;
+			};
+		};
+	};
+
 	soc {
 		sbc_serial0: serial at 9530000 {
 			status = "okay";
@@ -147,53 +193,11 @@
 			status = "okay";
 		};
 
-		sti_sasg_codec: sti-sasg-codec {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_spdif_out>;
-		};
-
-		sound {
-			compatible = "simple-audio-card";
-			simple-audio-card,name = "STI-B2120";
-			status = "okay";
-
-			simple-audio-card,dai-link at 0 {
-				/* HDMI */
-				format = "i2s";
-				mclk-fs = <128>;
-				cpu {
-					sound-dai = <&sti_uni_player0>;
-				};
-
-				codec {
-					sound-dai = <&sti_hdmi>;
-				};
-			};
-			simple-audio-card,dai-link at 1 {
-				/* DAC */
-				format = "i2s";
-				mclk-fs = <256>;
-				frame-inversion = <1>;
-				cpu {
-					sound-dai = <&sti_uni_player2>;
-				};
-
-				codec {
-					sound-dai = <&sti_sasg_codec 1>;
-				};
-			};
-			simple-audio-card,dai-link at 2 {
-				/* SPDIF */
-				format = "left_j";
-				mclk-fs = <128>;
-				cpu {
-					sound-dai = <&sti_uni_player3>;
-				};
-
-				codec {
-					sound-dai = <&sti_sasg_codec 0>;
-				};
+		syscfg_core: core-syscfg at 92b0000 {
+			sti_sasg_codec: sti-sasg-codec {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spdif_out>;
 			};
 		};
 	};
-- 
1.9.1
