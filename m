From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 26 Jul 2018 23:24:05 +0530
Subject: [PATCH 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
In-Reply-To: <20180722163601.28346-2-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-2-sravanhome@gmail.com>
Message-ID: <20180726175405.GD5220@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

On Sun, Jul 22, 2018 at 06:35:57PM +0200, Saravanan Sekar wrote:
> Existing constructor defined in S900 is reused generic
> for all Actions Semi SoC's.
> 

Perhaps this could be,

Move generic defines common to the Owl family out of S900 driver.

Thanks,
Mani

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.h  | 124 +++++++++++++++++++++++++
>  drivers/pinctrl/actions/pinctrl-s900.c | 122 ------------------------
>  2 files changed, 124 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 74342378937c..42635366e68f 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -15,6 +15,130 @@
>  #define OWL_PINCONF_SLEW_SLOW 0
>  #define OWL_PINCONF_SLEW_FAST 1
>  
> +#define OWL_GPIO_PORT_A		0
> +#define OWL_GPIO_PORT_B		1
> +#define OWL_GPIO_PORT_C		2
> +#define OWL_GPIO_PORT_D		3
> +#define OWL_GPIO_PORT_E		4
> +#define OWL_GPIO_PORT_F		5
> +

Please order the defines as pinctrl first and GPIO second. It does look
a lot better.

Thanks,
Mani

> +#define MUX_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.funcs = group_name##_funcs,				\
> +		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> +		.mfpctl_reg  = MFCTL##reg,				\
> +		.mfpctl_shift = shift,					\
> +		.mfpctl_width = width,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define DRV_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = PAD_DRV##reg,				\
> +		.drv_shift = shift,					\
> +		.drv_width = width,					\
> +		.sr_reg = -1,						\
> +		.sr_shift = -1,						\
> +		.sr_width = -1,						\
> +	}
> +
> +#define SR_PG(group_name, reg, shift, width)				\
> +	{								\
> +		.name = #group_name,					\
> +		.pads = group_name##_pads,				\
> +		.npads = ARRAY_SIZE(group_name##_pads),			\
> +		.mfpctl_reg  = -1,					\
> +		.mfpctl_shift = -1,					\
> +		.mfpctl_width = -1,					\
> +		.drv_reg = -1,						\
> +		.drv_shift = -1,					\
> +		.drv_width = -1,					\
> +		.sr_reg = PAD_SR##reg,					\
> +		.sr_shift = shift,					\
> +		.sr_width = width,					\
> +	}
> +
> +#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
> +	[OWL_GPIO_PORT_##port] = {				\
> +		.offset = base,					\
> +		.pins = count,					\
> +		.outen = _outen,				\
> +		.inen = _inen,					\
> +		.dat = _dat,					\
> +	}
> +
> +#define FUNCTION(fname)					\
> +	{						\
> +		.name = #fname,				\
> +		.groups = fname##_groups,		\
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +/* PAD PULL UP/DOWN CONFIGURES */
> +#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)	\
> +	{						\
> +		.reg = PAD_PULLCTL##pull_reg,		\
> +		.shift = pull_sft,			\
> +		.width = pull_wdt,			\
> +	}
> +
> +#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> +	struct owl_pullctl pad_name##_pullctl_conf			\
> +		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> +
> +#define ST_CONF(st_reg, st_sft, st_wdt)			\
> +	{						\
> +		.reg = PAD_ST##st_reg,			\
> +		.shift = st_sft,			\
> +		.width = st_wdt,			\
> +	}
> +
> +#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)	\
> +	struct owl_st pad_name##_st_conf		\
> +		= ST_CONF(st_reg, st_sft, st_wdt)
> +
> +#define PAD_INFO(name)					\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_ST(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = NULL,			\
> +		.st = &name##_st_conf,			\
> +	}
> +
> +#define PAD_INFO_PULLCTL(name)				\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = NULL,				\
> +	}
> +
> +#define PAD_INFO_PULLCTL_ST(name)			\
> +	{						\
> +		.pad = name,				\
> +		.pullctl = &name##_pullctl_conf,	\
> +		.st = &name##_st_conf,			\
> +	}
> +
>  enum owl_pinconf_pull {
>  	OWL_PINCONF_PULL_HIZ,
>  	OWL_PINCONF_PULL_DOWN,
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index 5503c7945764..baa2f4847418 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -33,13 +33,6 @@
>  #define PAD_SR1			(0x0274)
>  #define PAD_SR2			(0x0278)
>  
> -#define OWL_GPIO_PORT_A		0
> -#define OWL_GPIO_PORT_B		1
> -#define OWL_GPIO_PORT_C		2
> -#define OWL_GPIO_PORT_D		3
> -#define OWL_GPIO_PORT_E		4
> -#define OWL_GPIO_PORT_F		5
> -
>  #define _GPIOA(offset)		(offset)
>  #define _GPIOB(offset)		(32 + (offset))
>  #define _GPIOC(offset)		(64 + (offset))
> @@ -892,55 +885,6 @@ static unsigned int i2c2_sr_pads[]		= { I2C2_SCLK, I2C2_SDATA };
>  static unsigned int sensor0_sr_pads[]		= { SENSOR0_PCLK,
>  						    SENSOR0_CKOUT };
>  
> -#define MUX_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.funcs = group_name##_funcs,				\
> -		.nfuncs = ARRAY_SIZE(group_name##_funcs),		\
> -		.mfpctl_reg  = MFCTL##reg,				\
> -		.mfpctl_shift = shift,					\
> -		.mfpctl_width = width,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define DRV_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = PAD_DRV##reg,				\
> -		.drv_shift = shift,					\
> -		.drv_width = width,					\
> -		.sr_reg = -1,						\
> -		.sr_shift = -1,						\
> -		.sr_width = -1,						\
> -	}
> -
> -#define SR_PG(group_name, reg, shift, width)				\
> -	{								\
> -		.name = #group_name,					\
> -		.pads = group_name##_pads,				\
> -		.npads = ARRAY_SIZE(group_name##_pads),			\
> -		.mfpctl_reg  = -1,					\
> -		.mfpctl_shift = -1,					\
> -		.mfpctl_width = -1,					\
> -		.drv_reg = -1,						\
> -		.drv_shift = -1,					\
> -		.drv_width = -1,					\
> -		.sr_reg = PAD_SR##reg,					\
> -		.sr_shift = shift,					\
> -		.sr_width = width,					\
> -	}
>  
>  /* Pinctrl groups */
>  static const struct owl_pingroup s900_groups[] = {
> @@ -1442,13 +1386,6 @@ static const char * const sirq2_groups[] = {
>  	"sirq2_dummy",
>  };
>  
> -#define FUNCTION(fname)					\
> -	{						\
> -		.name = #fname,				\
> -		.groups = fname##_groups,		\
> -		.ngroups = ARRAY_SIZE(fname##_groups),	\
> -	}
> -
>  static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_ERAM] = FUNCTION(eram),
>  	[S900_MUX_ETH_RMII] = FUNCTION(eth_rmii),
> @@ -1500,28 +1437,6 @@ static const struct owl_pinmux_func s900_functions[] = {
>  	[S900_MUX_SIRQ1] = FUNCTION(sirq1),
>  	[S900_MUX_SIRQ2] = FUNCTION(sirq2)
>  };
> -/* PAD PULL UP/DOWN CONFIGURES */
> -#define PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)			\
> -	{								\
> -		.reg = PAD_PULLCTL##pull_reg,				\
> -		.shift = pull_sft,					\
> -		.width = pull_wdt,					\
> -	}
> -
> -#define PAD_PULLCTL_CONF(pad_name, pull_reg, pull_sft, pull_wdt)	\
> -	struct owl_pullctl pad_name##_pullctl_conf			\
> -		= PULLCTL_CONF(pull_reg, pull_sft, pull_wdt)
> -
> -#define ST_CONF(st_reg, st_sft, st_wdt)					\
> -	{								\
> -		.reg = PAD_ST##st_reg,					\
> -		.shift = st_sft,					\
> -		.width = st_wdt,					\
> -	}
> -
> -#define PAD_ST_CONF(pad_name, st_reg, st_sft, st_wdt)			\
> -	struct owl_st pad_name##_st_conf				\
> -		= ST_CONF(st_reg, st_sft, st_wdt)
>  
>  /* PAD_PULLCTL0 */
>  static PAD_PULLCTL_CONF(ETH_RXER, 0, 18, 2);
> @@ -1639,34 +1554,6 @@ static PAD_ST_CONF(SPI0_SS, 1, 2, 1);
>  static PAD_ST_CONF(I2S_BCLK0, 1, 1, 1);
>  static PAD_ST_CONF(I2S_MCLK0, 1, 0, 1);
>  
> -#define PAD_INFO(name)							\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_ST(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = NULL,					\
> -		.st = &name##_st_conf,					\
> -	}
> -
> -#define PAD_INFO_PULLCTL(name)						\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = NULL,						\
> -	}
> -
> -#define PAD_INFO_PULLCTL_ST(name)					\
> -	{								\
> -		.pad = name,						\
> -		.pullctl = &name##_pullctl_conf,			\
> -		.st = &name##_st_conf,					\
> -	}
> -
>  /* Pad info table */
>  static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
> @@ -1821,15 +1708,6 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>  	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
>  };
>  
> -#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
> -	[OWL_GPIO_PORT_##port] = {				\
> -		.offset = base,					\
> -		.pins = count,					\
> -		.outen = _outen,				\
> -		.inen = _inen,					\
> -		.dat = _dat,					\
> -	}
> -
>  static const struct owl_gpio_port s900_gpio_ports[] = {
>  	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
>  	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
> -- 
> 2.18.0
> 
