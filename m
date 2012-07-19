From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 19 Jul 2012 21:43:40 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120717090541.GA14624@mudshark.cambridge.arm.com>
References: <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
 <20120717090541.GA14624@mudshark.cambridge.arm.com>
Message-ID: <500800FC.40002@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Have not gone through your new mail yet, sorry..

On 7/17/2012 6:05 PM, Will Deacon wrote:
> I assume the reason you've done it like this is because your timer isn't up
> and running until after the delay loop has been calibrated? In which case,
> I'd really rather not duplicate the calibration here -- is there no way you
> can ensure the timer is available earlier? If not, then I'm not sure we
> should be using it as the delay source.

Of course not :-)  My timers get started and running from time_init()
point, before calibrate_delay().

And don't get me wrong, I just tried to provide a working example to
skip calibrate_delay() in response to Santosh request:

> Thanks for the detailed explanation. CPU clock detection is indeed the
> nit way to skip the calibration overhead and this was one of the comment
> when I tried to push the skipping of calibration for secondary CPUs.
> 
> Looks like you have a working patch for the clock detection. Will
> you able to post that patch so that this long pending calibration
> for secondary CPUs gets optimized.

... with keeping the following points in mind:

1. skip the calibration for secondary CPUs (that is, for SMP use)

2. can work without init_current_timer_delay() help; calculating lpj
   from the CPU clock speed, not from current timer

If I understand Santosh request correctly, he requested a patch that
could be tested on non-A15 SMP systems (may be A9).  We know that A15
comes with the architected timer and does not require any additional
patches apart from already provided ones.  Also he said he gave a try
to "the suggested change + two patches" and confirmed it worked.

As for lpj_early variable, I just wanted to reserve lpj_fine for real
"timer" use, and did not want to mix with CPU frequency thing.  That
being said, I have to admit that rewriting using lpj_fine looks much
simpler, and should have done so from the beginning:

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 395d5fb..b9874a3 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -65,6 +65,13 @@ void __init init_current_timer_delay(unsigned long freq)
 	arm_delay_ops.udelay		= __timer_udelay;
 }
 
+void __init calibrate_delay_early(unsigned long rate)
+{
+	pr_info("Calibrating delay using CPU frequency.. %lu Hz\n", rate);
+	lpj_fine = (rate + (HZ/2)) / HZ;
+	loops_per_jiffy = lpj_fine;
+}
+
 unsigned long __cpuinit calibrate_delay_is_known(void)
 {
 	return lpj_fine;
_

Anyway, my goal was to make calibrate_delay_is_known() work to skip
the calibration for secondary CPUs, whether init_current_timer_delay()
was involved or not.

> I also think you need to consider:
> 
>   1. Can your timer change frequency at runtime? [due to PM etc]
>   2.
>      i. Is its clock domain guaranteed to tick as long as the CPU is up?
>     ii. If it's in a separate power domain to the CPU, is that ever shut off
>         while the CPU is up?
> 
> If the answer to any of those is `yes', then I also think it's questionable
> whether it's worthwhile using it for delay.

Good point.  They all strongly suggest a need for current timer help.

At the same time, however, I wonder is it possible for runtime PM to
change frequency, or stop clock supply to the CPU core, or shut-down
its power domain _unnoticed_ by the CPU core? I do not think so.  It
may be easy from the hardware perspective, but it should not from the
software standpoint.

One thing we have to be careful when make use of the CPU clock speed
to skip the calibration on secondary CPUs is, the clock speed of each
CPU core when it enters / leaves from suspend.  And as long as it is
_predictable_, current calibrate_delay() & calibrate_delay_is_known()
infrastructure we have is going to work great.  On secondary CPUs,
loops_per_jiffy gets set up using calibrate_delay_is_known() at the
first calibration time, then stored to per_cpu(cpu_loops_per_jiffy).
Afterward, per_cpu(cpu_loops_per_jiffy) will be used.  If this works
for Santosh / OMAPs, it woudl be best, the way to go.

On the other hand, if it's unpredictable, we need yet another hacks
to 1) skip the calibration for secondary CPUs, and 2) the way to load
an appropriate value to global loops_per_jiffy, every time each CPU
gets started.

[ And at the point udelay() relies on the global loops_per_jiffy,
  this scenario doesn't work.  Primary reason to use current timer! ]

> Updating loops_per_jiffy from init_current_timer_delay is reasonable if
> people rely on these delays prior to calibration and there isn't a compromise
> value for lpj, but all this _early stuff is really horrible. Just make the
> thing tick before calibration occurs (we don't care about interrupts).

Lastly, would like to update examples of use cases.

/* For UP systems, or SMP systems without dynamic CPU freq scaling */
your_timer_init(void)
{
        unsigned long rate;

        rate = get_CPU_frequency();
        calibrate_delay_early(rate);
}

After calibrate_delay() is processed, loops_per_jiffy is supposed be
under the control of cpufreq, if required.

/* For SMP systems with dynamic CPU freq scaling */
your_timer_init(void)
{
        unsigned long rate;

        rate = get_Timer_frequency();
        init_current_timer_delay(rate);
}

You don't have to use calibrate_delay_early() in this case, of course.
My privious example was not clear on this point.

--
Shinya Kuribayashi
Renesas Electronics
