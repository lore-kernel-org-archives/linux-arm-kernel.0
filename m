From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 3 Jan 2017 14:26:56 +0530
Subject: [PATCH v2 3/4] ARM: davinci: da8xx: add pdata-quirks, use for
 VPIF capture
In-Reply-To: <20161207193137.27947-4-khilman@baylibre.com>
References: <20161207193137.27947-1-khilman@baylibre.com>
 <20161207193137.27947-4-khilman@baylibre.com>
Message-ID: <53b83b1b-510e-ca74-a9ef-652c06eb099e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thursday 08 December 2016 01:01 AM, Kevin Hilman wrote:
> Add pdata-quirks for da8xx DT platforms, which adds the legacy platform
> data for vpif_capture driver.
> 
> Passing legacy platform_data is required until the V4L2 framework, and
> subdevice drivers (such as the tvp514x) grow a way of selecting input
> and output routing  (c.f. V4L2 s_routing API)
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/mach-davinci/Makefile              |   2 +-
>  arch/arm/mach-davinci/da8xx-dt.c            |   2 +
>  arch/arm/mach-davinci/include/mach/common.h |   4 +
>  arch/arm/mach-davinci/pdata-quirks.c        | 155 ++++++++++++++++++++++++++++
>  4 files changed, 162 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-davinci/pdata-quirks.c

Can you please split this to separate addition of pdata quirks from
adding vpif capture support. I think it is fine to have a pre-patch
adding support for pdata quirks with just the sentinel included.

> 
> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
> index da4c336b4637..90d2e6e4d913 100644
> --- a/arch/arm/mach-davinci/Makefile
> +++ b/arch/arm/mach-davinci/Makefile
> @@ -21,7 +21,7 @@ obj-$(CONFIG_AINTC)			+= irq.o
>  obj-$(CONFIG_CP_INTC)			+= cp_intc.o
>  
>  # Board specific
> -obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o
> +obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
>  obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
>  obj-$(CONFIG_MACH_SFFSDR)		+= board-sffsdr.o
>  obj-$(CONFIG_MACH_NEUROS_OSD2)		+= board-neuros-osd2.o
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index c9f7e9274aa8..69c8099de9f5 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -38,6 +38,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  		       NULL),
>  	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
>  	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
> +	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
>  	{}
>  };
>  
> @@ -46,6 +47,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  static void __init da850_init_machine(void)
>  {
>  	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
> +	pdata_quirks_init();
>  }
>  
>  static const char *const da850_boards_compat[] __initconst = {
> diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
> index 0b3c169758ed..1fd4cd2d1c23 100644
> --- a/arch/arm/mach-davinci/include/mach/common.h
> +++ b/arch/arm/mach-davinci/include/mach/common.h
> @@ -102,6 +102,10 @@ int davinci_pm_init(void);
>  static inline int davinci_pm_init(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_MACH_DA8XX_DT
> +extern void __init pdata_quirks_init(void);

I noticed that checkpatch complains about the extern (with strict
warnings turned on). I think its better to drop it. I know you probably
added it to be consistent with other declarations in the file.

> +#endif
> +
>  #define SRAM_SIZE	SZ_128K
>  
>  #endif /* __ARCH_ARM_MACH_DAVINCI_COMMON_H */
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
> new file mode 100644
> index 000000000000..a186513edf7e
> --- /dev/null
> +++ b/arch/arm/mach-davinci/pdata-quirks.c
> @@ -0,0 +1,155 @@
> +/*
> + * Legacy platform_data quirks
> + *
> + * Copyright (C) 2016 BayLibre, Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +
> +#include <media/i2c/tvp514x.h>
> +
> +#include <mach/common.h>
> +#include <mach/da8xx.h>
> +#include <mach/mux.h>

The mux.h include can be dropped after you dropped the muxing from this
patch.

> +
> +struct pdata_init {
> +	const char *compatible;
> +	void (*fn)(void);
> +};
> +
> +#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE)
> +
> +#define TVP5147_CH0		"tvp514x-0"
> +#define TVP5147_CH1		"tvp514x-1"
> +
> +/* VPIF capture configuration */
> +static struct tvp514x_platform_data tvp5146_pdata = {
> +		.clk_polarity = 0,
> +		.hs_polarity  = 1,
> +		.vs_polarity  = 1,
> +};
> +
> +#define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
> +
> +static const struct vpif_input da850_ch0_inputs[] = {
> +	{
> +		.input = {
> +			.index = 0,
> +			.name  = "Composite",
> +			.type  = V4L2_INPUT_TYPE_CAMERA,
> +			.capabilities = V4L2_IN_CAP_STD,
> +			.std   = TVP514X_STD_ALL,
> +		},
> +		.input_route = INPUT_CVBS_VI2B,
> +		.output_route = OUTPUT_10BIT_422_EMBEDDED_SYNC,
> +		.subdev_name = TVP5147_CH0,
> +	},
> +};
> +
> +static const struct vpif_input da850_ch1_inputs[] = {
> +	{
> +		.input = {
> +			.index = 0,
> +			.name  = "S-Video",
> +			.type  = V4L2_INPUT_TYPE_CAMERA,
> +			.capabilities = V4L2_IN_CAP_STD,
> +			.std   = TVP514X_STD_ALL,
> +		},
> +		.input_route = INPUT_SVIDEO_VI2C_VI1C,
> +		.output_route = OUTPUT_10BIT_422_EMBEDDED_SYNC,
> +		.subdev_name = TVP5147_CH1,
> +	},
> +};
> +
> +static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
> +	{
> +		.name = TVP5147_CH0,
> +		.board_info = {
> +			I2C_BOARD_INFO("tvp5146", 0x5d),
> +			.platform_data = &tvp5146_pdata,
> +		},
> +	},
> +	{
> +		.name = TVP5147_CH1,
> +		.board_info = {
> +			I2C_BOARD_INFO("tvp5146", 0x5c),
> +			.platform_data = &tvp5146_pdata,
> +		},
> +	},
> +};
> +
> +static struct vpif_capture_config da850_vpif_capture_config = {
> +	.subdev_info = da850_vpif_capture_sdev_info,
> +	.subdev_count = ARRAY_SIZE(da850_vpif_capture_sdev_info),
> +	.chan_config[0] = {
> +		.inputs = da850_ch0_inputs,
> +		.input_count = ARRAY_SIZE(da850_ch0_inputs),
> +		.vpif_if = {
> +			.if_type = VPIF_IF_BT656,
> +			.hd_pol  = 1,
> +			.vd_pol  = 1,
> +			.fid_pol = 0,
> +		},
> +	},
> +	.chan_config[1] = {
> +		.inputs = da850_ch1_inputs,
> +		.input_count = ARRAY_SIZE(da850_ch1_inputs),
> +		.vpif_if = {
> +			.if_type = VPIF_IF_BT656,
> +			.hd_pol  = 1,
> +			.vd_pol  = 1,
> +			.fid_pol = 0,
> +		},
> +	},
> +	.card_name = "DA850/OMAP-L138 Video Capture",
> +};
> +
> +static void __init da850_vpif_legacy_init(void)
> +{
> +	int ret;
> +	
> +	/* LCDK doesn't have the 2nd TVP514x on CH1 */
> +	if (of_machine_is_compatible("ti,da850-lcdk"))
> +		da850_vpif_capture_config.subdev_count = 1;
> +
> +	/* EVM (UI card) uses i2c adapter 1 (not default: zero) */
> +	if (of_machine_is_compatible("ti,da850-evm"))
> +		da850_vpif_capture_config.i2c_adapter_id = 1;
> +
> +	ret = da850_register_vpif_capture(&da850_vpif_capture_config);
> +	if (ret)
> +		pr_warn("%s: VPIF capture setup failed: %d\n",
> +			__func__, ret);
> +}
> +#endif
> +
> +static void pdata_quirks_check(struct pdata_init *quirks)

This function can be marked __init too.

Thanks,
Sekhar
