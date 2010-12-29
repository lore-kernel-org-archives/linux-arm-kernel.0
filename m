From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 12:22:08 +0100
Subject: [PATCH 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <1293548155-16328-9-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-9-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101229112208.GB14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Dec 28, 2010 at 10:55:53PM +0800, Shawn Guo wrote:
> diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> new file mode 100644
> index 0000000..24457d7
> --- /dev/null
> +++ b/arch/arm/mach-mxs/ocotp.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +
> +#include <mach/mxs.h>
> +
> +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> +
> +int mxs_read_ocotp(int offset, int count, u32 *values)
> +{
> +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> +	int i, timeout = 0x400;
> +
> +	/* open OCOTP banks for read */
> +	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
The reference manual specifies:
	1. Program the HCLK to a frequency up to the maximum allowable HCLK
	   frequency. [...]
	2. Check that HW_OCOTP_CTRL_BUSY and HW_OCOTP_CTRL_ERROR are clear.
	3. Set HW_OCOTP_CTRL_RD_BANK_OPEN. [...]

1. isn't done (which is probably OK, or should it aquire a clk?)
For 2. there is no check for HW_OCOTP_CTRL_ERROR which is not OK i
guess?!

(Independant of that, shouldn't the list use BM_ prefixes as you did in
the code?)

> +
> +	/* approximately wait 32 hclk cycles */
> +	udelay(1);
> +
> +	/* poll BUSY bit becoming cleared */
> +	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
> +		/* nothing */;
> +
> +	if (unlikely(!timeout))
> +		goto error;
And I think you should recheck for BM_OCOTP_CTRL_RD_BANK_OPEN here (step
4 from the reference manual).

> +
> +	for (i = 0; i < count; i++, offset += 4)
> +		*values++ = __raw_readl(ocotp_base + offset);
> +
> +	/* close banks for power saving */
> +	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> +
> +	return 0;
> +
> +error:
> +	pr_err("%s: timeout in reading OCOTP\n", __func__);
> +	return -ETIMEDOUT;
> +}
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
