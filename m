From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Apr 2016 09:39:18 +0200
Subject: [PATCH] ARM: EXYNOS: Properly skip unitialized parent clock in power
 domain on
Message-ID: <1461310758-20615-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to skip reparenting a clock on turning on power domain, if we
do not have the parent yet. The parent is obtained when turning the
domain off. However due to a typo, the loop is continued on IS_ERR() of
clock being reparented, not on the IS_ERR() of the parent.

Theoretically this could lead to OOPS on first turn on of a power
domain, if there was no turn off before. Practically that should never
happen because all power domains are turned on by default (reset value,
bootloader does not turn off them usually) so the first action will be
always turn off.

Fixes: 29e5eea06bc1 ("ARM: EXYNOS: Get current parent clock for power domain on/off")
Reported-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 7c21760f590f..875a2bab64f6 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -92,7 +92,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 			if (IS_ERR(pd->clk[i]))
 				break;
 
-			if (IS_ERR(pd->clk[i]))
+			if (IS_ERR(pd->pclk[i]))
 				continue; /* Skip on first power up */
 			if (clk_set_parent(pd->clk[i], pd->pclk[i]))
 				pr_err("%s: error setting parent to clock%d\n",
-- 
1.9.1
