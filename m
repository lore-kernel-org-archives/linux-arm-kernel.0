From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 29 Jul 2015 23:15:13 +0300
Subject: [PATCH] ARM: EXYNOS: pd: fix resource deallocation on error path
Message-ID: <1438200913-10532-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change fixes a bug introduced by 2be2a3ff42a5, memory allocated
by kstrdup_const() must be always deallocated with kfree_const(),
otherwise there is a risk of kfree'ing ro memory.

Also remove unneeded of_node_put(), if for_each_compatible_node() body
execution is not terminated, this prevents from double kfree() in
OF_DYNAMIC build.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-exynos/pm_domains.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 6001f1c..4a87e86 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -146,9 +146,8 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->base = of_iomap(np, 0);
 		if (!pd->base) {
 			pr_warn("%s: failed to map memory\n", __func__);
-			kfree(pd->pd.name);
+			kfree_const(pd->pd.name);
 			kfree(pd);
-			of_node_put(np);
 			continue;
 		}
 
-- 
2.1.4
