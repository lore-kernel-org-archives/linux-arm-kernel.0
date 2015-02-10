From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Feb 2015 13:57:15 +0100
Subject: [PATCH] ARM: EXYNOS: Use platform device name as power domain name
Message-ID: <1423573035-21960-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power domain nodes in DTS may be very generic (e.g. "power-domain"
for Exynos 5420) making it very hard to debug:

$ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
power-domain                    on

Use platform device name instead so the names will be a little more user
friendly:
    domain                      status         slaves
100440e0.power-domain           on

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 arch/arm/mach-exynos/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f267121b3e..37642ea97d23 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -125,7 +125,7 @@ static __init int exynos4_pm_init_power_domain(void)
 			return -ENOMEM;
 		}
 
-		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
+		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
-- 
1.9.1
