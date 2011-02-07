From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 7 Feb 2011 15:31:04 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <19792.552.77000.702221@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> including apbh-dma and apbx-dma.
> 
> * apbh-dma and apbx-dma are supported in the driver as two instances,
>   and have to be filtered by dma clients via device id.  It becomes
>   the convention that apbh-dma always gets registered prior to
>   apbx-dma.
> 
> * apbh-dma is different between mx23 and mx28, hardware version
>   register is used to handle the differences.
> 
> * Every the mxs dma channel is statically assigned to client device
>   by soc design with fixed irq.  The irq number is being passed by
>   alloc_chan function with mxs_dma_data, and client driver has to
>   filter the correct channel by its channel id.
> 
> * mxs-dma supports pio function besides data transfer.  The driver
>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>   steals sgl and sg_len to get pio words and numbers from clients.
> 
> * mxs dmaengine has some very specific features, like sense function
>   and the special NAND support (nand_lock, nand_wait4ready).  These
>   are too specific to implemented in generic dmaengine driver.
> 
> * The parameter "flags" of prep functions is currently being used to
>   pass wait4end flag from clients.
> 
> * The driver refers to imx-sdma and only a single descriptor is
>   statically assigned to each channel.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/dma.h |   16 +
>  drivers/dma/Kconfig                  |    8 +
>  drivers/dma/Makefile                 |    1 +
>  drivers/dma/mxs-dma.c                |  702 ++++++++++++++++++++++++++++++++++
>  4 files changed, 727 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
>  create mode 100644 drivers/dma/mxs-dma.c
> 
> diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
> new file mode 100644
> index 0000000..429f431
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/dma.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MACH_MXS_DMA_H__
> +#define __MACH_MXS_DMA_H__
> +
> +struct mxs_dma_data {
> +	int chan_irq;
> +};
>
There is a name clash of this structure with the name of a different
structure defined in arch/arm/mach-mxs/include/mach/devices-common.h
(your patch 3/5):
|diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
|index e7aefb4..acd74b4 100644
|--- a/arch/arm/mach-mxs/include/mach/devices-common.h
|+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
|@@ -40,6 +40,13 @@ struct mxs_auart_data {
| struct platform_device *__init mxs_add_auart(
| 		const struct mxs_auart_data *data);
| 
|+/* dma */
|+struct mxs_dma_data {
|+	const char *devid;
|+	resource_size_t iobase;
|+};
|+struct platform_device *__init mxs_add_dma(const struct mxs_dma_data *data);


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
