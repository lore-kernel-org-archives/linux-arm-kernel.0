From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jan 2017 21:07:17 +0200
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <1484593637.2133.152.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 19:44 +0100, Jan Kiszka wrote:
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
> 

So, more comments/questions below.

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

Can we switch to do-while and move previous block here? Btw, can TINTE
bit be set again during a loop?

> +		/* Ignore possible writes if we don't need to write
> */
> +		if (!(sccr1_reg & SSCR1_TIE))
> +			mask &= ~SSSR_TFS;
> ?
> -	if (!drv_data->master->cur_msg) {
> -		handle_bad_msg(drv_data);
> -		/* Never fail */
> -		return IRQ_HANDLED;
> -	}
> +		if (!(status & mask))
> +			return ret;
> +
> +		if (!drv_data->master->cur_msg) {
> +			handle_bad_msg(drv_data);
> +			/* Never fail */
> +			return IRQ_HANDLED;
> +		}
> +

> +		ret |= drv_data->transfer_handler(drv_data);

So, we might call handler several times. This needs to be commented in
the code why you do so.

> ?
> -	return drv_data->transfer_handler(drv_data);
> +		status = pxa2xx_spi_read(drv_data, SSSR);

Would it be possible to get all 1:s from the register
(something/autosuspend just powered off it by timeout?) ?

> +		sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
> +	}
> ?}
> ?
> ?/*

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
