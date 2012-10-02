From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 2 Oct 2012 15:55:05 +0200 (CEST)
Subject: [PATCH 1/2] mtd: sh_flctl: Add DMA capabilty
In-Reply-To: <1349183522-15321-2-git-send-email-hechtb@gmail.com>
References: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
 <1349183522-15321-2-git-send-email-hechtb@gmail.com>
Message-ID: <Pine.LNX.4.64.1210021534570.15778@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Oct 2012, Bastian Hecht wrote:

> The code probes if DMA channels can get allocated and tears them down at
> removal/failure if needed.
> If available it uses them to transfer the data part (not ECC). On
> failure we fall back to PIO mode.
> 
> Based on Guennadi Liakhovetski's code from the sh_mmcif driver.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Looks mostly good to me, just a couple of cosmetic remarks below. They are 
not critical, so, I won't be upset, if you fix them later:-) In any case

Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> ---
>  drivers/mtd/nand/sh_flctl.c  |  174 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/sh_flctl.h |   12 +++
>  2 files changed, 183 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> index 4fbfe96..0fead2a 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -24,10 +24,13 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/sh_dma.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> @@ -106,6 +109,84 @@ static void wait_completion(struct sh_flctl *flctl)
>  	writeb(0x0, FLTRCR(flctl));
>  }
>  
> +static void flctl_dma_complete(void *param)
> +{
> +	struct sh_flctl *flctl = param;
> +
> +	complete(&flctl->dma_complete);

I think I mentioned in the first review, that it is good to include 
headers everywhere, where they are needed and not rely on pulling them in 
via other headers. So, it would be good to also include complete.h here 
directly.

[snip]

> @@ -308,13 +462,23 @@ static enum flctl_ecc_res_t read_ecfiforeg
>  static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
>  {
>  	int i, len_4align;
> -	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
> +	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
>  	void *fifo_addr = (void *)FLDTFIFO(flctl);
>  
>  	len_4align = (rlen + 3) / 4;
> +
> +	for (i = 0; i < len_4align; i++)
> +			buf[i] = cpu_to_be32(buf[i]);

indentation ran away here.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
