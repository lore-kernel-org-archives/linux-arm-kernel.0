From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 12 May 2016 15:07:06 +0200
Subject: [PATCH v9 2/2] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-mmio
In-Reply-To: <3c67e0ca-43eb-4a77-90ef-f8e2757c8edd@gmail.com>
References: <cover.1462911225.git.chunkeey@googlemail.com>
 <85c74586dbd0023306f012764b85d6aa168b4ae7.1462911225.git.chunkeey@googlemail.com>
 <3c67e0ca-43eb-4a77-90ef-f8e2757c8edd@gmail.com>
Message-ID: <1626318.aFfl1tphqe@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 12, 2016 07:30:05 PM Alexandre Courbot wrote:
> On Wednesday, May 11, 2016 6:34:35 PM JST, Christian Lamparter wrote:
> > This patch integrates the GPIO drivers for the following
> > boards, SoCs, etc. into gpio-mmio:
> >  - CLPS711X SoCs
> >  - MOXA ART SoC
> >  - TS-4800 FPGA DIO blocks and compatibles
> >  - GPIO controllers found on some GE Single Board Computers
> >
> > Cc: Alexander Shiyan <shc_work@mail.ru>
> > Cc: Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>
> > Cc: Martyn Welch <martyn.welch@ge.com>
> > Cc: Jonas Jensen <jonas.jensen@gmail.com>
> > Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> > ---
[...]
> > diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> > index f72e40e..1de9172 100644
> > --- a/drivers/gpio/gpio-mmio.c
> > +++ b/drivers/gpio/gpio-mmio.c
> > @@ -586,8 +586,220 @@ static int 
> > bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
> >  	return 0;
> >  }
> >  
> > +static int clps711x_parse_dt(struct platform_device *pdev,
> > +			     struct bgpio_pdata *pdata,
> > +			     unsigned long *flags)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct resource *res;
> > +	const char *dir_reg_name;
> > +	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> > +
> > +	switch (id) {
> > +	case 0:
> > +	case 1:
> > +	case 2:
> > +		pdata->ngpio = 0; /* determined by register width */
> > +		dir_reg_name = "dirout";
> > +		break;
> > +	case 3:
> > +		pdata->ngpio = 0; /* determined by register width */
> > +		/* PORTD is inverted logic for direction register */
> > +		dir_reg_name = "dirin";
> > +		break;
> > +	case 4:
> > +		pdata->ngpio = 3; /* PORTE is 3 lines only */
> > +		dir_reg_name = "dirout";
> > +		break;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +
> > +	pdata->base = id * 8;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> > +	if (!res->name || strcmp("dat", res->name))
> > +		res->name = devm_kstrdup(&pdev->dev, "dat", GFP_KERNEL);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	if (!res)
> > +		return -EINVAL;
> > +	if (!res->name || strcmp(dir_reg_name, res->name))
> > +		res->name = devm_kstrdup(&pdev->dev, dir_reg_name, GFP_KERNEL);
> 
> Ouch, I don't like this. Also the probability that the "if (!res->name || 
> ...)" condition is not met is so small that I would not bother with it and 
> do the kstrdup unconditionally. But maybe we can remove this altogether - 
> see below...

The !res->name check is simply there because the kernel's strcmp doesn't
check for NULL... the res->name will be coming from the device tree.
Yes it should always be initialized but again: it's not within the functions 
control so it better be prepared for it. The "dir_reg_name" is part of the
function so we can guarantee that it's not NULL or a invalid string. 

About the leakage: I use devm_kstrdup unlike the dump strdup, it does bind
the dupped string to the device. This way the resource is not leaked even
if the module is loaded and unloaded, it stays with the device. (Until
it is destroyed).
 
Note: The strcmp is there to check if resource name was already updated
so even if the module was loaded multiple times it will dup the string
just once.

Doing a direct assignment like I did in the earlier versions would lead
to issues since the device resources are part of the the device and not
with the driver module.

> > +/*
> > + * bgpio_init() needs up to five named mmio register resources.
> > + * These currently are dat, set, clr, [dirout | dirin]. There
> > + * is no particular order or predefined place for the entries.
> > + * However, dirout and dirin are mutually exclusive.
> > + */
> > +#define __NUM_COMPAT_OVERRIDE_MMIO_RESOURCES 4
> > +
> > +struct compat_gpio_device_data {
> > +	unsigned int expected_resource_size;
> > +	unsigned int ngpio;
> > +	resource_size_t register_width;
> > +	unsigned long flags;
> > +	int (*call_back)(struct platform_device *pdev,
> > +			 struct bgpio_pdata *pdata,
> > +			 unsigned long *flags);
> > +	struct resource_replacement {
> > +		resource_size_t start_offset;
> > +		const char *name;
> > +	} resources[__NUM_COMPAT_OVERRIDE_MMIO_RESOURCES];
> > +};
> > +#undef __NUM_COMPAT_OVERRIDE_MMIO_RESOURCES
> > +
> > +#define ADD_COMPAT_REGISTER(_name, _offset)	\
> > +	{ .name = (_name), .start_offset = (_offset) }
> > +
> > +#define ADD_COMPAT_GPIO(_comp, _sz, _ngpio, _width, _cb, _f, _res...)	\
> > +	{								\
> > +	  .compatible = (_comp),					\
> > +	  .data = &(struct compat_gpio_device_data) {			\
> > +		.expected_resource_size = (_sz),			\
> > +		.ngpio = (_ngpio),					\
> > +		.register_width = (_width),				\
> > +		.flags = (_f),						\
> > +		.call_back = (_cb),					\
> > +		.resources = { _res },					\
> > +	}								\
> > +}
> > +
> > +#define ADD_COMPAT_GE_GPIO(_name, _ngpio)				\
> > +	ADD_COMPAT_GPIO(_name, 0x24, _ngpio, 0x4, ge_dt_cb,		\
> > +		 BGPIOF_BIG_ENDIAN_BYTE_ORDER,				\
> > +		 ADD_COMPAT_REGISTER("dat", 0x04),			\
> > +		 ADD_COMPAT_REGISTER("set", 0x08),			\
> > +		 ADD_COMPAT_REGISTER("dirin", 0x00))			\
> > +
> > +static const struct of_device_id compat_gpio_devices[] = {
> > +	ADD_COMPAT_GE_GPIO("ge,imp3a-gpio", 16),
> > +	ADD_COMPAT_GE_GPIO("gef,sbc310-gpio", 6),
> > +	ADD_COMPAT_GE_GPIO("gef,sbc610-gpio", 19),
> > +	ADD_COMPAT_GPIO("moxa,moxart-gpio", 0xc, 0, 0x4, moxart_dt_cb,
> > +		 BGPIOF_READ_OUTPUT_REG_SET,
> > +		 ADD_COMPAT_REGISTER("dat", 0x04),
> > +		 ADD_COMPAT_REGISTER("set", 0x00),
> > +		 ADD_COMPAT_REGISTER("dirout", 0x08)),
> > +	ADD_COMPAT_GPIO("technologic,ts4800-gpio", 0x6, 16, 0x2, ts4800_dt_cb,
> > +		 0, ADD_COMPAT_REGISTER("dat", 0x00),
> > +		 ADD_COMPAT_REGISTER("set", 0x02),
> > +		 ADD_COMPAT_REGISTER("dirout", 0x04)),
> > +};
> > +
> > +#undef ADD_COMPAT_GE_GPIO
> > +#undef ADD_COMPAT_GPIO
> > +#undef ADD_COMPAT_REGISTER
> > +
> > +static int compat_parse_dt(struct platform_device *pdev,
> > +			   struct bgpio_pdata *pdata,
> > +			   unsigned long *flags)
> > +{
> > +	const struct device_node *node = pdev->dev.of_node;
> > +	const struct compat_gpio_device_data *entry;
> > +	const struct of_device_id *of_id;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	of_id = of_match_node(compat_gpio_devices, node);
> > +	if (!of_id)
> > +		return -ENODEV;
> > +
> > +	entry = of_id->data;
> > +	if (!entry || !entry->resources[0].name)
> > +		return -EINVAL;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> > +
> > +	if (!res->name || strcmp(entry->resources[0].name, res->name)) {
> > +		struct resource nres[ARRAY_SIZE(entry->resources)];
> > +		size_t i;
> > +
> > +		if (resource_size(res) != entry->expected_resource_size)
> > +			return -EINVAL;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(entry->resources); i++) {
> > +			if (!entry->resources[i].name)
> > +				continue;
> > +
> > +			nres[i].name = devm_kstrdup(&pdev->dev,
> > +				entry->resources[i].name, GFP_KERNEL);
> > +			nres[i].start = res->start +
> > +				entry->resources[i].start_offset;
> > +			nres[i].end = nres[i].start +
> > +				entry->register_width - 1;
> > +			nres[i].flags = IORESOURCE_MEM;
> > +		}
> > +
> > +		err = platform_device_add_resources(pdev, nres, i);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	pdata->base = -1;
> > +	pdata->ngpio = entry->ngpio;
> > +	*flags = entry->flags;
> > +
> > +	if (entry->call_back)
> > +		err = entry->call_back(pdev, pdata, flags);
> > +
> > +	return err;
> > +}
> 
> Ok, so this is getting quite complex, with two of_device_id tables and two 
> levels of hooks, mainly because you want to use the bgpio_pdev_probe() 
> function which relies on named memory resources.
I think I need more here. The bgpio_pdev_probe() also sets up the bgpio_maps()
(there are 6 and I'm using 4 at the moment for all compat chips). 
The bgpio_pdev_probe() also deals with devm_gpiochip_add_data() and allocates
the memory for the gpiochip structure... as well as  and the error handling.
etc...

That's why I reused the existing code as much as possible.
(But let's get to the main issue here:)
> This function is here for basic platform devices, and you are not obliged 
> to rely on it for DT. Feel free to write your own function (or rather split 
> bgpio_pdev_probe() in two code paths) if it can reduce the amount of black 
> magic you need to do (especially the renaming of resources on-the-fly).
> 
> At the end of the day what you want is a function that calls bgpio_init() 
> with the right parameters. These parameters should be inferred from the 
> compatible property whenever possible (which is most of the time, and why I 
> am suspiscious of using "reg" properties for these devices since I don't 
> think it can change much?), and passed as-is to bgpio_init(). Your 
> compat_gpio_device_data struct basically encodes this, so this will take 
> care of all the "compat" devices.
> 
> For the other devices, you should be able to fill in such a structure from 
> the DT properties. Then you just use it for the parameters of bgpio_init(). 
> It will be more elegant that adding resources, and probably shorter as 
> well.
> 
> > +
> >  static const struct of_device_id bgpio_of_match[] = {
> >  	{ .compatible = "wd,mbl-gpio", .data = bgpio_basic_mmio_parse_dt },
> > +	{ .compatible = "cirrus,clps711x-gpio", .data = clps711x_parse_dt },
> > +	{ .compatible = "ge,imp3a-gpio", .data = compat_parse_dt },
> > +	{ .compatible = "gef,sbc310-gpio", .data = compat_parse_dt },
> > +	{ .compatible = "gef,sbc610-gpio", .data = compat_parse_dt },
> > +	{ .compatible = "moxa,moxart-gpio", .data = compat_parse_dt },
> > +	{ .compatible = "technologic,ts4800-gpio", .data = compat_parse_dt },
> 
> If you implement my idea, the function referred to by .data should return 
> that structure I was talking about, and bgpio_init() can be called directly 
> on it after that. The current path of bgpio_pdev_probe() should only be 
> taken if bgpio_parse_dt() returned NULL.
> 
> I believe this will reduce the number of lines in your patch some more, and 
> it will also make the code easier to read.
> 
> Also this should be split into several patches, like the previous one: the 
> first one adds the required infrastructure to gpio-mmio, and the subsequent 
> patches each move one device into gpio-mmio.

The main issue why this got so complicated was keeping compatibility with
the existing drivers.

If you look at "clps711x_parse_dt". You will see that it supports 5 GPIOs.
The thing that makes it really ugly is that it uses the dt alias as a way
to identify each port (A-E). The Port is then used to encode the number of
gpios the controller has and whenever it is dirin or dirout... 
I argued that this information should be put in the dts and I made patch
for it. But updating the dts was not the way to go. as Rob explained
in <http://www.spinics.net/lists/devicetree/msg124538.html>.

This means that unless you can make a single structure that would encode
everything these compat drivers do, (look at the call_back functions of
the other drivers, each of the compat drivers also has a little bit of
extra code associated to setup stuff like a label or have an extra ngpios
property parser, etc...). I cannot see how you could make this any better
without breaking compatibility. This was the sole reason why there are
these individual parsers. (In RFC v4? I had that parser in their original
files - I don't know if this would have worked any better, but feedback
indicated that everything should be moved to the gpio-mmio.c). 

So, what's your take on it?

Note: This patch was added to this series as a request of Rob to demonstrate
that having a device tree binding for the gpio-mmio.c driver is something we
want. It isn't necessary to apply it right away as it also hinges on the ACKs
of people who use these devices. And so far, nobody replied. We can add this
individual patch at a later time. 

Regards,
Christian
