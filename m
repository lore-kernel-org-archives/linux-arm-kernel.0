From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 27 Sep 2013 16:10:49 +0100
Subject: [PATCH] arm: vexpress: tc2: fix CPU hotplug and CPU idle race on
 cluster power down
In-Reply-To: <1380292153-10480-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1380292153-10480-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130927151043.GA9746@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 03:29:13PM +0100, Lorenzo Pieralisi wrote:
> On the TC2 testchip, when all CPUs in a cluster enter standbywfi and
> commit a power down request, the power controller will wait for

[...]

(Minor nit: please wrap the commit message to a shorter length for git
log.  I use 67, but I can't remember where that recommendation came from)

[...]

> This patch moves the GIC CPU IF disable call in the TC2 MCPM implementation
> from the suspend method to the power down method to fix the mentioned
> race condition.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Dave Martn <Dave.Martin@arm.com> (for kexec)

It's worth briefly summarising the kexec scenario too:

kexec hotplugs secondary CPUs out during kernel reload/restart.
Because kexec may (deliberately) trash the old kernel text, it is
not OK for CPUs to follow the MCPM soft reboot path, since
instructions after the WFI may have been replaced by kexec.

If tc2_pm_down() does not disable the GIC cpu interface, there is a
race between CPU powerdown in the old kernel and the IPI from the
new kernel that triggers secondary boot, particluarly if the
powerdown is slow (due to L2 cache cleaning for example).  If the
new kernel wins the race, the affected CPU(s) will not really be
reset and may execute garbage after the WFI.

(some comments below)

> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm/mach-vexpress/tc2_pm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index 7aeb5d6..e6eb481 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -131,6 +131,16 @@ static void tc2_pm_down(u64 residency)
>  	} else
>  		BUG();
>  
> +	/*
> +	 * If the CPU is committed to power down, make sure
> +	 * the power controller will be in charge of waking it
> +	 * up upon IRQ, ie IRQ lines are cut from GIC CPU IF
> +	 * to the CPU by disabling the GIC CPU IF to prevent wfi
> +	 * from completing execution behind power controller back
> +	 */
> +	if (!skip_wfi)
> +		gic_cpu_if_down();
> +

In my version of this fix, I disabled the CPU interface much earlier,
just after entering the function.  I think it probably works either
way.  Do you think the location is critical, or should it not matter?

As far as I could tell, it matters only that this is done sometime
between committing to WFI and actually doing it, but if you think
there are extra requirements then I would like to understand them.

[...]

Cheers
---Dave
