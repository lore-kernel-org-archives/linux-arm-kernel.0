From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Jun 2013 16:25:45 -0500
Subject: [RFC PATCH V2 4/8] ARM: dts: OMAP4: add voltage controller nodes
In-Reply-To: <1371849949-12649-1-git-send-email-nm@ti.com>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
Message-ID: <1371849949-12649-5-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP443x, OMAP446x SoC use same offsets for voltage controller,
however their voltage characteristics differ a little.

Introduce the voltage controller nodes for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi    |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap443x.dtsi |   15 +++++++++++++++
 arch/arm/boot/dts/omap4460.dtsi |   16 ++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3b44546..a153e8d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		sysclk_in: sys_clkin {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		dpll_mpu: dpll_mpu {
 			#clock-cells = <0>;
 			compatible = "ti,omap-clock";
@@ -663,5 +668,26 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		vc: vc at 0x4A307B88 {
+			compatible = "ti,omap4-vc";
+			clocks = <&sysclk_in>;
+			reg = <0x4A307B88 0x40>;
+			reg-names = "base-address";
+
+			ti,i2c-high-speed; /* belongs to board file */
+			vc_mpu: vc_mpu {
+				compatible = "ti,omap4-vc-channel-mpu";
+				ti,master-channel;
+			};
+
+			vc_iva: vc_iva {
+				compatible = "ti,omap4-vc-channel-iva";
+			};
+
+			vc_core: vc_core {
+				compatible = "ti,omap4-vc-channel-core";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index bcf455e..2b0deb5 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -31,3 +31,18 @@
 		compatible = "ti,omap4430-bandgap";
 	};
 };
+
+&vc_mpu {
+	ti,retention-micro-volts = <750000>;
+	ti,off-micro-volts = <0>;
+};
+
+&vc_iva {
+	ti,retention-micro-volts = <750000>;
+	ti,off-micro-volts = <0>;
+};
+
+&vc_core {
+	ti,retention-micro-volts = <750000>;
+	ti,off-micro-volts = <0>;
+};
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index c2f0f39..16210a1 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -39,3 +39,19 @@
 		gpios = <&gpio3 22 0>; /* tshut */
 	};
 };
+
+&vc_mpu {
+	ti,retention-micro-volts = <750000>;
+	/* Erratum i738: Reliability impact work around */
+	ti,off-micro-volts = <750000>;
+};
+
+&vc_iva {
+	ti,retention-micro-volts = <750000>;
+	ti,off-micro-volts = <0>;
+};
+
+&vc_core {
+	ti,retention-micro-volts = <750000>;
+	ti,off-micro-volts = <0>;
+};
-- 
1.7.9.5
