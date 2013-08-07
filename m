From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Wed,  7 Aug 2013 16:46:11 +0530
Subject: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same as
 current
Message-ID: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the issue of un-necessary setting the clock controller
when the new target frequency is same as the current one. This case usually
occurs with governors like ondemand which passes the target frequency as the
percentage of average frequency. This check is present in most of the cpufreq
driver.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/cpufreq/exynos5440-cpufreq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 0c74018..d514c15 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -238,6 +238,9 @@ static int exynos_target(struct cpufreq_policy *policy,
 	freqs.old = dvfs_info->cur_frequency;
 	freqs.new = freq_table[index].frequency;
 
+	if (freqs.old == freqs.new)
+		goto out;
+
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Set the target frequency in all C0_3_PSTATE register */
-- 
1.7.1
