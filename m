From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Mar 2015 14:37:09 +0100
Subject: [PATCH v2 RESEND 2/4] arm/exynos/pm_domains: add support for
 async-bridge clocks
In-Reply-To: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
References: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1426167431-24470-3-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Exynos5420 there are async-bridges (ASB) between different IPs. These
bridges must be operational during power domain on/off, ie. clocks used
by these bridges should be enabled.
This patch enabled these clocks during domain on/off.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 37266a8..507dad0 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -37,6 +37,7 @@ struct exynos_pm_domain {
 	struct clk *oscclk;
 	struct clk *clk[MAX_CLK_PER_DOMAIN];
 	struct clk *pclk[MAX_CLK_PER_DOMAIN];
+	struct clk *asb_clk[MAX_CLK_PER_DOMAIN];
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -45,14 +46,19 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	void __iomem *base;
 	u32 timeout, pwr;
 	char *op;
+	int i;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
 
+	for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
+		if (IS_ERR(pd->asb_clk[i]))
+			break;
+		clk_prepare_enable(pd->asb_clk[i]);
+	}
+
 	/* Set oscclk before powering off a domain*/
 	if (!power_on) {
-		int i;
-
 		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
 			if (IS_ERR(pd->clk[i]))
 				break;
@@ -81,8 +87,6 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 
 	/* Restore clocks after powering on a domain*/
 	if (power_on) {
-		int i;
-
 		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
 			if (IS_ERR(pd->clk[i]))
 				break;
@@ -92,6 +96,12 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		}
 	}
 
+	for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
+		if (IS_ERR(pd->asb_clk[i]))
+			break;
+		clk_disable_unprepare(pd->asb_clk[i]);
+	}
+
 	return 0;
 }
 
@@ -131,6 +141,15 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
 
+		for (i = 0; i < MAX_CLK_PER_DOMAIN; i++) {
+			char clk_name[8];
+
+			snprintf(clk_name, sizeof(clk_name), "asb%d", i);
+			pd->asb_clk[i] = clk_get(dev, clk_name);
+			if (IS_ERR(pd->asb_clk[i]))
+				break;
+		}
+
 		pd->oscclk = clk_get(dev, "oscclk");
 		if (IS_ERR(pd->oscclk))
 			goto no_clk;
-- 
1.9.1
