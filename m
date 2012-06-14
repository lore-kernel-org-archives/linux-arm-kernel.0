From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 14 Jun 2012 23:24:10 +0530
Subject: [GIT PULL] gpio/omap: cleanups for v3.5
In-Reply-To: <20120614101541.39f50aee@notabene.brown>
References: <874nrmtf47.fsf@ti.com>
	<20120614101541.39f50aee@notabene.brown>
Message-ID: <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
> On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:
>
>> Hi Grant,
>>
>> Here's the final round of GPIO cleanups for v3.5. ?This branch is based
>> on my for_3.5/fixes/gpio branch you just pulled.
>>
>> Kevin
>
> Hi.
>
> ?I'm not sure if it was this series or the following cleanups which broke
> ?things for me, but I've been trying 3.5-rc2 on my GTA04 and the serial
> ?console (ttyO2) dies as soon as the omap-gpio driver initialises.
>
> ?After some digging I came up with this patch to gpio-omap.c
>
> @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>
> ? ? ? ?platform_set_drvdata(pdev, bank);
>
> + ? ? ? if (bank->get_context_loss_count)
> + ? ? ? ? ? ? ? bank->context_loss_count =
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->get_context_loss_count(bank->dev);
> ? ? ? ?pm_runtime_enable(bank->dev);
> ? ? ? ?pm_runtime_irq_safe(bank->dev);
> ? ? ? ?pm_runtime_get_sync(bank->dev);
>
> which fixes it.
>
> What was happening ?was that when omap_gpio_probe calls pm_runtime_get_sync,
> it calls
> ?_od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime_resume
> ?-> omap_gpio_restore_context
>
> and then the serial port stops.
> I reasoned that the context probably hadn't been set up yet, so restoring
> from it broke things.
> Initialising bank->context_loss_count seems sensible and would ensure that
> we didn't try to restore the context until it has actually been lost.

I thought the following code exactly does that. That is context_lost_cnt_after
would be zero until there is context loss. The bank->context_loss_count is zero
at the beginning. So, (context_lost_cnt_after != bank->context_loss_count) would
be false and hence context restore should NOT happen? Not sure if I am
over looking
anything here....

omap_gpio_runtime_resume(...)
{
...
        if (bank->get_context_loss_count) {
                context_lost_cnt_after =
                        bank->get_context_loss_count(bank->dev);
                if (context_lost_cnt_after != bank->context_loss_count) {
                        omap_gpio_restore_context(bank);
                } else {
                        spin_unlock_irqrestore(&bank->lock, flags);
                        return 0;
                }
        }
...
}
--
Tarun
>
> Thanks,
> NeilBrown
