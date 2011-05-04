From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 4 May 2011 13:40:56 -0400 (EDT)
Subject: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
In-Reply-To: <BANLkTinptOJrpdwbLOF_Th-Jz9gKj5Y6dQ@mail.gmail.com>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
	<1304525161-14448-2-git-send-email-per.forlin@linaro.org>
	<BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
	<BANLkTinptOJrpdwbLOF_Th-Jz9gKj5Y6dQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105041335570.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 May 2011, Per Forlin wrote:

> 2011/5/4 Micha? Miros?aw <mirqus@gmail.com>:
> > 2011/5/4 Per Forlin <per.forlin@linaro.org>:
> >> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> >>
> >> If there is only 1 function registered it is possible to
> >> improve performance by directly calling the irq handler
> >> and avoiding the overhead of reading the CCCR registers.
> >>
> > [...]
> >> --- a/drivers/mmc/core/sdio_irq.c
> >> +++ b/drivers/mmc/core/sdio_irq.c
> >> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
> >> ? ? ? ?int i, ret, count;
> >> ? ? ? ?unsigned char pending;
> >>
> >> + ? ? ? /*
> >> + ? ? ? ?* Optimization, if there is only 1 function registered
> >> + ? ? ? ?* call irq handler directly
> >> + ? ? ? ?*/
> >> + ? ? ? if (card->sdio_single_irq && card->sdio_single_irq->irq_handler) {
> >> + ? ? ? ? ? ? ? struct sdio_func *func = card->sdio_single_irq;
> >> + ? ? ? ? ? ? ? func->irq_handler(func);
> >> + ? ? ? ? ? ? ? return 1;
> >> + ? ? ? }
> > [...]
> >
> > The second condition can be avoided:
> >
> > in process_sdio_pending_irqs():
> >
> > if (card->sdio_irq_func)
> > ? call handler and return
> >
> I added the second condition as a sanity check. Same check is used in
> the main for loop
> >	ret = -EINVAL;
> >			} else if (func->irq_handler) {
> >				func->irq_handler(func);
> Is the second check necessary here?

Yes because we want to be notified if the hardware returns pending 
interrupt flags for interrupts we didn't claim.

> > in sdio_claim_irq():
> >
> > ?card->func->irq_handler = ...
> > ?if (host->sdio_irqs == 1)
> > ? ?card->sdio_irq_func = func;
> > ?else
> > ? ?card->sdio_irq_func = NULL;
> I wanted to keep it simple and use same function in claim and release.
> Your code looks nice.
> Is if safe to not check the condition "(card->host->caps &
> MMC_CAP_SDIO_IRQ)". What happens if the SDIO is in polling mode?

You cannot avoid checking MMC_CAP_SDIO_IRQ.  If it isn't set the CCCr 
register must be polled in all cases.


Nicolas
