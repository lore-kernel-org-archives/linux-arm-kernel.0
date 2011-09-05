From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Sep 2011 11:16:29 +0200
Subject: [PATCH v2 1/3] dmaengine: imx-sdma: use platform_device_id to
	identify sdma version
In-Reply-To: <1310723066-567-2-git-send-email-shawn.guo@linaro.org>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
	<1310723066-567-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110905091629.GB19678@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 05:44:24PM +0800, Shawn Guo wrote:
> It might be not good to use software defined version to identify sdma
> device type, when hardware does not define such version.  Instead,
> soc name is stable enough to define the device type.
I still don't get this rational. If you ask me v1, v2, v3 is better, as
it doesn't confuse people that wonder why an i.MX51 machine has a
imx35-sdma device. And if the version number is known to be virtual
(opposed to hardware defined) there is no problem with stability.

> The patch uses platform_device_id rather than version number passed
> by platform data to identify sdma device type/version.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/mach-imx/clock-imx25.c                 |    3 +-
>  arch/arm/mach-imx/clock-imx31.c                 |    2 +-
>  arch/arm/mach-imx/clock-imx35.c                 |    2 +-
>  arch/arm/mach-imx/mm-imx25.c                    |    4 +-
>  arch/arm/mach-imx/mm-imx31.c                    |    3 +-
>  arch/arm/mach-imx/mm-imx35.c                    |    3 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c             |    6 ++-
>  arch/arm/mach-mx5/mm.c                          |    8 ++--
>  arch/arm/plat-mxc/devices/platform-imx-dma.c    |    4 +-
>  arch/arm/plat-mxc/include/mach/devices-common.h |    2 +-
>  arch/arm/plat-mxc/include/mach/dma.h            |    3 +-
>  arch/arm/plat-mxc/include/mach/sdma.h           |    2 -
>  drivers/dma/imx-sdma.c                          |   39 +++++++++++++++++------
>  13 files changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> index 17d6d1b..5736e04 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -308,7 +308,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
>  	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
>  	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
> -	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
> +	/* i.mx25 has the i.mx35 type sdma */
> +	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
>  };
>  
>  int __init mx25_clocks_init(void)
> diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
> index 8d212a9..d973770 100644
> --- a/arch/arm/mach-imx/clock-imx31.c
> +++ b/arch/arm/mach-imx/clock-imx31.c
> @@ -565,7 +565,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "ata", ata_clk)
>  	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
>  	_REGISTER_CLOCK(NULL, "rng", rng_clk)
> -	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk1)
> +	_REGISTER_CLOCK("imx31-sdma", NULL, sdma_clk1)
>  	_REGISTER_CLOCK(NULL, "sdma_ipg", sdma_clk2)
>  	_REGISTER_CLOCK(NULL, "mstick", mstick1_clk)
>  	_REGISTER_CLOCK(NULL, "mstick", mstick2_clk)
> diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
> index 2d0b4c8..749acff 100644
> --- a/arch/arm/mach-imx/clock-imx35.c
> +++ b/arch/arm/mach-imx/clock-imx35.c
> @@ -481,7 +481,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
>  	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
>  	_REGISTER_CLOCK(NULL, "scc", scc_clk)
> -	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
> +	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
>  	_REGISTER_CLOCK(NULL, "spba", spba_clk)
>  	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
>  	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
> index 8bf0291..cc4d152 100644
> --- a/arch/arm/mach-imx/mm-imx25.c
> +++ b/arch/arm/mach-imx/mm-imx25.c
> @@ -79,7 +79,6 @@ static struct sdma_script_start_addrs imx25_sdma_script __initdata = {
>  };
>  
>  static struct sdma_platform_data imx25_sdma_pdata __initdata = {
> -	.sdma_version = 2,
>  	.fw_name = "sdma-imx25.bin",
>  	.script_addrs = &imx25_sdma_script,
>  };
> @@ -92,5 +91,6 @@ void __init imx25_soc_init(void)
>  	mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
>  	mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
>  
> -	imx_add_imx_sdma(MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
> +	/* i.mx25 has the i.mx35 type sdma */
> +	imx_add_imx_sdma("imx35-sdma", MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
>  }
> diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
> index 61bff38..b7c55e7 100644
> --- a/arch/arm/mach-imx/mm-imx31.c
> +++ b/arch/arm/mach-imx/mm-imx31.c
> @@ -69,7 +69,6 @@ static struct sdma_script_start_addrs imx31_to2_sdma_script __initdata = {
>  };
>  
>  static struct sdma_platform_data imx31_sdma_pdata __initdata = {
> -	.sdma_version = 1,
>  	.fw_name = "sdma-imx31-to2.bin",
>  	.script_addrs = &imx31_to2_sdma_script,
>  };
> @@ -88,5 +87,5 @@ void __init imx31_soc_init(void)
>  		imx31_sdma_pdata.script_addrs = &imx31_to1_sdma_script;
>  	}
>  
> -	imx_add_imx_sdma(MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
> +	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
>  }
> diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
> index 98769ae..f49bac7 100644
> --- a/arch/arm/mach-imx/mm-imx35.c
> +++ b/arch/arm/mach-imx/mm-imx35.c
> @@ -86,7 +86,6 @@ static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
>  };
>  
>  static struct sdma_platform_data imx35_sdma_pdata __initdata = {
> -	.sdma_version = 2,
>  	.fw_name = "sdma-imx35-to2.bin",
>  	.script_addrs = &imx35_to2_sdma_script,
>  };
> @@ -106,5 +105,5 @@ void __init imx35_soc_init(void)
>  		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
>  	}
>  
> -	imx_add_imx_sdma(MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
> +	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
>  }
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 31d904c..0a2fa8e 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1447,7 +1447,8 @@ static struct clk_lookup mx51_lookups[] = {
>  	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
> -	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
> +	/* i.mx51 has the i.mx35 type sdma */
> +	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
>  	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
>  	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
>  	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
> @@ -1494,7 +1495,8 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
>  	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> -	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
> +	/* i.mx53 has the i.mx35 type sdma */
> +	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
>  	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index ef8aec9..baea6e5 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -115,7 +115,6 @@ static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
>  };
>  
>  static struct sdma_platform_data imx51_sdma_pdata __initdata = {
> -	.sdma_version = 2,
>  	.fw_name = "sdma-imx51.bin",
>  	.script_addrs = &imx51_sdma_script,
>  };
> @@ -135,7 +134,6 @@ static struct sdma_script_start_addrs imx53_sdma_script __initdata = {
>  };
>  
>  static struct sdma_platform_data imx53_sdma_pdata __initdata = {
> -	.sdma_version = 2,
>  	.fw_name = "sdma-imx53.bin",
>  	.script_addrs = &imx53_sdma_script,
>  };
> @@ -148,7 +146,8 @@ void __init imx51_soc_init(void)
>  	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
>  	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
>  
> -	imx_add_imx_sdma(MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
> +	/* i.mx51 has the i.mx35 type sdma */
> +	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
>  }
>  
>  void __init imx53_soc_init(void)
> @@ -162,5 +161,6 @@ void __init imx53_soc_init(void)
>  	mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
>  	mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
>  
> -	imx_add_imx_sdma(MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
> +	/* i.mx53 has the i.mx35 type sdma */
> +	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
>  }
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> index 2b0fdb2..7fa7e9c 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> @@ -14,7 +14,7 @@ struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
>  			"imx-dma", -1, NULL, 0, NULL, 0);
>  }
>  
> -struct platform_device __init __maybe_unused *imx_add_imx_sdma(
> +struct platform_device __init __maybe_unused *imx_add_imx_sdma(char *name,
const char *name ?

>  	resource_size_t iobase, int irq, struct sdma_platform_data *pdata)
>  {
>  	struct resource res[] = {
> @@ -29,6 +29,6 @@ struct platform_device __init __maybe_unused *imx_add_imx_sdma(
>  		},
>  	};
>  
> -	return platform_device_register_resndata(&mxc_ahb_bus, "imx-sdma",
> +	return platform_device_register_resndata(&mxc_ahb_bus, name,
>  			-1, res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
>  }
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index c9e7b66..f5cb8d5 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -298,5 +298,5 @@ struct platform_device *__init imx_add_spi_imx(
>  		const struct spi_imx_master *pdata);
>  
>  struct platform_device *imx_add_imx_dma(void);
> -struct platform_device *imx_add_imx_sdma(
> +struct platform_device *imx_add_imx_sdma(char *name,
>  	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
> diff --git a/arch/arm/plat-mxc/include/mach/dma.h b/arch/arm/plat-mxc/include/mach/dma.h
> index ef77515..233d0a5 100644
> --- a/arch/arm/plat-mxc/include/mach/dma.h
> +++ b/arch/arm/plat-mxc/include/mach/dma.h
> @@ -60,7 +60,8 @@ static inline int imx_dma_is_ipu(struct dma_chan *chan)
>  
>  static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  {
> -	return !strcmp(dev_name(chan->device->dev), "imx-sdma") ||
> +	return !strcmp(dev_name(chan->device->dev), "imx31-sdma") ||
> +		!strcmp(dev_name(chan->device->dev), "imx35-sdma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx-dma");
>  }
>  
> diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
> index f495c87..3a39428 100644
> --- a/arch/arm/plat-mxc/include/mach/sdma.h
> +++ b/arch/arm/plat-mxc/include/mach/sdma.h
> @@ -48,12 +48,10 @@ struct sdma_script_start_addrs {
>  /**
>   * struct sdma_platform_data - platform specific data for SDMA engine
>   *
> - * @sdma_version	The version of this SDMA engine
>   * @fw_name		The firmware name
>   * @script_addrs	SDMA scripts addresses in SDMA ROM
>   */
>  struct sdma_platform_data {
> -	int sdma_version;
>  	char *fw_name;
>  	struct sdma_script_start_addrs *script_addrs;
>  };
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 1ea47db..4a7aa72 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -65,8 +65,8 @@
>  #define SDMA_ONCE_RTB		0x060
>  #define SDMA_XTRIG_CONF1	0x070
>  #define SDMA_XTRIG_CONF2	0x074
> -#define SDMA_CHNENBL0_V2	0x200
> -#define SDMA_CHNENBL0_V1	0x080
> +#define SDMA_CHNENBL0_IMX35	0x200
> +#define SDMA_CHNENBL0_IMX31	0x080
>  #define SDMA_CHNPRI_0		0x100
>  
>  /*
> @@ -299,13 +299,18 @@ struct sdma_firmware_header {
>  	u32	ram_code_size;
>  };
>  
> +enum sdma_devtype {
> +	IMX31_SDMA,	/* runs on i.mx31 */
> +	IMX35_SDMA,	/* runs on i.mx35 and later */
I don't like "and later". IMHO better list the affected SoCs currently
known.

> +};
> +
>  struct sdma_engine {
>  	struct device			*dev;
>  	struct device_dma_parameters	dma_parms;
>  	struct sdma_channel		channel[MAX_DMA_CHANNELS];
>  	struct sdma_channel_control	*channel_control;
>  	void __iomem			*regs;
> -	unsigned int			version;
> +	enum sdma_devtype		devtype;
>  	unsigned int			num_events;
>  	struct sdma_context_data	*context;
>  	dma_addr_t			context_phys;
> @@ -314,6 +319,18 @@ struct sdma_engine {
>  	struct sdma_script_start_addrs	*script_addrs;
>  };
>  
> +static struct platform_device_id sdma_devtypes[] = {
> +	{
> +		.name = "imx31-sdma",
> +		.driver_data = IMX31_SDMA,
> +	}, {
> +		.name = "imx35-sdma",
> +		.driver_data = IMX35_SDMA,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>  #define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
>  #define SDMA_H_CONFIG_RTD_PINS	(1 << 11) /* indicates if Real-Time Debug pins are enabled */
>  #define SDMA_H_CONFIG_ACR	(1 << 4)  /* indicates if AHB freq /core freq = 2 or 1 */
> @@ -321,8 +338,8 @@ struct sdma_engine {
>  
>  static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned int event)
>  {
> -	u32 chnenbl0 = (sdma->version == 2 ? SDMA_CHNENBL0_V2 : SDMA_CHNENBL0_V1);
> -
> +	u32 chnenbl0 = (sdma->devtype == IMX31_SDMA ? SDMA_CHNENBL0_IMX31 :
> +						      SDMA_CHNENBL0_IMX35);
This is a place that might easily be missed when we get imx-sdma-v3
(hehe, you see, I can talk about this version, you cannot because you
don't know the SoC that will introduce it :-). But this problem isn't
introduced by your patch.

>  	return chnenbl0 + event * 4;
>  }
>  
> @@ -1162,15 +1179,16 @@ static int __init sdma_init(struct sdma_engine *sdma)
>  	int i, ret;
>  	dma_addr_t ccb_phys;
>  
> -	switch (sdma->version) {
> -	case 1:
> +	switch (sdma->devtype) {
> +	case IMX31_SDMA:
>  		sdma->num_events = 32;
>  		break;
> -	case 2:
> +	case IMX35_SDMA:
>  		sdma->num_events = 48;
>  		break;
>  	default:
> -		dev_err(sdma->dev, "Unknown version %d. aborting\n", sdma->version);
> +		dev_err(sdma->dev, "Unknown sdma type %d. aborting\n",
> +			sdma->devtype);
>  		return -ENODEV;
>  	}
>  
> @@ -1284,7 +1302,7 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (!sdma->script_addrs)
>  		goto err_alloc;
>  
> -	sdma->version = pdata->sdma_version;
> +	sdma->devtype = pdev->id_entry->driver_data;
platform_get_device_id(pdev)->driver_data

>  
>  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
> @@ -1366,6 +1384,7 @@ static struct platform_driver sdma_driver = {
>  	.driver		= {
>  		.name	= "imx-sdma",
>  	},
> +	.id_table	= sdma_devtypes,
>  	.remove		= __exit_p(sdma_remove),
>  };
>  

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
