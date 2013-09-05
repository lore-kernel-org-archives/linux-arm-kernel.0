From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Sep 2013 17:39:43 +0100
Subject: [Xen-devel] [PATCH v5 02/13] arm: introduce a global dma_ops
 pointer
In-Reply-To: <5224A47A.3010704@citrix.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
 <1377801154-29215-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <5224A47A.3010704@citrix.com>
Message-ID: <alpine.DEB.2.02.1309051736130.6397@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Sep 2013, Julien Grall wrote:
> On 08/29/2013 07:32 PM, Stefano Stabellini wrote:
> > Initially set dma_ops to arm_dma_ops.
> > 
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: will.deacon at arm.com
> > CC: linux at arm.linux.org.uk
> > 
> > 
> > Changes in v3:
> > -  keep using arm_dma_ops in dmabounce.
> > ---
> >  arch/arm/include/asm/dma-mapping.h |    3 ++-
> >  arch/arm/mm/dma-mapping.c          |    3 +++
> >  2 files changed, 5 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > index 0982206..7d6e4f9 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -13,6 +13,7 @@
> >  #include <asm/cacheflush.h>
> >  
> >  #define DMA_ERROR_CODE	(~0)
> > +extern struct dma_map_ops *dma_ops;
> 
> Hi,
> 
> I tried to build your swiotlb patch series for the Arndale. I have a compilation
> error because dma_ops is already used in samsung sound driver (sound/soc/samsung/dma.c).
> 
> This small fix allow me to built this serie for the Arndale.
> Do I need to send it separately?

This looks like a good fix, I'll append it to the series


> =======================================================================
> commit 73d4ceded87f52fa958b92d8d8d65be485e90857
> Author: Julien Grall <julien.grall@linaro.org>
> Date:   Mon Sep 2 15:36:35 2013 +0100
> 
>     ASoC: Samsung: Rename dma_ops by samsung_dma_ops
>     
>     The commit "arm: introduce a global dma_ops pointer" introduce compilation issue
>     when CONFIG_SND_SOC_SAMSUNG is enabled.
>     
>     sound/soc/samsung/dma.c:345:27: error: conflicting types for 'dma_ops'
>     /local/home/julien/works/arndale/linux/arch/arm/include/asm/dma-mapping.h:16:28:
>     note: previous declaration of 'dma_ops' was here
>     
>     Signed-off-by: Julien Grall <julien.grall@linaro.org>
> 
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index ddea134..c341603 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -342,7 +342,7 @@ static int dma_mmap(struct snd_pcm_substream *substream,
>                                      runtime->dma_bytes);
>  }
>  
> -static struct snd_pcm_ops dma_ops = {
> +static struct snd_pcm_ops samsung_dma_ops = {
>         .open           = dma_open,
>         .close          = dma_close,
>         .ioctl          = snd_pcm_lib_ioctl,
> @@ -429,7 +429,7 @@ out:
>  }
>  
>  static struct snd_soc_platform_driver samsung_asoc_platform = {
> -       .ops            = &dma_ops,
> +       .ops            = &samsung_dma_ops,
>         .pcm_new        = dma_new,
>         .pcm_free       = dma_free_dma_buffers,
>  };
> 
> -- 
> Julien Grall
> 
