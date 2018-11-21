From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Wed, 21 Nov 2018 19:01:40 +0100
Subject: [PATCH 5/6] drivers: power: suspend: call devfreq suspend/resume
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181121180206eucas1p265865226e3938a28e842e8367233dc2e@eucas1p2.samsung.com>
Message-ID: <1542823301-23563-6-git-send-email-l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd4..0992e67 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuidle.h>
+#include <linux/devfreq.h>
 #include <linux/timer.h>
 
 #include "../base.h"
@@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
+	devfreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
 	cpufreq_suspend();
 
 	mutex_lock(&dpm_list_mtx);
-- 
2.7.4
