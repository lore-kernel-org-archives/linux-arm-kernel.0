From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  8 Jul 2018 22:56:56 +0800
Subject: [PATCH V4 4/5] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1531061817-1980-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Controller Firmware (SCFW) is a low-level system function
which runs on a dedicated Cortex-M core to provide power, clock, and
resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
(QM, QP), and i.MX8QX (QXP, DX).

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * fully change to mailbox binding
 * add child node description
v2->v3:
 * update a bit to mailbox binding
v1->v2:
 * remove status
 * changed to mu1
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
new file mode 100644
index 0000000..11e732a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -0,0 +1,65 @@
+NXP i.MX System Controller Firmware (SCFW)
+--------------------------------------------------------------------
+
+The System Controller Firmware (SCFW) is a low-level system function
+which runs on a dedicated Cortex-M core to provide power, clock, and
+resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+(QM, QP), and i.MX8QX (QXP, DX).
+
+The AP communicates with the SC using a multi-ported MU module found
+in the LSIO subsystem. The current definition of this MU module provides
+5 remote AP connections to the SC to support up to 5 execution environments
+(TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+using the MSI bus.
+
+System Controller Device Node:
+=============================
+
+Required properties:
+-------------------
+- compatible: should be "fsl,imx-scu"
+- mboxes: List of phandle of MU mailbox. Should be one of LSIO
+	  MU0~M4 for imx8qxp and imx8qm. Users need to make
+	  sure not use the one which is conflict with other
+	  execution environments. e.g. ATF.
+
+Examples:
+--------
+lsio_mu1: mailbox at 5d1c0000 {
+	compatible = "fsl,imx8qxp-mu";
+	reg = <0x0 0x5d1c0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+	#mbox-cells = <0>;
+};
+
+scu {
+	compatible = "fsl,imx-scu";
+	mboxes = <&lsio_mu1>;
+};
+
+
+i.MX SCU Client Device Node:
+=========================
+
+Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+Example (imx8qxp):
+-------------
+scu {
+	compatible = "fsl,imx-scu";
+	...
+
+	clk: clk {
+		...
+	};
+
+	iomuxc: iomuxc {
+		...
+	};
+
+	imx8qx-pm {
+		...
+	}
+	...
+};
-- 
2.7.4
