From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  1 Dec 2016 10:05:58 +0100
Subject: [PATCH v3 2/4] ARM64: dts: meson-gx: Add Graphic Controller nodes
In-Reply-To: <1480583160-31806-1-git-send-email-narmstrong@baylibre.com>
References: <1480583160-31806-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1480583160-31806-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Video Processing Unit and CVBS Output nodes, and enable CVBS on selected
boards.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi              | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi       | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi            |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts  | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi             |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts    | 16 ++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi             |  4 ++++
 8 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index fc033c0..eada0b5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -356,5 +356,21 @@
 				status = "disabled";
 			};
 		};
+
+		vpu: vpu at d0100000 {
+			compatible = "amlogic,meson-gx-vpu";
+			reg = <0x0 0xd0100000 0x0 0x100000>,
+			      <0x0 0xc883c000 0x0 0x1000>,
+			      <0x0 0xc8838000 0x0 0x1000>;
+			reg-names = "vpu", "hhi", "dmc";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* CVBS VDAC output port */
+			cvbs_vdac_port: port at 0 {
+				reg = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 9696820..4cbd626 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -142,6 +142,16 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
 };
 
 &uart_AO {
@@ -229,3 +239,9 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 203be28..4a96e0f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -125,6 +125,16 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
 };
 
 /* This UART is brought out to the DB9 connector */
@@ -234,3 +244,9 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index ac5ad3b..5353a20 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -506,3 +506,7 @@
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
+
+&vpu {
+	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
index e99101a..cea4a3e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts
@@ -117,6 +117,16 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
 };
 
 &uart_AO {
@@ -203,3 +213,9 @@
 	clocks = <&clkc CLKID_FCLK_DIV4>;
 	clock-names = "clkin0";
 };
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 9f89b99..5c7a8fa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -299,3 +299,7 @@
 		 <&clkc CLKID_FCLK_DIV2>;
 	clock-names = "core", "clkin0", "clkin1";
 };
+
+&vpu {
+	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index d320727..f2d0861 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -90,6 +90,16 @@
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
 	};
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
 };
 
 /* This UART is brought out to the DB9 connector */
@@ -167,3 +177,9 @@
 		max-speed = <1000>;
 	};
 };
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index c1974bb..eb2f0c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -112,3 +112,7 @@
 		};
 	};
 };
+
+&vpu {
+	compatible = "amlogic,meson-gxm-vpu", "amlogic,meson-gx-vpu";
+};
-- 
1.9.1
