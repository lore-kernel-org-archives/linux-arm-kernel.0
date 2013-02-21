From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Feb 2013 14:04:33 +0800
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <CAP1dx+zuGZ5uvOho03ieEB=17=YtkYn5UyBOsRXSJcpsKQRTAw@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
 <CAP1dx+zuGZ5uvOho03ieEB=17=YtkYn5UyBOsRXSJcpsKQRTAw@mail.gmail.com>
Message-ID: <20130221060431.GF17738@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 05:44:09PM +0800, Dong Aisheng wrote:
> > @@ -24,9 +24,9 @@ Required properties for iomux controller:
> >  Required properties for pin configuration node:
> >  - fsl,pins: two integers array, represents a group of pins mux and config
> >    setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is
> > -  pin working on a specific function, CONFIG is the pad setting value like
> > -  pull-up on this pin. Please refer to fsl,<soc>-pinctrl.txt for the valid
> > -  pins and functions of each SoC.
> > +  pin working on a specific function, which consists of a tuple of <pinid
> > +  mux_reg conf_reg input_reg mux_val input_val>.  CONFIG is the pad setting
> > +  value like pull-up on this pin.
> 
> Since we actually do not have a PIN_FUNC_ID anymore, i would suggest
> totoally remove this concept in both doc and code.
> 
Nothing really changed about PIN_FUNC_ID except it's a tuple of
numbers now.  So the concept is still there.

> > +/*
> > + * The pin function ID is a tuple of
> > + * <pinid mux_reg conf_reg input_reg mux_val input_val>
> > + */
> > +#define MX6Q_PAD_SD2_DAT1__USDHC2_DAT1                 0x000 0x04c 0x360 0x000 0x0 0x0
> 
> The original table generated does not have pinid, so you manually added it here?

The only goal about the patch is to move the data in that big array of
struct imx_pin_reg out of kernel.  Doesn't the struct have the pinid
encoded there before?

> Since the pin id is really created by us, maybe we could try to remove it
> and dynamically generate the pin id.

I actually thought about that, but decided to encode the pin id into
PIN_FUNC_ID for the reasons below.

 * I did not figure out a easy way to dynamically generate the pin id
 * Even we have a way to dynamically generate it, it might not match
   the existing pin id used in driver, which means we need to renumber
   the enum imxXX_pads.
 * Since pin id is a type of hard-coding value that pinctrl driver
   figures out from hardware manual and reports to pinctrl subsystem
   statically, I do not see why we have to dynamically generate it
   when it's not easy to do.

> Then user does not need to care about id anymore.
> 
> > +/*
> > + * Each pin represented in fsl,pins consists of 6 u32 PIN_FUNC_ID and
> 
> We could remove PIN_FUNC_ID.
> 
> > + * 1 u32 CONFIG, so 28 types in total for each pin.
> > + */
> > +#define FSL_PIN_SIZE 28
> >
> >  static int imx_pinctrl_parse_groups(struct device_node *np,
> >                                     struct imx_pin_group *grp,
> >                                     struct imx_pinctrl_soc_info *info,
> >                                     u32 index)
> >  {
> > -       unsigned int pin_func_id;
> > -       int ret, size;
> > +       int size;
> >         const __be32 *list;
> > -       int i, j;
> > +       int i;
> >         u32 config;
> >
> >         dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
> > @@ -447,32 +401,36 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
> >          */
> >         list = of_get_property(np, "fsl,pins", &size);
> >         /* we do not check return since it's safe node passed down */
> > -       size /= sizeof(*list);
> 
> Is this wrongly deleted?
> 
No, it's not.

> > -       if (!size || size % 2) {
> > -               dev_err(info->dev, "wrong pins number or pins and configs should be pairs\n");
> > +       if (!size || size % FSL_PIN_SIZE) {
> > +               dev_err(info->dev, "Invalid fsl,pins property\n");
> >                 return -EINVAL;
> >         }
> >
> > -       grp->npins = size / 2;
> > +       grp->npins = size / FSL_PIN_SIZE;
> >         grp->pins = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
> >                                 GFP_KERNEL);
> >         grp->mux_mode = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
> >                                 GFP_KERNEL);
> > +       grp->input_val = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
> > +                               GFP_KERNEL);
> >         grp->configs = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned long),
> >                                 GFP_KERNEL);
> > -       for (i = 0, j = 0; i < size; i += 2, j++) {
> > -               pin_func_id = be32_to_cpu(*list++);
> > -               ret = imx_pinctrl_get_pin_id_and_mux(info, pin_func_id,
> > -                                       &grp->pins[j], &grp->mux_mode[j]);
> > -               if (ret) {
> > -                       dev_err(info->dev, "get invalid pin function id\n");
> > -                       return -EINVAL;
> > -               }
> > +       for (i = 0; i < grp->npins; i++) {
> > +               unsigned int pin_id = be32_to_cpu(*list++);
> > +               struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
> > +
> > +               grp->pins[i] = pin_id;
> > +               pin_reg->mux_reg = be32_to_cpu(*list++);
> > +               pin_reg->conf_reg = be32_to_cpu(*list++);
> > +               pin_reg->input_reg = be32_to_cpu(*list++);
> > +               grp->mux_mode[i] = be32_to_cpu(*list++);
> > +               grp->input_val[i] = be32_to_cpu(*list++);
> > +
> >                 /* SION bit is in mux register */
> >                 config = be32_to_cpu(*list++);
> >                 if (config & IMX_PAD_SION)
> > -                       grp->mux_mode[j] |= IOMUXC_CONFIG_SION;
> > -               grp->configs[j] = config & ~IMX_PAD_SION;
> > +                       grp->mux_mode[i] |= IOMUXC_CONFIG_SION;
> > +               grp->configs[i] = config & ~IMX_PAD_SION;
> >         }
> >
> >  #ifdef DEBUG
> > @@ -568,8 +526,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
> >         struct resource *res;
> >         int ret;
> >
> > -       if (!info || !info->pins || !info->npins
> > -                 || !info->pin_regs || !info->npin_regs) {
> > +       if (!info || !info->pins || !info->npins) {
> >                 dev_err(&pdev->dev, "wrong pinctrl info\n");
> >                 return -EINVAL;
> >         }
> > @@ -580,6 +537,11 @@ int imx_pinctrl_probe(struct platform_device *pdev,
> >         if (!ipctl)
> >                 return -ENOMEM;
> >
> > +       info->pin_regs = devm_kzalloc(&pdev->dev, sizeof(*info->pin_regs) *
> > +                                     info->npins, GFP_KERNEL);
> 
> Since we only record the used pins from device tree, it seems not make too much
> sense to create pin_regs for everypin no matter wheter it's used or not.
> I would suggest to put the pin_regs info into group,
> then we do not need info->pin_regs anymore.
> What do you think?
> 
I thought about doing that.  What I do not like about that is the
register offset data for one pin will have multiple copies in different
groups, if the pin happens to be in several groups.

Shawn 
