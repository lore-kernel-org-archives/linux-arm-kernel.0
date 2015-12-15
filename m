From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 15 Dec 2015 10:09:38 +0100
Subject: [PATCH 1/3] Device tree binding documentation for gpio-switch
In-Reply-To: <CAL_JsqJXX71Bwbm21H3QAJxYDO60kyHgKVzXxxrH9ze6ZWYtXw@mail.gmail.com>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <CACRpkdYvU6YG5yRCLsyS7sq816t3shWw51OTR2-fkp-FqSeESg@mail.gmail.com>
 <CAL_JsqJXX71Bwbm21H3QAJxYDO60kyHgKVzXxxrH9ze6ZWYtXw@mail.gmail.com>
Message-ID: <1488914.9p6SgUg6XA@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 14 December 2015 09:45:48 Rob Herring wrote:
> On Mon, Dec 14, 2015 at 8:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Dec 11, 2015 at 3:06 PM, Rob Herring <robh+dt@kernel.org> wrote:
> >> On Fri, Dec 11, 2015 at 6:39 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >>> On Fri, Dec 4, 2015 at 6:31 PM, Martyn Welch
> >>> <martyn.welch@collabora.co.uk> wrote:
> 
> [...]
> 
> >>> Markus Pargmann also did a series that add initial values to
> >>> hogs, which is the inverse usecase of this, where you want to
> >>> *output* something by default, then maybe also make it available
> >>> to userspace.
> >>>
> >>> So what we need to see here is a patch series that does all of these
> >>> things:
> >>>
> >>> - Name lines
> >>>
> >>> - Sets them to initial values
> >>>
> >>> - Mark them as read-only
> >>>
> >>> - Mark them as "not used by the operating system" so that they
> >>>   can be default-exported to userspace.
> >>
> >> No! This should not be a DT property.
> >>
> >> Whether I want to control a GPIO in the kernel or userspace is not
> >> known and can change over time. It could simply depend on kernel
> >> config. There is also the case that a GPIO has no connection or kernel
> >> driver until some time later when a DT overlay for an expansion board
> >> is applied.
> >
> > That's correct. So from a DT point of view, what really matters is
> > to give things a name, and the hogs and initvals syntax already
> > has a structure for this that is in use
> > (from Documentation/devicetree/bindings/gpio/gpio.txt):
> >
> >         qe_pio_a: gpio-controller at 1400 {
> >                 compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
> >                 reg = <0x1400 0x18>;
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >
> >                 line_b {
> >                         gpio-hog;
> >                         gpios = <6 0>;
> >                         output-low;
> >                         line-name = "foo-bar-gpio";
> >                 };
> >         };
> >
> > Markus use this also for initial values. That could easily be used in
> > a budget version like this:
> >
> >                 line_b {
> >                         /* Just naming */
> >                         gpios = <6 0>;
> >                         line-name = "foo-bar-gpio";
> >                 };
> >
> > That could grow kind of big though. Or maybe not? How many
> > GPIO lines are actually properly named in a typical system?
> 
> We should limit it to GPIOs with no connection to another node. For
> example, I don't want to see a SD card detect in the list as that
> should be in the SD host node. However, that is hard to enforce and
> can change over time. Removing it would break userspace potentially.
> Of course if the kernel starts own a signal that userspace used, then
> that potentially breaks userspace regardless of the DT changing. OTOH,
> using GPIOs in userspace is kind of use at your own risk.

I see this a bit differently. I would really like to see the each GPIO having
two different names:
- GPIO label: This is the name of the GPIO line in the schematic for example
- GPIO use (this is the current semantic of the GPIO name): The use of a GPIO,
  e.g. 'sd-card-detect', 'LED', ...

I think it would be good to describe all GPIO labels in gpiochip subnodes as
gpio-hogging introduced it. This would offer a use-independent naming. The use
of the function could be defined in the device node that is using this gpio.

As an example perhaps something like this:

	&gpiochip {
		some_interrupt {
			gpios = <4 0>;
			line-name = "some_interrupt_line";
		};

		line_b {
			gpios = <6 0>;
			line-name = "line-b";
		};
	};

	randomswitch {
		compatible = "gpio-switch";
		gpios = <&gpiochip 4 0>;
		use = "action-trigger";
		read-only;
	};

Also this does seem kind of inconsistent with gpio-hogging and the proposed
gpio-initval. gpio-hogging is defined in subnodes of the gpio chip while
gpio-switches are not. As "gpio-switch" is not really any kind of device it
would perhaps make sense to keep this consistent with gpio-hogging as well and
define it in the same subnodes?
I would be happy about any consistent way.

> 
> The only real differences between this and Martyn's proposal are the
> location of the nodes and having a compatible string. A compatible
> string may be good to have. It indicates type of signal, but not
> specific use. Similar to how gpio-key compatible defines the function,
> but not what key code, or gpio-led does not say what color LED. A
> compatible here could cover switches, mode/id/revision strapping
> signals, jumpers, presence detect, etc.
> 
> > The problem is that naming is usually imposed by consumers (they
> > are the ones who know how the line is used).
> >
> > And then I do not mean naming it after the pin on the capsule
> > where it comes out as per the datasheet, but
> > naming it after the actual use.
> 
> Right. We need a way to query "I need the GPIO that does X" which
> works across boards.
> 
> > Naming it after the hardware specs is something the operating
> > system can do, in Linux' case by the array char *names; inside the
> > struct gpio_chip and should not be part of the bindings IMO.
> 
> Agreed. That just came up with STM32 gpio bindings[1].
> 
> > I would rather imagine this is something used in a top-level board
> > file naming it: "header-2-22" for the 22nd pin on some second header
> > on my BeagleBone Black or something like that. And those may not
> > be so vast in numbers so they could be named using this pattern.
> 
> Exactly. This is one of the cases I care about. However, this is not
> really a function, but it is SOC independent at least.
> 
> We also have to consider how to handle add-on boards. We probably need
> a connector node which can remap connector signals to host signals in
> order to have overlays independent of the host board DT. For GPIOs
> this is probably a gpio-map property similar to interrupt-map. The
> complicated part will be connectors that require pinmux setup of the
> host.

Also what about hotplugging gpio-chips? Is there any mechanism to let the
'gpio-switch' know that the GPIO is not there anymore?

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151215/6a2743a5/attachment-0001.sig>
