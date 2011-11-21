From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 21 Nov 2011 10:42:52 -0600
Subject: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
In-Reply-To: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 8, 2011 at 12:00 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
> to use timer->func_base OCP_CFG should not use this wrapper anymore.
> Instead use __raw_writel() directly and use timer->io_base instead
> to write to OCP_CFG.
>
> The timer->sys_stat is valid only if timer->revision is 1. In the
> context restore function make this correction.
>
> Save the contexts and loss count when timer is stopped.
> Also, disable the clock. Else, clock usecount would become imbalanced.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
...
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index af3b92b..f042c82 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
...
> @@ -357,6 +357,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>
> ? ? ? ?__omap_dm_timer_stop(timer, timer->posted, rate);
>
> + ? ? ? if (timer->loses_context) {
> + ? ? ? ? ? ? ? if (timer->get_context_loss_count)

Maybe: if (timer->loses_context && timer->get_context_loss_count)

> + ? ? ? ? ? ? ? ? ? ? ? timer->ctx_loss_count =
> + ? ? ? ? ? ? ? ? ? ? ? timer->get_context_loss_count(&timer->pdev->dev);

could get rid  of this weird one-line formatting

> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Since the register values are computed and written within
> + ? ? ? ?* __omap_dm_timer_stop, we need to use read to retrieve the
> + ? ? ? ?* context.
> + ? ? ? ?*/
> + ? ? ? timer->context.tclr =
> + ? ? ? ? ? ? ? ? ? ? ? omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> + ? ? ? timer->context.tisr = __raw_readl(timer->irq_stat);
> + ? ? ? omap_dm_timer_disable(timer);

FWIW, functionally it looks good to me, besides it fixes the broken
dmtimer start/stop sequence from 3.2-rc1. Tested with tidspbridge on
omap3.

If needed:

Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,

Omar
