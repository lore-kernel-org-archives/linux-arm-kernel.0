From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 17:02:52 +0200
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <4FFC367A.8020100@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com>
Message-ID: <201207101702.52632.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lauri Hintsala,

[...]

> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int irq,
> void *dev_id)
>   	writel(stat & MXS_MMC_IRQ_BITS,
>   	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> 
> +	spin_unlock(&host->lock);
> +
>   	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>   		mmc_signal_sdio_irq(host->mmc);
> 
> -	spin_unlock(&host->lock);
> -

Spinlock in irq handler is interesting too ;-)

>   	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>   		cmd->error = -ETIMEDOUT;
>   	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
> 
> 
> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
> acquire lock while it is already acquired.
> 
> 
> Best regards,
> Lauri Hintsala

Best regards,
Marek Vasut
