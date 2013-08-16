From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Aug 2013 07:55:14 +0530
Subject: [PATCH 17/34] cpufreq: longhaul: set CPUFREQ_NO_NOTIFICATION flag
In-Reply-To: <cover.1376619363.git.viresh.kumar@linaro.org>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
Message-ID: <b67c7b6951b63ff38bac847e0b213bff3368e0b7.1376619363.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the drivers do following in their ->target_index() routines:

	struct cpufreq_freqs freqs;
	freqs.old = old freq...
	freqs.new = new freq...

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);

	/* Change rate here */

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

This is replicated over all cpufreq drivers today and there doesn't exists a
good enough reason why this shouldn't be moved to cpufreq core instead.

Earlier patches have added support in cpufreq core to do cpufreq notification on
frequency change, but this drivers needs to do this notification itself and so
it sets its CPUFREQ_NO_NOTIFICATION flag.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/longhaul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 45bafdd..7359043 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -909,6 +909,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 }
 
 static struct cpufreq_driver longhaul_driver = {
+	.flags = CPUFREQ_NO_NOTIFICATION,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.target_index = longhaul_target,
 	.get	= longhaul_get,
-- 
1.7.12.rc2.18.g61b472e
