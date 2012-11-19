From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Mon, 19 Nov 2012 17:20:22 +0530
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <20121102124433.GA28213@bnru03>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
 <20121102124433.GA28213@bnru03>
Message-ID: <20121119115021.GA19788@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 13:44:33 +0100, Srinidhi Kasagar wrote:
> Rob,
> 
> On Wed, Oct 31, 2012 at 15:58:34 +0100, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > In preparation of moving gic code to drivers/irqchip, remove the direct
> > platform dependencies on gic_raise_softirq. Move the setup of
> > smp_cross_call into the gic code. Now that all platforms are using IPI#0
> > for core wakeup, create a common wakeup ipi function.

[...]


> > 
> >         for (i = 0; i < ncores; i++)
> >                 set_cpu_possible(i, true);
> > -
> > -       set_smp_cross_call(gic_raise_softirq);
> 
> The ux500 changes looks ok too..
> 
> However would you mind re-spinning your series on top of the below patch?

ping??

> 
> From 6a574702ad6c45819c182a2c2bbd70d3ba7a859f Mon Sep 17 00:00:00 2001
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Date: Fri, 2 Nov 2012 12:45:40 +0530
> Subject: [PATCH] ARM : mach-ux500: use SGI0 to wake up the other core
> 
> The commit 7d28e3eaa1a8e951251b942e7220f97114bd73b9
> ("ARM: ux500: wake secondary cpu via resched") makes use
> of schedule IPI to wake up the secondary core which seems
> incorrect. Rather use SGI0.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  arch/arm/mach-ux500/platsmp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index da1d5ad..3f996f2 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -97,7 +97,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 */
>  	write_pen_release(cpu_logical_map(cpu));
>  
> -	smp_send_reschedule(cpu);
> +	gic_raise_softirq(cpumask_of(cpu), 0);
>  
>  	timeout = jiffies + (1 * HZ);
>  	while (time_before(jiffies, timeout)) {
> -- 
