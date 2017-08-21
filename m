From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Aug 2017 10:56:23 +0100
Subject: [PATCH v2] arm64: acpi/gtdt: validate CNTFRQ after having enabled the
 frame
Message-ID: <20170821095623.27691-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACPI GTDT code validates the CNTFRQ field of each MMIO timer
frame against the CNTFRQ system register of the current CPU, to
ensure that they are equal, which is mandated by the architecture.

However, reading the CNTFRQ field of a frame is not possible until
the RFRQ bit in the frame's CNTACRn register is set, and doing so
before that willl produce the following error:

  arch_timer: [Firmware Bug]: CNTFRQ mismatch: frame @ 0x00000000e0be0000: (0x00000000), CPU: (0x0ee6b280)
  arch_timer: Disabling MMIO timers due to CNTFRQ mismatch
  arch_timer: Failed to initialize memory-mapped timer.

The reason is that the CNTFRQ field is RES0 if access is not enabled.

So move the validation of CNTFRQ into the loop that iterates over the
timers to find the best frame, and disregard the frame if its CNTFRQ
field differs from the CPU timer's CNTFRQ value. Even though the
architecture suggests that the CNTFRQ field of each frame should simply
reflect the CNTFRQ value of the base frame, in reality we cannot rule
out the possibility that there is another frame available that does
have the correct value, and so it makes sense to inspect any remaining
frames in this case.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 47 +++++++-----------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aae87c4c546e..c16fa694a47b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1217,7 +1217,8 @@ arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
 }
 
 static struct arch_timer_mem_frame * __init
-arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
+arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem,
+			       bool verify_freq)
 {
 	struct arch_timer_mem_frame *frame, *best_frame = NULL;
 	void __iomem *cntctlbase;
@@ -1259,6 +1260,11 @@ arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
 		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
 			continue;
 
+		if (verify_freq &&
+		    arch_timer_mem_frame_get_cntfrq(frame) != arch_timer_rate) {
+			pr_err(FW_BUG "Ignoring MMIO timer frame with incorrect CNTFRQ\n");
+			continue;
+		}
 		best_frame = frame;
 	}
 
@@ -1366,7 +1372,7 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 		frame->valid = true;
 	}
 
-	frame = arch_timer_mem_find_best_frame(timer_mem);
+	frame = arch_timer_mem_find_best_frame(timer_mem, false);
 	if (!frame) {
 		ret = -EINVAL;
 		goto out;
@@ -1386,33 +1392,6 @@ TIMER_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
-static int __init
-arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		frame = &timer_mem->frame[i];
-
-		if (!frame->valid)
-			continue;
-
-		rate = arch_timer_mem_frame_get_cntfrq(frame);
-		if (rate == arch_timer_rate)
-			continue;
-
-		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
-			&frame->cntbase,
-			(unsigned long)rate, (unsigned long)arch_timer_rate);
-
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 {
 	struct arch_timer_mem *timers, *timer;
@@ -1428,14 +1407,6 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 	if (ret || !timer_count)
 		goto out;
 
-	for (i = 0; i < timer_count; i++) {
-		ret = arch_timer_mem_verify_cntfrq(&timers[i]);
-		if (ret) {
-			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
-			goto out;
-		}
-	}
-
 	/*
 	 * While unlikely, it's theoretically possible that none of the frames
 	 * in a timer expose the combination of feature we want.
@@ -1443,7 +1414,7 @@ static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 	for (i = i; i < timer_count; i++) {
 		timer = &timers[i];
 
-		frame = arch_timer_mem_find_best_frame(timer);
+		frame = arch_timer_mem_find_best_frame(timer, true);
 		if (frame)
 			break;
 	}
-- 
2.11.0
