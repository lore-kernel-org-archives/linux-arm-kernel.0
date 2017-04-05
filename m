From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  5 Apr 2017 15:19:09 +0200
Subject: [PATCH v2 3/3] soc: imx: gpc: add workaround for i.MX6QP to the GPC
 PD driver
In-Reply-To: <20170405131909.16880-1-l.stach@pengutronix.de>
References: <20170405131909.16880-1-l.stach@pengutronix.de>
Message-ID: <20170405131909.16880-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6QP, due to hardware erratum ERR009619, the PRE clocks may be
stalled during the power up sequencing of the PU power domain. As this
may lead to a complete loss of display output, the recommended
workaround is to keep the PU domain enabled during normal system
operation.

Implement this by rejecting the domain power down request on the
affected SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- use domain index define
- switch to domain flags
- switch to positive logic
---
 drivers/soc/imx/gpc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index d4ebb325b558..47e7aa963dbb 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -36,6 +36,8 @@
 
 #define GPC_CLK_MAX		6
 
+#define PGC_DOMAIN_FLAG_NO_PD		BIT(0)
+
 struct imx_pm_domain {
 	struct generic_pm_domain base;
 	struct regmap *regmap;
@@ -45,6 +47,7 @@ struct imx_pm_domain {
 	unsigned int reg_offs;
 	signed char cntr_pdn_bit;
 	unsigned int ipg_rate_mhz;
+	unsigned int flags;
 };
 
 static inline struct imx_pm_domain *
@@ -59,6 +62,9 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 	int iso, iso2sw;
 	u32 val;
 
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		return -EBUSY;
+
 	/* Read ISO and ISO2SW power down delays */
 	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
 	iso = val & 0x3f;
@@ -272,18 +278,27 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 
 struct imx_gpc_dt_data {
 	int num_domains;
+	bool err009619_present;
 };
 
 static const struct imx_gpc_dt_data imx6q_dt_data = {
 	.num_domains = 2,
+	.err009619_present = false,
+};
+
+static const struct imx_gpc_dt_data imx6qp_dt_data = {
+	.num_domains = 2,
+	.err009619_present = true,
 };
 
 static const struct imx_gpc_dt_data imx6sl_dt_data = {
 	.num_domains = 3,
+	.err009619_present = false,
 };
 
 static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
+	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
 	{ .compatible = "fsl,imx6sl-gpc", .data = &imx6sl_dt_data },
 	{ }
 };
@@ -381,6 +396,11 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Disable PU power down in normal operation if ERR009619 is present */
+	if (of_id_data->err009619_present)
+		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
+				PGC_DOMAIN_FLAG_NO_PD;
+
 	if (!pgc_node) {
 		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
 					  of_id_data->num_domains);
-- 
2.11.0
