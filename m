From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Dec 2017 15:57:07 +0530
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <20171213095345.GJ13194@kroah.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
 <20171213095345.GJ13194@kroah.com>
Message-ID: <20171213102707.GD3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:53, Greg Kroah-Hartman wrote:
> On Sun, Oct 29, 2017 at 07:18:56PM +0530, Viresh Kumar wrote:
> > +static void add_deferrable_of_single(struct device_node *np,
> > +				     struct dev_boot_constraint *constraints,
> > +				     int count)
> > +{
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	if (!of_device_is_available(np))
> > +		return;
> > +
> > +	ret = of_platform_bus_create(np, NULL, NULL, NULL, false);
> > +	if (ret)
> > +		return;
> > +
> > +	if (of_device_is_compatible(np, "arm,primecell")) {
> 
> Why is "arm,primecell" in the core code here?

All we need here is a struct device pointer to add constraints. But how we get
the device node depends on what bus type the device corresponds to. Currently
this only support amba and platform devices, but we may need to get spi, i2c,
etc later on.

How do you suggest to keep this stuff out of core here ? Are you asking me to
add a generic API in the OF core to find the struct device pointer using a node
pointer ?

> > +		struct amba_device *adev = of_find_amba_device_by_node(np);
> > +
> > +		if (!adev) {
> > +			pr_err("Failed to find amba dev: %s\n", np->full_name);
> 
> Never use pr_* when you have a valid struct device to use. 

Sure. I agree.

> Don't you
> have one from the struct device_node * passed in here?

The struct device_node doesn't contain a struct device * unfortunately. Will it
be acceptable to add one ? That will solve some controversial part of this
function for sure :)

-- 
viresh
