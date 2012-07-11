From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 14:06:09 +0800
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <4FFC367A.8020100@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com>
Message-ID: <20120711060607.GE14060@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 05:04:42PM +0300, Lauri Hintsala wrote:
> Hi,
> 
> I was able to get deadlock with CONFIG_DEBUG_SPINLOCK enabled. I
> added also CONFIG_PROVE_LOCKING to get more verbose output. I got
> following error message after SDIO device has been powered.
> 
> I'm able to replicate issue with Linux next-20120710. Platform is imx28.
> 
The bug is there probably because the driver hasn't been widely tested
on SDIO card.

> I found a way to fix this issue:
> 
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int
> irq, void *dev_id)
>  	writel(stat & MXS_MMC_IRQ_BITS,
>  	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> 
> +	spin_unlock(&host->lock);
> +
>  	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>  		mmc_signal_sdio_irq(host->mmc);
> 
> -	spin_unlock(&host->lock);
> -
>  	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>  		cmd->error = -ETIMEDOUT;
>  	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
> 
> 
> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
> acquire lock while it is already acquired.
> 
The fix looks right to me.  You can have my ack when you send a patch
for it.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
