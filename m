From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 19 Feb 2017 21:12:32 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <20170216182957.zypkvmg7xhwu6geq@lukather>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
 <20170216061753.sd7zjs5jzdingufp@localhost>
 <20170216182957.zypkvmg7xhwu6geq@lukather>
Message-ID: <20170219201232.uvja5jvqhmltobra@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 07:29:57PM +0100, Maxime Ripard wrote:
> On Thu, Feb 16, 2017 at 07:17:54AM +0100, Rask Ingemann Lambertsen wrote:
> > > > Supported features (+ means tested):
[...]
> > > > + SATA port on on-board SATA-to-USB bridge *
[...]
> > > > * Only shows up when a SATA device is connected. Also, if a power source
> > > >   is connected to the USB 3.0 connector across power cycles (e.g. FEL
> > > >   boot), the bridge may not properly reset and not show up on the USB bus.
> > > >   The vendor U-Boot performs some unknown magic which resets the bridge.
> > > 
> > > Is that magic at the USB level, or specific to the bridge itself?
> > 
> > I don't know, but since the other USB port connected to the hub comes up
> > fine, I'm assuming it's something to do with the SATA-to-USB bridge.
> 
> But where is that magic written to then? the USB controller registers,
> or is it an USB packet?

I don't know. Like I said, unknown magic. I haven't found the source code to
the U-Boot version that the board uses.

For all I know, it could be a bug in the Linux USB stack. I've always had
to unplug and replug my USB keyboards after Linux has booted, otherwise
they are not detected. If the keyboard was connected to a hub, Linux doesn't
detect that port on the hub, so the hub must be unplugged and replugged.
If it's an internal hub, tough luck.

> > > > +	reg_usb0_vbus: regulator-usb0-vbus {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-name = "usb0-vbus";
> > > > +		regulator-min-microvolt = <5000000>;
> > > > +		regulator-max-microvolt = <5000000>;
> > > > +		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;	/* PH15 */
> > > > +		enable-active-high;
> > > 
> > > This is redundant with the GPIO flag

The GPIO flag is overridden by the regulator core, which makes it misleading.
I will remove the GPIO flag and add a comment there that GPIO flags are not
supported. This is to prevent someone from thinking that

gpio = <... GPIO_ACTIVE_HIGH>;
enable-active-high;

and

gpio = <... GPIO_ACTIVE_LOW>;

are equivalent. It would be an easy mistake to make, because in mmc nodes,

cd-gpios = <...  GPIO_ACTIVE_HIGH>;

and

cd-gpios = <...  GPIO_ACTIVE_LOW>;
cd-inverted;

_are_ equivalent.

> > No. I have now tested without "enable-active-high" and then Vbus stays off.
> > This is also in line with the binding documentation:
> > 
> > "- enable-active-high: Polarity of GPIO is Active high
> >  If this property is missing, the default assumed is Active low."
> >
> > It also seems to me that the way this is implemented in Linux, the GPIO
> > polarity flag is ignored.
> 
> It works just fine if the driver uses the gpiod API. If that driver
> doesn't, then that driver needs some fixing :)

Take it up with the maintainer of the regulator core, then. :)
>From of_get_fixed_voltage_config() in drivers/regulator/fixed.c:
[...]
	config->gpio = of_get_named_gpio(np, "gpio", 0);
[...]
	config->enable_high = of_property_read_bool(np, "enable-active-high");
	config->gpio_is_open_drain = of_property_read_bool(np,
							   "gpio-open-drain");
[...]

>From reg_fixed_voltage_probe() in drivers/regulator/fixed.c:
[...]
		config = of_get_fixed_voltage_config(&pdev->dev,
						     &drvdata->desc);
[...]
	if (gpio_is_valid(config->gpio)) {
		cfg.ena_gpio = config->gpio;
		if (pdev->dev.of_node)
			cfg.ena_gpio_initialized = true;
	}
	cfg.ena_gpio_invert = !config->enable_high;
	if (config->enabled_at_boot) {
		if (config->enable_high)
			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
		else
			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
	} else {
		if (config->enable_high)
			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
		else
			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
	}
	if (config->gpio_is_open_drain)
		cfg.ena_gpio_flags |= GPIOF_OPEN_DRAIN;
[...]

>From regulator_ena_gpio_request() in drivers/regulator/core.c:
[...]
	gpiod = gpio_to_desc(config->ena_gpio);
[...]
	ret = gpio_request_one(config->ena_gpio,
				GPIOF_DIR_OUT | config->ena_gpio_flags,
				rdev_get_name(rdev));
[...]
	pin->gpiod = gpiod;
	pin->ena_gpio_invert = config->ena_gpio_invert;

And finally, gpio_request_one() in drivers/gpio/gpiolib-legacy.c:

int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
{
	struct gpio_desc *desc;
	int err;

	desc = gpio_to_desc(gpio);
[...]
	if (flags & GPIOF_OPEN_DRAIN)
		set_bit(FLAG_OPEN_DRAIN, &desc->flags);

	if (flags & GPIOF_OPEN_SOURCE)
		set_bit(FLAG_OPEN_SOURCE, &desc->flags);

	if (flags & GPIOF_ACTIVE_LOW)
		set_bit(FLAG_ACTIVE_LOW, &desc->flags);

	if (flags & GPIOF_DIR_IN)
		err = gpiod_direction_input(desc);
	else
		err = gpiod_direction_output_raw(desc,
				(flags & GPIOF_INIT_HIGH) ? 1 : 0);
[...]

> > > > +		regulator-always-on;
> > > 
> > > And it shouldn't be always on. The USB driver will enable it if needs
> > > be.
> > 
> > Yes, we just don't have a driver for the A80 USB 3.0 port yet.
> 
> Aaah, so that's what you meant. Leave it out of the DT then.

OK.

> > > You're listing a minimum state of 750mv, yet your minimum voltage is
> > > 800mV.
> > 
> > Yes. The regulator is capable of outputting the listed voltages in the
> > 750 mV to 1200 mV range, but the permissible range of the consumer is only
> > 800 mV to 1100 mV according to the A80 data sheet. Likewise, the AXP806
> > regulators support a larger voltage range than that of the connected
> > consumers.
> 
> Adding a comment stating that would be nice then.

OK.

> > > > +	pmic at 745 {
> > > > +		compatible = "x-powers,axp808", "x-powers,axp806";
> > > > +		reg = <0x745>;
> > > > +		interrupt-parent = <&nmi_intc>;
> > > > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > > > +		interrupt-controller;
> > > > +		#interrupt-cells = <1>;
> > > > +
> > > > +		swin-supply = <&reg_dcdce>;
> > > 
> > > Please use an incude for that PMIC.
> > 
> > I don't understand. What would that include file contain? Very few lines
> > would be shared between .dts files. You could save < 8 lines total if you
> > #include the 5 lines that are common between the Cubieboard4, the Optimus
> > and this board.
> 
> You also have to take into account that the PMIC is barely supported
> at the moment, you'll also need to define the GPIO controllers, the
> various power supplies, adc, etc. nodes that are going (hopefully to
> be added) in the future.
> 
> If the include is shared, once it is enabled, every one benefits from
> it. Otherwise, you have to duplicate that change across all DTs. This
> is much likely to error, harder to maintain, and you end up in a
> situation where none of the boards really support the same feature set
> while being based on the same SoC / PMIC combination.

Fair enough, I'll add an include file the next time around. Like you
mentioned youself, though, we will only really know how compatible the two
PMICs are when we have the code to support the other features (or a data
sheet/user's manual is found). I'm hopeful based on what has been found so
far.

-- 
Rask Ingemann Lambertsen
