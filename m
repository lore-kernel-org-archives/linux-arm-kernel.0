From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 May 2012 10:47:15 +0800
Subject: [PATCH] pinctrl: mxs: add gpio range support
In-Reply-To: <20120515115113.GC10347@shlinux2.ap.freescale.net>
References: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
 <20120515115113.GC10347@shlinux2.ap.freescale.net>
Message-ID: <20120517024715.GH3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 07:51:14PM +0800, Dong Aisheng wrote:
> > +/*
> > + * The .base is initialized as the gpio offset local to the port, and will
> > + * have gpio base of the port added at runtime.
> > + */
> A good idea.
> I was also trying to do this for pinctrl gpio dt improvement but i planned to
> do such things in core since i thought other SoCs may face the same issue.
> Maybe i should send out a RFC patch for open discussion.
> 
Yes, I just had a look on your patch.  It will be good if we can really
implement this at core level. 

> > +static void mxs_gpio_disable_free(struct pinctrl_dev *pctldev,
> > +				  struct pinctrl_gpio_range *range,
> > +				  unsigned pinid)
> > +{
> > +	/* Nothing to do here */
> > +}
> It seems .gpio_disable_free can be optional, so you can remove this
> empty function.
> 
Ok.

> > +
> >  static struct pinmux_ops mxs_pinmux_ops = {
> >  	.get_functions_count = mxs_pinctrl_get_funcs_count,
> >  	.get_function_name = mxs_pinctrl_get_func_name,
> >  	.get_function_groups = mxs_pinctrl_get_func_groups,
> >  	.enable = mxs_pinctrl_enable,
> >  	.disable = mxs_pinctrl_disable,
> > +	.gpio_request_enable = mxs_gpio_request_enable,
> > +	.gpio_disable_free = mxs_gpio_disable_free,
> >  };
> >  
> >  static int mxs_pinconf_get(struct pinctrl_dev *pctldev,
> > @@ -482,7 +512,9 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
> >  				struct mxs_pinctrl_soc_data *soc)
> >  {
> >  	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *child;
> >  	struct mxs_pinctrl_data *d;
> > +	int id, i, j = 0;
> >  	int ret;
> >  
> >  	d = devm_kzalloc(&pdev->dev, sizeof(*d), GFP_KERNEL);
> > @@ -500,6 +532,26 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
> >  	mxs_pinctrl_desc.npins = d->soc->npins;
> >  	mxs_pinctrl_desc.name = dev_name(&pdev->dev);
> >  
> > +	for_each_child_of_node(np, child) {
> > +		if (!of_device_is_compatible(child, "fsl,mxs-gpio"))
> > +			continue;
> I planned to use a phandle list to point to gpio nodes rather than forcing
> put gpio nodes under pinctrl node.

On mxs, the gpio nodes are naturally under pinctrl node, because gpio
controller is part of pin controller and share the same IO space range
with pin controller.

For the phandle approach, there is a patch from Viresh Kumar "gpiolib:
Add of_get_gpio_chip_by_phandle() helper" are currently flowing around
on the list.  But it hasn't been accepted.  The whole pull-request of
"SPEAr pinctrl updates for v-3.5" is being held on this.

http://thread.gmane.org/gmane.linux.ports.arm.kernel/166668/focus=167395

> I will send out the common patch for discussion.
> 
> > +
> > +		id = of_alias_get_id(child, "gpio");
> > +		if (id < 0 || id > soc->gpio_num_ranges) {
> > +			dev_err(&pdev->dev, "invalid gpio id: %d\n", id);
> > +			return id;
> > +		}
> > +
> > +		for (i = j; i < soc->gpio_num_ranges; i++) {
> I'm wondering this may fail if the gpio nodes are not sequentially listed
> in dts file.
> 
This is a mxs specific implementation, and we do have gpio nodes
sequentially listed under pinctrl node.

> > +			struct pinctrl_gpio_range *range = &soc->gpio_ranges[i];
> > +			if (range->id == id) {
> > +				range->gc = of_node_to_gpiochip(child);
> shouldn't check return?
> 
Yes.  Will do.

-- 
Regards,
Shawn
