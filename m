From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Sep 2014 15:32:53 -0400
Subject: [PATCH] drivers/soc: ti: fix build break with modules
In-Reply-To: <1411585589-6108-1-git-send-email-olof@lixom.net>
References: <5422CDB1.9060505@ti.com>
 <1411585589-6108-1-git-send-email-olof@lixom.net>
Message-ID: <54231C65.8050908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 03:06 PM, Olof Johansson wrote:
> Fixes below build break by not switching to stubs when the driver is a module:
> 
> drivers/soc/ti/knav_dma.c:418:7: error: redefinition of 'knav_dma_open_channel'
>  void *knav_dma_open_channel(struct device *dev, const char *name,
>        ^
> In file included from drivers/soc/ti/knav_dma.c:26:0:
> include/linux/soc/ti/knav_dma.h:165:21: note: previous definition of 'knav_dma_open_channel' was here
>  static inline void *knav_dma_open_channel(struct device *dev, const char *name,
>                      ^
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  include/linux/soc/ti/knav_dma.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/soc/ti/knav_dma.h b/include/linux/soc/ti/knav_dma.h
> index e864a3e..dad035c 100644
> --- a/include/linux/soc/ti/knav_dma.h
> +++ b/include/linux/soc/ti/knav_dma.h
> @@ -157,7 +157,7 @@ struct knav_dma_desc {
>  	u32	pad[4];
>  } ____cacheline_aligned;
>  
> -#ifdef CONFIG_KEYSTONE_NAVIGATOR_DMA
> +#if IS_ENABLED(CONFIG_KEYSTONE_NAVIGATOR_DMA)
>  void *knav_dma_open_channel(struct device *dev, const char *name,
>  				struct knav_dma_cfg *config);
>  void knav_dma_close_channel(void *channel);
> 
Thanks Olof for fixing it up.

Regards,
Santosh
