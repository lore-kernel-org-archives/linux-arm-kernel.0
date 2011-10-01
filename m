From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:12:48 +0100
Subject: [PATCH 4/4] mmc: mmci: Fix incorrect handling of HW flow
	control for SDIO
In-Reply-To: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
References: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111001161248.GG11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 09:46:56AM +0200, Ulf Hansson wrote:
>  	/* The ST Micro variants has a special bit to enable SDIO */
>  	if (variant->sdio && host->mmc->card)
> -		if (mmc_card_sdio(host->mmc->card))
> +		if (mmc_card_sdio(host->mmc->card)) {
> +			/*
> +			 * The ST Micro variants has a special bit
> +			 * to enable SDIO.
> +			 */
>  			datactrl |= MCI_ST_DPSM_SDIOEN;
>  
> +			/*
> +			 * The ST Micro variant for SDIO transfer sizes
> +			 * less then or equal to 8 bytes needs to have clock
> +			 * H/W flow control disabled. Since flow control is
> +			 * not really needed for anything that fits in the
> +			 * FIFO, we can disable it for any write smaller
> +			 * than the FIFO size.
> +			 */
> +			if ((host->size <= variant->fifosize) &&
> +			    (data->flags & MMC_DATA_WRITE))
> +				writel(readl(host->base + MMCICLOCK) &
> +				       ~variant->clkreg_enable,
> +				       host->base + MMCICLOCK);
> +			else
> +				writel(readl(host->base + MMCICLOCK) |
> +				       variant->clkreg_enable,
> +				       host->base + MMCICLOCK);
> +		}

Shouldn't this also re-enable the ST hardware flow control for non-SDIO
cards?
