From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 14 May 2018 16:52:37 +0200
Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM domain
 exists
Message-ID: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
to devices, clearly we must allow a device to have the pointer already
being assigned. For this reason, return 0 instead of -EEXIST.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Krzysztof reported problems for an Exynos5 board, where some devices are added
to their PM domains (genpd) via calling of_genpd_add_device(). As also pointed
out by Sylvester, this leads to probe failure when dev_pm_domain_attach()
returns -EXISTS.

Rafael, potentially this change could be squashed with the recently queued
patch: "PM / Domains: Check for existing PM domain in dev_pm_domain_attach()",
but perhaps its too late for that and the fix is better applied on top!?

---
 drivers/base/power/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 5e4b481..390868c 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -106,7 +106,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 	int ret;
 
 	if (dev->pm_domain)
-		return -EEXIST;
+		return 0;
 
 	ret = acpi_dev_pm_attach(dev, power_on);
 	if (!ret)
-- 
2.7.4
