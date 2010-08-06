From: samu.p.onkalo@nokia.com (Samu Onkalo)
Date: Fri,  6 Aug 2010 12:17:41 +0300
Subject: [PATCH 1/1] arm: kernel: idle loop pm constraints
In-Reply-To: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
References: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
Message-ID: <1281086261-23908-2-git-send-email-samu.p.onkalo@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check pm qos cpu latency requirements before preparing for pm-idle activities.
Scheduling is prevented during those operations and interrupt thread serving
latency in increased. Driver can set pm qos latency requirement to zero to
indicate extreme tight latency needs.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 arch/arm/kernel/process.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 401e38b..3645947 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/utsname.h>
 #include <linux/uaccess.h>
 #include <linux/random.h>
+#include <linux/pm_qos_params.h>
 
 #include <asm/cacheflush.h>
 #include <asm/leds.h>
@@ -162,6 +163,12 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		if (pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY) == 0) {
+			preempt_enable_no_resched();
+			schedule();
+			preempt_disable();
+			continue;
+		}
 		tick_nohz_stop_sched_tick(1);
 		leds_event(led_idle_start);
 		while (!need_resched()) {
-- 
1.6.3.3
