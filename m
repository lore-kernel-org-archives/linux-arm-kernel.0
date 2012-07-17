From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jul 2012 10:05:41 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <5005176C.6050904@renesas.com>
References: <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
Message-ID: <20120717090541.GA14624@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shinya,

On Tue, Jul 17, 2012 at 08:42:36AM +0100, Shinya Kuribayashi wrote:
> Something like this should work (not even build tested, can be applied
> on top of Will's v2 patchset):

Ok, please see the HEAD of my delay branch as I already pushed an extra patch
there:

http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commitdiff;h=aef33b43ac8664d5a3c4990e845946e7eb5aceb0

> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index e1030e1..736dcea 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -25,6 +25,8 @@
>  #include <linux/module.h>
>  #include <linux/timex.h>
>  
> +static unsigned long lpj_early;
> +
>  /*
>   * Default to the loop-based delay implementation.
>   */
> @@ -59,8 +61,22 @@ void __init init_current_timer_delay(unsigned long freq)
>  {
>  	pr_info("Switching to timer-based delay loop\n");
>  	lpj_fine			= freq / HZ;
> +	lpj_early			= lpj_fine;
> +	loops_per_jiffy			= lpj_fine;
>  	arm_delay_ops.delay		= __timer_delay;
>  	arm_delay_ops.const_udelay	= __timer_const_udelay;
>  	arm_delay_ops.udelay		= __timer_udelay;
>  }
> +
> +void __cpuinit calibrate_delay_early(unsigned long cpu_freq)
> +{
> +	lpj_early = (cpu_freq + HZ/2) / HZ;
> +	loops_per_jiffy = lpj_early;
> +	pr_info("Calibrating delay using CPU frequency.. %lu Hz\n", cpu_freq);
> +}
> +
> +unsigned long __cpuinit calibrate_delay_is_known(void)
> +{
> +	return lpj_early; /* this function works for both UP/SMP cases */
> +}
>  #endif

I assume the reason you've done it like this is because your timer isn't up
and running until after the delay loop has been calibrated? In which case,
I'd really rather not duplicate the calibration here -- is there no way you
can ensure the timer is available earlier? If not, then I'm not sure we
should be using it as the delay source. I also think you need to consider:

  1. Can your timer change frequency at runtime? [due to PM etc]
  2.
     i. Is its clock domain guaranteed to tick as long as the CPU is up?
    ii. If it's in a separate power domain to the CPU, is that ever shut off
        while the CPU is up?

If the answer to any of those is `yes', then I also think it's questionable
whether it's worthwhile using it for delay.

Updating loops_per_jiffy from init_current_timer_delay is reasonable if
people rely on these delays prior to calibration and there isn't a compromise
value for lpj, but all this _early stuff is really horrible. Just make the
thing tick before calibration occurs (we don't care about interrupts).

Will
