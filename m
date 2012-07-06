From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Jul 2012 18:51:21 +0100
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <20120706173957.GA10202@core.coreip.homeip.net>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org>
 <20120706173957.GA10202@core.coreip.homeip.net>
Message-ID: <CAF2Aj3h7t5J0cJad11vsybg8bGbnz2SSoKdcpzGNXcLkzxT4OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So I am. Great spot Dmitry.

I'll fix and resubmit next week.

Sent from my mobile Linux device.
On Jul 6, 2012 6:40 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Hi Lee,
>
> On Fri, Jul 06, 2012 at 08:52:43AM +0100, Lee Jones wrote:
> > Sorry Dmitry, looks like I missed you off of the CC list on this one.
> >
> > Here it is again:
> >
> > Before we can use any domain allocated IRQ, we need to first create a
> > map between the Hardware IRQ (hwirq) and the Linux Virtual IRQ (virq).
> > We do this with a helper function provided by the AB8500 IRQ domain
> > controller called ab8500_irq_get_virq(). We need to do this for both
> > IRQs which the Power-On-Key driver uses; one for button press, the other
> > for button depress.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > drivers/input/misc/ab8500-ponkey.c |    2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/misc/ab8500-ponkey.c
> b/drivers/input/misc/ab8500-ponkey.c
> > index 5ceb23e..ae4b683 100644
> > --- a/drivers/input/misc/ab8500-ponkey.c
> > +++ b/drivers/input/misc/ab8500-ponkey.c
> > @@ -82,6 +82,7 @@ static int __devinit ab8500_ponkey_probe(struct
> platform_device *pdev)
> >       input_set_capability(input, EV_KEY, KEY_POWER);
> > +     ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, ponkey->irq_dbf);
> >       error = request_any_context_irq(ponkey->irq_dbf,
> ab8500_ponkey_handler,
> >                                       0, "ab8500-ponkey-dbf", ponkey);
> >       if (error < 0) {
> > @@ -90,6 +91,7 @@ static int __devinit ab8500_ponkey_probe(struct
> platform_device *pdev)
> >               goto err_free_mem;
> >       }
> > +     ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, ponkey->irq_dbr);
>
> I do not think this is right - you are storing irq_dbr in irq_dbf. Also,
> I think you want to do this earlier, like this:
>
> -       ponkey->irq_dbf = irq_dbf;
> -       ponkey->irq_dbr = irq_dbr;
> +       ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
> +       ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
>
> Thanks.
>
> --
> Dmitry
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120706/7dcf77ff/attachment-0001.html>
