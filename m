From: dmurphy@ti.com (Dan Murphy)
Date: Thu, 30 May 2013 11:23:13 -0500
Subject: [PATCH] dmaengine: shdma: fix a build failure on platforms with
 no DMA support
In-Reply-To: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
Message-ID: <51A77CF1.7040105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2013 11:02 AM, Guennadi Liakhovetski wrote:
> On platforms with no support for the shdma dmaengine driver build is
> currently failing with
>
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
>
> Fix the breakage by defining shdma_chan_filter to NULL in such
> configurations.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> This is for "next." Compile-tested only. I'll test it on hardware next 
> week, but I don't think it shall break anything.
>
>  include/linux/sh_dma.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index b64d6be..1fd8a20 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -99,6 +99,10 @@ struct sh_dmae_pdata {
>  #define CHCR_TE	0x00000002
>  #define CHCR_IE	0x00000004
>  
> +#if IS_ENABLED(CONFIG_SH_DMAE)
>  bool shdma_chan_filter(struct dma_chan *chan, void *arg);
> +#else
> +#define shdma_chan_filter NULL
Would this not be better as a
#else
static inline bool shdma_chan_filter(struct dma_chan *chan, void *arg)
{
    return false;
}
#endif

Otherwise runtime will call a NULL pointer

> +#endif
>  
>  #endif


-- 
------------------
Dan Murphy
