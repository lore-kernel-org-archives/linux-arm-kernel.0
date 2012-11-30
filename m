From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 19:36:02 +0000
Subject: [PATCH 09/10] arm64: move from arm_generic to arm_arch_timer
In-Reply-To: <1354297568-26366-10-git-send-email-mark.rutland@arm.com>
References: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
 <1354297568-26366-10-git-send-email-mark.rutland@arm.com>
Message-ID: <20121130193602.GB12819@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 05:46:07PM +0000, Mark Rutland wrote:
> The arch_timer driver supports a superset of the functionality of the
> arm_generic driver, and is not tied to a particular arch.
> 
> This patch moves arm64 to use the arch_timer driver, gaining additional
> functionality in doing so, and removes the (now unused) arm_generic
> driver. Timer-related hooks specific to arm64 are moved into
> arch/arm64/kernel/time.c.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

[...]

> +static inline void __cpuinit arch_counter_enable_user_access(void)
> +{
> +       u32 cntkctl;
> +
> +       /* Disable user access to the timers and the virtual counter. */
> +       asm volatile("mrs       %0, cntkctl_el1" : "=r" (cntkctl));
> +       cntkctl &= ~((3 << 8) | (1 << 1));
> +
> +       /* Enable user access to the physical counter and frequency. */
> +       cntkctl |= 1;
> +       asm volatile("msr       cntkctl_el1, %0" : : "r" (cntkctl));
> +}

We need to be careful here as I have some patches pending which change the
vdso to use the virtual counter, rather than the physical one (updating
drivers/clocksource/arm_generic.c in the process).

*Hopefully* we'll conflict and the fixup will do the right thing, but I
thought I'd better raise it in case the vdso and the timer driver get
out-of-sync and we start SIGILLing userspace!

Take a look at my aarch64/vdso branch.

Will
