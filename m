From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 6 May 2018 20:23:25 +0200
Subject: [PATCH] arm: Convert arm boot_lock to raw
In-Reply-To: <20180504105600.20613-1-bigeasy@linutronix.de>
References: <20180504105600.20613-1-bigeasy@linutronix.de>
Message-ID: <20180506182325.w7yvrpp3hcii54pj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 12:55:58PM +0200, Sebastian Andrzej Siewior wrote:
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
> Cc: Russell King <linux@armlinux.org.uk>
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
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-soc at vger.kernel.org
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: added new boot_lock user]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-actions/platsmp.c   |    6 +++---
>  arch/arm/mach-exynos/platsmp.c    |   12 ++++++------

I assume this is needed for -rt patches?

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Exynos5422 (Odroid HC1) with Linaro PM-QA:
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
