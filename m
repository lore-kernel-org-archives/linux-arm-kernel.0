From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 May 2011 20:38:41 -0500
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764D331A4B2@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011 10:03 AM, Mika Westerberg wrote:
>
> The ep93xx DMA controller has 10 independent memory to peripheral (M2P)
> channels, and 2 dedicated memory to memory (M2M) channels. M2M channels can
> also be used by SPI and IDE to perform DMA transfers to/from their memory
> mapped FIFOs.
>
> This driver supports both M2P and M2M channels with DMA_SLAVE, DMA_CYCLIC and
> DMA_MEMCPY (M2M only) capabilities.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/dma.h |   87 ++
>  drivers/dma/Kconfig                     |    7 +
>  drivers/dma/Makefile                    |    1 +
>  drivers/dma/ep93xx_dma.c                | 1356 +++++++++++++++++++++++++++++++
>  4 files changed, 1451 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/ep93xx_dma.c
>

[snip]

> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index a572600..614ce7b 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -235,6 +235,13 @@ config MXS_DMA
>  	  Support the MXS DMA engine. This engine including APBH-DMA
>  	  and APBX-DMA is integrated into Freescale i.MX23/28 chips.
>  
> +config EP93XX_DMA
> +	bool "Cirrus Logic EP93xx DMA support"
> +	depends on ARCH_EP93XX
> +	select DMA_ENGINE
> +	help
> +	  Enable support for the Cirrus Logic EP93xx M2P/M2M DMA controller.
> +
>  config DMA_ENGINE
>  	bool

The old dma-m2p support was always builtin.  Should ARCH_EP93XX select
EP93XX_DMA to keep this, or should it be added to the ep93xx_defconfig?
Ryan, what do you think?

[snip]

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> new file mode 100644
> index 0000000..7898e8c
> --- /dev/null
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -0,0 +1,1356 @@
> +/*
> + * Driver for the Cirrus Logic EP93xx DMA Controller
> + *
> + * Copyright (C) 2011 Mika Westerberg
> + *
> + * DMA M2P implementation is based on the original
> + * arch/arm/mach-ep93xx/dma-m2p.c which has following copyrights:
> + *
> + *   Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + *   Copyright (C) 2006 Applied Data Systems
> + *   Copyright (C) 2009 Ryan Mallon <ryan@bluewatersys.com>
> + *
> + * This driver is based on dw_dmac and amba-pl08x drivers.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
> +#include <linux/moduleparam.h>

Unnecessary header.

The reset looks fine to me.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
