From: archit@ti.com (Archit Taneja)
Date: Wed, 16 Apr 2014 18:44:22 +0530
Subject: [RFC 3/4] ARM: dts: Add dss_deshdcp clock node under dra7-ctrl-core
In-Reply-To: <1397654063-8055-1-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
Message-ID: <1397654063-8055-3-git-send-email-archit@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DESHDCP clock is required only by the DES-HDCP block within HDMI in DSS.
However, if the clock isn't set before DSS clock domian is enabled, the clock
domain never comes out of idle state.

The DESHDCP clock is enabled/disabled at the DSS boundary by the bit
DSS_DESHDCP_CLKEN in CTRL_CORE_CONTROL_IO_2.

Add dss_deshdcp gate-clock node under dra7-ctrl-core. There are separate bit
fields for enabling and disabling the clock. We just map the enable bit since
this clock doesn't cause any impact if left enabled.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index e96da9a..78d309c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2007,6 +2007,16 @@
 	};
 };
 
+&ctrl_core_clocks {
+	dss_deshdcp_clk: dss_deshdcp_clk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l3_iclk_div>;
+		ti,bit-shift = <0>;
+		reg = <0x0558>;
+	};
+};
+
 &cm_core_clockdomains {
 	coreaon_clkdm: coreaon_clkdm {
 		compatible = "ti,clockdomain";
-- 
1.8.3.2
