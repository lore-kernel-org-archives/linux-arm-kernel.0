From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Dec 2017 15:43:19 +0530
Subject: [PATCH V4 10/12] boot_constraint: Add support for Hisilicon
 platforms
In-Reply-To: <20171213094718.GE13194@kroah.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <facf1c5838468c8440240e2828a8e4982003a6f6.1509284255.git.viresh.kumar@linaro.org>
 <20171213094718.GE13194@kroah.com>
Message-ID: <20171213101319.GC3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:47, Greg Kroah-Hartman wrote:
> On Sun, Oct 29, 2017 at 07:18:58PM +0530, Viresh Kumar wrote:
> > +static const struct of_device_id machines[] __initconst = {
> > +	{ .compatible = "hisilicon,hi3660", .data = &hikey3660_constraints },
> > +	{ .compatible = "hisilicon,hi3798cv200", .data = &hikey3798cv200_constraints },
> > +	{ .compatible = "hisilicon,hi6220", .data = &hikey6220_constraints },
> > +	{ }
> > +};
> > +
> > +static int __init hikey_constraints_init(void)
> > +{
> > +	const struct hikey_machine_constraints *constraints;
> > +	const struct of_device_id *match;
> > +	struct device_node *np;
> > +
> > +	if (!boot_constraint_earlycon_enabled())
> > +		return 0;
> > +
> > +	np = of_find_node_by_path("/");
> 
> What is this for?

We need to match the above list of "machines" with the root node and "np" here
points to the root node.. and ...

> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	match = of_match_node(machines, np);

Its used here.

> > +	of_node_put(np);

> > +/*
> > + * The amba-pl011 driver registers itself from arch_initcall level. Setup the
> > + * serial boot constraints before that in order not to miss any boot messages.
> > + */
> > +postcore_initcall_sync(hikey_constraints_init);
> 
> Now you have to worry about the bootconstraints earlycon being called
> before/after your code.

For boot-constraints to work for any device, it is extremely important to add
the constraint before the device is probed by its driver, otherwise the driver
would end up re-configuring the resources. There is no other way then having
this order dependency here.

> That's another linking order dependancy you
> just created.  It feels more complex for something so "simple" as
> looking for the earlycon flag...

-- 
viresh
