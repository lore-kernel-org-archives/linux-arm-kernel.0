From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 31 Jul 2015 03:09:50 +0300
Subject: [PATCH v2 2/2] ARM: EXYNOS: fix double of_node_put() on error path
In-Reply-To: <1438301390-7397-1-git-send-email-vz@mleia.com>
References: <1438301390-7397-1-git-send-email-vz@mleia.com>
Message-ID: <1438301390-7397-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change removes the second of_node_put(), if
for_each_compatible_node() body execution is not terminated. This
prevents from object refcounter overflow over zero in OF_DYNAMIC
build.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* split a single change v1 into two

 arch/arm/mach-exynos/pm_domains.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 5121baa..4a87e86 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -148,7 +148,6 @@ static __init int exynos4_pm_init_power_domain(void)
 			pr_warn("%s: failed to map memory\n", __func__);
 			kfree_const(pd->pd.name);
 			kfree(pd);
-			of_node_put(np);
 			continue;
 		}
 
-- 
2.1.4
