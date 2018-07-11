From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 11 Jul 2018 17:29:30 +0200
Subject: [PATCH 1/3] arm: Convert arm boot_lock to raw
In-Reply-To: <20180711110037.12928-2-bigeasy@linutronix.de>
References: <20180711110037.12928-1-bigeasy@linutronix.de>
 <20180711110037.12928-2-bigeasy@linutronix.de>
Message-ID: <1266f6c9-8eda-c71f-2d07-90291281c6f8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.07.2018 um 13:00 schrieb Sebastian Andrzej Siewior:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
> 
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
> 
> Fix by converting boot_lock to a raw spin lock.
> 
> Cc: "Andreas F?rber" <afaerber@suse.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-soc at vger.kernel.org
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org> [Exynos5422 Linaro PM-QA]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-actions/platsmp.c   |  6 +++---
>  arch/arm/mach-exynos/platsmp.c    | 12 ++++++------
>  arch/arm/mach-hisi/platmcpm.c     | 22 +++++++++++-----------
>  arch/arm/mach-omap2/omap-smp.c    | 10 +++++-----
>  arch/arm/mach-prima2/platsmp.c    | 10 +++++-----
>  arch/arm/mach-qcom/platsmp.c      | 10 +++++-----
>  arch/arm/mach-spear/platsmp.c     | 10 +++++-----
>  arch/arm/mach-sti/platsmp.c       | 10 +++++-----
>  arch/arm/mach-sunxi/mc_smp.c      | 20 ++++++++++----------
>  arch/arm/plat-versatile/platsmp.c | 10 +++++-----
>  10 files changed, 60 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 3efaa10efc43..770079245d27 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -39,7 +39,7 @@ static void __iomem *sps_base_addr;
>  static void __iomem *timer_base_addr;
>  static int ncores;
>  
> -static DEFINE_SPINLOCK(boot_lock);
> +static DEFINE_RAW_SPINLOCK(boot_lock);
>  
>  void owl_secondary_startup(void);
>  
> @@ -93,7 +93,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  	udelay(10);
>  
> -	spin_lock(&boot_lock);
> +	raw_spin_lock(&boot_lock);
>  
>  	smp_send_reschedule(cpu);
>  
> @@ -106,7 +106,7 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>  	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
>  
> -	spin_unlock(&boot_lock);
> +	raw_spin_unlock(&boot_lock);
>  
>  	return 0;
>  }
[snip]

Looks okay, so

Acked-by: Andreas F?rber <afaerber@suse.de> (for mach-actions)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
