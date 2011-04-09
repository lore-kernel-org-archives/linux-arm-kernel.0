From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Apr 2011 19:47:58 -0700
Subject: [RFC PATCHv2 09/20] ARM: architected timers: add A15 architected
	timers
In-Reply-To: <1300201983-26124-10-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
	<1300201983-26124-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <4D9FC8DE.3090701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2011 8:12 AM, Marc Zyngier wrote:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b7e504b..38ee56e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1407,9 +1407,14 @@ config HOTPLUG_CPU
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.
>  
> +config HAVE_ARCH_TIMERS
> +	bool
> +	depends on CPU_V7
> +	select TICK_ONESHOT

I don't think you need to select TICK_ONESHOT. The user should be
selecting NO_HZ or HIGH_RES_TIMERS instead, right?

> +
> +static struct clocksource clocksource_counter = {
> +	.name	= "arch_sys_counter",
> +	.rating	= 400,
> +	.read	= arch_counter_read,
> +	.mask	= CLOCKSOURCE_MASK(56),
> +	.flags	= (CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES),

I'm fairly certain that CLOCK_SOURCE_VALID_FOR_HRES is a private flag
not to be used by clocksource drivers. At least grepping the kernel for
it shows no results outside of kernel/time/

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
