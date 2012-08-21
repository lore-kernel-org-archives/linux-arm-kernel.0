From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 21 Aug 2012 15:20:18 -0400
Subject: [PATCH v2 28/31] arm64: Generic timers support
In-Reply-To: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Message-ID: <5033DF72.70609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2012 01:52 PM, Catalin Marinas wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
> 
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.

[...]

> +++ b/drivers/clocksource/arm_generic.c

[...]

> +static void arch_timer_reg_write(int reg, u32 val)
> +{
> +	switch (reg) {
> +	case ARCH_TIMER_REG_CTRL:
> +		asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
> +		break;
> +	case ARCH_TIMER_REG_TVAL:
> +		asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	isb();
> +}

Doesn't architecture-specific assembly need to go in the arch directory rather
than the drivers directory?

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
