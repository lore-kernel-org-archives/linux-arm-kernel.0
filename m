From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 12:53:21 +0100
Subject: [PATCH 02/11] misc: Versatile Express config bus infrastructure
In-Reply-To: <201209032117.35677.arnd@arndb.de>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-3-git-send-email-pawel.moll@arm.com>
 <201209032117.35677.arnd@arndb.de>
Message-ID: <1346759601.2605.68.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your time!

On Mon, 2012-09-03 at 22:17 +0100, Arnd Bergmann wrote:
> On Monday 03 September 2012, Pawel Moll wrote:
> > +	dcc at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		#interrupt-cells = <0>;
> > +		arm,vexpress,site = <0xff>; /* Master site */
> > +
> > +		osc at 0 {
> > +			compatible = "arm,vexpress-config,osc";
> > +			reg = <0>;
> > +			freq-range = <50000000 100000000>;
> > +			#clock-cells = <1>;
> > +			clock-output-names = "oscclk0";
> > +		};
> > +	};
> >  };
> 
> The #interrupt-cells property seems misplaced here.

Right. I'm not sure what I meant here, probably a cut-and-paste error.

> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -517,4 +517,5 @@ source "drivers/misc/lis3lv02d/Kconfig"
> >  source "drivers/misc/carma/Kconfig"
> >  source "drivers/misc/altera-stapl/Kconfig"
> >  source "drivers/misc/mei/Kconfig"
> > +source "drivers/misc/vexpress/Kconfig"
> >  endmenu
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index b88df7a..49964fd 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -50,3 +50,4 @@ obj-y				+= carma/
> >  obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
> >  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
> >  obj-$(CONFIG_INTEL_MEI)		+= mei/
> > +obj-y				+= vexpress/
> 
> This does not look like something that should go to drivers/misc (well,
> basically nothing ever does). How about drivers/mfd or drivers/bus instead?

I don't see drivers/bus in 3.6-rc4? If there will be such thing, I guess
I can move config_bus.c to drivers/bus/vexpress-config.c, display.c to
drivers/video/vexpress-display.c (see my other answer), sysreg.c to
drivers/mfd/vexpress-sysreg.c (it is a multifunction device indeed, not
argument about that), but reset.c seems to me should stay as
drivers/misc/vexpress-reset.c - it's hardly a mfd...

> > +#define ADDR_FMT "%u.%x:%x:%x:%x"
> > +
> > +#define ADDR_ARGS(_ptr) \
> > +		_ptr->func, _ptr->addr.site, _ptr->addr.position, \
> > +		_ptr->addr.dcc, _ptr->addr.device
> 
> Can't you use dev_printk() to print the device name in the normal format?

Well, in some places it's used before dev_set_name(), but I guess I can
get rid of those printk-s (they are debug messages anyway).

> > +#define ADDR_TO_U64(addr) \
> > +		(((u64)(addr).site << 32) | ((addr).position << 24) | \
> > +		((addr).dcc << 16) | (addr).device)
> > +
> > +static bool vexpress_config_early = true;
> > +static DEFINE_MUTEX(vexpress_config_early_mutex);
> > +static LIST_HEAD(vexpress_config_early_drivers);
> > +static LIST_HEAD(vexpress_config_early_devices);
> 
> What is the reason for needing early devices that you have to keep in a list
> like this? If it's only for setup purposes, it's probably easier to
> have a platform hook that probes the hardware you want to initialize at boot
> time and only start using the device method at device init time.

Funnily enough the first version didn't have anything "early related"...
Till I actually defined the real clock dependency in the tree :-(

So it's all about clocks, that must be available really early. The
particular problem I faced was the amba_probe() trying to enable
apb_pclk of each device and failing...

Now, during the clock registration the device model is not initialized
yet, so I can't do normal devices registration. I've stolen some ideas
from the early platform bus code...

> > +static int vexpress_config_match(struct device *dev, struct device_driver *drv)
> > +{
> > +	struct vexpress_config_device *vecdev = to_vexpress_config_device(dev);
> > +	struct vexpress_config_driver *vecdrv = to_vexpress_config_driver(drv);
> > +
> > +	if (vecdrv->funcs) {
> > +		const unsigned *func = vecdrv->funcs;
> > +
> > +		while (*func) {
> > +			if (*func == vecdev->func)
> > +				return 1;
> > +			func++;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct device vexpress_config_bus = {
> > +	.init_name = "vexpress-config",
> > +};
> 
> No static devices in new code please. Just put it into the device tree.

Hm. This is just a dummy device serving as a default parent, similarly
to:

struct device platform_bus = {
        .init_name      = "platform",
};
EXPORT_SYMBOL_GPL(platform_bus);

Without that I can see two options:

1. Create some kind of a device (platform?) for the dcc/mcc node and use
it as a parent.
2. Scan the device tree "downwards" searching for a node that has a
device already associated with it (but this may not work at the early
stage).

> > +struct bus_type vexpress_config_bus_type = {
> > +	.name = "vexpress-config",
> > +	.match = vexpress_config_match,
> > +};
> 
> What is the reason for having a separate bus_type here?
> Is this a discoverable bus? If it is, why do you need a
> device tree binding for the child devices?

It is not a discoverable bus, but the devices are very different from
the "normal" platform devices and have specific read/write interface, so
it seemed to me that a separate bus would make sense. And I didn't want
to reinvent the wheel with my own "device/driver model".

> > +#define VEXPRESS_COMPATIBLE_TO_FUNC(_compatible, _func) \
> > +	{ \
> > +		.compatible = "arm,vexpress-config," _compatible, \
> > +		.data = (void *)VEXPRESS_CONFIG_FUNC_##_func \
> > +	}
> > +
> > +static struct of_device_id vexpress_config_devices_matches[] = {
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("osc", OSC),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("volt", VOLT),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("amp", AMP),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("temp", TEMP),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("reset", RESET),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("scc", SCC),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("muxfpga", MUXFPGA),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("shutdown", SHUTDOWN),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("reboot", REBOOT),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("dvimode", DVIMODE),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("power", POWER),
> > +	VEXPRESS_COMPATIBLE_TO_FUNC("energy", ENERGY),
> > +	{},
> > +};
> 
> What is the purpose of this lookup? Can't you make the child devices get
> probed by the compatible value?

Ok, there are two reasons for this table existence:

1. vexpress_config_of_populate() below - I need a comprehensive list of
compatible values to be able to search the tree and create respective
devices.

2. Non-DT static devices - I need something to be able to match a driver
with a device, and the "functions list" seemed appropriate.

> > +static void vexpress_config_of_device_add(struct device_node *node)
> > +{
> > +	int err;
> > +	struct vexpress_config_device *vecdev;
> > +	const struct of_device_id *match;
> > +	u32 value;
> > +
> > +	if (!of_device_is_available(node))
> > +		return;
> > +
> > +	vecdev = kzalloc(sizeof(*vecdev), GFP_KERNEL);
> > +	if (WARN_ON(!vecdev))
> > +		return;
> > +
> > +	vecdev->dev.of_node = of_node_get(node);
> > +
> > +	vecdev->name = node->name;
> > +
> > +	match = of_match_node(vexpress_config_devices_matches, node);
> > +	vecdev->func = (unsigned)match->data;
> > +
> > +	err = of_property_read_u32(node->parent, "arm,vexpress,site", &value);
> > +	if (!err)
> > +		vecdev->addr.site = value;
> > +
> > +	err = of_property_read_u32(node->parent, "arm,vexpress,position",
> > +			&value);
> > +	if (!err)
> > +		vecdev->addr.position = value;
> > +
> > +	err = of_property_read_u32(node->parent, "arm,vexpress,dcc", &value);
> > +	if (!err)
> > +		vecdev->addr.dcc = value;
> > +
> > +	err = of_property_read_u32(node, "reg", &value);
> > +	if (!err) {
> > +		vecdev->addr.device = value;
> > +	} else {
> > +		pr_err("Invalid reg property in '%s'! (%d)\n",
> > +				node->full_name, err);
> > +		kfree(vecdev);
> > +		return;
> > +	}
> > +
> > +	err = vexpress_config_device_register(vecdev);
> > +	if (err) {
> > +		pr_err("Failed to add OF device '%s'! (%d)\n",
> > +				node->full_name, err);
> > +		kfree(vecdev);
> > +		return;
> > +	}
> > +}
> > +
> > +void vexpress_config_of_populate(void)
> > +{
> > +	struct device_node *node;
> > +
> > +	for_each_matching_node(node, vexpress_config_devices_matches)
> > +		vexpress_config_of_device_add(node);
> > +}
> 
> This is unusual. Why do you only add the matching devices rather than
> all of them? Doing it your way also means O(n^2) rather than O(n)
> traversal through the list of children.

Em, I'm not sure what do you mean... The idea is shamelessly stolen from
of_irq_init() and of_clk_init()...

> > +int vexpress_config_device_register(struct vexpress_config_device *vecdev)
> > +{
> > +	pr_debug("Registering %sdevice '%s." ADDR_FMT "'\n",
> > +			vexpress_config_early ? "early " : "",
> > +			vecdev->name, ADDR_ARGS(vecdev));
> > +
> > +	if (vecdev->addr.site == VEXPRESS_SITE_MASTER)
> > +		vecdev->addr.site = vexpress_config_get_master_site();
> > +
> > +	if (!vecdev->bridge) {
> > +		spin_lock(&vexpress_config_bridges_lock);
> > +		vexpress_config_bridge_find(&vecdev->dev, NULL);
> > +		spin_unlock(&vexpress_config_bridges_lock);
> > +	}
> > +
> > +	if (vexpress_config_early) {
> > +		list_add(&vecdev->early, &vexpress_config_early_devices);
> > +		vexpress_config_early_bind();
> > +
> > +		return 0;
> > +	}
> > +
> > +	device_initialize(&vecdev->dev);
> > +	vecdev->dev.bus = &vexpress_config_bus_type;
> > +	if (!vecdev->dev.parent)
> > +		vecdev->dev.parent = &vexpress_config_bus;
> > +
> > +	dev_set_name(&vecdev->dev, "%s." ADDR_FMT,
> > +			vecdev->name, ADDR_ARGS(vecdev));
> > +
> > +	return device_add(&vecdev->dev);
> > +}
> > +EXPORT_SYMBOL(vexpress_config_device_register);
> 
> Why is this exported to non-GPL drivers? It looks like the only caller should be
> in this file.

Hm. There's no hidden agenda behind the non-GPL export, if that's what
you are afraid of ;-) Now, why it is exported at all? Because
platform_device_register is, I suppose (you can tell that I was looking
at the platform bus code ;-). The non-DT platform code is using it, so
it can't be static, but I wouldn't really expect any module to use it.
So I can make it EXPORT_SYMBOL_GPL or drop it, no problem.

Cheers!

Pawel
