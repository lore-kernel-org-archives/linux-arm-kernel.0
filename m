From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Aug 2012 16:51:25 -0700
Subject: [PATCH v2 2/2] ARM: delay: add registration mechanism for delay
 timer sources
In-Reply-To: <1346275524-13817-2-git-send-email-will.deacon@arm.com>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
 <1346275524-13817-2-git-send-email-will.deacon@arm.com>
Message-ID: <503FFC7D.9050704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2012 2:25 PM, Will Deacon wrote:
> From: Jonathan Austin <Jonathan.Austin@arm.com>
>
> The current timer-based delay loop relies on the architected timer to
> initiate the switch away from the polling-based implementation. This is
> unfortunate for platforms without the architected timers but with a
> suitable delay source (that is, constant frequency, always powered-up
> and ticking as long as the CPUs are online).
>
> This patch introduces a registration mechanism for the delay timer
> (which provides an unconditional read_current_timer implementation) and
> updates the architected timer code to use the new interface.
>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 62e7547..88401c2 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -4,7 +4,6 @@
>  #include <asm/errno.h>
>  
>  #ifdef CONFIG_ARM_ARCH_TIMER
> -#define ARCH_HAS_READ_CURRENT_TIMER
>  int arch_timer_of_register(void);
>  int arch_timer_sched_clock_init(void);
>  #else
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index dc61451..50928e8 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -15,6 +15,11 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +struct delay_timer {
> +	unsigned long (*read_current_timer)(void);
> +	unsigned long freq;

I wonder if we should print a warning and not actually switch to the
timer based udelay if the frequency is not fast enough (< 1Mhz). Or
people just wouldn't do that?

> @@ -55,18 +62,24 @@ static void __timer_udelay(unsigned long usecs)
>  	__timer_const_udelay(usecs * UDELAY_MULT);
>  }
>  
> -void __init init_current_timer_delay(unsigned long freq)
> +void __init register_current_timer_delay(struct delay_timer *timer)

const?

>  {
> -	pr_info("Switching to timer-based delay loop\n");
> -	lpj_fine			= freq / HZ;
> -	loops_per_jiffy			= lpj_fine;
> -	arm_delay_ops.delay		= __timer_delay;
> -	arm_delay_ops.const_udelay	= __timer_const_udelay;
> -	arm_delay_ops.udelay		= __timer_udelay;
> +	if (!delay_calibrated) {
> +		pr_info("Switching to timer-based delay loop\n");
> +		delay_timer			= timer;
> +		lpj_fine			= timer->freq / HZ;
> +		loops_per_jiffy			= lpj_fine;
> +		arm_delay_ops.delay		= __timer_delay;
> +		arm_delay_ops.const_udelay	= __timer_const_udelay;
> +		arm_delay_ops.udelay		= __timer_udelay;
> +		delay_calibrated		= true;
> +	} else {
> +		pr_info("Ignoring duplicate/late registration of read_current_timer delay\n");

warn?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
