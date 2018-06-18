From: Sven.Schmitt@mixed-mode.de (Sven Schmitt)
Date: Mon, 18 Jun 2018 09:01:15 +0000
Subject: [PATCH] soc: imx: gpc: fix PDN delay & improve readability
Message-ID: <1529312474617.59395@mixed-mode.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- imx6_pm_domain_power_off(): reads iso and iso2sw
  from GPC_PGC_PUPSCR_OFFS which stores the power up delays
  => use GPC_PGC_PDNSCR_OFFS for the correct delays

- remove unused #defines

- struct imx_pm_domain: introduce cntr_pup_bit
  to replace usage of cntr_pdn_bit+1 in imx6_pm_domain_power_on()

- GPC_PGC_DOMAIN_*: made consistent use of index defines

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index c4d35f32af8d..b92377c75ddf 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -24,15 +24,6 @@
 #define GPC_PGC_CTRL_OFFS	0x0
 #define GPC_PGC_PUPSCR_OFFS	0x4
 #define GPC_PGC_PDNSCR_OFFS	0x8
-#define GPC_PGC_SW2ISO_SHIFT	0x8
-#define GPC_PGC_SW_SHIFT	0x0
-
-#define GPC_PGC_GPU_PDN		0x260
-#define GPC_PGC_GPU_PUPSCR	0x264
-#define GPC_PGC_GPU_PDNSCR	0x268
-
-#define GPU_VPU_PUP_REQ		BIT(1)
-#define GPU_VPU_PDN_REQ		BIT(0)
 
 #define GPC_CLK_MAX		6
 
@@ -46,6 +37,7 @@ struct imx_pm_domain {
 	int num_clks;
 	unsigned int reg_offs;
 	signed char cntr_pdn_bit;
+	signed char cntr_pup_bit;
 	unsigned int ipg_rate_mhz;
 	unsigned int flags;
 };
@@ -66,7 +58,7 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 		return -EBUSY;
 
 	/* Read ISO and ISO2SW power down delays */
-	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
+	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PDNSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
@@ -116,7 +108,7 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 	sw2iso = (val >> 8) & 0x3f;
 
 	/* Request GPC to power up domain */
-	val = BIT(pd->cntr_pdn_bit + 1);
+	val = BIT(pd->cntr_pup_bit);
 	regmap_update_bits(pd->regmap, GPC_CNTR, val, val);
 
 	/* Wait ISO + ISO2SW IPG clock cycles */
@@ -241,22 +233,24 @@ static struct platform_driver imx_pgc_power_domain_driver = {
 };
 builtin_platform_driver(imx_pgc_power_domain_driver)
 
-#define GPC_PGC_DOMAIN_ARM	0
-#define GPC_PGC_DOMAIN_PU	1
-#define GPC_PGC_DOMAIN_DISPLAY	2
-
 static struct genpd_power_state imx6_pm_domain_pu_state = {
 	.power_off_latency_ns = 25000,
 	.power_on_latency_ns = 2000000,
 };
 
+#define GPC_PGC_DOMAIN_ARM 0
+#define GPC_PGC_DOMAIN_PU 1
+#define GPC_PGC_DOMAIN_DISPLAY 2
+#define GPC_PGC_DOMAIN_PCI 3
+
 static struct imx_pm_domain imx_gpc_domains[] = {
-	{
+	[GPC_PGC_DOMAIN_ARM] {
 		.base = {
 			.name = "ARM",
 			.flags = GENPD_FLAG_ALWAYS_ON,
 		},
-	}, {
+	},
+	[GPC_PGC_DOMAIN_PU] {
 		.base = {
 			.name = "PU",
 			.power_off = imx6_pm_domain_power_off,
@@ -266,7 +260,9 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
-	}, {
+		.cntr_pup_bit = 1,
+	},
+	[GPC_PGC_DOMAIN_DISPLAY] {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
@@ -274,7 +270,9 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
-	}, {
+		.cntr_pup_bit = 5,
+	},
+	[GPC_PGC_DOMAIN_PCI] {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
@@ -282,6 +280,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x200,
 		.cntr_pdn_bit = 6,
+		.cntr_pup_bit = 7,
 	},
 };
 
@@ -326,8 +325,8 @@ static const struct regmap_config imx_gpc_regmap_config = {
 };
 
 static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
-	&imx_gpc_domains[0].base,
-	&imx_gpc_domains[1].base,
+	&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base,
+	&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base,
 };
 
 static struct genpd_onecell_data imx_gpc_onecell_data = {
-- 
2.17.1
