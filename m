From: neilb@suse.de (NeilBrown)
Date: Fri, 15 Jun 2012 07:06:11 +1000
Subject: [GIT PULL] gpio/omap: cleanups for v3.5
In-Reply-To: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
References: <874nrmtf47.fsf@ti.com> <20120614101541.39f50aee@notabene.brown>
 <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Message-ID: <20120615070611.0fa559ed@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jun 2012 23:24:10 +0530 "DebBarma, Tarun Kanti"
<tarun.kanti@ti.com> wrote:

> On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
> > On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:
> >
> >> Hi Grant,
> >>
> >> Here's the final round of GPIO cleanups for v3.5. ?This branch is based
> >> on my for_3.5/fixes/gpio branch you just pulled.
> >>
> >> Kevin
> >
> > Hi.
> >
> > ?I'm not sure if it was this series or the following cleanups which broke
> > ?things for me, but I've been trying 3.5-rc2 on my GTA04 and the serial
> > ?console (ttyO2) dies as soon as the omap-gpio driver initialises.
> >
> > ?After some digging I came up with this patch to gpio-omap.c
> >
> > @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
> >
> > ? ? ? ?platform_set_drvdata(pdev, bank);
> >
> > + ? ? ? if (bank->get_context_loss_count)
> > + ? ? ? ? ? ? ? bank->context_loss_count =
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->get_context_loss_count(bank->dev);
> > ? ? ? ?pm_runtime_enable(bank->dev);
> > ? ? ? ?pm_runtime_irq_safe(bank->dev);
> > ? ? ? ?pm_runtime_get_sync(bank->dev);
> >
> > which fixes it.
> >
> > What was happening ?was that when omap_gpio_probe calls pm_runtime_get_sync,
> > it calls
> > ?_od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime_resume
> > ?-> omap_gpio_restore_context
> >
> > and then the serial port stops.
> > I reasoned that the context probably hadn't been set up yet, so restoring
> > from it broke things.
> > Initialising bank->context_loss_count seems sensible and would ensure that
> > we didn't try to restore the context until it has actually been lost.
> 
> I thought the following code exactly does that. That is context_lost_cnt_after
> would be zero until there is context loss. The bank->context_loss_count is zero
> at the beginning. So, (context_lost_cnt_after != bank->context_loss_count) would
> be false and hence context restore should NOT happen? Not sure if I am
> over looking
> anything here....

Ahhh... I think I know what might be happening.

I found a while ago that if I actually enable off_mode some things
didn't work properly, but if I just set mpu_deepest_state to PWRDM_POWER_OFF
in next_valid_state, it all does work and I use less power.  So I did that.
It has now come back to bite me I expect.

I'll revert that, enable off mode properly, and see what happens.

Thanks,

NeilBrown


> 
> omap_gpio_runtime_resume(...)
> {
> ...
>         if (bank->get_context_loss_count) {
>                 context_lost_cnt_after =
>                         bank->get_context_loss_count(bank->dev);
>                 if (context_lost_cnt_after != bank->context_loss_count) {
>                         omap_gpio_restore_context(bank);
>                 } else {
>                         spin_unlock_irqrestore(&bank->lock, flags);
>                         return 0;
>                 }
>         }
> ...
> }
> --
> Tarun
> >
> > Thanks,
> > NeilBrown
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120615/50978419/attachment.sig>
