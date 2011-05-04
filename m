From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 4 May 2011 18:23:38 +0200
Subject: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
In-Reply-To: <1304525161-14448-2-git-send-email-per.forlin@linaro.org>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
	<1304525161-14448-2-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/4 Per Forlin <per.forlin@linaro.org>:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> If there is only 1 function registered it is possible to
> improve performance by directly calling the irq handler
> and avoiding the overhead of reading the CCCR registers.
>
[...]
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
> ? ? ? ?int i, ret, count;
> ? ? ? ?unsigned char pending;
>
> + ? ? ? /*
> + ? ? ? ?* Optimization, if there is only 1 function registered
> + ? ? ? ?* call irq handler directly
> + ? ? ? ?*/
> + ? ? ? if (card->sdio_single_irq && card->sdio_single_irq->irq_handler) {
> + ? ? ? ? ? ? ? struct sdio_func *func = card->sdio_single_irq;
> + ? ? ? ? ? ? ? func->irq_handler(func);
> + ? ? ? ? ? ? ? return 1;
> + ? ? ? }
[...]

The second condition can be avoided:

in process_sdio_pending_irqs():

if (card->sdio_irq_func)
   call handler and return

in sdio_claim_irq():

  card->func->irq_handler = ...
  if (host->sdio_irqs == 1)
    card->sdio_irq_func = func;
  else
    card->sdio_irq_func = NULL;

in sdio_release_irq():

  card->sdio_irq_func = NULL;
  card->func->irq_handler = ...
  sdio_card_irq_put();
  if (host->sdio_irqs == 1)
    sdio_single_irq_set(func->card);

in struct mmc_card:
  struct sdio_func ? ? ? ?*sdio_irq_func;

Best Regards,
Micha? Miros?aw
