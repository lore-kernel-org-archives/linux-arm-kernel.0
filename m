From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 20:16:41 +0200
Subject: [PATCH 3/7] pinctrl: imx1 core driver
In-Reply-To: <20130805092952.GO26614@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-4-git-send-email-mpa@pengutronix.de>
 <20130805092952.GO26614@pengutronix.de>
Message-ID: <20130809181641.GI13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 11:29:52AM +0200, Sascha Hauer wrote:
> On Fri, Aug 02, 2013 at 12:38:23PM +0200, Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/pinctrl/Kconfig             |   5 +
> >  drivers/pinctrl/Makefile            |   1 +
> >  drivers/pinctrl/pinctrl-imx1-core.c | 667 ++++++++++++++++++++++++++++++++++++
> >  drivers/pinctrl/pinctrl-imx1.h      |  23 ++
> >  4 files changed, 696 insertions(+)
> >  create mode 100644 drivers/pinctrl/pinctrl-imx1-core.c
> >  create mode 100644 drivers/pinctrl/pinctrl-imx1.h
> > 
> > +static int imx1_pinctrl_parse_groups(struct device_node *np,
> > +				    struct imx_pin_group *grp,
> > +				    struct imx_pinctrl_soc_info *info,
> > +				    u32 index)
> > +{
> > +	int size;
> > +	const __be32 *list;
> > +	int i;
> > +	u32 config;
> > +
> > +	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
> > +
> > +	/* Initialise group */
> > +	grp->name = np->name;
> > +
> > +	/*
> > +	 * the binding format is fsl,pins = <PIN_FUNC_ID CONFIG ...>,
> > +	 * do sanity check and calculate pins number
> > +	 */
> > +	list = of_get_property(np, "fsl,pins", &size);
> > +	/* we do not check return since it's safe node passed down */
> > +	if (!size || size % 12) {
> > +		dev_notice(info->dev, "Not a valid fsl,pins property (%s)\n",
> > +				np->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	grp->npins = size / 12;
> > +	grp->pins = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
> > +				GFP_KERNEL);
> > +	grp->mux_mode = devm_kzalloc(info->dev,
> > +				grp->npins * sizeof(unsigned int), GFP_KERNEL);
> > +	grp->configs = devm_kzalloc(info->dev,
> > +				grp->npins * sizeof(unsigned long), GFP_KERNEL);
> 
> I know this is copied from the existing imx pinctrl driver, but normally
> we check for allocation failures.

Yes, I added allocation checks.

> 
> Also I find it very irritating that you allocate three arrays of
> integers instead of a single array of a struct type. I know the pinctrl
> framework forces you to pass an array of pin numbers (which is quite
> horrible for drivers to handle, who came up with the idea that a pin is
> a number instead of some struct pointer which can be attached data to?)

Fixed, using new imx1_pin structs now.

> 
> > +	for (i = 0; i < grp->npins; i++) {
> > +		grp->pins[i] = be32_to_cpu(*list++);
> > +		grp->mux_mode[i] = be32_to_cpu(*list++);
> > +
> > +		config = be32_to_cpu(*list++);
> > +		grp->configs[i] = config;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> [...]
> 
> > +
> > +	for_each_child_of_node(np, child) {
> > +		func->groups[i] = child->name;
> > +		grp = &info->groups[grp_index++];
> > +		ret = imx1_pinctrl_parse_groups(child, grp, info, i++);
> > +		if (ret)
> > +			return ret;
> 
> This is one thing which nags me in the imx pinctrl driver aswell. Once
> you made a single mistake in a single pinctrl group in the devicetree
> you will never see the error message because the whole pinctrl driver
> bails out leaving the serial driver with the console unusable. Wouldn't
> it be possible to continue here instead of bailing out?

Yes, it is possible. I changed it to continue if ret != -ENOMEM.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
