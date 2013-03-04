From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 15:15:37 -0800
Subject: [PATCH] ARM: perf: Fix section mismatch on armpmu_init()
Message-ID: <1362438937-28143-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.text+0xfb80): Section mismatch in reference
from the function armpmu_register() to the function
.init.text:armpmu_init()
The function armpmu_register() references
the function __init armpmu_init().
This is often because armpmu_register lacks a __init
annotation or the annotation of armpmu_init is wrong.

Just drop the __init marking on armpmu_init() because
armpmu_register() no longer has an __init marking.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I doubt anyone is actually experiencing any problems because this
driver probes before kernel init is over. But the warning is a bit
annoying.

 arch/arm/kernel/perf_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 31e0eb3..32081ad 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -484,7 +484,7 @@ const struct dev_pm_ops armpmu_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
 };
 
-static void __init armpmu_init(struct arm_pmu *armpmu)
+static void armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
 	mutex_init(&armpmu->reserve_mutex);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
