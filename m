From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 Oct 2015 22:59:25 +0200
Subject: [PATCH 6/9] clocksource/drivers/exynos_mct: Use container_of()
 instead of this_cpu_ptr()
In-Reply-To: <1445288368-6440-1-git-send-email-daniel.lezcano@linaro.org>
References: <56255943.6060807@linaro.org>
 <1445288368-6440-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1445288368-6440-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Klimov <alexey.klimov@linaro.org>

Since evt structure is embedded in per-CPU mevt structure it's
definitely faster to use container_of() to get access to mevt
if we have evt (for example as incoming function argument) instead
of more expensive approach with this_cpu_ptr(&percpu_mct_tick).
this_cpu_ptr() on per-CPU mevt structure leads to access to cp15
to get cpu id and arithmetic operations.
Container_of() is cheaper since it's just one asm instruction.
This should work if used evt pointer is correct and owned by
local mevt structure.

For example, before this patch set_state_shutdown() looks like:

 4a4:	e92d4010 	push	{r4, lr}
 4a8:	e3004000 	movw	r4, #0
 4ac:	ebfffffe 	bl	0 <debug_smp_processor_id>
 4b0:	e3003000 	movw	r3, #0
 4b4:	e3404000 	movt	r4, #0
 4b8:	e3403000 	movt	r3, #0
 4bc:	e7933100 	ldr	r3, [r3, r0, lsl #2]
 4c0:	e0844003 	add	r4, r4, r3
 4c4:	e59400c0 	ldr	r0, [r4, #192]	; 0xc0
 4c8:	ebffffd4 	bl	420 <exynos4_mct_tick_stop.isra.1>
 4cc:	e3a00000 	mov	r0, #0
 4d0:	e8bd8010 	pop	{r4, pc}

With this patch:

 4a4:	e92d4010 	push	{r4, lr}
 4a8:	e59000c0 	ldr	r0, [r0, #192]	; 0xc0
 4ac:	ebffffdb 	bl	420 <exynos4_mct_tick_stop.isra.1>
 4b0:	e3a00000 	mov	r0, #0
 4b4:	e8bd8010 	pop	{r4, pc}

Also, for me size of exynos_mct.o decreased from 84588 bytes
to 83956.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 029f96a..ff44082 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -382,24 +382,28 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
+	struct mct_clock_event_device *mevt;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_start(cycles, mevt);
-
 	return 0;
 }
 
 static int set_state_shutdown(struct clock_event_device *evt)
 {
-	exynos4_mct_tick_stop(this_cpu_ptr(&percpu_mct_tick));
+	struct mct_clock_event_device *mevt;
+
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
+	exynos4_mct_tick_stop(mevt);
 	return 0;
 }
 
 static int set_state_periodic(struct clock_event_device *evt)
 {
-	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
+	struct mct_clock_event_device *mevt;
 	unsigned long cycles_per_jiffy;
 
+	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	cycles_per_jiffy = (((unsigned long long)NSEC_PER_SEC / HZ * evt->mult)
 			    >> evt->shift);
 	exynos4_mct_tick_stop(mevt);
-- 
1.9.1
