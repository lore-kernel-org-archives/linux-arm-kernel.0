From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Fri, 2 Nov 2012 18:14:34 +0530
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <1351695517-5636-3-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
Message-ID: <20121102124433.GA28213@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, Oct 31, 2012 at 15:58:34 +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation of moving gic code to drivers/irqchip, remove the direct
> platform dependencies on gic_raise_softirq. Move the setup of
> smp_cross_call into the gic code. Now that all platforms are using IPI#0
> for core wakeup, create a common wakeup ipi function.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---

[...]

>  static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index 3db7782..774e527 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -155,8 +155,6 @@ static void __init ux500_smp_init_cpus(void)
> 
>         for (i = 0; i < ncores; i++)
>                 set_cpu_possible(i, true);
> -
> -       set_smp_cross_call(gic_raise_softirq);

The ux500 changes looks ok too..

However would you mind re-spinning your series on top of the below patch?

>From 6a574702ad6c45819c182a2c2bbd70d3ba7a859f Mon Sep 17 00:00:00 2001
From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Fri, 2 Nov 2012 12:45:40 +0530
Subject: [PATCH] ARM : mach-ux500: use SGI0 to wake up the other core

The commit 7d28e3eaa1a8e951251b942e7220f97114bd73b9
("ARM: ux500: wake secondary cpu via resched") makes use
of schedule IPI to wake up the secondary core which seems
incorrect. Rather use SGI0.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index da1d5ad..3f996f2 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -97,7 +97,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(cpu_logical_map(cpu));
 
-	smp_send_reschedule(cpu);
+	gic_raise_softirq(cpumask_of(cpu), 0);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.2.dirty
