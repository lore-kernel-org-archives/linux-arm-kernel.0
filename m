From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 21 Nov 2017 09:55:03 -0600
Subject: [PATCH] perf: arm_spe: add user error messaging
Message-ID: <20171121095503.965fba61d90fbf5fa1f81734@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the SPE PMU driver easier to use by elaborating SPE-specific
errors at perf record event initialization time.

Example #1: Trouble setting the sampling period:

  BEFORE THIS PATCH:

    $ ./perf record -e arm_spe_0/ts_enable=1/ -F 30 true
    Error:
    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arm_spe_0/ts_enable=1/).
    /bin/dmesg may provide additional information.
    No CONFIG_PERF_EVENTS=y kernel support configured?

    with nothing in dmesg.

  AFTER: like BEFORE above, but this text is in dmesg:

    arm_spe_pmu spe-pmu at 0: Sample period must be specified with --count

    The user takes the corrective action and specifies -c instead of -F,
    which succeeds.

Example #2:  Trouble specifying CPU vs. SPE domains:

  BEFORE:

    $ ./perf record -e arm_spe_0/ts_enable=1/ -C 3-7 true
    Error:
    The arm_spe_0/ts_enable=1/ event is not supported.

  AFTER: like BEFORE above, but this text is in dmesg:

    arm_spe_pmu spe-pmu at 0: Target CPU list includes unsupported CPUs

Example #3: Non-privileged user tries to obtain physical address (pa) data
            on a non-paranoid system:

  BEFORE:

    $ ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/ -C 0 true
    Error:
    You may not have permission to collect stats.

    Consider tweaking /proc/sys/kernel/perf_event_paranoid,
    which controls use of the performance events system by
    unprivileged users (without CAP_SYS_ADMIN).

    The current value is -1:

      -1: Allow use of (almost) all events by all users
          Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
    >= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
          Disallow raw tracepoint access by users without CAP_SYS_ADMIN
    >= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
    >= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

    To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

          kernel.perf_event_paranoid = -1

  AFTER: like BEFORE above, but this text is in dmesg:

    arm_spe_pmu spe-pmu at 0: Admin privilege needed for physical addr, time and/or context capture

Example #4:  Trying to exclude idle profiling:

  BEFORE:

    $ sudo ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/I -c 1 true
    Error:
    PMU Hardware doesn't support sampling/overflow-interrupts.

  AFTER: like BEFORE above, but this text is in dmesg:

    arm_spe_pmu spe-pmu at 0: Cannot exclude profiling when idle

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
I've tried to help solve the PMU error messaging problem various ways
from userspace [1], but it hasn't been resolved [2] by the time the SPE
driver was pushed upstream last week (now commit d5d9696b0380).

For these reasons, please consider applying this patch for the
interim.  Thanks!

[1] latest SPE incarnation:

https://www.spinics.net/lists/arm-kernel/msg614362.html

[2] -EINVAL when using CCN but not from the driver itself:

https://www.spinics.net/lists/arm-kernel/msg614025.html

 drivers/perf/arm_spe_pmu.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8ce262fc2561..6887eb45b401 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -659,20 +659,27 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	u64 reg;
 	struct perf_event_attr *attr = &event->attr;
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+	struct device *dev = &spe_pmu->pdev->dev;
 
 	/* This is, of course, deeply driver-specific */
 	if (attr->type != event->pmu->type)
 		return -ENOENT;
 
 	if (event->cpu >= 0 &&
-	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
+	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus)) {
+		dev_err_ratelimited(dev, "Target CPU list includes unsupported CPUs\n");
 		return -ENOENT;
+	}
 
-	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0) {
+		dev_err_ratelimited(dev, "Specified event filter is not supported\n");
 		return -EOPNOTSUPP;
+	}
 
-	if (attr->exclude_idle)
+	if (attr->exclude_idle) {
+		dev_err_ratelimited(dev, "Cannot exclude profiling when idle\n");
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * Feedback-directed frequency throttling doesn't work when we
@@ -681,28 +688,38 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	 * count to reflect that. Instead, just force the user to specify
 	 * a sample period.
 	 */
-	if (attr->freq)
+	if (attr->freq) {
+		dev_err_ratelimited(dev, "Sample period must be specified with --count\n");
 		return -EINVAL;
+	}
 
 	reg = arm_spe_event_to_pmsfcr(event);
 	if ((reg & BIT(SYS_PMSFCR_EL1_FE_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT)) {
+		dev_err_ratelimited(dev, "Unsupported EVT filter\n");
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(SYS_PMSFCR_EL1_FT_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP)) {
+		dev_err_ratelimited(dev, "Unsupported TYP filter\n");
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(SYS_PMSFCR_EL1_FL_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT)) {
+		dev_err_ratelimited(dev, "Unsupported LAT filter\n");
 		return -EOPNOTSUPP;
+	}
 
 	reg = arm_spe_event_to_pmscr(event);
 	if (!capable(CAP_SYS_ADMIN) &&
 	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
 		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
-		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
+		    BIT(SYS_PMSCR_EL1_PCT_SHIFT)))) {
+		dev_err_ratelimited(dev, "Admin privilege needed for physical addr, time and/or context capture\n");
 		return -EACCES;
+	}
 
 	return 0;
 }
-- 
2.15.0
