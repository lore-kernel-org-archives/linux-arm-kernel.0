From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 17 Oct 2011 12:59:08 +0100
Subject: [PATCH 6/6] mach-ux500: remove intermediary add_platform_device*
	functions
In-Reply-To: <1318852378-14180-7-git-send-email-lee.jones@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<1318852378-14180-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20111017115908.GE4992@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Oct 17, 2011 at 12:52:58PM +0100, Lee Jones wrote:
> These are no longer required since a 'parent' pointer is now
> passed to each registering device.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/devices-common.c |   53 ----------------------------------
>  arch/arm/mach-ux500/devices-common.h |   34 +++++++++------------
>  arch/arm/mach-ux500/devices-db8500.h |   10 ++++--
>  3 files changed, 22 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
> index b8d9a99..170975f 100644
> --- a/arch/arm/mach-ux500/devices-common.c
> +++ b/arch/arm/mach-ux500/devices-common.c
> @@ -59,59 +59,6 @@ dbx500_add_amba_device(struct device *parent, const char *name,
>  }
>  
>  static struct platform_device *
> -dbx500_add_platform_device(const char *name, int id, void *pdata,
> -			   struct resource *res, int resnum)
> -{
> -	struct platform_device *dev;
> -	int ret;
> -
> -	dev = platform_device_alloc(name, id);
> -	if (!dev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> -	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> -
> -	ret = platform_device_add_resources(dev, res, resnum);
> -	if (ret)
> -		goto out_free;
> -
> -	dev->dev.platform_data = pdata;
> -
> -	ret = platform_device_add(dev);
> -	if (ret)
> -		goto out_free;
> -
> -	return dev;
> -
> -out_free:
> -	platform_device_put(dev);
> -	return ERR_PTR(ret);
> -}
[...]
> diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
> index f8adff8..089371e 100644
> --- a/arch/arm/mach-ux500/devices-common.h
> +++ b/arch/arm/mach-ux500/devices-common.h
[...]
> -static inline struct platform_device *
> -dbx500_add_msp_i2s(int id, resource_size_t base, int irq,
> -		   struct msp_i2s_platform_data *pdata)
> -{
> -	return dbx500_add_platform_device_4k1irq("MSP_I2S", id, base, irq,
> -						 pdata);
> +	struct resource resources[] = {
> +		DEFINE_RES_MEM(base, SZ_4K),
> +		DEFINE_RES_IRQ(irq),
> +	};
> +
> +	return platform_device_register_resndata(parent, "nmk-i2c",
> +						 id, resources,
> +						 ARRAY_SIZE(resources),
> +						 pdata, sizeof(*pdata));
>  }

I think you need platform_device_register_full() rather than 
platform_device_register_resndata() here as dbx500_add_platform_device() 
also set a dma mask which platform_device_register_resndata() doesn't 
do.  Otherwise a nice diffstat!

Jamie
