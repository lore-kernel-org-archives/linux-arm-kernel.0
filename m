From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Oct 2016 23:28:29 -0200
Subject: [PATCH v2] ARM: imx: gpc: Initialize all power domains
Message-ID: <1477013309-2808-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit 0159ec670763dd ("PM / Domains: Verify the PM domain is present
when adding a provider") the following regression is observed on imx6:

imx-gpc: probe of 20dc000.gpc failed with error -22

The imx-gpc driver probe failure causes several issues such as:

- When booting a kernel built with multi_v7_defconfig a kernel crash is
seen.

- When booting a kernel built with imx_v6_v7_defconfig the Etnaviv GPU
driver is not loaded due to the lack of power domains.

The gpc probe fails because of_genpd_add_provider_onecell() now checks
if all the domains are initialized via pm_genpd_present() function
and it fails because not all the power domains are initialized.

In order to fix this error, initialize all the power domains from
imx_gpc_domains[], not only the imx6q_pu_domain.base one.

Reported-by: Olof's autobooter <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/gpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 0df062d..d0463e9 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -430,7 +430,8 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
 		return 0;
 
-	pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
+	for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++)
+		pm_genpd_init(imx_gpc_domains[i], NULL, false);
 	return of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
 
-- 
2.7.4
