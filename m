From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 5 Jan 2011 16:16:46 +0000
Subject: [PATCH v3 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <1294236457-17476-9-git-send-email-shawn.guo@freescale.com>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-9-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110105161235.GA2112@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Jan 05, 2011 at 10:07:35PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Add mutex locking for mxs_read_ocotp()
>  - Use type size_t for count and i
>  - Add comment for clk_enable/disable skipping
>  - Add ERROR bit clearing and polling step
> 
>  arch/arm/mach-mxs/Makefile              |    2 +-
>  arch/arm/mach-mxs/include/mach/common.h |    1 +
>  arch/arm/mach-mxs/ocotp.c               |   79 +++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/ocotp.c
> 
[...]
> diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> new file mode 100644
> index 0000000..902ef59
> --- /dev/null
> +++ b/arch/arm/mach-mxs/ocotp.c
> @@ -0,0 +1,79 @@
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
> +#include <linux/mutex.h>
> +
> +#include <mach/mxs.h>
> +
> +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> +#define BM_OCOTP_CTRL_ERROR		(1 << 9)
> +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> +
> +static DEFINE_MUTEX(ocotp_mutex);
> +
> +int mxs_read_ocotp(unsigned offset, size_t count, u32 *values)
> +{
> +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> +	int timeout = 0x400;
> +	size_t i;
> +
> +	mutex_lock(&ocotp_mutex);
> +
> +	/*
> +	 * clk_enable(hbus_clk) for ocotp can be skipped
> +	 * as it must be on when system is running.
> +	 */
> +
> +	/* try to clear ERROR bit */
> +	__mxs_clrl(BM_OCOTP_CTRL_ERROR, ocotp_base);
> +
> +	/* check both BUSY and ERROR cleared */
> +	while ((__raw_readl(ocotp_base) &
> +		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
> +		/* nothing */;

Is it worth using cpu_relax() in these polling loops?

Jamie
