From: Sven.Schmitt@mixed-mode.de (Sven Schmitt)
Date: Tue, 24 Jul 2018 09:46:07 +0000
Subject: [PATCH v3 3/3] soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes
Message-ID: <1532425563388.30268@mixed-mode.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPC_PGC_DOMAIN_* indexes consistent.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 35cc1d2dc4d5..6618ff1eaebd 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -247,6 +247,7 @@ builtin_platform_driver(imx_pgc_power_domain_driver)
 #define GPC_PGC_DOMAIN_ARM	0
 #define GPC_PGC_DOMAIN_PU	1
 #define GPC_PGC_DOMAIN_DISPLAY	2
+#define GPC_PGC_DOMAIN_PCI	3
 
 static struct genpd_power_state imx6_pm_domain_pu_state = {
 	.power_off_latency_ns = 25000,
@@ -254,12 +255,13 @@ static struct genpd_power_state imx6_pm_domain_pu_state = {
 };
 
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
@@ -269,7 +271,8 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
-	}, {
+	},
+	[GPC_PGC_DOMAIN_DISPLAY] {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
@@ -277,7 +280,8 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
-	}, {
+	},
+	[GPC_PGC_DOMAIN_PCI] {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
@@ -343,8 +347,8 @@ static const struct regmap_config imx_gpc_regmap_config = {
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
