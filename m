From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 4 May 2012 14:15:03 +0200
Subject: [PATCH v2 2/5] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <1336133539-13465-2-git-send-email-b29396@freescale.com>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
 <1336133539-13465-2-git-send-email-b29396@freescale.com>
Message-ID: <201205041415.04095.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Rewrite mxs_dma_is_apbh and mxs_dma_is_apbx in order to support
> other SoCs like imx6q and reform the platform_device_id for the
> better further dt support.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Huang Shijie <b32955@freescale.com>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ChangeLog v1->v2:
> * remove using mxs_dma->version
> * other minor fixes suggested by Shawn.
> ---
>  arch/arm/mach-mxs/clock-mx23.c           |    4 +-
>  arch/arm/mach-mxs/clock-mx28.c           |    4 +-
>  arch/arm/mach-mxs/devices/platform-dma.c |   14 ++--
>  drivers/dma/mxs-dma.c                    |  115
> ++++++++++++++++++++--------- include/linux/fsl/mxs-dma.h              |  
> 12 +---
>  5 files changed, 93 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c
> b/arch/arm/mach-mxs/clock-mx23.c index e3ac52c..1e67b85 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -427,8 +427,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
>  	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
> -	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> -	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
> +	_REGISTER_CLOCK("imx23-dma-apbh", NULL, hbus_clk)
> +	_REGISTER_CLOCK("imx23-dma-apbx", NULL, xbus_clk)
>  	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
>  	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp_clk)
>  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
> diff --git a/arch/arm/mach-mxs/clock-mx28.c
> b/arch/arm/mach-mxs/clock-mx28.c index 1867a17..cca2cf7 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -625,8 +625,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
>  	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
> -	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> -	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
> +	_REGISTER_CLOCK("imx28-dma-apbh", NULL, hbus_clk)
> +	_REGISTER_CLOCK("imx28-dma-apbx", NULL, xbus_clk)
>  	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
>  	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
>  	_REGISTER_CLOCK("mxs-mmc.2", NULL, ssp2_clk)
> diff --git a/arch/arm/mach-mxs/devices/platform-dma.c
> b/arch/arm/mach-mxs/devices/platform-dma.c index 6a0202b..aff4813 100644
> --- a/arch/arm/mach-mxs/devices/platform-dma.c
> +++ b/arch/arm/mach-mxs/devices/platform-dma.c
> @@ -32,17 +32,19 @@ static struct platform_device *__init mxs_add_dma(const
> char *devid,
> 
>  static int __init mxs_add_mxs_dma(void)
>  {
> -	char *apbh = "mxs-dma-apbh";
> -	char *apbx = "mxs-dma-apbx";
> +	char *mx23_apbh = "imx23-dma-apbh";
> +	char *mx23_apbx = "imx23-dma-apbx";
> +	char *mx28_apbh = "imx28-dma-apbh";
> +	char *mx28_apbx = "imx28-dma-apbx";

Wild guess ... but const char * won't hurt here ?

> 
>  	if (cpu_is_mx23()) {
> -		mxs_add_dma(apbh, MX23_APBH_DMA_BASE_ADDR);
> -		mxs_add_dma(apbx, MX23_APBX_DMA_BASE_ADDR);
> +		mxs_add_dma(mx23_apbh, MX23_APBH_DMA_BASE_ADDR);
> +		mxs_add_dma(mx23_apbx, MX23_APBX_DMA_BASE_ADDR);
>  	}
> 
>  	if (cpu_is_mx28()) {
> -		mxs_add_dma(apbh, MX28_APBH_DMA_BASE_ADDR);
> -		mxs_add_dma(apbx, MX28_APBX_DMA_BASE_ADDR);
> +		mxs_add_dma(mx28_apbh, MX28_APBH_DMA_BASE_ADDR);
> +		mxs_add_dma(mx28_apbx, MX28_APBX_DMA_BASE_ADDR);
>  	}
> 
>  	return 0;
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 0fefdd3..d8505d3 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -35,12 +35,8 @@
>   * dma can program the controller registers of peripheral devices.
>   */
> 
> -#define MXS_DMA_APBH		0
> -#define MXS_DMA_APBX		1
> -#define dma_is_apbh()		(mxs_dma->dev_id == MXS_DMA_APBH)
> -
> -#define APBH_VERSION_LATEST	3
> -#define apbh_is_old()		(mxs_dma->version < APBH_VERSION_LATEST)
> +#define dma_is_apbh()		(mxs_dma->type == MXS_DMA_APBH)
> +#define apbh_is_old()		(mxs_dma->dev_id == IMX23_DMA)
> 
>  #define HW_APBHX_CTRL0				0x000
>  #define BM_APBH_CTRL0_APB_BURST8_EN		(1 << 29)
> @@ -50,9 +46,6 @@
>  #define HW_APBHX_CTRL2				0x020
>  #define HW_APBHX_CHANNEL_CTRL			0x030
>  #define BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL	16
> -#define HW_APBH_VERSION				(cpu_is_mx23() ? 0x3f0 : 
0x800)
> -#define HW_APBX_VERSION				0x800
> -#define BP_APBHX_VERSION_MAJOR			24
>  #define HW_APBHX_CHn_NXTCMDAR(n) \
>  	(((dma_is_apbh() && apbh_is_old()) ? 0x050 : 0x110) + (n) * 0x70)
>  #define HW_APBHX_CHn_SEMA(n) \
> @@ -120,9 +113,19 @@ struct mxs_dma_chan {
>  #define MXS_DMA_CHANNELS		16
>  #define MXS_DMA_CHANNELS_MASK		0xffff
> 
> +enum mxs_dma_devtype {
> +	MXS_DMA_APBH,
> +	MXS_DMA_APBX,
> +};
> +
> +enum mxs_dma_id {
> +	IMX23_DMA,
> +	IMX28_DMA,
> +};
> +
>  struct mxs_dma_engine {
> -	int				dev_id;
> -	unsigned int			version;
> +	enum mxs_dma_id			dev_id;
> +	enum mxs_dma_devtype		type;
>  	void __iomem			*base;
>  	struct clk			*clk;
>  	struct dma_device		dma_device;
> @@ -130,6 +133,66 @@ struct mxs_dma_engine {
>  	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
>  };
> 
> +struct mxs_dma_type {
> +	enum mxs_dma_id id;
> +	enum mxs_dma_devtype type;
> +};
> +
> +static struct mxs_dma_type mxs_dma_types[] = {
> +	{
> +		.id = IMX23_DMA,
> +		.type = MXS_DMA_APBH,
> +	}, {
> +		.id = IMX23_DMA,
> +		.type = MXS_DMA_APBX,
> +	}, {
> +		.id = IMX28_DMA,
> +		.type = MXS_DMA_APBH,
> +	}, {
> +		.id = IMX28_DMA,
> +		.type = MXS_DMA_APBX,
> +	}
> +};
> +
> +static struct platform_device_id mxs_dma_ids[] = {
> +	{
> +		.name = "imx23-dma-apbh",
> +		.driver_data = (kernel_ulong_t) &mxs_dma_types[0],
> +	}, {
> +		.name = "imx23-dma-apbx",
> +		.driver_data = (kernel_ulong_t) &mxs_dma_types[1],
> +	}, {
> +		.name = "imx28-dma-apbh",
> +		.driver_data = (kernel_ulong_t) &mxs_dma_types[2],
> +	}, {
> +		.name = "imx28-dma-apbx",
> +		.driver_data = (kernel_ulong_t) &mxs_dma_types[3],
> +	}, {
> +		/* end of list */
> +	}
> +};
> +
> +static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct mxs_dma_chan, chan);
> +}
> +
> +int mxs_dma_is_apbh(struct dma_chan *chan)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;

Do you need the above here ? :)

> +
> +	return dma_is_apbh();
> +}
> +
> +int mxs_dma_is_apbx(struct dma_chan *chan)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +

Dtto ?

> +	return !dma_is_apbh();
> +}
> +
>  static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
>  {
>  	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> @@ -193,11 +256,6 @@ static void mxs_dma_resume_chan(struct mxs_dma_chan
> *mxs_chan) mxs_chan->status = DMA_IN_PROGRESS;
>  }
> 
> -static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
> -{
> -	return container_of(chan, struct mxs_dma_chan, chan);
> -}
> -
>  static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  {
>  	return dma_cookie_assign(tx);
> @@ -570,12 +628,6 @@ static int __init mxs_dma_init(struct mxs_dma_engine
> *mxs_dma) if (ret)
>  		goto err_out;
> 
> -	/* only major version matters */
> -	mxs_dma->version = readl(mxs_dma->base +
> -				((mxs_dma->dev_id == MXS_DMA_APBX) ?
> -				HW_APBX_VERSION : HW_APBH_VERSION)) >>
> -				BP_APBHX_VERSION_MAJOR;
> -
>  	/* enable apbh burst */
>  	if (dma_is_apbh()) {
>  		writel(BM_APBH_CTRL0_APB_BURST_EN,
> @@ -597,6 +649,8 @@ static int __init mxs_dma_probe(struct platform_device
> *pdev) {
>  	const struct platform_device_id *id_entry =
>  				platform_get_device_id(pdev);
> +	const struct mxs_dma_type *dma_type =
> +			(struct mxs_dma_type *)id_entry->driver_data;
>  	struct mxs_dma_engine *mxs_dma;
>  	struct resource *iores;
>  	int ret, i;
> @@ -605,7 +659,8 @@ static int __init mxs_dma_probe(struct platform_device
> *pdev) if (!mxs_dma)
>  		return -ENOMEM;
> 
> -	mxs_dma->dev_id = id_entry->driver_data;
> +	mxs_dma->dev_id = dma_type->id;
> +	mxs_dma->type = dma_type->type;
> 
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
> @@ -688,23 +743,11 @@ err_request_region:
>  	return ret;
>  }
> 
> -static struct platform_device_id mxs_dma_type[] = {
> -	{
> -		.name = "mxs-dma-apbh",
> -		.driver_data = MXS_DMA_APBH,
> -	}, {
> -		.name = "mxs-dma-apbx",
> -		.driver_data = MXS_DMA_APBX,
> -	}, {
> -		/* end of list */
> -	}
> -};
> -
>  static struct platform_driver mxs_dma_driver = {
>  	.driver		= {
>  		.name	= "mxs-dma",
>  	},
> -	.id_table	= mxs_dma_type,
> +	.id_table	= mxs_dma_ids,
>  };
> 
>  static int __init mxs_dma_module_init(void)
> diff --git a/include/linux/fsl/mxs-dma.h b/include/linux/fsl/mxs-dma.h
> index 203d7c4..55d8702 100644
> --- a/include/linux/fsl/mxs-dma.h
> +++ b/include/linux/fsl/mxs-dma.h
> @@ -15,14 +15,6 @@ struct mxs_dma_data {
>  	int chan_irq;
>  };
> 
> -static inline int mxs_dma_is_apbh(struct dma_chan *chan)
> -{
> -	return !strcmp(dev_name(chan->device->dev), "mxs-dma-apbh");
> -}
> -
> -static inline int mxs_dma_is_apbx(struct dma_chan *chan)
> -{
> -	return !strcmp(dev_name(chan->device->dev), "mxs-dma-apbx");
> -}
> -
> +extern int mxs_dma_is_apbh(struct dma_chan *chan);
> +extern int mxs_dma_is_apbx(struct dma_chan *chan);
>  #endif /* __MACH_MXS_DMA_H__ */
