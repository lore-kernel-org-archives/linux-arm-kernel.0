From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 20 Nov 2013 15:00:36 +0100
Subject: [PATCH] pinctrl: samsung: Allow grouping multiple pinmux/pinconf
 nodes
In-Reply-To: <528BB789.5020201@wwwdotorg.org>
References: <1384881034-10520-1-git-send-email-t.figa@samsung.com>
 <528BB789.5020201@wwwdotorg.org>
Message-ID: <7242109.um7KlGhuI2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tuesday 19 of November 2013 12:10:01 Stephen Warren wrote:
> On 11/19/2013 10:10 AM, Tomasz Figa wrote:
> > One of remaining limitations of current pinctrl-samsung driver was
> > the inability to parse multiple pinmux/pinconf group nodes grouped
> > inside a single device tree node. It made defining groups of pins for
> > single purpose, but with different parameters very inconvenient.
> > 
> > This patch implements Tegra-like support for grouping multiple pinctrl
> > groups inside one device tree node, by completely changing the way
> > pin groups and functions are parsed from device tree.
> 
> > The code creating
> > pinctrl maps from DT nodes has been borrowed from pinctrl-tegra,
> 
> A lot of the Tegra code has been slightly generalized and put into
> pinconf-generic.c. Can the Samsung driver be converted to use that core
> code rather than adding another copy of it? Perhaps this isn't possible
> given the backwards-compatibility requirements that allow either 1- or
> 2-level nodes though, although I imagine that could be added to the core
> code. One thing you'd certainly need to do is enhance the code in
> pinconf-generic.c so that you could substitute your own
> pinconf_generic_parse_dt_config() function or dt_params[] table, to
> allow for the SoC-specific property names, but I doubt that's too hard.
> Tegra could be converted then too:-)

I can't say that it's not a good idea, but I would prefer this to be
merged first as an Exynos-specific patch and only then somehow try to
figure out how to remove code duplication. This is due to the fact that
I won't have too much time to work on this in very near future, but this
feature itself is rather convenient and it would be nice to have it
anyway.

> 
> > while
> > the initial creation of groups and functions has been completely
> > rewritten with following assumptions:
> >  - each group consists of just one pin and does not depend on data
> >    from device tree,
> >  - each function is represented by a device tree child node of the
> >    pin controller, which in turn can contain multiple child nodes
> >    for pins that need to have different configuration values.
> 
> OK, I think that sounds reasonable.
> 
> > Device Tree bindings are fully backwards compatible. New functionality
> > can be used by defining a new pinctrl group consisting of several child
> > nodes, as on following example:
> > 
> > 	sd4_bus8: sd4-bus-width8 {
> > 		part-1 {
> > 			samsung,pins = "gpk0-3", "gpk0-4",
> > 					"gpk0-5", "gpk0-6";
> > 			samsung,pin-function = <3>;
> > 			samsung,pin-pud = <3>;
> > 			samsung,pin-drv = <3>;
> > 		};
> > 		part-2 {
> > 			samsung,pins = "gpk1-3", "gpk1-4",
> > 					"gpk1-5", "gpk1-6";
> > 			samsung,pin-function = <4>;
> > 			samsung,pin-pud = <4>;
> > 			samsung,pin-drv = <3>;
> > 		};
> > 	};
> 
> OK, that all looks great!
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> 
> The DT changes fully, and the code a little briefly,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> Just a minor comment below,
> 
> > diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
> 
> > +static int samsung_pinctrl_create_function(struct device *dev,
> > +				struct samsung_pinctrl_drv_data *drvdata,
> > +				struct device_node *func_np,
> > +				struct samsung_pmx_func *func)
> ...
> > +	for (i = 0; i < npins; ++i) {
> > +		const char *gname;
> > +		char *gname_copy;
> > +
> > +		ret = of_property_read_string_index(func_np, "samsung,pins",
> > +							i, &gname);
> > +		if (ret) {
> > +			dev_err(dev,
> > +				"failed to read pin name %d from %s node\n",
> > +				i, func_np->name);
> > +			return ret;
> >  		}
> > +
> > +		gname_copy = devm_kzalloc(dev, strlen(gname) + 1, GFP_KERNEL);
> > +		if (!gname_copy)
> > +			return -ENOMEM;
> > +		strcpy(gname_copy, gname);
> 
> Is the lifetime of the string "returned" by
> of_property_read_string_index() really so short that you must copy the
> string? I'd be tempted just to store the pointer, although perhaps you
> need to get() the node so that's safe.

Right. I have done it the copy-less way in other places, but missed this
one. Thanks.

Best regards,
Tomasz
