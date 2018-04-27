From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 02:46:15 +0800
Subject: [PATCH 3/4] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
References: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524854776-14863-4-git-send-email-aisheng.dong@nxp.com>
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
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
new file mode 100644
index 0000000..3b51d82
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -0,0 +1,40 @@
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
+- compatible: should be "fsl,imx8qxp-scu" or "fsl,imx8qm-scu"
+- fsl,mu: a phandle to the Message Unit used by SCU. Should be
+	  one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
+	  to make sure not use the one which is conflict with
+	  other execution environments. e.g. ATF.
+
+Examples:
+--------
+lsio_mu0: mu at 5d1b0000 {
+	compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+	reg = <0x0 0x5d1b0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
+
+scu {
+	compatible = "fsl,imx8qxp-scu";
+	fsl,mu = <&lsio_mu0>;
+	status = "okay";
+};
-- 
2.7.4
