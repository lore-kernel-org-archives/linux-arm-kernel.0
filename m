From: attila@kinali.ch (Attila Kinali)
Date: Tue, 17 Jul 2012 15:39:01 +0200
Subject: [PATCH 05/10] mmc: spi: Pull out the SSP clock configuration
 function
In-Reply-To: <1342440597-8395-6-git-send-email-marex@denx.de>
References: <1342440597-8395-1-git-send-email-marex@denx.de>
 <1342440597-8395-6-git-send-email-marex@denx.de>
Message-ID: <20120717153901.5530a246a7a5fecfef03b373@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2012 14:09:52 +0200
Marek Vasut <marex@denx.de> wrote:

> Pull out the MMC clock configuration function and make it
> into SSP clock configuration function, so it can be used by
> the SPI driver too.

> diff --git a/drivers/clk/mxs/clk-ssp.c b/drivers/clk/mxs/clk-ssp.c
> new file mode 100644
> index 0000000..b3c1e16
> --- /dev/null
> +++ b/drivers/clk/mxs/clk-ssp.c
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright 2012 DENX Software Engineering, GmbH
> + *
> + * Pulled from code:
> + * Portions copyright (C) 2003 Russell King, PXA MMCI Driver
> + * Portions copyright (C) 2004-2005 Pierre Ossman, W83L51xD SD/MMC driver
> + *
> + * Copyright 2008 Embedded Alley Solutions, Inc.
> + * Copyright 2009-2011 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/spi/mxs-spi.h>
> +
> +void mxs_ssp_set_clk_rate(struct mxs_ssp *ssp, unsigned int rate)
> +{
> +	unsigned int ssp_clk, ssp_sck;
> +	u32 clock_divide, clock_rate;
> +	u32 val;
> +
> +	ssp_clk = clk_get_rate(ssp->clk);
> +
> +	for (clock_divide = 2; clock_divide <= 254; clock_divide += 2) {
> +		clock_rate = DIV_ROUND_UP(ssp_clk, rate * clock_divide);
> +		clock_rate = (clock_rate > 0) ? clock_rate - 1 : 0;
> +		if (clock_rate <= 255)
> +			break;
> +	}
> +
> +	if (clock_divide > 254) {
> +		dev_err(ssp->dev,
> +			"%s: cannot set clock to %d\n", __func__, rate);
> +		return;
> +	}
> +
> +	ssp_sck = ssp_clk / clock_divide / (1 + clock_rate);
> +
> +	val = readl(ssp->base + HW_SSP_TIMING(ssp));
> +	val &= ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
> +	val |= BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
> +	val |= BF_SSP(clock_rate, TIMING_CLOCK_RATE);
> +	writel(val, ssp->base + HW_SSP_TIMING(ssp));
> +
> +	ssp->clk_rate = ssp_sck;
> +
> +	dev_dbg(ssp->dev,
> +		"%s: clock_divide %d, clock_rate %d, ssp_clk %d, rate_actual %d, rate_requested %d\n",
> +		__func__, clock_divide, clock_rate, ssp_clk, ssp_sck, rate);
> +}

There is a EXPORT_SYMBOL_GPL(mxs_ssp_set_clk_rate); missing here.

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
