From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:20 -0400
Subject: [PATCH 04/13] ARM: bL_switcher: add clockevent save/restore support
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Per-CPU timers that are shutdown when a CPU is switched over must be disabled
upon switching and reprogrammed on the inbound CPU by relying on the
clock events management API. save/restore sequence is executed with irqs
disabled as mandated by the clock events API.

The next_event is an absolute time, hence, when the inbound CPU resumes,
if the timer has expired the min delta is forced into the tick device to
fire after few cycles.

This patch adds switching support for clock events that are per-CPU and
have to be migrated when a switch takes place; the cpumask of the clock
event device is checked against the cpumask of the current cpu, and if
they match, the clockevent device mode is saved and it is put in
shutdown mode. Resume code reprogrammes the tick device accordingly.

Tested on A15/A7 fast models and architected timers.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index e63881b430..d6f7e507d9 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -15,7 +15,11 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpumask.h>
 #include <linux/workqueue.h>
+#include <linux/clockchips.h>
+#include <linux/hrtimer.h>
+#include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/irqchip/arm-gic.h>
@@ -122,6 +126,8 @@ static int bL_switchpoint(unsigned long _arg)
 static int bL_switch_to(unsigned int new_cluster_id)
 {
 	unsigned int mpidr, cpuid, clusterid, ob_cluster, ib_cluster, this_cpu;
+	struct tick_device *tdev;
+	enum clock_event_mode tdev_mode;
 	int ret;
 
 	mpidr = read_mpidr();
@@ -167,6 +173,14 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	 */
 	arch_send_wakeup_ipi_mask(cpumask_of(this_cpu));
 
+	tdev = tick_get_device(this_cpu);
+	if (tdev && !cpumask_equal(tdev->evtdev->cpumask, cpumask_of(this_cpu)))
+		tdev = NULL;
+	if (tdev) {
+		tdev_mode = tdev->evtdev->mode;
+		clockevents_set_mode(tdev->evtdev, CLOCK_EVT_MODE_SHUTDOWN);
+	}
+
 	ret = cpu_pm_enter();
 
 	/* we can not tolerate errors at this point */
@@ -197,6 +211,12 @@ static int bL_switch_to(unsigned int new_cluster_id)
 
 	ret = cpu_pm_exit();
 
+	if (tdev) {
+		clockevents_set_mode(tdev->evtdev, tdev_mode);
+		clockevents_program_event(tdev->evtdev,
+					  tdev->evtdev->next_event, 1);
+	}
+
 	local_fiq_enable();
 	local_irq_enable();
 
-- 
1.8.1.2
