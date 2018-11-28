From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Wed, 28 Nov 2018 12:24:47 +0100
Subject: [PATCH] perf: arm_spe: handle devm_kasprintf() failure
Message-ID: <1543404287-3946-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kasprintf() may return NULL on failure of internal allocation
thus the assignment to  name  is not safe if unchecked. if NULL
is passed in for name then perf_pmu_register() would not fail
but rather silently jump to skip_type which is not the intent
here. As perf_pmu_register() may also return -ENOMEM returning 
-ENOMEM in the (unlikely) failure case of devm_kasprintf() should 
be fine here as well.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
---

Problem located with an experimental coccinelle script

The dev_err() might seem a bit much for this unlikely error but as 
perf_pmu_register() may also return -ENOMEM it would be hard to figure
out what went wrong without this message.

Patch was compile tested with: defconfig (ARCH=arm64) +
ARM_SPE_PMU=y

Patch is against 4.20-rc3 (localversion-next is next-20181128)

 drivers/perf/arm_spe_pmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 54ec278..f1ea00c 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -927,6 +927,11 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 
 	idx = atomic_inc_return(&pmu_idx);
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
+	if (!name) {
+		dev_err(dev, "Allocation of name failed\n");
+		return -ENOMEM;
+	}
+
 	return perf_pmu_register(&spe_pmu->pmu, name, -1);
 }
 
-- 
2.1.4
