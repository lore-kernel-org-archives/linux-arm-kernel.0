From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Apr 2013 17:00:24 -0700
Subject: [PATCH 1/2] clocksource: arm_arch_timer: unify sched_clock init
In-Reply-To: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
References: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
Message-ID: <51708918.1070501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/13 12:30, Rob Herring wrote:
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 122ff05..17ed8e4 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -266,6 +266,15 @@ static struct notifier_block arch_timer_cpu_nb __cpuinitdata = {
>  	.notifier_call = arch_timer_cpu_notify,
>  };
>  
> +static u64 sched_clock_mult __read_mostly;
> +
> +unsigned long long notrace arch_timer_sched_clock(void)
> +{
> +	return arch_timer_read_counter() * sched_clock_mult;
> +}
> +unsigned long long sched_clock(void) \
> +	__attribute__((weak, alias("arch_timer_sched_clock")));

I'm still lost, how does this prevent the timer in ARM's 32 bit
sched_clock code from getting setup in sched_clock_postinit()? That
print is still there right? Who owns sched_clock() in multi-target builds?

Why can't we play along with the sched_clock code that lives in arm?
Maybe we should resurrect those clocksource sched_clock patches again.
Or maybe we should add support for setup_sched_clock_64() in arm's sched
clock code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
