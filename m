From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 23:17:36 +0200
Subject: [RFC v5 4/4] gpio: dt-bindings: add gpio-mmio bindings
In-Reply-To: <20160429111500.GA23726@leverpostej>
References: <cover.1461888822.git.chunkeey@googlemail.com>
 <a0ded4d0161f7ab3cd1945741d95d2718dbe4f44.1461888822.git.chunkeey@googlemail.com>
 <20160429111500.GA23726@leverpostej>
Message-ID: <4076961.kk4fBVZfd9@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(I'm sort of answering both of yours and Linus' questions)

On Friday, April 29, 2016 12:15:01 PM Mark Rutland wrote:
> As a general thing, please put the binding earlier in a series than code
> implemeting it, as that that makes it easier to review the series
> in-order (with context from the binding making code review easier). See
> Documentation/devicetree/bindings/submitting-patches.txt

Understood. I have to rebase my series anyway since Linus Walleij already
merged two related patches (the bugfix and the rename patch). For the new
series I'll put the binding on the top.
 
> On Fri, Apr 29, 2016 at 02:53:17AM +0200, Christian Lamparter wrote:
> > From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> > 
> > This patch adds the device tree bindings for the gpio-mmio.
> > The gpio-mmio is already part of a the GPIO generic library.
> > 
> > Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> > Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> > ---
> >  .../devicetree/bindings/gpio/gpio-mmio.txt         | 73 ++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mmio.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.txt b/Documentation/devicetree/bindings/gpio/gpio-mmio.txt
> > new file mode 100644
> > index 0000000..cc7f0b1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.txt
> > @@ -0,0 +1,73 @@
> > +Bindings for the generic driver for memory-mapped GPIO controllers.
> > +
> 
> Bindings should be for hardware (either specific device models, or for
> classes), and not for Linux drivers. The latter is subject to arbitrary
> changes while the former is not, as old hardware continues to exist and
> does not change while drivers get completely reworked.
Ok, maybe here's part of the problem. I'm thinking that the GPIOs devices
I'm referring to:
	MyBook Live
	brcm63xx (which is a popular router SoC so there are many boards)

are the same common class: "memory-mapped gpio". It's is a bit
unfortunate that the linux driver file name was gpio-generic.c. (But
this since been fixed... actually funny thing is that it started as:
basic_mmio_gpio.c)

The important bit is that, when I looked around: there is was already
an existing device binding in the form of a platform_device called:
"basic-mmio-gpio" [0].

commit aeec56e331c6d2750de02ef34b305338305ca690
Author: Anton Vorontsov <cbouatmailru@gmail.com>
Date:   Wed Oct 27 15:33:15 2010 -0700

    gpio: add driver for basic memory-mapped GPIO controllers
    
    The basic GPIO controllers may be found in various on-board FPGA and ASIC
    solutions that are used to control board's switches, LEDs, chip-selects,
    Ethernet/USB PHY power, etc.
    
    These controllers may not provide any means of pin setup
    (in/out/open drain).
    
    The driver supports:
    - 8/16/32/64 bits registers;
    - GPIO controllers with clear/set registers;
    - GPIO controllers with a single "data" register;
    - Big endian bits/GPIOs ordering (mostly used on PowerPC).

And there are a users of this "basic-mmio-gpio" interface:
arch/arm/mach-s3c64xx/mach-crag6410.c
arch/arm/mach-omap1/board-ams-delta.c
arch/arm/mach-imx/mach-mx21ads.c
arch/arm/mach-clps711x/board-p720t.c
arch/arm/mach-clps711x/board-autcpu12.c

to that end: The patch series proposed by Mr. Fern?ndez simply added a
device-tree-parser for translating the fdt into a bgpio_pdata platform
structure and use the existing interface with the same "basic-mmio-gpio"
compatible string. So unless steps are taken to remove or rename this
"basic-mmio-gpio" interface there will be patches like this (in your inboxes).
[I know: It's a silly idea to actually touch it, as it'll break compatibility]

> So please frame this binding document in terms of the class of hardware
> you are trying to address. Please provide some introduction to the
> assumptions that you are making about said hardware, such that it's
> obvious when one needs a more specific binding.
> 
> I share the same fears that Rob mentioned in that while this may appear
> simple now, the limitations are unclear, and this effectively prevents
> us from accurately/specifically describing some hardware.
Well, I think this has been trainwrecked enough. But there's a way out:
I would really like to preserve the bgpio_basic_mmio_parse_dt so probably
going to introduce a "wd,mbl-gpio" binding for my own hardware and let 
potential new user be able to reuse the generic dt parser. This will cut
down on the work required to add a device. As they will only need to add
an compatible entry to of_device_id list of the driver like this:
	"brcm,bcm63xx-gpio", bgpio_basic_mmio_parse_dt

Will this work for you Linus, Rob and Mark?

That said, I'm still going through the rest of the post. As some of the
issues are still relevant for the "wd,mbl-gpio" as well.

> Regardless, I've taken the time to review the below, and I have a number
> of comments.
> 
> > +Required properties:
> > +	- reg-names: must contain
> > +		"dat" - data register
> > +		may contain
> > +		"set" - data set register
> > +		"clr" - data clear register
> > +		"dirout" - direction output register
> > +		"dirin" - direction input register
> 
> Below, we mention endianness. Are registers an arbitrary number of bytes
> long? In what unit size are they grouped (e.g. {8,16,32,64}-bit)?
No, sadly they can't be (commit log above). The basic_mmio_gpio
device only supports 8/16/32/64 bits registers and you only can
have one register. 

In a nutshell, the basic_mmio_gpio is a glorified
io(read|write)(8|16|32|64)[be] interface. And that's what makes it appealing.
It won't be long until someone clobbers together gpiohog, gpio-led,
gpio-key-polled, led-triggers definitions and implements a full turing machine
within a fdt just for the fun of it.
 
> What are the expectations for the set/clear/dirin/dirout registers? Are
> they write-one to modify, or write-zero to modify?

There's a paragraph in the driver:
"For the single output register, this drives a 1 by setting a bit and a zero
by clearing a bit.  For the set clr pair, this drives a 1 by setting a bit
in the set register and clears it by setting a bit in the clear register.
The configuration is detected by which resources are present."

I'll add that to the binding.

About dirin/dirout. There can only be either be one of the two.
dirin: 1 = GPIO is input, 0 = GPIO is output
dirout: 1 = GPIO is output, 1 = GPIO is input

> For the names, don't bother abbreviating (i.e. use "data", "set",
> "clear").
>
> These names might clash with the real names a specific HW model applies
> to its register sets, which means that this binding is exclusive w.r.t.
> a specific binding for a device (i.e. it cannot be extended with
> device-specific information).
> 
> If we're happy with that, then we must call out the expected limitations
> on the use of this binding, or we end up with the not-so-simple-any-more
> issues Rob mentioned previously. 

Sadly the resource names are part of the original commit. It's not possible
without adding a resource rename step in the dt parser or breaking 
compatibility with existing interface. So, the question would be: which one
do you actually want or better yet: "what can we agree on?".
 
> > +	- reg: address + size pairs describing the GPIO register sets;
> > +		order must correspond with the order of entries in reg-names
> > +	- #gpio-cells = must be set to 2
> 
> Where the cells encode what? I'm guessing this is <$idx $flags>, but you
> should spell that out explicitly.
Ok. I'll add that.
 
> > +	- gpio-controller: Marks the device node as a gpio controller.
> > +
> > +Optional properties:
> > +	- ngpio: specifies the number of gpio mapped in the register.
> > +	- big-endian: force big endian register accesses.
> > +	- big-endian-byte-order: assign GPIOs in reverse order.
> 
> I cannot parse this last description. It needs a better wording.
> 
> I guess this means that the indices (in the first GPIO cell) are applied
> in descending order for ascending chunks of the registers (and that is a
> poor description, too).

I looked up the proper CS terms: 
"big-endian-byte-order: assign GPIOs in MSB 0 bit numbering order."
(The default is: LSB 0 bit numbering)

> > +	- unreadable-reg-set: data set register is not readable.
> > +	- read-output-reg-set: cache value set for reads.
> > +	- unreadable-reg-dir: dirout/dirin register is not readable.
> > +	- no-output: GPIOs are read-only.
> > +
> > +The GPIO generic library provides support for memory-mapped GPIO
> > +controllers. The configuration is detected by which resources are present.
> > +The simplest form of a GPIO controller that the driver support is just a
> > +single "dat" register, where GPIO state can be read and/or written.
> > +However, the driver supports far more:
> > +	- 8/16/32/64 bits registers. The number of GPIOs is automatically
> > +	  determined by the width of the registers.
> > +	- GPIO controllers with clear/set registers.
> > +	- GPIO controllers with a single "dat" register.
> > +	- Big endian bits/GPIOs ordering.
> 
> Reword this in terms of the class of hardware you are trying to support,
> (rather than the specific library code you are using), and move it to
> the introduction at the top of the binding.

Yes. That said the MyBook Live only has a bidirectional "dat" register
and 8 bit for GPIOs (this simplifies a lot of things).

Unless of course, we can somehow agree on the generic approach.
 
Regards,
Christian

[0] <http://marc.info/?l=git-commits-head&m=128867795112158&w=2>
