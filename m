From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Tue, 17 Jul 2012 16:42:36 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
Message-ID: <5005176C.6050904@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/2012 3:11 PM, Shilimkar, Santosh wrote:
> Thanks for the detailed explanation. CPU clock detection is indeed the
> nit way to skip the calibration overhead and this was one of the comment
> when I tried to push the skipping of calibration for secondary CPUs.
> 
> Looks like you have a working patch for the clock detection. Will
> you able to post that patch so that this long pending calibration
> for secondary CPUs gets optimized.

Something like this should work (not even build tested, can be applied
on top of Will's v2 patchset):

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index e1030e1..736dcea 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/timex.h>
 
+static unsigned long lpj_early;
+
 /*
  * Default to the loop-based delay implementation.
  */
@@ -59,8 +61,22 @@ void __init init_current_timer_delay(unsigned long freq)
 {
 	pr_info("Switching to timer-based delay loop\n");
 	lpj_fine			= freq / HZ;
+	lpj_early			= lpj_fine;
+	loops_per_jiffy			= lpj_fine;
 	arm_delay_ops.delay		= __timer_delay;
 	arm_delay_ops.const_udelay	= __timer_const_udelay;
 	arm_delay_ops.udelay		= __timer_udelay;
 }
+
+void __cpuinit calibrate_delay_early(unsigned long cpu_freq)
+{
+	lpj_early = (cpu_freq + HZ/2) / HZ;
+	loops_per_jiffy = lpj_early;
+	pr_info("Calibrating delay using CPU frequency.. %lu Hz\n", cpu_freq);
+}
+
+unsigned long __cpuinit calibrate_delay_is_known(void)
+{
+	return lpj_early; /* this function works for both UP/SMP cases */
+}
 #endif


And change your ->timer() func (called via time_init) to make use of it:

        unsigned long freq;

        /* For UP/SMP systems */
        freq = get_CPU_frequency();
        calibrate_delay_early(freq);

#ifdef CONFIG_SMP
        /* For SMP systems */
        freq = get_Timer_frequency();
        init_current_timer_delay(freq);
#endif

The way to detect CPU clock speed can vary depending on your systems,
so hard to be generalized.  In my case, I have full-blown clock tree
described for my SoCs, and the CPU clock speed can be easily obtained
by clk_get_rate("xxx").

Hope this helps!
-- 
Shinya Kuribayashi
Renesas Electronics
