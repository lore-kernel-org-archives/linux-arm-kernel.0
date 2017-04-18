From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 18 Apr 2017 08:01:32 -0700
Subject: [PATCH v2 6/7] ARM: dts: imx7d: Add node for PCIe controller
In-Reply-To: <20170418150133.31679-1-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
Message-ID: <20170418150133.31679-7-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: yurovsky at gmail.com
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f6dee41..f46814a 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -42,6 +42,7 @@
  */
 
 #include "imx7s.dtsi"
+#include <dt-bindings/reset/imx7-reset.h>
 
 / {
 	cpus {
@@ -127,6 +128,42 @@
 		fsl,num-rx-queues=<3>;
 		status = "disabled";
 	};
+
+	pcie: pcie at 0x33800000 {
+		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
+		reg = <0x33800000 0x4000>,
+		      <0x4ff00000 0x80000>;
+		reg-names = "dbi", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
+		num-lanes = <1>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
+			 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
+			 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
+		clock-names = "pcie", "pcie_bus", "pcie_phy";
+		assigned-clocks = <&clks IMX7D_PCIE_CTRL_ROOT_SRC>,
+				  <&clks IMX7D_PCIE_PHY_ROOT_SRC>;
+		assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_250M_CLK>,
+					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+
+		fsl,max-link-speed = <2>;
+		power-domains = <&pgc_pcie_phy>;
+		resets = <&src IMX7_RESET_PCIEPHY>,
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
+		reset-names = "pciephy", "apps";
+		status = "disabled";
+	};
 };
 
 &ca_funnel_ports {
-- 
2.9.3
