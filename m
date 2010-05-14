From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 14 May 2010 14:32:42 +0200
Subject: [PATCH 7/8] MXC: mach-mx31_3ds: Add support for the keypad.
In-Reply-To: <1269370655.3276.177.camel@realization>
References: <1269369741.3276.162.camel@realization>	<1269370017.3276.165.camel@realization>	<1269370175.3276.168.camel@realization>	<1269370228.3276.169.camel@realization>	<1269370305.3276.171.camel@realization>	<1269370438.3276.173.camel@realization>	<1269370499.3276.174.camel@realization>
	<1269370655.3276.177.camel@realization>
Message-ID: <4BED42EA.2080604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


Sascha, perhaps it's time to apply this patch now? I was very close to submit a very similar patch a few moments ago (based on the current Linus git tree) but found this post in the archive.


Regrds, Magnus

On 2010-03-23 19:57, Alberto Panizzo wrote:
> The kpp device is not a board private one, so it have to be defined
> in devices.c
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
>  arch/arm/mach-mx3/devices.c       |   19 +++++++++++++++++++
>  arch/arm/mach-mx3/devices.h       |    1 +
>  arch/arm/mach-mx3/mach-mx31_3ds.c |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> index 6adb586..539a08d 100644
> --- a/arch/arm/mach-mx3/devices.c
> +++ b/arch/arm/mach-mx3/devices.c
> @@ -575,6 +575,25 @@ struct platform_device imx_ssi_device1 = {
>  	.resource = imx_ssi_resources1,
>  };
>  
> +static struct resource imx_kpp_resources[] = {
> +	{
> +		.start	= MX3x_KPP_BASE_ADDR,
> +		.end	= MX3x_KPP_BASE_ADDR + 0xf,
> +		.flags	= IORESOURCE_MEM
> +	}, {
> +		.start	= MX3x_INT_KPP,
> +		.end	= MX3x_INT_KPP,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device imx_kpp_device = {
> +	.name = "imx-keypad",
> +	.id = -1,
> +	.num_resources = ARRAY_SIZE(imx_kpp_resources),
> +	.resource = imx_kpp_resources,
> +};
> +
>  static int mx3_devices_init(void)
>  {
>  	if (cpu_is_mx31()) {
> diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
> index 42cf175..4ca2a18 100644
> --- a/arch/arm/mach-mx3/devices.h
> +++ b/arch/arm/mach-mx3/devices.h
> @@ -25,4 +25,5 @@ extern struct platform_device mxc_spi_device1;
>  extern struct platform_device mxc_spi_device2;
>  extern struct platform_device imx_ssi_device0;
>  extern struct platform_device imx_ssi_device1;
> +extern struct platform_device imx_kpp_device;
>  
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index 46ccb6c..258e8d1 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -30,6 +30,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/log2.h>
>  #include <linux/err.h>
> +#include <linux/input/matrix_keypad.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -109,6 +110,35 @@ static int mx31_3ds_pins[] = {
>  	MX31_PIN_HSYNC__HSYNC,
>  	MX31_PIN_FPSHIFT__FPSHIFT,
>  	MX31_PIN_CONTRAST__CONTRAST,
> +	/*Keyboard*/
> +	IOMUX_MODE(MX31_PIN_KEY_ROW0, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_ROW1, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_ROW2, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL0, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL1, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL2, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL3, IOMUX_CONFIG_FUNC),
> +};
> +
> +/*
> + * Matrix keyboard
> + */
> +
> +static const uint32_t mx31_3ds_keymap[] = {
> +	KEY(0, 0, KEY_UP),
> +	KEY(0, 1, KEY_DOWN),
> +	KEY(1, 0, KEY_RIGHT),
> +	KEY(1, 1, KEY_LEFT),
> +	KEY(1, 2, KEY_ENTER),
> +	KEY(2, 0, KEY_F6),
> +	KEY(2, 1, KEY_F8),
> +	KEY(2, 2, KEY_F9),
> +	KEY(2, 3, KEY_F10),
> +};
> +
> +static struct matrix_keymap_data mx31_3ds_keymap_data = {
> +	.keymap		= mx31_3ds_keymap,
> +	.keymap_size	= ARRAY_SIZE(mx31_3ds_keymap),
>  };
>  
>  /*
> @@ -609,6 +639,8 @@ static void __init mxc_board_init(void)
>  	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
>  	mxc_register_device(&mx3_fb, &mx3fb_pdata);
>  
> +	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
> +
>  	if (!mx31_3ds_init_expio())
>  		platform_device_register(&smsc911x_device);
>  }
