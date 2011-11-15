From: or.rmz1@gmail.com (Omar Ramirez Luna)
Date: Tue, 15 Nov 2011 11:57:59 -0600
Subject: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
In-Reply-To: <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAPTm=KGDEKGxLpJt0t6k_NL5Wz81NkMmRJ+OkmyvHedd6_exgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

On Tue, Sep 20, 2011 at 6:30 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Clock is enabled only when timer is started and disabled when the the timer
> is stopped. Therefore before accessing registers in functions clock is enabled
> and then disabled back at the end of access. Context save is done dynamically
> whenever the registers are modified. Context restore is called when context is
> lost.

Now that handling of the clock has been decoupled from
omap_dm_timer_request_specific/free and placed in start/stop
functions, there is a "possible irq lock inversion dependency
detected" for any attempt to enable the clock from soft|hard irq.

My use case is as follows:

DSP sends a mailbox message to ARM, this triggers a tasklet in mailbox
for processing the message, when it reaches tidspbridge it turns out
that the DSP wants to enable a gpt timer; however, locks involved
"clocks_mutex" and "dm_timer_lock" now could cause a deadlock as they
have been called from unsafe contexts in the past
(http://pastebin.com/7Dtz8t0f).

Is the intention to restrict enabling the dmtimer clocks from hard|soft irqs?

...
> @@ -303,6 +342,22 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
> ? ? ? ? ? ? ? ?rate = clk_get_rate(timer->fclk);
>
> ? ? ? ?__omap_dm_timer_stop(timer, timer->posted, rate, is_omap2);
> +
> + ? ? ? if (timer->loses_context) {
> + ? ? ? ? ? ? ? if (timer->get_context_loss_count)
> + ? ? ? ? ? ? ? ? ? ? ? timer->ctx_loss_count =
> + ? ? ? ? ? ? ? ? ? ? ? timer->get_context_loss_count(&timer->pdev->dev);
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
> ?}
> ?EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>

I didn't review the whole patch, but at least this part is not in
mainline, it seems like the patch modified by Tony and the v16 were
not the same.

I could diff and include the missing parts, if someone can confirm
that we need v16, which I believe so, since current stop function
doesn't call omap_dm_timer_disable.

Regards,

Omar
