From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 10 Jul 2017 16:42:19 +0200
Subject: [PATCH v1 1/2] remoteproc: dt: Provide bindings for iMX6SX/7D Remote
 Processor Controller driver
In-Reply-To: <20170710144220.31594-1-o.rempel@pengutronix.de>
References: <20170710144220.31594-1-o.rempel@pengutronix.de>
Message-ID: <20170710144220.31594-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/remoteproc/imx-rproc.txt   | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
new file mode 100644
index 000000000000..e7c61993e1b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
@@ -0,0 +1,44 @@
+NXP iMX6SX/iMX7D Co-Processor Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+NXP iMX SoCs.
+
+Required properties:
+- compatible		Should be one of:
+				"fsl,imx7d-rproc"
+				"fsl,imx6sx-rproc"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- syscfg		Phandle to syscon block which provide access to
+			System Reset Controller
+
+Optional properties:
+- reg:			Should contain the address ranges for some of internal
+			memory regions.
+- reg-names:		Contains the corresponding names for the memory
+			regions. These should be named "ddr", "ocram", "ocram-s",
+			"ocram-epdc" or "ocram-pxp".
+Fallowing memory ranges are expected:
+- For "fsl,imx7d-rproc"
+	<0x00900000 0x00020000> - "ocram"
+	<0x00920000 0x00020000> - "ocram-epdc"
+	<0x00940000 0x00008000> - "ocram-pxp"
+	<0x80000000 0x0FFF0000> - "ddr" (code area)
+	<0x80000000 0x60000000> - "ddr" (data area)
+- For "fsl,imx6sx-rproc"
+	<0x008F8000 0x00004000> - "ocram-s"
+	<0x80000000 0x0FFF8000> - "ddr" (code area)
+	<0x80000000 0x60000000> - "ddr" (data area)
+
+Note: the "ddr" code and data ranges are overlapping. Code area is smaller
+than data area.  So this range should be carefully chosen according to your
+system and application requirements.
+
+Example:
+	imx_rproc: imx7d-rp0 at 0 {
+		compatible	= "fsl,imx7d-rproc";
+		reg		= <0x80000000 0x80000>, <0x00900000 0x2000>;
+		reg-names	= "ddr", "ocram";
+		syscon		= <&src>;
+		clocks		= <&clks IMX7D_ARM_M4_ROOT_CLK>;
+	};
-- 
2.11.0
