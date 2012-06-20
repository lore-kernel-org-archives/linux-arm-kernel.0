From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Wed, 20 Jun 2012 11:13:07 +0200
Subject: Fwd: Re: [PATCH]  mmc: at91: fix bus speed
In-Reply-To: <4FE18E84.9000603@atmel.com>
References: <4FE18E84.9000603@atmel.com>
Message-ID: <4FE19423.4010103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mmc mailing list.


-------- Message original --------
Sujet: Re: [PATCH]  mmc: at91: fix bus speed
Date : Wed, 20 Jun 2012 10:49:08 +0200
De : ludovic.desroches <ludovic.desroches@atmel.com>
Pour : Prchal Ji?? <jiri.prchal@aksignal.cz>
Copie ? : <ludovic.desroches@atmel.com>, 
<linux-arm-kernel@lists.infradead.org>

Hello Jiri,

Thanks for your patch but at91-mci is now deprecated and should be
removed in 3.7.
On one hand I don't know if we have to continue to take patches for this
driver, on the other hand it's a fix for some SD cards.

Le 06/20/2012 10:15 AM, Prchal Ji?? a ?crit :
> This patch change minimum and maximum clock speed because some noname
> cards doesn't work during init even at 375kHz and new cards (SD v. 3.0)
> can run at 50 or 100 MHz.
> Also aded clkdiv register overrun fix when setting low speeds.
>
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>
> --- linux/linux-3.5-rc3/drivers/mmc/host/at91_mci.c.orig    2012-06-17
> 02:25:17.000000000 +0200
> +++ linux/linux-3.5-rc3/drivers/mmc/host/at91_mci.c    2012-06-18
> 11:01:49.751415984 +0200
> @@ -724,6 +724,10 @@ static void at91_mci_set_ios(struct mmc_
>           else
>               clkdiv = (at91_master_clock / ios->clock) / 2;
>
> +        /* set maximum divider */
> +        if (clkdiv > 255)
> +            clkdiv = 255;
> +
>           pr_debug("clkdiv = %d. mcck = %ld\n", clkdiv,
>               at91_master_clock / (2 * (clkdiv + 1)));
>       }
> @@ -948,8 +952,8 @@ static int __init at91_mci_probe(struct
>       }
>
>       mmc->ops = &at91_mci_ops;
> -    mmc->f_min = 375000;
> -    mmc->f_max = 25000000;
> +    mmc->f_min = 200000; /* not all cards can run at 375kHz */

I will check on atmel-mci if we have to decrease f_min.

> +    mmc->f_max = 100000000; /* new cards can run at 100MHz */

MCI operates at a rate of up to master clock divided by two so you can't
reach 100MHz as max frequency since it means that our master clock is at
200MHz that is not the case. I would say 50MHz is the maximum frequency
for product compatible with at91-mci.

>       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>       mmc->caps = 0;
>
>
>

Regards

Ludovic
