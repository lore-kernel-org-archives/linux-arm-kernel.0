From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Mar 2012 17:28:50 -0600
Subject: [PATCH 3/9] dmaengine: add private header file
In-Reply-To: <E1S4eK0-0000sv-87@rmk-PC.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <E1S4eK0-0000sv-87@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555A9@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 05, 2012 1:16 PM, Russell King wrote:
>
> Add a local private header file to contain definitions and declarations
> which should only be used by DMA engine drivers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/amba-pl08x.c    |    2 ++
>  drivers/dma/at_hdmac.c      |    1 +
>  drivers/dma/coh901318.c     |    1 +
>  drivers/dma/dmaengine.h     |   10 ++++++++++
>  drivers/dma/dw_dmac.c       |    1 +
>  drivers/dma/ep93xx_dma.c    |    2 ++
>  drivers/dma/fsldma.c        |    1 +
>  drivers/dma/imx-dma.c       |    2 ++
>  drivers/dma/imx-sdma.c      |    2 ++
>  drivers/dma/intel_mid_dma.c |    2 ++
>  drivers/dma/ioat/dma.c      |    2 ++
>  drivers/dma/ioat/dma_v2.c   |    2 ++
>  drivers/dma/iop-adma.c      |    2 ++
>  drivers/dma/ipu/ipu_idmac.c |    1 +
>  drivers/dma/mpc512x_dma.c   |    2 ++
>  drivers/dma/mv_xor.c        |    2 ++
>  drivers/dma/mxs-dma.c       |    2 ++
>  drivers/dma/pch_dma.c       |    2 ++
>  drivers/dma/pl330.c         |    2 ++
>  drivers/dma/ppc4xx/adma.c   |    1 +
>  drivers/dma/shdma.c         |    2 ++
>  drivers/dma/ste_dma40.c     |    1 +
>  drivers/dma/timb_dma.c      |    2 ++
>  drivers/dma/txx9dmac.c      |    2 ++
>  24 files changed, 49 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/dmaengine.h
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 2b5121f..87475cb 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -85,6 +85,8 @@
>  #include <linux/slab.h>
>  #include <asm/hardware/pl080.h>
>  
> +#include "dmaengine.h"
> +
>  #define DRIVER_NAME	"pl08xdmac"
>  
>  static struct amba_driver pl08x_amba_driver;
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 6baf5d7..ce26ba3 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_device.h>
>  
>  #include "at_hdmac_regs.h"
> +#include "dmaengine.h"
>  
>  /*
>   * Glossary
> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> index 521434b..fb0d124 100644
> --- a/drivers/dma/coh901318.c
> +++ b/drivers/dma/coh901318.c
> @@ -24,6 +24,7 @@
>  #include <mach/coh901318.h>
>  
>  #include "coh901318_lli.h"
> +#include "dmaengine.h"
>  
>  #define COHC_2_DEV(cohc) (&cohc->chan.dev->device)
>  
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> new file mode 100644
> index 0000000..968570d
> --- /dev/null
> +++ b/drivers/dma/dmaengine.h
> @@ -0,0 +1,10 @@
> +/*
> + * The contents of this file are private to DMA engine drivers, and is not
> + * part of the API to be used by DMA engine users.
> + */
> +#ifndef DMAENGINE_H
> +#define DMAENGINE_H
> +
> +#include <linux/dmaengine.h>
> +
> +#endif

Russell,

You have an include issue here.

All the dmaengine drivers have:

#include <linux/dmaengine.h>

Which is guarded with

#ifndef DMAENGINE_H
#define DMAENGINE_H

...

#endif

This is the same guard you are using in the private "dmaengine.h". And it
also includes <linux/dmaengine.h> again...

This doesn't compile as-is because the "dmaengine.h" file is not used due
to the #ifndef...

Regards,
Hartley
