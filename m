From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:27 +0200
Subject: [PATCH 14/24] PM / Domains: Add late_initcall to disable unused
 domains
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-15-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As default behavior let genpd at late init try to disable the unused
domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 825e81d..095a4fa4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -722,6 +722,13 @@ void pm_genpd_poweroff_unused(void)
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
1.7.9.5
