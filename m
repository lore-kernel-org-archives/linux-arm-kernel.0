From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 16 Jul 2011 23:13:17 -0600
Subject: [PATCH 3/4] dt: omap3: add generic board file for dt support
In-Reply-To: <CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
Message-ID: <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

Comments below.  I left in a lot of context for the new folks that
I've cc'd (Tony and Kevin).

On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> > +static void __init omap3_init(void)
>>> > +{
>>> > + ? ? ? struct device_node *node;
>>> > +
>>> > + ? ? ? node = of_find_matching_node_by_address(NULL, omap3_dt_intc_match,
>>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP34XX_IC_BASE);
>>> > + ? ? ? if (node)
>>> > + ? ? ? ? ? ? ? irq_domain_add_simple(node, 0);
>>> > +
>>> > + ? ? ? omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>> > + ? ? ? omap3_beagle_init_rev();
>>> > + ? ? ? omap3_beagle_i2c_init();
>>> > + ? ? ? platform_add_devices(omap3_beagle_devices,
>>> > + ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(omap3_beagle_devices));
>>> > + ? ? ? omap_display_init(&beagle_dss_data);
>>> > + ? ? ? omap_serial_init();
>>> > +
>>> > + ? ? ? omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>>> > + ? ? ? /* REVISIT leave DVI powered down until it's needed ... */
>>> > + ? ? ? gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
>>> > +
>>> > + ? ? ? usb_musb_init(NULL);
>>> > + ? ? ? usbhs_init(&usbhs_bdata);
>>> > + ? ? ? omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
>>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(omap3beagle_nand_partitions));
>>> > +
>>> > + ? ? ? /* Ensure msecure is mux'd to be able to set the RTC. */
>>> > + ? ? ? omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
>>> > +
>>> > + ? ? ? /* Ensure SDRC pins are mux'd for self-refresh */
>>> > + ? ? ? omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>>> > + ? ? ? omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>>> > +
>>> > + ? ? ? beagle_display_init();
>>> > + ? ? ? beagle_opp_init();
>>> > + ? ? ? of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>>>
>>> Hmmm, I don't think this will work for OMAP because it will not create
>>> the i2c bus as an omap_device. ?It will only be a plane
>>> platform_deevice. ?You'll need to have a hook in
>>> of_platform_populate() to create devices the way omap3 infrastructure
>>> expects.
>>>
>>
> This dependency is mentioned in patch series. Since you pointed out this
> issue, I would like to propose following approach for hooking up omap hwmod?
> framework with dt. Though, the current approach focus only on i2c driver, it
> can be extended and generalized as it evolves with other board and
> driver cleanup
> activities. The following changes are not tested and also not compiled, ?it is
> only proposal I am thinking to implement.
>
> Let me know if you see any serious issues with the approach.
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index c1773456..104ef31 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -457,6 +457,8 @@ void of_platform_prepare(struct device_node *root,
> ? ? ? ?}
> ?}
>
> +
> +
> ?#ifdef CONFIG_ARM_AMBA
> ?static struct amba_device *of_amba_device_create(struct device_node *node,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const char *bus_id,
> @@ -537,13 +539,60 @@ static const struct of_dev_auxdata
> *of_dev_lookup(const struct of_dev_auxdata *l
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?continue;
> ? ? ? ? ? ? ? ? ? ? ? ?if (res.start != lookup->phys_addr)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?continue;
> - ? ? ? ? ? ? ? ? ? ? ? pr_debug("%s: devname=%s\n", np->full_name,
> lookup->name);
> + ? ? ? ? ? ? ? ? ? ? ? printk("%s: devname=%s\n", np->full_name, lookup->name);
> ? ? ? ? ? ? ? ? ? ? ? ?return lookup;
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
> ? ? ? ?return NULL;
> ?}
>
> +static struct omap_device *of_omap_i2c_device_create(struct device_node *node,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const char *bus_id,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?void *platform_data,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device *parent)
> +{
> + ? ? ? struct platform_device *pdev;
> + ? ? ? struct i2c_board_info *i2c_board_info;
> + ? ? ? u8 id;
> +
> + ? ? ? printk("Creating omap i2c device %s\n", node->full_name);
> +
> + ? ? ? if (!of_device_is_available(node))
> + ? ? ? ? ? ? ? return NULL;
> +
> + ? ? ? id = simple_strtol(bus_id, NULL, 0);
> + ? ? ? pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> + ? ? ? pdev->dev.of_node = of_node_get(node);
> + ? ? ? if (!pdev->dev.of_node) {
> + ? ? ? ? ? ? ? speed = 100;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? u32 prop;
> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
> + ? ? ? ? ? ? ? ? ? ? ? speed = prop/100;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? speed = 100;
> + ? ? ? }
> + ? ? ? printk("%s : speed->%d\n",__func__, speed);
> +
> + ? ? ? for_each_child_of_node(bus, child) {
> + ? ? ? ? ? ? ? u32 prop;
> +
> + ? ? ? ? ? ? ? printk(" ? create child: %s\n", child->full_name);
> + ? ? ? ? ? ? ? i2c_board_info = kzalloc(sizeof(*i2c_board_info), GFP_KERNEL);
> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "reg",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
> + ? ? ? ? ? ? ? i2c_board_info->addr = prop;
> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "interrupts",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
> + ? ? ? ? ? ? ? i2c_board_info->irq = prop;
> + ? ? ? ? ? ? ? i2c_board_info->platform_data = platform_data;
> + ? ? ? ? ? ? ? strncpy(i2c_board_info->type, child->name,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(i2c_board_info->type));
> + ? ? ? }
> + ? ? ? omap_register_i2c_bus(id, speed, i2c_board_info, 1);

While this does in a sense work, and creates an omap_device for the
i2c bus that does get probed, it ends up encoding an awful lot of
device specific details into the generic devicetree support code.  The
i2c bus driver itself must be responsible for decoding the speed and
child nodes, and in fact it can easily be modified to do so (I've
already demonstrated how to do so).  The real problem is making sure
the platform_device is created in a way that attaches the correct
hwmod data. For this context, the current omap_register_i2c_bus()
isn't a useful method for doing so.

So what is to be done?  omap_register_i2c_bus() does three things;
1) register an i2c board info for the bus with i2c_register_board_info(),
2) fill platform_data for the device, and
3) use omap_i2c_add_bus to create the platform_device with attached hwmod.

Of these three, 1 & 2 must not be done when using the DT. Only
omap_i2c_add_bus() does something useful, but that is still specific
to the i2c device.

omap_i2c_add_bus() splits to omap{1,2}_add_bus().

omap1_i2c_add_bus() sets up pinmux and calls platform_device register.
 pinmux setup needs to be factored out anyway for generic DT platform
device registration, which just leaves platform_device creation which
is already handled by of_platform_populate().

omap2_i2c_add_bus() does the same thing, except it also looks up the
hwmod data (*oh) and uses it to call omap_device_build().
omap_device_build() or something equivalent needs to be called for
every omap device in the system, which is to create platform_devices
with hwmod attached.  Now we're starting to hit generic code.  :-)

The way I see it, you've got two options:

1) modify the of_platform_bus_create() to call some kind of
of_platform_bus_create_omap() for devices that match "ti,omap3-device"
or something.

2) Leave of_platform_bus_create(), and instead us a notifier to attach
hwmod data to normal platform devices.  omap_device_build() is
actually pretty simple.  It allocated a device, it attaches
platform_data and hwmod pointers to the device and registers it.
omap_device_register() is just a wrapper around
platform_device_register().

My preference is definitely #2, but there is a wrinkle in this
approach.  Unfortunately omap_devices are not simply plain
platform_devices with extra data attached, an omap_device actually
embeds the platform_device inside it, which cannot be attached after
the fact.  I think I had talked with Kevin (cc'd) about eliminating
the embedding, but I cannot remember clearly on this point.  As long
as platform_device remains embedded inside struct omap_device, #2
won't work.

In either case, looking up the correct hwmod data should be easy for
any device provided the omap code maintains a lookup table of
compatible strings and base addresses of devices (much like auxdata).
In fact, I'd be okay with extending auxdata to include OMAP fields if
that would be easiest since the whole point of auxdata is to ease the
transition to DT support.  When a matching device is created, the
hwmod pointer can easily be attached.  This should work transparently
for all omap devices, not just the i2c bus.

> +}
> +
> ?/**
> ?* of_platform_bus_create() - Create a device for a node and its children.
> ?* @bus: device node of the bus to instantiate
> @@ -593,6 +642,11 @@ static int of_platform_bus_create(struct device_node *bus,
> ? ? ? ? ? ? ? ?return 0;
> ? ? ? ?}
>
> + ? ? ? if (of_device_is_compatible(bus, "ti,omap3-i2c")) {
> + ? ? ? ? ? ? ? of_omap_i2c_device_create(bus, bus_id, platform_data, parent);
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> +
> ? ? ? ?dev = of_platform_device_create_pdata(bus, bus_id,
> platform_data, parent);
> ? ? ? ?if (!dev || !of_match_node(matches, bus))
> ? ? ? ? ? ? ? ?return 0;
>
> -M
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
