From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:37 +0000
Subject: [PATCH v3 18/20] perf: arm_spe: Fail device probe when
 arm64_kernel_unmapped_at_el0()
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512563739-25239-19-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running with the kernel unmapped whilst at EL0, the virtually-addressed
SPE buffer is also unmapped, which can lead to buffer faults if userspace
profiling is enabled and potentially also when writing back kernel samples
unless an expensive drain operation is performed on exception return.

For now, fail the SPE driver probe when arm64_kernel_unmapped_at_el0().

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8ce262fc2561..51b40aecb776 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1164,6 +1164,15 @@ static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
 	struct arm_spe_pmu *spe_pmu;
 	struct device *dev = &pdev->dev;
 
+	/*
+	 * If kernelspace is unmapped when running at EL0, then the SPE
+	 * buffer will fault and prematurely terminate the AUX session.
+	 */
+	if (arm64_kernel_unmapped_at_el0()) {
+		dev_warn_once(dev, "profiling buffer inaccessible. Try passing \"kpti=off\" on the kernel command line\n");
+		return -EPERM;
+	}
+
 	spe_pmu = devm_kzalloc(dev, sizeof(*spe_pmu), GFP_KERNEL);
 	if (!spe_pmu) {
 		dev_err(dev, "failed to allocate spe_pmu\n");
-- 
2.1.4
