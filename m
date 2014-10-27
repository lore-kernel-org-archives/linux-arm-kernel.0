From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:32 +0000
Subject: [PATCHv2 2/9] arm: perf: add missing pr_info newlines
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the pr_info format strings in perf_event_cpu.c are missing
newlines. Currently we get away with this as the format strings for
subsequent calls to printk (including all pr_* calls) begin with a log
prefix, and the printk core adds the omitted newline for this case.
While generates the output we expect, we probably should not rely on the
format of successive printk calls in order to get legible output.

This patch adds the missing newlines to pr_info format strings in
perf_event_cpu.c, making them consistent with the format strings for
other pr_info, warn, and pr_err calls, and preventing potentially
illegible output if the next printk/pr_* format string doesn't begin
with a log prefix.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index eb2c4d5..8e901f7 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -299,13 +299,13 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 
 	if (cpu_pmu) {
-		pr_info("attempt to register multiple PMU devices!");
+		pr_info("attempt to register multiple PMU devices!\n");
 		return -ENOSPC;
 	}
 
 	pmu = kzalloc(sizeof(struct arm_pmu), GFP_KERNEL);
 	if (!pmu) {
-		pr_info("failed to allocate PMU device!");
+		pr_info("failed to allocate PMU device!\n");
 		return -ENOMEM;
 	}
 
@@ -320,7 +320,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	if (ret) {
-		pr_info("failed to probe PMU!");
+		pr_info("failed to probe PMU!\n");
 		goto out_free;
 	}
 
@@ -331,7 +331,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		return 0;
 
 out_free:
-	pr_info("failed to register PMU devices!");
+	pr_info("failed to register PMU devices!\n");
 	kfree(pmu);
 	return ret;
 }
-- 
1.9.1
