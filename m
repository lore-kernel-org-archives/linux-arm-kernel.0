From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 27 Nov 2011 22:02:32 +0100 (CET)
Subject: [PATCH 20/62] mmc: remove the second argument of k[un]map_atomic()
In-Reply-To: <1322371662-26166-21-git-send-email-amwang@redhat.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-21-git-send-email-amwang@redhat.com>
Message-ID: <Pine.LNX.4.64.1111272159520.8317@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cong Wang

Thanks for the patch, one small comment though:

On Sun, 27 Nov 2011, Cong Wang wrote:

> 
> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 ++++----
>  drivers/mmc/host/msm_sdcc.c |    6 +++---
>  drivers/mmc/host/sdhci.c    |    4 ++--
>  drivers/mmc/host/tifm_sd.c  |   16 ++++++++--------
>  drivers/mmc/host/tmio_mmc.c |    1 -
>  drivers/mmc/host/tmio_mmc.h |    4 ++--
>  6 files changed, 19 insertions(+), 20 deletions(-)

[snip]

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index a4ea102..4626ef2 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -20,7 +20,6 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> -
>  #include "tmio_mmc.h"
>  
>  #ifdef CONFIG_PM

This hunk doesn't belong here, please, drop it.

Otherwise for TMIO

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 3020f98..a95e6d9 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -105,13 +105,13 @@ static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
>  					 unsigned long *flags)
>  {
>  	local_irq_save(*flags);
> -	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
> +	return kmap_atomic(sg_page(sg)) + sg->offset;
>  }
>  
>  static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
>  					  unsigned long *flags, void *virt)
>  {
> -	kunmap_atomic(virt - sg->offset, KM_BIO_SRC_IRQ);
> +	kunmap_atomic(virt - sg->offset);
>  	local_irq_restore(*flags);
>  }
>  
> -- 
> 1.7.4.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
