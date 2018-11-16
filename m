From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:10 +0000
Subject: [PATCH 07/10] x86: perf/core: generalise event exclusion checking
 with perf macro
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542363853-13849-8-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace checking of perf event exclusion flags with perf macro.

This is a functional change as exclude_host and exclude_guest are
added in these files:

arch/x86/events/intel/uncore.c

and exclude_idle and exclude_hv are added in these files:

arch/x86/events/amd/iommu.c
arch/x86/events/amd/uncore.c

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/ibs.c          | 11 +----------
 arch/x86/events/amd/iommu.c        |  3 +--
 arch/x86/events/amd/power.c        |  8 +-------
 arch/x86/events/amd/uncore.c       |  3 +--
 arch/x86/events/intel/cstate.c     |  7 +------
 arch/x86/events/intel/rapl.c       |  7 +------
 arch/x86/events/intel/uncore.c     |  3 +--
 arch/x86/events/intel/uncore_snb.c |  7 +------
 arch/x86/events/msr.c              |  7 +------
 9 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d50bb4d..a51981c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -253,15 +253,6 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
-static const struct perf_event_attr ibs_notsupp = {
-	.exclude_user	= 1,
-	.exclude_kernel	= 1,
-	.exclude_hv	= 1,
-	.exclude_idle	= 1,
-	.exclude_host	= 1,
-	.exclude_guest	= 1,
-};
-
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -282,7 +273,7 @@ static int perf_ibs_init(struct perf_event *event)
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
 
-	if (perf_flags(&event->attr) & perf_flags(&ibs_notsupp))
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	if (config & ~perf_ibs->config_mask)
diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 3210fee..fa7541b 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -224,8 +224,7 @@ static int perf_iommu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* IOMMU counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	if (event->cpu < 0)
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 2aefacf..4129fbe 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -136,13 +136,7 @@ static int pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* Unsupported modes and filters. */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    /* no sampling */
+	if (event_has_exclude_flags(event) ||
 	    event->attr.sample_period)
 		return -EINVAL;
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8671de1..c2015c7 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -202,8 +202,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* NB and Last level cache counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	/* and we do not enable counter overflow interrupts */
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f8084f..9366833 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -280,12 +280,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
+	if (event_has_exclude_flags(event) ||
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 32f3e94..428d40c 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -397,12 +397,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
+	if (event_has_exclude_flags(event) ||
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..0544100 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -699,8 +699,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	 * Uncore PMU does measure at all privilege level all the time.
 	 * So it doesn't make sense to specify any exclude bits.
 	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-			event->attr.exclude_hv || event->attr.exclude_idle)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	/* Sampling not supported yet */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e..8bd1727 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -374,12 +374,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
+	if (event_has_exclude_flags(event) ||
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b4771a6..5f1b50b 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -160,12 +160,7 @@ static int msr_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
+	if (event_has_exclude_flags(event) ||
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
-- 
2.7.4
