From: tony@atomide.com (Tony Lindgren)
Date: Wed,  3 Jun 2015 09:23:18 -0700
Subject: [PATCH 09/12] ARM: dts: Add minimal clocks for dm814x
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Message-ID: <1433348601-8966-10-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use fixed clocks until we have a clock driver for the PLL.
The mux and divider composite clocks work the same way
as on dm816x and am335x.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi | 109 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dm814x.dtsi        |   2 +
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm/boot/dts/dm814x-clocks.dtsi

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
new file mode 100644
index 0000000..ef1e8e7
--- /dev/null
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -0,0 +1,109 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&scm_clocks {
+
+	tclkin_ck: tclkin_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+	devosc_ck: devosc_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+	};
+
+	/* Optional auxosc, 20 - 30 MHz range, assume 27 MHz by default */
+	auxosc_ck: auxosc_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+	};
+
+	mpu_ck: mpu_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <1000000000>;
+	};
+
+	sysclk4_ck: sysclk4_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <222000000>;
+	};
+
+	sysclk6_ck: sysclk6_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+	};
+
+	sysclk10_ck: sysclk10_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <48000000>;
+	};
+
+	sysclk18_ck: sysclk18_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+
+        cpsw_125mhz_gclk: cpsw_125mhz_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+	};
+
+	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <250000000>;
+	};
+
+};
+
+&pllss_clocks {
+
+	aud_clkin0_ck: aud_clkin0_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+	};
+
+	aud_clkin1_ck: aud_clkin1_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+	};
+
+	aud_clkin2_ck: aud_clkin2_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <20000000>;
+	};
+
+	timer1_mux_ck: timer1_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+		ti,bit-shift = <3>;
+		reg = <0x2e0>;
+	};
+
+	timer2_mux_ck: timer2_mux_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sysclk18_ck &aud_clkin0_ck &aud_clkin1_ck
+			  &aud_clkin2_ck &devosc_ck &auxosc_ck &tclkin_ck>;
+		ti,bit-shift = <6>;
+		reg = <0x2e0>;
+	};
+};
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index f3077e3..972c9c9 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -329,3 +329,5 @@
 		};
 	};
 };
+
+#include "dm814x-clocks.dtsi"
-- 
2.1.4
