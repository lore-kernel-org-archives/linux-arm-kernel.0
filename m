From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 09:38:52 +0100
Subject: [PATCH] ARM: mxs: pass fec device name via platform data
In-Reply-To: <1294988000-20232-1-git-send-email-shawn.guo@freescale.com>
References: <20110113150622.GV24920@pengutronix.de>
	<1294988000-20232-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110114083852.GE24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 02:53:20PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  arch/arm/mach-mxs/devices/platform-fec.c        |   11 ++++++-----
>  arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/devices/platform-fec.c b/arch/arm/mach-mxs/devices/platform-fec.c
> index c42dff7..75eb26b 100644
> --- a/arch/arm/mach-mxs/devices/platform-fec.c
> +++ b/arch/arm/mach-mxs/devices/platform-fec.c
> @@ -10,20 +10,21 @@
>  #include <mach/mx28.h>
>  #include <mach/devices-common.h>
>  
> -#define mxs_fec_data_entry_single(soc, _id)				\
> +#define mxs_fec_data_entry_single(soc, _devid, _id)			\
>  	{								\
> +		.devid = _devid,					\
>  		.id = _id,						\
>  		.iobase = soc ## _ENET_MAC ## _id ## _BASE_ADDR,	\
>  		.irq = soc ## _INT_ENET_MAC ## _id,			\
>  	}
>  
> -#define mxs_fec_data_entry(soc, _id)					\
> -	[_id] = mxs_fec_data_entry_single(soc, _id)
> +#define mxs_fec_data_entry(soc, _devid, _id)				\
> +	[_id] = mxs_fec_data_entry_single(soc, _devid, _id)
>  
>  #ifdef CONFIG_SOC_IMX28
>  const struct mxs_fec_data mx28_fec_data[] __initconst = {
>  #define mx28_fec_data_entry(_id)					\
> -	mxs_fec_data_entry(MX28, _id)
> +	mxs_fec_data_entry(MX28, "imx28-fec", _id)
>  	mx28_fec_data_entry(0),
>  	mx28_fec_data_entry(1),
>  };
> @@ -45,6 +46,6 @@ struct platform_device *__init mxs_add_fec(
>  		},
>  	};
>  
> -	return mxs_add_platform_device("imx28-fec", data->id,
> +	return mxs_add_platform_device(data->devid, data->id,
>  			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
>  }
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index 6c3d1a1..10fbcfd 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -33,6 +33,7 @@ int __init mxs_add_duart(const struct amba_device *dev);
>  /* fec */
>  #include <linux/fec.h>
>  struct mxs_fec_data {
> +	const char *devid;
>  	int id;
>  	resource_size_t iobase;
>  	resource_size_t iosize;
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
