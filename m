From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Jun 2012 10:54:33 +0200
Subject: [PATCH 2/2] ARM: Exynos4: pm_domains: register devices in
 'need_restore' state
In-Reply-To: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
References: <1339750473-32699-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1339750473-32699-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ca1d72f033 ('PM / Domains: Make it possible to add devices to
inactive domains') introduced possibility to add devices to inactive
power domains and added pm_genpd_dev_need_restore() function which lets
platform core to notify power domain core that the specified device must
be restored (with its runtime_resume() callback) before first use.

This patch adds the pm_genpd_dev_need_restore() call what brings back
the suspend/resume behaviour for the client devices known from the
previous power domain driver (removed by commit 91cfbd4ee0 - 'ARM:
EXYNOS: Hook up power domains to generic power domain infrastructure').
Client device drivers relay on that suspend/resume behaviour, thus this
patch fixes runtime pm operation for client devices.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 0a952a5..373c3c0 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -119,7 +119,9 @@ static __init void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
 						struct exynos_pm_domain *pd)
 {
 	if (pdev->dev.bus) {
-		if (pm_genpd_add_device(&pd->pd, &pdev->dev))
+		if (!pm_genpd_add_device(&pd->pd, &pdev->dev))
+			pm_genpd_dev_need_restore(&pdev->dev, true);
+		else
 			pr_info("%s: error in adding %s device to %s power"
 				"domain\n", __func__, dev_name(&pdev->dev),
 				pd->name);
-- 
1.7.1.569.g6f426
