From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 30 Jun 2015 14:48:24 +0200
Subject: [PATCH] ARM: imx6: gpc: always enable PU domain if CONFIG_PM is not
 set
Message-ID: <1435668504-26945-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_PM is not set the PU power domain needs to be enabled always,
otherwise there are two failure scenarios which will hang the system if
one of the devices in the PU domain is accessed.

1. New DTs (4.1+) drop the "always-on" property from the PU regulator, so
if it isn't properly enabled by the GPC code it will be disabled at the
end of boot.

2. If the bootloader already disabled the PU domain the GPC explicitly
needs to enable it again, even if the kernel doesn't do any power
management. This is a bit hypothetical, as it requires to boot a
mainline kernel on a downstream bootloader, as no mainline bootloader
disables the PM domains.

Cc: <stable@vger.kernel.org> # 4.1
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 6d0893a3828e..78b6fd0b86e6 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -291,8 +291,6 @@ void __init imx_gpc_check_dt(void)
 	}
 }
 
-#ifdef CONFIG_PM_GENERIC_DOMAINS
-
 static void _imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
 {
 	int iso, iso2sw;
@@ -399,7 +397,6 @@ static struct genpd_onecell_data imx_gpc_onecell_data = {
 static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 {
 	struct clk *clk;
-	bool is_off;
 	int i;
 
 	imx6q_pu_domain.reg = pu_reg;
@@ -416,18 +413,13 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 	}
 	imx6q_pu_domain.num_clks = i;
 
-	is_off = IS_ENABLED(CONFIG_PM);
-	if (is_off) {
-		_imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
-	} else {
-		/*
-		 * Enable power if compiled without CONFIG_PM in case the
-		 * bootloader disabled it.
-		 */
-		imx6q_pm_pu_power_on(&imx6q_pu_domain.base);
-	}
+	/* Enable power always in case bootloader disabled it. */
+	imx6q_pm_pu_power_on(&imx6q_pu_domain.base);
+
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
+		return 0;
 
-	pm_genpd_init(&imx6q_pu_domain.base, NULL, is_off);
+	pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
 	return of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
 
@@ -437,13 +429,6 @@ clk_err:
 	return -EINVAL;
 }
 
-#else
-static inline int imx_gpc_genpd_init(struct device *dev, struct regulator *reg)
-{
-	return 0;
-}
-#endif /* CONFIG_PM_GENERIC_DOMAINS */
-
 static int imx_gpc_probe(struct platform_device *pdev)
 {
 	struct regulator *pu_reg;
-- 
2.1.4
