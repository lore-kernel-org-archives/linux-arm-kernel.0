From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Sep 2014 12:52:26 +0200
Subject: [PATCH 10/15] PM / Domains: Add late_initcall to disable unused PM
 domains
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409741551-16437-11-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As default behavior let genpd at late init try to disable the unused
PM domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d71d045..cf4651a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -721,6 +721,13 @@ void pm_genpd_poweroff_unused(void)
 	mutex_unlock(&gpd_list_lock);
 }
 
+static int __init genpd_poweroff_unused(void)
+{
+	pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(genpd_poweroff_unused);
+
 #else
 
 static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
-- 
1.9.1
