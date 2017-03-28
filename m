From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 28 Mar 2017 08:19:44 -0700
Subject: [PATCH v8 1/2] dt-bindings: Add GPCv2 power gating driver
In-Reply-To: <20170328151945.32665-1-andrew.smirnov@gmail.com>
References: <20170328151945.32665-1-andrew.smirnov@gmail.com>
Message-ID: <20170328151945.32665-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for power domain driver for GPCv2 IP block found in
i.MX7 SoCs.

Cc: yurovsky at gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <dongas86@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    | 71 ++++++++++++++++++++++
 include/dt-bindings/power/imx7-power.h             | 16 +++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 include/dt-bindings/power/imx7-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
new file mode 100644
index 0000000..02f45c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -0,0 +1,71 @@
+Freescale i.MX General Power Controller v2
+==========================================
+
+The i.MX7S/D General Power Control (GPC) block contains Power Gating
+Control (PGC) for various power domains.
+
+Required properties:
+
+- compatible: Should be "fsl,imx7d-gpc"
+
+- reg: should be register base and length as documented in the
+  datasheet
+
+- interrupts: Should contain GPC interrupt request 1
+
+Power domains contained within GPC node are generic power domain
+providers, documented in
+Documentation/devicetree/bindings/power/power_domain.txt, which are
+described as subnodes of the power gating controller 'pgc' node,
+which, in turn, is expected to contain the following:
+
+Required properties:
+
+- reg: Power domain index. Valid values are defined in
+  include/dt-bindings/power/imx7-power.h
+
+- #power-domain-cells: Should be 0
+
+Optional properties:
+
+- power-supply: Power supply used to power the domain
+
+Example:
+
+	gpc: gpc at 303a0000 {
+		compatible = "fsl,imx7d-gpc";
+		reg = <0x303a0000 0x1000>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+
+		pgc {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pgc_pcie_phy: power-domain at 3 {
+				#power-domain-cells = <0>;
+
+				reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
+				power-supply = <&reg_1p0d>;
+			};
+		};
+	};
+
+
+Specifying power domain for IP modules
+======================================
+
+IP cores belonging to a power domain should contain a 'power-domains'
+property that is a phandle for PGC node representing the domain.
+
+Example of a device that is part of the PCIE_PHY power domain:
+
+	pcie: pcie at 33800000 {
+	      reg = <0x33800000 0x4000>,
+	            <0x4ff00000 0x80000>;
+		/* ... */
+		power-domains = <&pgc_pcie_phy>;
+		/* ... */
+	};
diff --git a/include/dt-bindings/power/imx7-power.h b/include/dt-bindings/power/imx7-power.h
new file mode 100644
index 0000000..3a181e4
--- /dev/null
+++ b/include/dt-bindings/power/imx7-power.h
@@ -0,0 +1,16 @@
+/*
+ *  Copyright (C) 2017 Impinj
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DT_BINDINGS_IMX7_POWER_H__
+#define __DT_BINDINGS_IMX7_POWER_H__
+
+#define IMX7_POWER_DOMAIN_MIPI_PHY		0
+#define IMX7_POWER_DOMAIN_PCIE_PHY		1
+#define IMX7_POWER_DOMAIN_USB_HSIC_PHY		2
+
+#endif
-- 
2.9.3
