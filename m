From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 00:24:57 -0200
Subject: [PATCH 1/2] soc: imx: gpc: Add i.MX6SX PCI power domain
Message-ID: <1513304698-15169-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

i.MX6SX has a PCI power domain in PGC. Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt |  3 +++
 drivers/soc/imx/gpc.c                                   | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
index e371b26..441f71e 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -9,6 +9,7 @@ Required properties:
   - fsl,imx6q-gpc
   - fsl,imx6qp-gpc
   - fsl,imx6sl-gpc
+  - fsl,imx6sx-gpc
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain one interrupt specifier for the GPC interrupt
@@ -29,6 +30,8 @@ Required properties:
   PU_DOMAIN      1
   The following additional DOMAIN_INDEX value is valid for i.MX6SL:
   DISPLAY_DOMAIN 2
+  The following additional DOMAIN_INDEX value is valid for i.MX6SX:
+  PCI_DOMAIN     3
 
 - #power-domain-cells: Should be 0
 
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 47e7aa9..53f7275 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -273,7 +273,15 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
-	}
+	}, {
+		.base = {
+			.name = "PCI",
+			.power_off = imx6_pm_domain_power_off,
+			.power_on = imx6_pm_domain_power_on,
+		},
+		.reg_offs = 0x200,
+		.cntr_pdn_bit = 6,
+	},
 };
 
 struct imx_gpc_dt_data {
@@ -296,10 +304,16 @@ static const struct imx_gpc_dt_data imx6sl_dt_data = {
 	.err009619_present = false,
 };
 
+static const struct imx_gpc_dt_data imx6sx_dt_data = {
+	.num_domains = 4,
+	.err009619_present = false,
+};
+
 static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
 	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
 	{ .compatible = "fsl,imx6sl-gpc", .data = &imx6sl_dt_data },
+	{ .compatible = "fsl,imx6sx-gpc", .data = &imx6sx_dt_data },
 	{ }
 };
 
-- 
2.7.4
