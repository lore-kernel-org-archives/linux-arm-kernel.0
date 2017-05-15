From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 15 May 2017 08:56:18 +0000
Subject: [PATCH 1/5] pinctrl: imx: add generic pin config core support
In-Reply-To: <20170515083500.GL8471@dragon>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-2-git-send-email-aisheng.dong@nxp.com>
 <20170515083500.GL8471@dragon>
Message-ID: <AM3PR04MB3067B92ED9E3D62153536F880E10@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Sorry to reply in outlook as I don't know why my gmail failed to receive
this mail.

First of all, thank you for the review.

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, May 15, 2017 4:35 PM
> To: A.S. Dong
> Cc: linux-gpio at vger.kernel.org; Andy Duan; Jacky Bai;
> linus.walleij at linaro.org; stefan at agner.ch; kernel at pengutronix.de; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/5] pinctrl: imx: add generic pin config core support
> 
> On Fri, May 12, 2017 at 08:38:01PM +0800, Dong Aisheng wrote:
> > The design is based on the exist architecture that the core will
> > provide a uniformed way to decode the generic pin config into platform
> > config register raw data according to the imx_cfg_params_decode maps
> > registered by platform.
> 
> We should probably make it clearer that rather than fully utilizing the
> generic pinconf support provided by pinctrl core, we only adopt the device
> tree bindings of generic pinconf.  The config used in .pin_config_get[set]
> are raw register data instead of generic one, and that's why we cannot set
> pinconf_ops.is_generic.
> 

Yes, that's true.
Maybe i could merge these words into the commit message in my next version
Then we can make it clearer.

> >
> > Two useful macros, IMX_CFG_PARAMS_DECODE and
> > IMX_CFG_PARAMS_DECODE_INVERT, are created for platform to register
> decode map conveniently.
> >
> > In order to cope with some special case, a platform specific fixup()
> > function is also available to use.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/pinctrl/freescale/Kconfig       |   2 +-
> >  drivers/pinctrl/freescale/pinctrl-imx.c | 106
> > ++++++++++++++++++++++++++++----
> > drivers/pinctrl/freescale/pinctrl-imx.h |  25 ++++++++
> >  3 files changed, 121 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pinctrl/freescale/Kconfig
> > b/drivers/pinctrl/freescale/Kconfig
> > index cae05e7..0b266b2 100644
> > --- a/drivers/pinctrl/freescale/Kconfig
> > +++ b/drivers/pinctrl/freescale/Kconfig
> > @@ -2,7 +2,7 @@ config PINCTRL_IMX
> >  	bool
> >  	select GENERIC_PINCTRL_GROUPS
> >  	select GENERIC_PINMUX_FUNCTIONS
> > -	select PINCONF
> > +	select GENERIC_PINCONF
> >  	select REGMAP
> >
> >  config PINCTRL_IMX1_CORE
> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> > b/drivers/pinctrl/freescale/pinctrl-imx.c
> > index a7ace9e..db76e9d 100644
> > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/regmap.h>
> >
> >  #include "../core.h"
> > +#include "../pinconf.h"
> >  #include "../pinmux.h"
> >  #include "pinctrl-imx.h"
> >
> > @@ -359,6 +360,62 @@ static const struct pinmux_ops imx_pmx_ops = {
> >  	.gpio_set_direction = imx_pmx_gpio_set_direction,  };
> >
> > +/* decode generic config into raw register values */ static u32
> > +imx_pinconf_decode_generic_config(struct imx_pinctrl *ipctl,
> > +					      unsigned long *configs,
> > +					      unsigned int num_configs)
> > +{
> > +	struct imx_pinctrl_soc_info *info = ipctl->info;
> > +	struct imx_cfg_params_decode *decode;
> > +	enum pin_config_param param;
> > +	u32 raw_config = 0;
> > +	u32 param_val;
> > +	int i, j;
> > +
> > +	WARN_ON(num_configs > info->num_decodes);
> > +
> > +	for (i = 0; i < num_configs; i++) {
> > +		param = pinconf_to_config_param(configs[i]);
> > +		param_val = pinconf_to_config_argument(configs[i]);
> > +		decode = info->decodes;
> > +		for (j = 0; j < info->num_decodes; j++) {
> > +			if (param == decode->param) {
> > +				if (decode->invert)
> > +					param_val = !param_val;
> > +				raw_config |= (param_val << decode->offset)
> > +					      & decode->mask;
> > +				break;
> > +			}
> > +			decode++;
> > +		}
> > +	}
> > +
> > +	if (info->fixup)
> > +		info->fixup(configs, num_configs, &raw_config);
> > +
> > +	return raw_config;
> > +}
> > +
> > +static u32 imx_pinconf_parse_generic_config(struct device_node *np,
> > +					    struct imx_pinctrl *ipctl)
> > +{
> > +	struct imx_pinctrl_soc_info *info = ipctl->info;
> > +	struct pinctrl_dev *pctl = ipctl->pctl;
> > +	unsigned int num_configs;
> > +	unsigned long *configs;
> > +	int ret;
> > +
> > +	if (!info->generic_pinconf)
> > +		return 0;
> > +
> > +	ret = pinconf_generic_parse_dt_config(np, pctl, &configs,
> > +					      &num_configs);
> > +	if (ret)
> > +		return 0;
> > +
> > +	return imx_pinconf_decode_generic_config(ipctl, configs,
> > +num_configs); }
> > +
> >  static int imx_pinconf_get(struct pinctrl_dev *pctldev,
> >  			     unsigned pin_id, unsigned long *config)  { @@ -
> 475,9 +532,10
> > @@ static const struct pinconf_ops imx_pinconf_ops = {
> >
> >  static int imx_pinctrl_parse_groups(struct device_node *np,
> >  				    struct group_desc *grp,
> > -				    struct imx_pinctrl_soc_info *info,
> > +				    struct imx_pinctrl *ipctl,
> >  				    u32 index)
> >  {
> > +	struct imx_pinctrl_soc_info *info = ipctl->info;
> >  	int size, pin_size;
> >  	const __be32 *list;
> >  	int i;
> > @@ -489,17 +547,29 @@ static int imx_pinctrl_parse_groups(struct
> device_node *np,
> >  		pin_size = SHARE_FSL_PIN_SIZE;
> >  	else
> >  		pin_size = FSL_PIN_SIZE;
> > +
> > +	if (info->generic_pinconf)
> > +		pin_size -= 4;
> > +
> >  	/* Initialise group */
> >  	grp->name = np->name;
> >
> >  	/*
> > -	 * the binding format is fsl,pins = <PIN_FUNC_ID CONFIG ...>,
> > +	 * the binding format is pins = <PIN_FUNC_ID CONFIG ...>,
> 
> This is not correct for generic pinconf bindings.  CONIFIG shouldn't be
> there.
> 

Yes, that's for legacy stuff.

To make things easy, how about adding below notes and keep it there?

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 57e1f7a..b2cb3f5 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -564,6 +564,9 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
         *
         * First try generic 'pins' property, then fall back to the
         * legacy 'fsl,pins'.
+        *
+        * Note: for generic pin config case, there's no CONFIG part in
+        * the binding format.
         */
        list = of_get_property(np, "pins", &size);
        if (!list) {


> >  	 * do sanity check and calculate pins number
> > +	 *
> > +	 * First try generic 'pins' property, then fall back to the
> > +	 * legacy 'fsl,pins'.
> >  	 */
> > -	list = of_get_property(np, "fsl,pins", &size);
> > +	list = of_get_property(np, "pins", &size);
> >  	if (!list) {
> > -		dev_err(info->dev, "no fsl,pins property in node %s\n", np-
> >full_name);
> > -		return -EINVAL;
> > +		list = of_get_property(np, "fsl,pins", &size);
> > +		if (!list) {
> > +			dev_err(info->dev,
> > +				"no pins and fsl,pins property in node %s\n",
> > +				np->full_name);
> > +			return -EINVAL;
> > +		}
> >  	}
> >
> >  	/* we do not check return since it's safe node passed down */ @@
> > -508,6 +578,9 @@ static int imx_pinctrl_parse_groups(struct device_node
> *np,
> >  		return -EINVAL;
> >  	}
> >
> > +	/* first try to parse the generic pin config */
> > +	config = imx_pinconf_parse_generic_config(np, ipctl);
> > +
> >  	grp->num_pins = size / pin_size;
> >  	grp->data = devm_kzalloc(info->dev, grp->num_pins *
> >  				 sizeof(struct imx_pin), GFP_KERNEL); @@ -544,11
> +617,18 @@
> > static int imx_pinctrl_parse_groups(struct device_node *np,
> >  		pin->mux_mode = be32_to_cpu(*list++);
> >  		pin->input_val = be32_to_cpu(*list++);
> >
> > -		/* SION bit is in mux register */
> > -		config = be32_to_cpu(*list++);
> > -		if (config & IMX_PAD_SION)
> > -			pin->mux_mode |= IOMUXC_CONFIG_SION;
> > -		pin->config = config & ~IMX_PAD_SION;
> > +		if (info->generic_pinconf) {
> > +			/* generic pin config decoded */
> > +			pin->config = config;
> > +		} else {
> > +			/* legacy pin config read from devicetree */
> > +			config = be32_to_cpu(*list++);
> > +
> > +			/* SION bit is in mux register */
> > +			if (config & IMX_PAD_SION)
> > +				pin->mux_mode |= IOMUXC_CONFIG_SION;
> > +			pin->config = config & ~IMX_PAD_SION;
> > +		}
> 
> So we do not have this SION support for all SoCs that will use generic
> pinconf bindings?
> 

Yes, we only support starting from IMX7ULP and IMX7ULP has no SION bit.

If we do want the legacy MX6&7 supports as well, we could add it later
With a separate patch as it probably needs change not only SION bit,
But should also taking account of generic and non-generic pinconf co-exist.

> >
> >  		dev_dbg(info->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
> >  				pin->mux_mode, pin->config);
> > @@ -598,7 +678,7 @@ static int imx_pinctrl_parse_functions(struct
> device_node *np,
> >  				  info->group_index++, grp);
> >  		mutex_unlock(&info->mutex);
> >
> > -		imx_pinctrl_parse_groups(child, grp, info, i++);
> > +		imx_pinctrl_parse_groups(child, grp, ipctl, i++);
> >  	}
> >
> >  	return 0;
> > @@ -769,6 +849,10 @@ int imx_pinctrl_probe(struct platform_device *pdev,
> >  	imx_pinctrl_desc->confops = &imx_pinconf_ops;
> >  	imx_pinctrl_desc->owner = THIS_MODULE;
> >
> > +	/* for generic pinconf */
> > +	imx_pinctrl_desc->custom_params = info->custom_params;
> > +	imx_pinctrl_desc->num_custom_params = info->num_custom_params;
> > +
> >  	mutex_init(&info->mutex);
> >
> >  	ipctl->info = info;
> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
> > b/drivers/pinctrl/freescale/pinctrl-imx.h
> > index ff2d3e5..b5c8fe1 100644
> > --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> > @@ -15,6 +15,8 @@
> >  #ifndef __DRIVERS_PINCTRL_IMX_H
> >  #define __DRIVERS_PINCTRL_IMX_H
> >
> > +#include <linux/pinctrl/pinconf-generic.h>
> > +
> >  struct platform_device;
> >
> >  /**
> > @@ -44,6 +46,14 @@ struct imx_pin_reg {
> >  	s16 conf_reg;
> >  };
> >
> > +/* decode a generic config into raw register value */ struct
> > +imx_cfg_params_decode {
> > +	enum pin_config_param param;
> > +	u32 mask;
> > +	u8 offset;
> 
> 'shift' might be better, since we mostly use 'offset' for a register
> offset.
> 

Got it.
I'm fine with it, will update later.

Regards
Dong Aisheng

> Shawn
> 
> > +	bool invert;
> > +};
> > +
> >  struct imx_pinctrl_soc_info {
> >  	struct device *dev;
> >  	const struct pinctrl_pin_desc *pins; @@ -53,8 +63,23 @@ struct
> > imx_pinctrl_soc_info {
> >  	unsigned int flags;
> >  	const char *gpr_compatible;
> >  	struct mutex mutex;
> > +
> > +	/* generic pinconf */
> > +	bool generic_pinconf;
> > +	const struct pinconf_generic_params *custom_params;
> > +	unsigned int num_custom_params;
> > +	struct imx_cfg_params_decode *decodes;
> > +	unsigned int num_decodes;
> > +	void (*fixup)(unsigned long *configs, unsigned int num_configs,
> > +		      u32 *raw_config);
> >  };
> >
> > +#define IMX_CFG_PARAMS_DECODE(p, m, o) \
> > +	{ .param = p, .mask = m, .offset = o, .invert = false, }
> > +
> > +#define IMX_CFG_PARAMS_DECODE_INVERT(p, m, o) \
> > +	{ .param = p, .mask = m, .offset = o, .invert = true, }
> > +
> >  #define SHARE_MUX_CONF_REG	0x1
> >  #define ZERO_OFFSET_VALID	0x2
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
