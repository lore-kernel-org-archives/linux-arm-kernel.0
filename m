From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:05 +0000
Subject: [PATCH 02/10] arm: perf/core: generalise event exclusion checking
 with perf macro
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542363853-13849-3-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace checking of perf event exclusion flags with perf macro.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm/mach-imx/mmdc.c     | 8 +-------
 arch/arm/mm/cache-l2x0-pmu.c | 7 +------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 04b3bf7..d9d468f 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -293,13 +293,7 @@ static int mmdc_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (event->attr.exclude_user		||
-			event->attr.exclude_kernel	||
-			event->attr.exclude_hv		||
-			event->attr.exclude_idle	||
-			event->attr.exclude_host	||
-			event->attr.exclude_guest	||
-			event->attr.sample_period)
+	if (event_has_exclude_flags(event) || event->attr.sample_period)
 		return -EINVAL;
 
 	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index afe5b4c..968fdf8 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -314,12 +314,7 @@ static int l2x0_pmu_event_init(struct perf_event *event)
 	    event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	if (event->cpu < 0)
-- 
2.7.4
