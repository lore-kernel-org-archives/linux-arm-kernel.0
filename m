From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 17 Feb 2014 11:04:57 +0100
Subject: [PATCH v3 1/7] Documentation: Add device tree bindings for Freescale
 i.MX GPC
In-Reply-To: <1392631503-17283-1-git-send-email-p.zabel@pengutronix.de>
References: <1392631503-17283-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392631503-17283-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 contains a power controller that controls power gating and
sequencing for the SoC's power domains.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/power/fsl,imx-gpc.txt      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
new file mode 100644
index 0000000..3ec8c0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -0,0 +1,61 @@
+Freescale i.MX General Power Controller
+=======================================
+
+The i.MX6Q General Power Control (GPC) block contains DVFS load tracking
+counters and Power Gating Control (PGC) for the CPU and PU (GPU/VPU) power
+domains.
+
+Required properties:
+- compatible: Should be "fsl,imx6q-gpc"
+- reg: should be register base and length as documented in the
+  datasheet
+- interrupts: Should contain GPC interrupt request 1
+- pu-supply: Link to the LDO regulator powering the PU power domain
+- #address-cells, #size-cells: Should be <1>
+
+The gpc node should contain 'power-domain' subnodes for each power domain.
+These serve as phandle targets for devices belonging to the power domain:
+
+Power domains controlled by a PGC register set
+==============================================
+
+Required properties:
+- compatible: Should be "fsl,imx6q-power-domain"
+- reg: should be register base and length as documented in the
+  datasheet
+
+Specifying power domain for IP modules
+======================================
+
+IP cores belonging to a power domain should contain a 'power-domain' property
+that is a phandle pointing to the power-domain subnode of the gpc device node.
+
+Required properties:
+- power-domain: A phandle pointing to the power-domain device tree node
+
+
+Example:
+
+	gpc: gpc at 020dc000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,imx6q-gpc";
+		reg = <0x020dc000 0x4000>;
+		interrupts = <0 89 0x04 0 90 0x04>;
+		pu-supply = <&reg_pu>;
+
+		pd_pu: power-domain at 020dc260 {
+			compatible = "fsl,imx6q-power-domain";
+			reg = <0x020dc260 0x10>;
+		};
+	};
+
+Example of a device that is part of a power domain:
+
+	vpu: vpu at 02040000 {
+		reg = <0x02040000 0x3c000>;
+		/* ... */
+		power-domain = <&pd_pu>;
+		/* ... */
+	};
+
-- 
1.8.5.3
