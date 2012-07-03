From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Tue, 03 Jul 2012 21:09:31 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <1340991231-17682-3-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
Message-ID: <4FF2E0FB.4040008@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 6/30/2012 2:33 AM, Will Deacon wrote:
> implemented in terms of read_current_timer. This further allows us to
> skip the loop calibration and have a consistent delay function in the
> face of core frequency scaling.
[...]
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> new file mode 100644
> index 0000000..e1030e1
> --- /dev/null
> +++ b/arch/arm/lib/delay.c
> @@ -0,0 +1,66 @@
[...]
> +void __init init_current_timer_delay(unsigned long freq)
> +{
> +	pr_info("Switching to timer-based delay loop\n");
> +	lpj_fine			= freq / HZ;

Looking at init/calibrate.c, 'lpj_fine' can save the first loop
calibration, but does not save the second and subsequent calls to
calibrate_delay().

Magnus first noticed this, and changed to use 'preset_lpj' instead.
See the commit 173bf69a7a (ARM / mach-shmobile: Use preset_lpj with
calibrate_delay(), 2012-05-10).

If we use 'lpj_fine' for this, we need to skip secondary CPU calibration
explicitly in another way, something like this:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/039506.html
[PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot

I've been using Stephen's read_current_timer implemented + lpj_fine +
Santosh's skip secondary calibration combo for over a year, because I
wanted to save 'preset_lpj' for the original purpose, FWIW.


  Shinya

> +	arm_delay_ops.delay		= __timer_delay;
> +	arm_delay_ops.const_udelay	= __timer_const_udelay;
> +	arm_delay_ops.udelay		= __timer_udelay;
> +}
> +#endif
