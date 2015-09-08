From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 08 Sep 2015 18:41:02 +0200
Subject: [PATCH v5 2/4] cpufreq: allow cpufreq_generic_suspend() to work
 without suspend frequency
In-Reply-To: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1441730464-7947-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some cpufreq drivers may set suspend frequency only for
selected setups but still would like to use the generic
suspend handler.  Thus don't treat !policy->suspend_freq
condition as an incorrect one.

Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b3d9368..a634fcb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1626,8 +1626,8 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
 	int ret;
 
 	if (!policy->suspend_freq) {
-		pr_err("%s: suspend_freq can't be zero\n", __func__);
-		return -EINVAL;
+		pr_debug("%s: suspend_freq not defined\n", __func__);
+		return 0;
 	}
 
 	pr_debug("%s: Setting suspend-freq: %u\n", __func__,
-- 
1.9.1
