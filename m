From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Jun 2012 14:39:10 -0700
Subject: [PATCH 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <1340377774-17173-3-git-send-email-will.deacon@arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-3-git-send-email-will.deacon@arm.com>
Message-ID: <4FE8DA7E.5040105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/12 08:09, Will Deacon wrote:
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index dbbeec4..675cee0 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -32,6 +32,8 @@ static int arch_timer_ppi2;
>  
>  static struct clock_event_device __percpu **arch_timer_evt;
>  
> +extern void init_current_timer_delay(unsigned long freq);

Can we find a home for this in some header file?

> +static void __timer_const_udelay(unsigned long xloops)
> +{
> +	unsigned long long loops = xloops;
> +	loops *= loops_per_jiffy;
> +	__timer_delay(loops >> 30);
> +}

Is it ok to have a 64 bit multiply here? It seems the assembly version
tries to keep it all 32 bit math.

> +
> +static void __timer_udelay(unsigned long usecs)
> +{
> +	__timer_const_udelay(usecs * ((2199023U * HZ) >> 11));
> +}

It's unfortunate that we have to duplicate the same code and constants
in both C and assembly. With my approach we convert delay.S into C and
avoid the duplication.

> +
> +void __init init_current_timer_delay(unsigned long freq)
> +{
> +	pr_info("Switching to timer-based delay loop\n");

Might be worth printing the frequency here too.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
