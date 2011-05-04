From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 4 May 2011 19:00:10 +0200
Subject: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
In-Reply-To: <BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
	<1304525161-14448-2-git-send-email-per.forlin@linaro.org>
	<BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
Message-ID: <BANLkTinptOJrpdwbLOF_Th-Jz9gKj5Y6dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/4 Micha? Miros?aw <mirqus@gmail.com>:
> 2011/5/4 Per Forlin <per.forlin@linaro.org>:
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> If there is only 1 function registered it is possible to
>> improve performance by directly calling the irq handler
>> and avoiding the overhead of reading the CCCR registers.
>>
> [...]
>> --- a/drivers/mmc/core/sdio_irq.c
>> +++ b/drivers/mmc/core/sdio_irq.c
>> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>> ? ? ? ?int i, ret, count;
>> ? ? ? ?unsigned char pending;
>>
>> + ? ? ? /*
>> + ? ? ? ?* Optimization, if there is only 1 function registered
>> + ? ? ? ?* call irq handler directly
>> + ? ? ? ?*/
>> + ? ? ? if (card->sdio_single_irq && card->sdio_single_irq->irq_handler) {
>> + ? ? ? ? ? ? ? struct sdio_func *func = card->sdio_single_irq;
>> + ? ? ? ? ? ? ? func->irq_handler(func);
>> + ? ? ? ? ? ? ? return 1;
>> + ? ? ? }
> [...]
>
> The second condition can be avoided:
>
> in process_sdio_pending_irqs():
>
> if (card->sdio_irq_func)
> ? call handler and return
>
I added the second condition as a sanity check. Same check is used in
the main for loop
>	ret = -EINVAL;
>			} else if (func->irq_handler) {
>				func->irq_handler(func);
Is the second check necessary here?

> in sdio_claim_irq():
>
> ?card->func->irq_handler = ...
> ?if (host->sdio_irqs == 1)
> ? ?card->sdio_irq_func = func;
> ?else
> ? ?card->sdio_irq_func = NULL;
I wanted to keep it simple and use same function in claim and release.
Your code looks nice.
Is if safe to not check the condition "(card->host->caps &
MMC_CAP_SDIO_IRQ)". What happens if the SDIO is in polling mode?

>
> in sdio_release_irq():
>
> ?card->sdio_irq_func = NULL;
> ?card->func->irq_handler = ...
> ?sdio_card_irq_put();
> ?if (host->sdio_irqs == 1)
> ? ?sdio_single_irq_set(func->card);
This works for me.

>
> in struct mmc_card:
> ?struct sdio_func ? ? ? ?*sdio_irq_func;
The name sdio_single_irq indicates it is only used for single irq.
"sdio_irq_func" is too generic I think. But the your name is shorter
and makes the indentation look nicer.
Not a big deal really.

I will wait until tomorrow to post patch v3. This will give time for
other to comment as well.

> Best Regards,
> Micha? Miros?aw
>
Thanks for your feedback,
Per
