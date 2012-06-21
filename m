From: neilb@suse.de (NeilBrown)
Date: Thu, 21 Jun 2012 13:16:16 +1000
Subject: [GIT PULL] gpio/omap: cleanups for v3.5
In-Reply-To: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
References: <874nrmtf47.fsf@ti.com> <20120614101541.39f50aee@notabene.brown>
 <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
Message-ID: <20120621131616.7ac6426f@notabene.brown>
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

Hi,
 I've looked more closely at this now.

The problem is that the initial context loss count is *not* zero.  Not always.
The context loss count is the sum of 

	count = pwrdm->state_counter[PWRDM_POWER_OFF];
	count += pwrdm->ret_logic_off_counter;

	for (i = 0; i < pwrdm->banks; i++)
		count += pwrdm->ret_mem_off_counter[i];

(from  pwrdm_get_context_loss_count()).

These are initlialised in _pwrdm_register

	/* Initialize the powerdomain's state counter */
	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
		pwrdm->state_counter[i] = 0;

	pwrdm->ret_logic_off_counter = 0;
	for (i = 0; i < pwrdm->banks; i++)
		pwrdm->ret_mem_off_counter[i] = 0;

	pwrdm_wait_transition(pwrdm);
	pwrdm->state = pwrdm_read_pwrst(pwrdm);
	pwrdm->state_counter[pwrdm->state] = 1;


What I'm seeing is that for wkup_pwrdm and dpll{3,4,5}_pwrdm,
the state that pwrdm_read_pwrst returns is PWRDM_POWER_OFF.
So that state_counter gets initialised to '1', and so the initial
context_loss_count, which includes that counter, is also '1'.
I think it is the wkup_pwrdm that covers the GPIOs that are causing problems
for me.

So either there is something seriously wrong with pwrdm_read_pwrst and it
shouldn't be reporting that the wkup_pwrdm is off, or we need to initialise
bank->context_loss_count like my patch does.

NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/1b8947b3/attachment-0001.sig>
