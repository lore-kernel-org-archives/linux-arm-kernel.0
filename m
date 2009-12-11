From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 11 Dec 2009 09:44:20 +0000
Subject: [PATCH 2/4] arm/oprofile: reserve the PMU when starting
In-Reply-To: <1260524662-30683-2-git-send-email-jamie.iles@picochip.com>
References: <1260524662-30683-1-git-send-email-jamie.iles@picochip.com>
	<1260524662-30683-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260524662-30683-3-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that we have access to the performance counters and
that they aren't being used by perf events or anything else.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/oprofile/op_model_mpcore.c |    9 ++++++++-
 arch/arm/oprofile/op_model_v6.c     |    8 +++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/oprofile/op_model_mpcore.c b/arch/arm/oprofile/op_model_mpcore.c
index 4ce0f98..b14e2d9 100644
--- a/arch/arm/oprofile/op_model_mpcore.c
+++ b/arch/arm/oprofile/op_model_mpcore.c
@@ -43,6 +43,7 @@
 #include <mach/hardware.h>
 #include <mach/board-eb.h>
 #include <asm/system.h>
+#include <asm/pmu.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
@@ -234,7 +235,10 @@ static int arm11_irqs[] = {
 
 static int em_start(void)
 {
-	int ret;
+	int ret = reserve_pmu();
+
+	if (ret)
+		goto out;
 
 	ret = arm11_request_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
 	if (ret == 0) {
@@ -244,6 +248,8 @@ static int em_start(void)
 		if (ret)
 			arm11_release_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
 	}
+
+out:
 	return ret;
 }
 
@@ -252,6 +258,7 @@ static void em_stop(void)
 	em_call_function(arm11_stop_pmu);
 	arm11_release_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
 	scu_stop();
+	release_pmu();
 }
 
 /*
diff --git a/arch/arm/oprofile/op_model_v6.c b/arch/arm/oprofile/op_model_v6.c
index e468017..e37720a 100644
--- a/arch/arm/oprofile/op_model_v6.c
+++ b/arch/arm/oprofile/op_model_v6.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <asm/irq.h>
 #include <asm/system.h>
+#include <asm/pmu.h>
 
 #include "op_counter.h"
 #include "op_arm_model.h"
@@ -45,16 +46,21 @@ static void armv6_pmu_stop(void)
 {
 	arm11_stop_pmu();
 	arm11_release_interrupts(irqs, ARRAY_SIZE(irqs));
+	release_pmu();
 }
 
 static int armv6_pmu_start(void)
 {
-	int ret;
+	int ret = reserve_pmu();
+
+	if (ret)
+		goto out;
 
 	ret = arm11_request_interrupts(irqs, ARRAY_SIZE(irqs));
 	if (ret >= 0)
 		ret = arm11_start_pmu();
 
+out:
 	return ret;
 }
 
-- 
1.6.5.4
