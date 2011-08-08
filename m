From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:02 +0100
Subject: [PATCH 01/10] ARM: perf: de-const struct arm_pmu
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

This patch removes const qualifiers from instances of struct arm_pmu,
and functions initialising them, in preparation for generalising
arm_pmu usage to system (AKA uncore) PMUs.

This will allow for dynamically modifiable structures (locks,
struct pmu) to be added as members of struct arm_pmu.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |    2 +-
 arch/arm/kernel/perf_event_v6.c     |   12 ++++++------
 arch/arm/kernel/perf_event_v7.c     |   16 ++++++++--------
 arch/arm/kernel/perf_event_xscale.c |   12 ++++++------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 53c9c26..7304996 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -90,7 +90,7 @@ struct arm_pmu {
 };
 
 /* Set at runtime when we know what CPU type we are. */
-static const struct arm_pmu *armpmu;
+static struct arm_pmu *armpmu;
 
 enum arm_perf_pmu_ids
 armpmu_get_pmu_id(void)
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index dd7f3b9..d1abe97 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -635,7 +635,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
-static const struct arm_pmu armv6pmu = {
+static struct arm_pmu armv6pmu = {
 	.id			= ARM_PERF_PMU_ID_V6,
 	.name			= "v6",
 	.handle_irq		= armv6pmu_handle_irq,
@@ -653,7 +653,7 @@ static const struct arm_pmu armv6pmu = {
 	.max_period		= (1LLU << 32) - 1,
 };
 
-static const struct arm_pmu *__init armv6pmu_init(void)
+static struct arm_pmu *__init armv6pmu_init(void)
 {
 	return &armv6pmu;
 }
@@ -665,7 +665,7 @@ static const struct arm_pmu *__init armv6pmu_init(void)
  * disable the interrupt reporting and update the event. When unthrottling we
  * reset the period and enable the interrupt reporting.
  */
-static const struct arm_pmu armv6mpcore_pmu = {
+static struct arm_pmu armv6mpcore_pmu = {
 	.id			= ARM_PERF_PMU_ID_V6MP,
 	.name			= "v6mpcore",
 	.handle_irq		= armv6pmu_handle_irq,
@@ -683,17 +683,17 @@ static const struct arm_pmu armv6mpcore_pmu = {
 	.max_period		= (1LLU << 32) - 1,
 };
 
-static const struct arm_pmu *__init armv6mpcore_pmu_init(void)
+static struct arm_pmu *__init armv6mpcore_pmu_init(void)
 {
 	return &armv6mpcore_pmu;
 }
 #else
-static const struct arm_pmu *__init armv6pmu_init(void)
+static struct arm_pmu *__init armv6pmu_init(void)
 {
 	return NULL;
 }
 
-static const struct arm_pmu *__init armv6mpcore_pmu_init(void)
+static struct arm_pmu *__init armv6mpcore_pmu_init(void)
 {
 	return NULL;
 }
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 4c85183..74f9119 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1188,7 +1188,7 @@ static u32 __init armv7_read_num_pmnc_events(void)
 	return nb_cnt + 1;
 }
 
-static const struct arm_pmu *__init armv7_a8_pmu_init(void)
+static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
 	armv7pmu.name		= "ARMv7 Cortex-A8";
@@ -1198,7 +1198,7 @@ static const struct arm_pmu *__init armv7_a8_pmu_init(void)
 	return &armv7pmu;
 }
 
-static const struct arm_pmu *__init armv7_a9_pmu_init(void)
+static struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA9;
 	armv7pmu.name		= "ARMv7 Cortex-A9";
@@ -1208,7 +1208,7 @@ static const struct arm_pmu *__init armv7_a9_pmu_init(void)
 	return &armv7pmu;
 }
 
-static const struct arm_pmu *__init armv7_a5_pmu_init(void)
+static struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA5;
 	armv7pmu.name		= "ARMv7 Cortex-A5";
@@ -1218,7 +1218,7 @@ static const struct arm_pmu *__init armv7_a5_pmu_init(void)
 	return &armv7pmu;
 }
 
-static const struct arm_pmu *__init armv7_a15_pmu_init(void)
+static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA15;
 	armv7pmu.name		= "ARMv7 Cortex-A15";
@@ -1228,22 +1228,22 @@ static const struct arm_pmu *__init armv7_a15_pmu_init(void)
 	return &armv7pmu;
 }
 #else
-static const struct arm_pmu *__init armv7_a8_pmu_init(void)
+static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
 	return NULL;
 }
 
-static const struct arm_pmu *__init armv7_a9_pmu_init(void)
+static struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
 	return NULL;
 }
 
-static const struct arm_pmu *__init armv7_a5_pmu_init(void)
+static struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
 	return NULL;
 }
 
-static const struct arm_pmu *__init armv7_a15_pmu_init(void)
+static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
 	return NULL;
 }
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 3c43974..730b1c2 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -424,7 +424,7 @@ xscale1pmu_write_counter(int counter, u32 val)
 	}
 }
 
-static const struct arm_pmu xscale1pmu = {
+static struct arm_pmu xscale1pmu = {
 	.id		= ARM_PERF_PMU_ID_XSCALE1,
 	.name		= "xscale1",
 	.handle_irq	= xscale1pmu_handle_irq,
@@ -442,7 +442,7 @@ static const struct arm_pmu xscale1pmu = {
 	.max_period	= (1LLU << 32) - 1,
 };
 
-static const struct arm_pmu *__init xscale1pmu_init(void)
+static struct arm_pmu *__init xscale1pmu_init(void)
 {
 	return &xscale1pmu;
 }
@@ -786,7 +786,7 @@ xscale2pmu_write_counter(int counter, u32 val)
 	}
 }
 
-static const struct arm_pmu xscale2pmu = {
+static struct arm_pmu xscale2pmu = {
 	.id		= ARM_PERF_PMU_ID_XSCALE2,
 	.name		= "xscale2",
 	.handle_irq	= xscale2pmu_handle_irq,
@@ -804,17 +804,17 @@ static const struct arm_pmu xscale2pmu = {
 	.max_period	= (1LLU << 32) - 1,
 };
 
-static const struct arm_pmu *__init xscale2pmu_init(void)
+static struct arm_pmu *__init xscale2pmu_init(void)
 {
 	return &xscale2pmu;
 }
 #else
-static const struct arm_pmu *__init xscale1pmu_init(void)
+static struct arm_pmu *__init xscale1pmu_init(void)
 {
 	return NULL;
 }
 
-static const struct arm_pmu *__init xscale2pmu_init(void)
+static struct arm_pmu *__init xscale2pmu_init(void)
 {
 	return NULL;
 }
-- 
1.7.0.4
