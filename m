From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jan 2017 11:24:50 +0200
Subject: [PATCH 1/2] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <6fe26505e67790b27eed28fd7451b51e70b7e8ba.1484557560.git.jan.kiszka@siemens.com>
References: <cover.1484557560.git.jan.kiszka@siemens.com>
 <6fe26505e67790b27eed28fd7451b51e70b7e8ba.1484557560.git.jan.kiszka@siemens.com>
Message-ID: <1484558690.2133.132.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 10:05 +0100, Jan Kiszka wrote:
> When using the a device with edge-triggered interrupts, such as MSIs,
> the interrupt handler has to ensure that there is a point in time
> during
> its execution where all interrupts sources are silent so that a new
> event can trigger a new interrupt again.
> 
> This is achieved here by looping over SSSR evaluation. We need to take
> into account that SSCR1 may be changed by the transfer handler, thus
> we
> need to redo the mask calculation, at least regarding the volatile
> interrupt enable bit (TIE).

Could you split this to two patches, one just move the code under
question to a helper function (no functional change), the other does
what you state in commit message here?

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> ?drivers/spi/spi-pxa2xx.c | 50 +++++++++++++++++++++++++++----------
> -----------
> ?1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index dd7b5b4..24bf549 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -737,6 +737,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
> ?	struct driver_data *drv_data = dev_id;
> ?	u32 sccr1_reg;
> ?	u32 mask = drv_data->mask_sr;
> +	irqreturn_t ret = IRQ_NONE;
> ?	u32 status;
> ?
> ?	/*
> @@ -760,37 +761,42 @@ static irqreturn_t ssp_int(int irq, void
> *dev_id)
> ?
> ?	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
> ?
> -	/* Ignore possible writes if we don't need to write */
> -	if (!(sccr1_reg & SSCR1_TIE))
> -		mask &= ~SSSR_TFS;
> -
> ?	/* Ignore RX timeout interrupt if it is disabled */
> ?	if (!(sccr1_reg & SSCR1_TINTE))
> ?		mask &= ~SSSR_TINT;
> ?
> -	if (!(status & mask))
> -		return IRQ_NONE;
> +	while (1) {
> +		/* Ignore possible writes if we don't need to write
> */
> +		if (!(sccr1_reg & SSCR1_TIE))
> +			mask &= ~SSSR_TFS;
> ?
> -	if (!drv_data->master->cur_msg) {
> +		if (!(status & mask))
> +			return ret;
> ?
> -		pxa2xx_spi_write(drv_data, SSCR0,
> -				?pxa2xx_spi_read(drv_data, SSCR0)
> -				?& ~SSCR0_SSE);
> -		pxa2xx_spi_write(drv_data, SSCR1,
> -				?pxa2xx_spi_read(drv_data, SSCR1)
> -				?& ~drv_data->int_cr1);
> -		if (!pxa25x_ssp_comp(drv_data))
> -			pxa2xx_spi_write(drv_data, SSTO, 0);
> -		write_SSSR_CS(drv_data, drv_data->clear_sr);
> +		if (!drv_data->master->cur_msg) {
> ?
> -		dev_err(&drv_data->pdev->dev,
> -			"bad message state in interrupt handler\n");
> +			pxa2xx_spi_write(drv_data, SSCR0,
> +					?pxa2xx_spi_read(drv_data,
> SSCR0)
> +					?& ~SSCR0_SSE);
> +			pxa2xx_spi_write(drv_data, SSCR1,
> +					?pxa2xx_spi_read(drv_data,
> SSCR1)
> +					?& ~drv_data->int_cr1);
> +			if (!pxa25x_ssp_comp(drv_data))
> +				pxa2xx_spi_write(drv_data, SSTO, 0);
> +			write_SSSR_CS(drv_data, drv_data->clear_sr);
> ?
> -		/* Never fail */
> -		return IRQ_HANDLED;
> -	}
> +			dev_err(&drv_data->pdev->dev,
> +				"bad message state in interrupt
> handler\n");
> ?
> -	return drv_data->transfer_handler(drv_data);
> +			/* Never fail */
> +			return IRQ_HANDLED;
> +		}
> +
> +		ret |= drv_data->transfer_handler(drv_data);
> +
> +		status = pxa2xx_spi_read(drv_data, SSSR);
> +		sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
> +	}
> ?}
> ?
> ?/*

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
