From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 05 Jul 2012 21:12:14 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120704153624.GI15104@mudshark.cambridge.arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FF2E0FB.4040008@renesas.com>
 <20120704153624.GI15104@mudshark.cambridge.arm.com>
Message-ID: <4FF5849E.6060301@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 7/5/2012 12:36 AM, Will Deacon wrote:
>> If we use 'lpj_fine' for this, we need to skip secondary CPU calibration
>> explicitly in another way, something like this:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/039506.html
>> [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot
> 
> How about keeping it simple like this:?
> 
> 
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index e1030e1..84bb5da 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -63,4 +63,9 @@ void __init init_current_timer_delay(unsigned long freq)
>         arm_delay_ops.const_udelay      = __timer_const_udelay;
>         arm_delay_ops.udelay            = __timer_udelay;
>  }
> +
> +unsigned long __cpuinit calibrate_delay_is_known(void)
> +{
> +       return lpj_fine ?: 0;
> +}
>  #endif

Thanks for the patch, looks lika a missing piece of CPU calibration
optimization for SMP platforms in the face of core frequency scaling.

Ok, I gave your patch a try (including above), and confirmed that:

* It works fine with non-arch_timer counter.  I'm using SH/R-Mobile
  devices, with a memory mapped I/O, 32-bit free-run up-counter
  running at 13MHz.

* Secondary CPU calibration gets skipped as expected.

* Your new timer-based delay works as before (loop-based one).  I've
  verified 10..1999-microsecond busy-wait with a reasonable accuracy
  (and confirmed that 2000+ usec gets rejected as intended).

By the way,

> +       return lpj_fine ?: 0;

Is there any difference with just

        return lpj_fine;

?
