From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:26:40 -0500
Subject: [RFC PATCH 3/3] arm64: dts: ti: k3-am6: Add Device Management
 Security Controller support
In-Reply-To: <20180605062640.3356-1-nm@ti.com>
References: <20180605062640.3356-1-nm@ti.com>
Message-ID: <20180605062640.3356-4-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TISCI compatible System controller for AM6 SoCs.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am6.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
index 07e9cc05519c..898422e24b27 100644
--- a/arch/arm64/boot/dts/ti/k3-am6.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
@@ -97,6 +97,38 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		dmsc: dmsc {
+			compatible = "ti,k2g-sci";
+			ti,host-id = <12>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			/*
+			 * In case of rare platforms that does not use am6 as
+			 * system master, use /delete-property/
+			 */
+			ti,system-reboot-controller;
+			mbox-names = "rx", "tx";
+
+			mboxes= <&secure_proxy 11>,
+				<&secure_proxy 13>;
+
+			k3_pds: power-controller {
+				compatible = "ti,sci-pm-domain";
+				#power-domain-cells = <1>;
+			};
+
+			k3_clks: clocks {
+				compatible = "ti,k2g-sci-clk";
+				#clock-cells = <2>;
+			};
+
+			k3_reset: reset-controller {
+				compatible = "ti,sci-reset";
+				#reset-cells = <2>;
+			};
+		};
+
 		wkup_uart0: serial at 42300000 {
 			compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
 			reg = <0x0 0x42300000 0x0 0x100>;
-- 
2.15.1
