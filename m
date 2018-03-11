From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:05 +0300
Subject: [PATCH 5/8] ARM: dts: berlin2cd: add remaining Cortex-A9 nodes
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-6-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT nodes for the Cortex-A9 MPCore SCU, local watchdog and
most importantly the global timer.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index c6929f84b201..7da6da3f0222 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -109,6 +109,11 @@
 			cache-level = <2>;
 		};
 
+		snoop-control-unit at ad0000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xad0000 0x100>;
+		};
+
 		gic: interrupt-controller at ad1000 {
 			compatible = "arm,cortex-a9-gic";
 			reg = <0xad1000 0x1000>, <0xad0100 0x0100>;
@@ -116,6 +121,13 @@
 			#interrupt-cells = <3>;
 		};
 
+		global-timer at ad0200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xad0200 0x20>;
+			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&chip_clk CLKID_TWD>;
+		};
+
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
@@ -123,6 +135,13 @@
 			clocks = <&chip_clk CLKID_TWD>;
 		};
 
+		local-wdt at ad0620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0xad0620 0x20>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&chip_clk CLKID_TWD>;
+		};
+
 		usb_phy0: usb-phy at b74000 {
 			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb74000 0x128>;
-- 
2.11.0
