From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Apr 2015 15:14:04 +0200
Subject: [PATCH 3/5] ARM: ux500: add CoreSight blocks to DTS file
Message-ID: <1429535644-9308-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers all the CoreSight blocks on the DB8500 SoC:
each core has a PTM (v1.0, r1p0-00rel0) connected, both connected
to a funnel (DK-TM908-r0p1-00rel0) which in turn connects to a
replicator (DM-TM909-r0p1-00rel0). The replicator has two outputs,
port 0 to a TPIU interface and port 1 to an ETB
(DK-TM907-r0p3-00rel0). The CoreSight blocks are all clocked by
the APEATCLK from the PRCMU and their AHB interconnect is clocked
from a separate clock called APETRACECLK.

The SoC also has a CTI/CTM block which can be added later as we
have upstream support in the CoreSight subsystem.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 128 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index bd6bd0926931..0d801ec00227 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -48,6 +48,134 @@
 			};
 		};
 
+		ptm at 801ae000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x801ae000 0x1000>;
+
+			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "apb_pclk", "atclk";
+			cpu = <&CPU0>;
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
+			};
+		};
+
+		ptm at 801af000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x801af000 0x1000>;
+
+			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "apb_pclk", "atclk";
+			cpu = <&CPU1>;
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
+			};
+		};
+
+		funnel at 801a6000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x801a6000 0x1000>;
+
+			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "apb_pclk", "atclk";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* funnel output ports */
+				port at 0 {
+					reg = <0>;
+					funnel_out_port: endpoint {
+						remote-endpoint =
+							<&replicator_in_port0>;
+					};
+				};
+
+				/* funnel input ports */
+				port at 1 {
+					reg = <0>;
+					funnel_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&ptm0_out_port>;
+					};
+				};
+
+				port at 2 {
+					reg = <1>;
+					funnel_in_port1: endpoint {
+						slave-mode;
+						remote-endpoint = <&ptm1_out_port>;
+					};
+				};
+			};
+		};
+
+		replicator {
+			compatible = "arm,coresight-replicator";
+			clocks = <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "atclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* replicator output ports */
+				port at 0 {
+					reg = <0>;
+					replicator_out_port0: endpoint {
+						remote-endpoint = <&tpiu_in_port>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					replicator_out_port1: endpoint {
+						remote-endpoint = <&etb_in_port>;
+					};
+				};
+
+				/* replicator input port */
+				port at 2 {
+					reg = <0>;
+					replicator_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&funnel_out_port>;
+					};
+				};
+			};
+		};
+
+		tpiu at 80190000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x80190000 0x1000>;
+
+			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "apb_pclk", "atclk";
+			port {
+				tpiu_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator_out_port0>;
+				};
+			};
+		};
+
+		etb at 801a4000 {
+			compatible = "arm,coresight-etb10", "arm,primecell";
+			reg = <0x801a4000 0x1000>;
+
+			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
+			clock-names = "apb_pclk", "atclk";
+			port {
+				etb_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator_out_port1>;
+				};
+			};
+		};
+
 		intc: interrupt-controller at a0411000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-- 
1.9.3
