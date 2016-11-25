From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 25 Nov 2016 17:03:10 +0100
Subject: [RFC PATCH 2/3] ARM64: dts: meson-gx: Add Graphic Controller nodes
In-Reply-To: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
References: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1480089791-12517-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Video Processing Unit and CVBS Output nodes, and enable CVBS on selected
boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 46 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 12 ++++++
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  8 ++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  4 ++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  9 +++++
 8 files changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index fc033c0..bcc1d1f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -153,6 +153,27 @@
 		};
 	};
 
+	venc_cvbs: venc-cvbs {
+		compatible = "amlogic,meson-gx-venc-cvbs";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			enc_cvbs_in: port at 0 {
+				 #address-cells = <1>;
+				 #size-cells = <0>;
+				 reg = <0>;
+
+				 venc_cvbs_in_vpu: endpoint at 0 {
+					 reg = <0>;
+					 remote-endpoint = <&vpu_out_venc_cvbs>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -356,5 +377,30 @@
 				status = "disabled";
 			};
 		};
+
+		vpu: vpu at d0100000 {
+			compatible = "amlogic,meson-gx-vpu";
+			reg = <0x0 0xd0100000 0x0 0x100000>,
+			      <0x0 0xc883c000 0x0 0x1000>,
+			      <0x0 0xc8838000 0x0 0x1000>;
+			reg-names = "base", "hhi", "dmc";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				vpu_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					vpu_out_venc_cvbs: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&venc_cvbs_in_vpu>;
+					};
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 9696820..a55d1cf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -229,3 +229,7 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&venc_cvbs {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 5e5e2de..3c09bd1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -266,3 +266,7 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&venc_cvbs {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index ac5ad3b..99ff37c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -506,3 +506,15 @@
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
+
+&venc_cvbs {
+	status = "okay";
+};
+
+&venc_cvbs {
+	compatible = "amlogic,meson-gxbb-venc-cvbs", "amlogic,meson-gx-venc-cvbs";
+};
+
+&vpu {
+	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
index e99101a..2a9b46f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
@@ -203,3 +203,7 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&venc_cvbs {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3af54dc..98b8118 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -299,3 +299,11 @@
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
+
+&venc_cvbs {
+	compatible = "amlogic,meson-gxl-venc-cvbs", "amlogic,meson-gx-venc-cvbs";
+};
+
+&vpu {
+	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index d320727..1ae2451 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -167,3 +167,7 @@
 		max-speed = <1000>;
 	};
 };
+
+&venc_cvbs {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index c1974bb..7bf2d6e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -112,3 +112,12 @@
 		};
 	};
 };
+
+
+&venc_cvbs {
+	compatible = "amlogic,meson-gxm-venc-cvbs", "amlogic,meson-gx-venc-cvbs";
+};
+
+&vpu {
+	compatible = "amlogic,meson-gxm-vpu", "amlogic,meson-gx-vpu";
+};
-- 
1.9.1
