From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 16 Jul 2018 07:42:26 +0000
Subject: [PATCH 1/3] arm: Convert arm boot_lock to raw
In-Reply-To: <20180711110037.12928-2-bigeasy@linutronix.de>
References: <20180711110037.12928-1-bigeasy@linutronix.de>
 <20180711110037.12928-2-bigeasy@linutronix.de>
Message-ID: <768ab9bd-40f7-b031-2dd5-1629ddafd3ac@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian

On 07/11/2018 01:00 PM, Sebastian Andrzej Siewior wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
> 
> try_to_wake_up()
>     ...
>        activate_task()
>           enqueue_task()
>              p->sched_class->enqueue_task(rq, p, flags)
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
>   arch/arm/mach-actions/platsmp.c   |  6 +++---
>   arch/arm/mach-exynos/platsmp.c    | 12 ++++++------
>   arch/arm/mach-hisi/platmcpm.c     | 22 +++++++++++-----------
>   arch/arm/mach-omap2/omap-smp.c    | 10 +++++-----
>   arch/arm/mach-prima2/platsmp.c    | 10 +++++-----
>   arch/arm/mach-qcom/platsmp.c      | 10 +++++-----
>   arch/arm/mach-spear/platsmp.c     | 10 +++++-----
>   arch/arm/mach-sti/platsmp.c       | 10 +++++-----
>   arch/arm/mach-sunxi/mc_smp.c      | 20 ++++++++++----------
>   arch/arm/plat-versatile/platsmp.c | 10 +++++-----
>   10 files changed, 60 insertions(+), 60 deletions(-)
> 

For mach-sti:

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
