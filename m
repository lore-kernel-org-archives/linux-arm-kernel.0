From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 5 Jul 2013 09:16:30 +0200
Subject: [RFC PATCH 01/13] misc: atmel_ssc: add device tree DMA support
In-Reply-To: <51D62074.9070303@atmel.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
 <51D24299.9050209@atmel.com>
 <CACQ1gAgcc=j3kmcpjp8bbdHhxr_k=h8jJs6R_paJbPUMv74uGg@mail.gmail.com>
 <51D29927.80900@atmel.com>
 <CACQ1gAhnDk-qSt_5xrsMakXqGGDO5pEbA-9UDWCJG=AABDc+zg@mail.gmail.com>
 <CACQ1gAgPaRm3gxxJNgfj9bR565Q0+SNY3+EcjA_mrh1N+yPzSA@mail.gmail.com>
 <51D4CC94.3020908@atmel.com>
 <CACQ1gAio0ekQMgyfrLjTHmMPGJQoKoe61GreFQDN-iLjxbLQ0w@mail.gmail.com>
 <51D62074.9070303@atmel.com>
Message-ID: <CACQ1gAjNGsAWMwyL_9zEobKz=MEzgiA7Gqt=p4anuGhq2dLd_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/5 Bo Shen <voice.shen@atmel.com>:
> Yes, I aware this issue.
> Actually the system not hang, the resource all are occupied by the
> interrupt. This because, we enable the interrupt, when once interrupt occur,
> I try many methods to clear it, however we can not clear it. So, it
> generates the interrupt all the time. It seems the system hang.
>
> Temp solution: not enable the interrupt. use the following patch to disable
> the interrupt.
> ---8>---
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c
> b/sound/soc/atmel/atmel_ssc_dai.c
> index 0ecf356..bb53dea 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -649,7 +649,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream
> *substream,
>         dma_params = ssc_p->dma_params[dir];
>
>         ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
> -       ssc_writel(ssc_p->ssc->regs, IER, dma_params->mask->ssc_error);
> +       ssc_writel(ssc_p->ssc->regs, IDR, dma_params->mask->ssc_error);
>
>         pr_debug("%s enabled SSC_SR=0x%08x\n",
>                         dir ? "receive" : "transmit",
> ---<8---
>
> BTW, I am checking this with our IP team, if find the real solution, I will
> fix it.

ok, I'll rebase my patches on that.

Thanks !

Best Regards,
Richard
