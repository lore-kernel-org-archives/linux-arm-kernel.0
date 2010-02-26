From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2010 11:17:02 -0000
Subject: [PATCH 2/6] ARM: perf-events: use numeric ID to identify PMU
In-Reply-To: <201002261010.03017.jpihet@mvista.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-2-git-send-email-will.deacon@arm.com>
	<1267124175-21721-3-git-send-email-will.deacon@arm.com>
	<201002261010.03017.jpihet@mvista.com>
Message-ID: <000701cab6d5$38d828a0$aa8879e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> > +/* ARM perf PMU IDs for use by internal perf clients. */
> > +#define ARM_PERF_PMU_ID_XSCALE1	0
> > +#define ARM_PERF_PMU_ID_XSCALE2	(ARM_PERF_PMU_ID_XSCALE1 + 1)
> > +#define ARM_PERF_PMU_ID_V6	(ARM_PERF_PMU_ID_XSCALE2 + 1)
> > +#define ARM_PERF_PMU_ID_V6MP	(ARM_PERF_PMU_ID_V6 + 1)
> > +#define ARM_PERF_PMU_ID_CA8	(ARM_PERF_PMU_ID_V6MP + 1)
> > +#define ARM_PERF_PMU_ID_CA9	(ARM_PERF_PMU_ID_CA8 + 1)
> > +#define ARM_NUM_PMU_IDS		(ARM_PERF_PMU_ID_CA9 + 1)
> I think we need a better representation of the IDs and names. This is error
> prone in case of modification, e.g. adding an ID.

OK - how about something like this?:

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 925b9a4..7584aa4 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -29,13 +29,15 @@ set_perf_event_pending(void)
 #define PERF_EVENT_INDEX_OFFSET 1
 
 /* ARM perf PMU IDs for use by internal perf clients. */
-#define ARM_PERF_PMU_ID_XSCALE1        0
-#define ARM_PERF_PMU_ID_XSCALE2        (ARM_PERF_PMU_ID_XSCALE1 + 1)
-#define ARM_PERF_PMU_ID_V6     (ARM_PERF_PMU_ID_XSCALE2 + 1)
-#define ARM_PERF_PMU_ID_V6MP   (ARM_PERF_PMU_ID_V6 + 1)
-#define ARM_PERF_PMU_ID_CA8    (ARM_PERF_PMU_ID_V6MP + 1)
-#define ARM_PERF_PMU_ID_CA9    (ARM_PERF_PMU_ID_CA8 + 1)
-#define ARM_NUM_PMU_IDS                (ARM_PERF_PMU_ID_CA9 + 1)
+static enum arm_perf_pmu_ids {
+       ARM_PERF_PMU_ID_XSCALE1 = 0,
+       ARM_PERF_PMU_ID_XSCALE2,
+       ARM_PERF_PMU_ID_V6,
+       ARM_PERF_PMU_ID_V6MP,
+       ARM_PERF_PMU_ID_CA8,
+       ARM_PERF_PMU_ID_CA9,
+       ARM_NUM_PMU_IDS,
+};
 
 extern int
 armpmu_get_pmu_id(void);

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 98c62ff..513ee60 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -69,13 +69,13 @@ struct cpu_hw_events {
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 /* PMU names. */
-static const char *arm_pmu_names[ARM_NUM_PMU_IDS] = {
-       "xscale1",
-       "xscale2",
-       "v6",
-       "v6mpcore",
-       "ARMv7 Cortex-A8",
-       "ARMv7 Cortex-A9",
+static const char *arm_pmu_names[] = {
+       [ARM_PERF_PMU_ID_XSCALE1] = "xscale1",
+       [ARM_PERF_PMU_ID_XSCALE2] = "xscale2",
+       [ARM_PERF_PMU_ID_V6]      = "v6",
+       [ARM_PERF_PMU_ID_V6MP]    = "v6mpcore",
+       [ARM_PERF_PMU_ID_CA8]     = "ARMv7 Cortex-A8",
+       [ARM_PERF_PMU_ID_CA9]     = "ARMv7 Cortex-A9",
 };
 
 struct arm_pmu {


Cheers,

Will
