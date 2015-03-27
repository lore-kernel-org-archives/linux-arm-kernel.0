From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 27 Mar 2015 11:43:55 +0100
Subject: [RESEND PATCH 1/2] ARM: EXYNOS: Handle of of_iomap() failure
Message-ID: <1427453036-6808-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent possible NULL pointer dereference if of_iomap() fails. Handle
the error by skipping such power domain.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index cbe56b35aea0..2c5c206f3ea9 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -138,6 +138,13 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
+		if (!pd->base) {
+			dev_warn(&pdev->dev, "Failed to map memory\n");
+			kfree(pd);
+			of_node_put(np);
+			continue;
+		}
+
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
 
-- 
1.9.1
