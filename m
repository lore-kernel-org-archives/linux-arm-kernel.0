From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jan 2013 16:46:10 +0100
Subject: [PATCH V3 1/5] W1: Add device tree support to MXC onewire master.
In-Reply-To: <20130129154608.5184.46101.stgit@localhost>
References: <20130129154608.5184.46101.stgit@localhost>
Message-ID: <20130129154610.5184.91342.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 .../devicetree/bindings/w1/fsl-imx-owire.txt       |   20 ++++++++++++++++++++
 drivers/w1/masters/mxc_w1.c                        |    9 ++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.txt

diff --git a/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt b/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
new file mode 100644
index 0000000..b6d53b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
@@ -0,0 +1,20 @@
+* Freescale i.MX One wire bus master controller
+
+Required properties:
+- compatible : should be "fsl,imx21-owire"
+- reg : Address and length of the register set for the device
+
+Optional properties:
+- clocks : phandle of clock that supplies the module (required if platform
+		clock bindings use device tree)
+
+Example:
+
+- From imx53.dtsi:
+owire: owire at 63fa4000 {
+	compatible = "fsl,imx53-owire", "fsl,imx21-owire";
+	reg = <0x63fa4000 0x4000>;
+	clocks = <&clks 159>;
+	status = "disabled";
+};
+
diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 708a25f..949e566 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -186,9 +186,16 @@ static int mxc_w1_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id mxc_w1_dt_ids[] = {
+	{ .compatible = "fsl,imx21-owire" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxc_w1_dt_ids);
+
 static struct platform_driver mxc_w1_driver = {
 	.driver = {
-		   .name = "mxc_w1",
+		.name = "mxc_w1",
+		.of_match_table = mxc_w1_dt_ids,
 	},
 	.probe = mxc_w1_probe,
 	.remove = mxc_w1_remove,
