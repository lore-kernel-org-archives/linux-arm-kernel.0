From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 11:21:49 +0100
Subject: [RFCv4 4/7] drivers/perf: arm_pmu: only use common attr_groups
In-Reply-To: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473330112-28528-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the 32-bit and 64-bit perf backends use the common groups
directly, remove the fallback and no longer allow the groups array to be
overridden.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 145caf4..ac83e1e 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -549,6 +549,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
 		.stop		= armpmu_stop,
 		.read		= armpmu_read,
 		.filter_match	= armpmu_filter_match,
+		.attr_groups	= armpmu->attr_groups,
 	};
 }
 
@@ -1039,8 +1040,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
-	if (!pmu->pmu.attr_groups)
-		pmu->pmu.attr_groups = pmu->attr_groups;
 
 	ret = cpu_pmu_init(pmu);
 	if (ret)
-- 
1.9.1
