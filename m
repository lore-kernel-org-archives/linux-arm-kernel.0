From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 16 Jan 2015 10:12:56 +0100
Subject: [PATCH v4 02/18] arm: exynos: pm_domains: add support for devices
 registered before arch_initcall
In-Reply-To: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421399592-7482-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SYSMMU devices will be registered early before any other devices and
before calling arch_initcall. To add them to respective power domains,
additional scan of all platform devices is needed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 37266a826437..0e2bc366b5eb 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -105,6 +105,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
+static __init int exynos_pd_init_platform_dev(struct device *dev, void *data)
+{
+	dev_pm_domain_attach(dev, true);
+	return 0;
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -189,6 +195,7 @@ no_clk:
 		of_node_put(np);
 	}
 
-	return 0;
+	return bus_for_each_dev(&platform_bus_type, NULL, NULL,
+				exynos_pd_init_platform_dev);
 }
 arch_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
