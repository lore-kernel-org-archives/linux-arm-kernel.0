From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  3 Nov 2017 11:45:18 +0000
Subject: [PATCH 2/2] arm-ccn: perf: Prevent module unload while PMU is in use
In-Reply-To: <20171103114518.5311-1-suzuki.poulose@arm.com>
References: <20171103114518.5311-1-suzuki.poulose@arm.com>
Message-ID: <20171103114518.5311-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the PMU driver is built as a module, the perf expects the
pmu->module to be valid, so that the driver is prevented from
being unloaded while it is in use. Fix the CCN pmu driver to
fill in this field.

Fixes: commit a33b0daab73a0 ("bus: ARM CCN PMU driver")
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-ccn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index e8c6946fed9d..3063f5312397 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1276,6 +1276,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 
 	/* Perf driver registration */
 	ccn->dt.pmu = (struct pmu) {
+		.module = THIS_MODULE,
 		.attr_groups = arm_ccn_pmu_attr_groups,
 		.task_ctx_nr = perf_invalid_context,
 		.event_init = arm_ccn_pmu_event_init,
-- 
2.13.6
