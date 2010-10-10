From: premi@ti.com (Premi, Sanjeev)
Date: Mon, 11 Oct 2010 01:47:56 +0530
Subject: [PATCH 2/3] omap: dsp: fix ioremap() usage
In-Reply-To: <1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302342AE533@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Felipe 
> Contreras
> Sent: Sunday, October 10, 2010 11:11 PM
> To: linux-arm; linux-omap; Greg KH
> Cc: Ramirez Luna, Omar; Russell King; Felipe Contreras
> Subject: [PATCH 2/3] omap: dsp: fix ioremap() usage
> 
> On commit 309caa9 doing ioremap() became forbidden due tue 
> architectural
> limitations. Only a single mapping is allowed now, so the mempool must
> not be part of the memory managed by the kernel.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/plat-omap/common.c              |   43 
> +++++++++++++++++++++++++++--
>  arch/arm/plat-omap/devices.c             |   30 ---------------------
>  arch/arm/plat-omap/include/plat/common.h |    3 +-
>  arch/arm/plat-omap/include/plat/dsp.h    |    6 ----
>  4 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 57205a4..3fee3ca 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -37,7 +37,6 @@
>  #include <plat/fpga.h>
>  #include <plat/serial.h>
>  #include <plat/vram.h>
> -#include <plat/dsp.h>
>  
>  #include <plat/clock.h>
>  
> @@ -84,11 +83,49 @@ const void *omap_get_var_config(u16 tag, 
> size_t *len)
>  }
>  EXPORT_SYMBOL(omap_get_var_config);
>  
> -void __init omap_reserve(void)
> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)

[sp] I do understand that dspbridge is the only driver accessing dsp in
     the linux-omap; but there are other known drivers - which would need
     this feature.

     Can we use a more generic config option viz. CONFIG_RESERVE_DSPMEM
     (or something similar) so that code is easily (re)usable.

~sanjeev

[snip]...[snip]
> +
> 
