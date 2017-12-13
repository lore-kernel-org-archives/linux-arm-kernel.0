From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Dec 2017 20:09:12 +0530
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <20171213103315.GI10595@n2100.armlinux.org.uk>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
 <20171213095345.GJ13194@kroah.com>
 <20171213102707.GD3322@vireshk-i7>
 <20171213103315.GI10595@n2100.armlinux.org.uk>
Message-ID: <20171213143912.GN3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-17, 10:33, Russell King - ARM Linux wrote:
> On Wed, Dec 13, 2017 at 03:57:07PM +0530, Viresh Kumar wrote:
> > On 13-12-17, 10:53, Greg Kroah-Hartman wrote:
> > > On Sun, Oct 29, 2017 at 07:18:56PM +0530, Viresh Kumar wrote:
> > > > +static void add_deferrable_of_single(struct device_node *np,
> > > > +				     struct dev_boot_constraint *constraints,
> > > > +				     int count)
> > > > +{
> > > > +	struct device *dev;
> > > > +	int ret;
> > > > +
> > > > +	if (!of_device_is_available(np))
> > > > +		return;
> > > > +
> > > > +	ret = of_platform_bus_create(np, NULL, NULL, NULL, false);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	if (of_device_is_compatible(np, "arm,primecell")) {
> > > 
> > > Why is "arm,primecell" in the core code here?
> > 
> > All we need here is a struct device pointer to add constraints. But how we get
> > the device node depends on what bus type the device corresponds to. Currently
> > this only support amba and platform devices, but we may need to get spi, i2c,
> > etc later on.
> > 
> > How do you suggest to keep this stuff out of core here ? Are you asking me to
> > add a generic API in the OF core to find the struct device pointer using a node
> > pointer ?
> 
> Why do we need this?  Why can't we lookup the "struct device" by DT
> node, and then look at the device's bus type and decide what to do
> from that?

My requirement is only to get the struct device * for the DT node and I don't
really need to get into the bus specific details at all. I was not sure if there
is a way to lookup for the "struct device" by its DT node currently and so
depended on helpers like of_find_device_by_node(). Can you please point me to
the routine (or the way we can traverse all devices) ?

> Wouldn't a better solution be to use fwnode stuff for this, and
> make the bus-type handling a property of the bus type itself,
> pushing the bus specific code into the bus layer?

As I said earlier, I don't really need to work at the bus level. I just need the
device structure and so that may not be required.

-- 
viresh
