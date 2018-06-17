From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun, 17 Jun 2018 20:49:47 +0800
Subject: [PATCH V2 2/4] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1529239789-26849-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Messaging Unit module enables two processors within
the SoC to communicate and coordinate by passing messages
(e.g. data, status and control) through the MU interface.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * typo fixes
 * remove status property
 * remove imx6&7 compatible string which may be added later for
   the generic mailbox binding

Note: Because MU used by SCU is not implemented as a mailbox driver,
Instead, they're provided in library calls to gain higher performance.
Futhermore, SCU MU has only one channel. But the binding doc claims
(Change to allow 0?)
So we did not follow the mailbox binding.

For the generic mailbox driver binding way, it may be added later.
---
 .../devicetree/bindings/arm/freescale/fsl,mu.txt   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
new file mode 100644
index 0000000..c37aa1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,mu.txt
@@ -0,0 +1,32 @@
+NXP i.MX Messaging Unit (MU)
+--------------------------------------------------------------------
+
+The Messaging Unit module enables two processors within the SoC to
+communicate and coordinate by passing messages (e.g. data, status
+and control) through the MU interface. The MU also provides the ability
+for one processor to signal the other processor using interrupts.
+
+Because the MU manages the messaging between processors, the MU uses
+different clocks (from each side of the different peripheral buses).
+Therefore, the MU must synchronize the accesses from one side to the
+other. The MU accomplishes synchronization using two sets of matching
+registers (Processor A-facing, Processor B-facing).
+
+Messaging Unit Device Node:
+=============================
+
+Required properties:
+-------------------
+- compatible :	should be "fsl,<chip>-mu", the supported chips include
+		imx8qxp, imx8qm.
+- reg :		Should contain the registers location and length
+- interrupts :	Interrupt number. The interrupt specifier format depends
+		on the interrupt controller parent.
+
+Examples:
+--------
+lsio_mu0: mu at 5d1b0000 {
+	compatible = "fsl,imx8qxp-mu";
+	reg = <0x0 0x5d1b0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4
