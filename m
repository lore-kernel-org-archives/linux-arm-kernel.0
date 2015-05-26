From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 26 May 2015 09:28:34 +0200
Subject: [PATCH v4 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <1432589362-23241-3-git-send-email-robert.jarzmik@free.fr>
References: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
 <1432589362-23241-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1432625314.27695.200.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod already applied this, so my remarks, if valid, should probably be
handled in a follow up patch.

On Mon, 2015-05-25 at 23:29 +0200, Robert Jarzmik wrote:
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
 
> +config PXA_DMA
> +	bool "PXA DMA support"
> +	depends on (ARCH_MMP || ARCH_PXA)
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support the DMA engine for PXA. It is also compatible with MMP PDMA
> +	  platform. The internal DMA IP of all PXA variants is supported, with
> +	  16 to 32 channels for peripheral to memory or memory to memory
> +	  transfers.

> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile

> +obj-$(CONFIG_PXA_DMA) += pxa_dma.o

> --- /dev/null
> +++ b/drivers/dma/pxa_dma.c

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(of, pxad_dt_ids);

> +module_platform_driver(pxad_driver);

(The series starting at https://lkml.org/lkml/2015/5/10/131 would allow
to use builtin_platform_driver() for built-in only code.)

> +MODULE_DESCRIPTION("Marvell PXA Peripheral DMA Driver");
> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
> +MODULE_LICENSE("GPL v2");

This patch added a bool Kconfig symbol. So pxa_dma.c will never be part
of a module. Its code contains a few module specific macros. Was it
actually intended for PXA_DMA to be tristate?


Paul Bolle
