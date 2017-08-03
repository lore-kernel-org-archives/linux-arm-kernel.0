From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 3 Aug 2017 10:00:22 +0800
Subject: [PATCH 3/3] pinctrl: add mt2712 pinctrl driver
In-Reply-To: <1501653837.844.39.camel@mhfsdcap03>
References: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
 <1501489333-23145-4-git-send-email-zhiyong.tao@mediatek.com>
 <1501578845.32089.18.camel@mtksdaap41> <1501653837.844.39.camel@mhfsdcap03>
Message-ID: <1501725622.15593.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-02 at 14:03 +0800, Zhiyong Tao wrote:
> On Tue, 2017-08-01 at 17:14 +0800, Yingjoe Chen wrote:
> > 
> > Hi Zhiyong,
> > 
> > 
> > 
> > On Mon, 2017-07-31 at 16:22 +0800, Zhiyong Tao wrote:
> > <...>
> > > 3)Add "spec_dir_set" and "spec_dir_get" in "mtk_pinctrl_devdata".
> > > 4)Change "spec_dir_set" and add "spec_dir_get" in "pinctrl-mt2701.c"
> > >   and "pinctrl-mtk-common.c".
> > 
> > I think these deserve another patch.
> > Please also explain why we need this.
> 
> ==> ok, I will separate it in another patch in the next version.
> Because we should control another gpio base register for gpio16 and 17
> in mt2712 E1. It is special for the direction control in gpio16 and
> gpio17.
> > 
> > 
> > > 5)Change "port_mask" from "7" to "6" for EINT.
> > 
> > I'm assuming this is a bug fix for mt2701?
> > If yes, this should be a separate patch.
> 
> ==> yes, it is a bug fix for mt2701. When I use EINT bothe edge triggle,
> offset can't get the offset address which offset address is 1/3/5/7.
> I will separate it in another patch in the next version.
> > 
> > > 6)Remove generic pull config condition in "mtk_pconf_set_pull_select".
> > > 7)Change "arg" to "MTK_PUPD_SET_R1R0_00" of "mtk_pconf_set_pull_select".
> > 
> > Why we need to change arg?
> 
> ==> to parse the "bias-disable" property in dts for special pins.
> 
> > 
> > 
> > > 
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > ---
> > >  drivers/pinctrl/mediatek/Kconfig              |    8 +
> > >  drivers/pinctrl/mediatek/Makefile             |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-mt2701.c     |   21 +-
> > >  drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  670 +++++++++
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   16 +-
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |   44 +-
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1858 +++++++++++++++++++++++++
> > >  7 files changed, 2586 insertions(+), 32 deletions(-)
> > >  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
> > >  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
> > > 
> > 
> > <...>
> > 
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
> > > index f86f3b3..4a43f5c 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
> > > @@ -503,10 +503,26 @@ static void mt2701_spec_pinmux_set(struct regmap *reg, unsigned int pin,
> > >  	regmap_update_bits(reg, mt2701_spec_pinmux[i].offset, mask, value);
> > >  }
> > >  
> > > -static void mt2701_spec_dir_set(unsigned int *reg_addr, unsigned int pin)
> > > +static int mt2701_spec_dir_set(struct mtk_pinctrl *pctl,
> > > +				unsigned int *reg_addr,
> > > +				unsigned int pin,
> > > +				bool input)
> > >  {
> > >  	if (pin > 175)
> > >  		*reg_addr += 0x10;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mt2701_spec_dir_get(struct mtk_pinctrl *pctl,
> > > +				unsigned int *reg_addr,
> > > +				unsigned int pin,
> > > +				bool input)
> > 
> > incorrect prototype?
> > 
> > > +{
> > > +	if (pin > 175)
> > > +		*reg_addr += 0x10;
> > > +
> > > +	return 0;
> > >  }
> > >  
> > >  static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
> > > @@ -520,6 +536,7 @@ static void mt2701_spec_dir_set(unsigned int *reg_addr, unsigned int pin)
> > >  	.spec_ies_smt_set = mt2701_ies_smt_set,
> > >  	.spec_pinmux_set = mt2701_spec_pinmux_set,
> > >  	.spec_dir_set = mt2701_spec_dir_set,
> > > +	.spec_dir_get = mt2701_spec_dir_get,
> > >  	.dir_offset = 0x0000,
> > >  	.pullen_offset = 0x0150,
> > >  	.pullsel_offset = 0x0280,
> > > @@ -551,7 +568,7 @@ static void mt2701_spec_dir_set(unsigned int *reg_addr, unsigned int pin)
> > >  		.dbnc_ctrl = 0x500,
> > >  		.dbnc_set  = 0x600,
> > >  		.dbnc_clr  = 0x700,
> > > -		.port_mask = 6,
> > > +		.port_mask = 7,
> > >  		.ports     = 6,
> > >  	},
> > >  	.ap_num = 169,
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
> > > new file mode 100644
> > > index 0000000..c933b75
> > > --- /dev/null
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
> > 
> > <...>
> > 
> > > +
> > > +static int mt2712_spec_dir_set(struct mtk_pinctrl *pctl,
> > > +				unsigned int *reg_addr,
> > > +				unsigned int pin,
> > > +				bool input)
> > > +{
> > > +	u32 reg_val;
> > > +
> > > +	if (pin == 16) {
> > > +		regmap_read(pctl->regmap2, 0x940, &reg_val);
> > > +		reg_val |= BIT(15);
> > > +		if (input == true)
> > > +			reg_val &= ~BIT(14);
> > > +		else
> > > +			reg_val |= BIT(14);
> > > +		regmap_write(pctl->regmap2, 0x940, reg_val);
> > > +	}
> > > +
> > > +	if (pin == 17) {
> > > +		regmap_read(pctl->regmap2, 0x940, &reg_val);
> > > +		reg_val |= BIT(7);
> > > +		if (input == true)
> > > +			reg_val &= ~BIT(6);
> > > +		else
> > > +			reg_val |= BIT(6);
> > > +		regmap_write(pctl->regmap2, 0x940, reg_val);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > Does this means pin 16, 17 is in different/special reg/bit location?
> > I didn't see spec_dir_get in your patch, does this means they are in
> > standard location or you just forgot it?
> > 
> > The original idea of spec_dir_set is to get the register offset for the
> > pin, so both set_direction and get_direction are using the same
> > extension function. Instead of adding a new spec_dir_get, can we just
> > extend the function to also include bit location?
> 
> ==> In mt2712 E1 gpi16 and gpio17 direction control is special. The
> based register is different. so we add "struct mtk_pinctrl *pctl"
> parameter to get the regmap2. The direction status is also different.
> we forgot to add spec_dir_get, we will add it in the next version.

In your device tree, you only provide one pctl-regmap, so who will setup
this regmap2? If you need 2 pctl-regmap, you should add it in binding.

Your code will access register twice when setting pin 16,17, One in the
0x940 here and original location in normal code.

The spec_dir_set was intend to be a remap function, ie, find the correct
register for the pin. If possible, it would be better to expand the
remap function for new chip instead of accessing the register directly.
This way you don't need to have 2 functions for set and get, don't need
to have extra code access register and don't have access twice bug.



> > 
> > <...>
> > 
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > index 3cf384f..aeec87e 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > @@ -84,7 +84,7 @@ static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> > >  	bit = BIT(offset & 0xf);
> > >  
> > >  	if (pctl->devdata->spec_dir_set)
> > > -		pctl->devdata->spec_dir_set(&reg_addr, offset);
> > > +		pctl->devdata->spec_dir_set(pctl, &reg_addr, offset, input);
> > >  
> > >  	if (input)
> > >  		/* Different SoC has different alignment offset. */
> > > @@ -307,13 +307,6 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
> > >  			return 0;
> > >  	}
> > >  
> > > -	/* For generic pull config, default arg value should be 0 or 1. */
> > > -	if (arg != 0 && arg != 1) {
> > > -		dev_err(pctl->dev, "invalid pull-up argument %d on pin %d .\n",
> > > -			arg, pin);
> > > -		return -EINVAL;
> > > -	}
> > > -
> > 
> > 
> > Why we need to remove this?
> ==> In order to parse "bias-disable" property. we change "arg" to
> "MTK_PUPD_SET_R1R0_00". for normal pins, If we don't remove it.
> It will return here.

Please don't. We still need the check for other property.

> > 
> > >  	bit = BIT(pin & 0xf);
> > >  	if (enable)
> > >  		reg_pullen = SET_ADDR(mtk_get_port(pctl, pin) +
> > > @@ -343,7 +336,8 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
> > >  
> > >  	switch (param) {
> > >  	case PIN_CONFIG_BIAS_DISABLE:
> > > -		ret = mtk_pconf_set_pull_select(pctl, pin, false, false, arg);
> > > +		ret = mtk_pconf_set_pull_select(pctl, pin, false, false,
> > > +						MTK_PUPD_SET_R1R0_00);
> > 
> > Why we need to change this?
> > 
> ==> if only just add "bias-disable" property in dts. "arg" is 0 or 1,
> It can't to parse the "bias-disable" property. so we change it to
> "MTK_PUPD_SET_R1R0_00".

Why not? 
The enable is false here, you should check that.
R1R0_00 means set R1R0 to 00, it does not mean disable. Using it as
disable is a bug.

Joe.C
