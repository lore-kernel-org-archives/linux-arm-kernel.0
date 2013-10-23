From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 09:57:58 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022211000.GA30394@roeck-us.net>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
 <52665314.2040904@imgtec.com>
 <232aa6e4-19fe-4460-8101-8bf1d639ff3c@email.android.com>
 <20131022164922.GA29852@roeck-us.net>
 <20131022203546.GC8037@mithrandir>
 <20131022211000.GA30394@roeck-us.net>
Message-ID: <20131023075758.GA7404@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 02:10:00PM -0700, Guenter Roeck wrote:
[...]
> Thinking about it, much of a hardware description can be seen as "use
> case", at least when it comes to gpio pins or adc channels.

There are many more examples where this is the case. Regulators are one
example. A regulator is pretty much useless until you connect it up to
some other device.

The same goes for things like a backlight. Sure we can expose backlights
via sysfs and tell people to use that interface to control the backlight
but that just doesn't always work. Furthermore, backlights don't always
need to be associated with display panels. They can be used together
with keyboards too...

In order to effectively make use of these basic building blocks we need
some way to interconnect them, because they cannot be correlated to each
other without some form of meta data.

> > But on the other hand we do the same with other "resources". GPIOs for
> > example are rather useless if you don't associate them with specific
> > functionality. And we actually do that quite often. They are used in
> > properties such as:
> > 
> > 	foo {
> > 		...
> > 		enable-gpios = <&gpio 42 0>;
> > 		...
> > 	};
> > 
> > I don't see how that is different to the ADC/sensor example above.
> > Perhaps there's no real physical device that is the sensor, but if we
> > can't even represent simple yet essential things like that in DT, then
> > we definitely need something better.
> > 
> I don't think the issue is "can". After all, the restriction that DT shall only
> describe HW and not its use is purely arbitrary.

That's what I was trying to say. "can" in the sense of "not able because
we're arbitrarily restricting what we can express with DT".

Now, I can even understand why it's a good idea to keep Linux-specifics
out of the DT and not encode software policy within it, but all these
examples aren't software policy nor Linux-specifics. In my opinion they
describe hardware. They may not restrict themselves to the bare minimum,
but they give meaning to the hardware so that an operating system can
use it.

If we cannot describe these things in DT but have to come up with some
alternative method to describe it, then any other operating system would
either need to copy that alternative method (in which case there's no
point at all in keeping it separate from DT) or invent yet something
different to describe those relationships.

I've said above that I understand why it can be good to keep DT hardware
specific, but I also think that if that's what we end up deciding, we'll
still need to supplement it with something that can describe software
policy. With our concept of DT right now we're regressing with respect
to board files because some things can no longer be described.

> > We do pretty much the same thing with regulators. We can have fixed
> > regulators that control a GPIO, yet there's no physical device that one
> > could associate with such regulators either.
> > 
> > > Another example is my recent attempt to add dt support to gpio based connectors.
> > > Even though a connector is as much hardware as it can get (or at least one
> > > should think so), that was rejected because it isn't generic enough and,
> > > after all, it describes the _use_ of gpio pins which apparently is already
> > > borderline. So now I have my own out of tree driver (where I can add as many
> > > bindings and as much functionality as I want and see fit, so I am not too
> > > unhappy about that).
> > 
> > That's odd. This sounds exactly like a variant of the above. Would you
> > mind posting the binding (or a usage example here)? I'd be interested to
> > understand why it would be inappropriate.
> > 
> 
> Patch 4 and 5 of https://lkml.org/lkml/2013/8/30/23.
> 
> The bindings I currently use are actually a bit more complex.
> Here is an example.
> 
>         pic1 {
>             compatible = "jnpr,pic-connector";
>             presence-detect-gpios = <&gpio20 36 0x10013>;
>             request-button-gpios = <&gpio20 38 0x10013>;
>             power-enable-gpios = <&gpio20 42 0x0>;
>             power-status-gpios = <&gpio20 39 0x3>;
>             reset-gpios = <&gpio20 41 0x10000>;
>             power-enable-timeout = <2000>;
>             debounce-interval = <1>;
>             led-green = <&pic1_green>;
>             led-red = <&pic1_red>;
> 
>             i2c-bus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 i2c-parent = <&pic1i2c>;
> 
>                 eeprom at 55 {
>                     compatible = "atmel,24c02";
>                     reg = <0x55>;
>                     ideeprom;
>                 };
>             };
>         };
> 
> [ Note this is preliminary, and I expect some of the bindings to change.
>   Also, I have no plan to even try to get this code upstream ;) ]

This is rather complex, but then, describing relationships within one
board is already difficult, so I'm not surprised that describing
connections between boards is even more difficult. I suspect that the
above could more traditionally be written as:

	pic1i2c: i2c-controller {
		...

		eeprom at 55 {
			/* insert all other properties here */
		};
	};

But that breaks down once you start needing to represent more than just
a single EEPROM behind the connector.

> > > not the very least because DT isn't supported on x86 and I have to deal with
> > > that situation as well (and, no, ACPI doesn't solve my problems there either).
> > 
> > Actually DT is supported very well on x86. There's at least one platform
> > in mainline that uses it (arch/x86/platform/ce4100/falconfalls.dts) and
> > I've ported a platform that I worked on in the past to use DT on x86 as
> > well.
> > 
> But presumably that was DT only, or was it a system that needs to use
> DT on top of ACPI ? If so, I would be very interested in that experience,
> especially if you had any issues to get it working.

I'm not quite sure I understand what you mean by "on top of ACPI". The
device certainly did support ACPI, but I was using DT more as a
supplement to describe what ACPI and PCI couldn't.

To be somewhat more specific, the platform used an FPGA connected to the
chipset using PCIe. That itself was excellent because all of a sudden
devices were actually discoverable. So it was easy to just implement a
GPIO, SPI or I2C controller and whatnot within that FPGA, but once a
device behind SPI or I2C needed to be hooked up, you loose all benefits
from having something like PCI and you're back to square one.

One example where this became essential was that the touchscreen on the
device was controlled by an I2C chip, and the touchscreen controller's
interrupt pin was connected to the GPIO controller on the PCI bus. So
what we ended up with looked roughly something like this:

	pci at 3fc {
		[...bunch of nodes to describe PCI hierarchy...]

		pci at 2,0 {
			/* GPIO expander */
			gpio: pci at 0,0 {
				...
				interrupt-controller;
				...
			};
		};

		[...more nodes...]

		pci at 8,0 {
			/* I2C controller */
			pci at 0,0 {
				touchscreen at 48 {
					...
					interrupt-parent = <&gpio>;
					interrupts = <1 0x8>;
					...
				};
			};
		};
	};

That's a *very* simplified form. The complete device tree is much more
complex because it requires the exact hierarchy of PCI to be represented
in order for the right device nodes to end up attached to the right PCI
devices.

But perhaps that doesn't help you at all with the problems that you've
encountered?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/9e6fded2/attachment.sig>
