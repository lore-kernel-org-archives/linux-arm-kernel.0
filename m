From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 31 Jul 2015 03:09:49 +0300
Subject: [PATCH v2 1/2] ARM: EXYNOS: pd: fix potentian kfree() of ro memory
In-Reply-To: <1438301390-7397-1-git-send-email-vz@mleia.com>
References: <1438301390-7397-1-git-send-email-vz@mleia.com>
Message-ID: <1438301390-7397-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change fixes a bug introduced by 2be2a3ff42a5, memory allocated
by kstrdup_const() must be always deallocated with kfree_const(),
otherwise there is a risk of kfree'ing ro memory.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: <stable@vger.kernel.org>
Fixes: 2be2a3ff42a5 ("ARM: EXYNOS: register power domain driver from core_initcall")
---
Changes from v1 to v2:
* split a single change v1 into two
* added Fixes tag and Cc: <stable@vger.kernel.org>

 arch/arm/mach-exynos/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 6001f1c..5121baa 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -146,7 +146,7 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->base = of_iomap(np, 0);
 		if (!pd->base) {
 			pr_warn("%s: failed to map memory\n", __func__);
-			kfree(pd->pd.name);
+			kfree_const(pd->pd.name);
 			kfree(pd);
 			of_node_put(np);
 			continue;
-- 
2.1.4
