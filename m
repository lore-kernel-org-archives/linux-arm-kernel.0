From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 22 Oct 2013 18:06:44 -0500
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <1608328105.3024513.1382481731286.JavaMail.zimbra@advansee.com>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
 <20131022123544.GB31304@pengutronix.de>
 <CAHCPf3tLovKaCWAQn13c+ifvzQH4ojcXyevYxbh018XYYK=xJA@mail.gmail.com>
 <20131022215747.GC31304@pengutronix.de>
 <1608328105.3024513.1382481731286.JavaMail.zimbra@advansee.com>
Message-ID: <CAHCPf3vPCTmKOWEMNeJBEd7eXO_Z-cWX=-hqcYT81K6BFQqa2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 5:42 PM, Beno?t Th?baudeau
<benoit.thebaudeau@advansee.com> wrote:
> Dear Sascha Hauer,
>
> On Tuesday, October 22, 2013 11:57:47 PM, Sascha Hauer wrote:
>> > >
>> > > 0 is definitely wrong here. We have 0x80000000 for "Don't touch
>> > > padctrl", but otherwise this should contain some real padctrl settings.
>> >
>> > A more pressing question is in what world did the bootloader not
>> > already set these pins up and if they are already set up, why are they
>> > loitering in the device tree?
>>
>> Having NO_PAD_CTRL in the devicetree doesn't make sense, you're right.
>> Either a pin has to be configured by the bootloader completely or not at
>> all. Having the mux configured by the kernel and the drive strength by
>> the bootloader is broken by design. All pins should have a complete
>> padctrl setup and NO_PAD_CTRL should be dropped.
>
> Some pins may be configured completely by the kernel, and not at all by the
> bootloader. In that case, the device tree may wish to keep the SoC reset pad
> configuration. NO_PAD_CTRL is useful in that case, although one might argue that
> the reset values should not be trusted for various reasons.

No, that's totally illogical. The magic bit to "leave my pad controls
alone" makes no sense since you're re-configuring mux mode and input
select (even if they're the same as the bootloader, you're doing it
twice).

There are two reasons this gets done, both of which are very very odd..

1) The definition of the pinmux tuple of 3 register/value pairs is
ordered such that the pad control can be set independently of the
preprocessor definition for the pad (which supplies the first 5 values
in the 6 value pin definition). This is weird since one of the values
doesn't belong to the register the value pair is intended for, and
saying "do not

2) The reason we have to define the three registers even if we "don't
change values" is so users (or userspace) can fiddle with the GPIOs
through some never-used non-existent (since it doesn't expose these
values) sysfs pinmuxing API.

In this case, you don't "set the pad control to 'do not touch'" but
supply the exact values from the manual or empirically derived from
inspection at SoC power on. There is ZERO use for a 'do not touch'
bit. In the case where it turns out the bootloader is wrong, you'll
have to supply a value here anyway. So supply the default.

In reality what would happen is the binding gets a kick in the pants
so it makes more sense, and we define that the bootloader MUST set up
all static pin multiplexing configuration at the earliest opportunity
and save Linux the hassle. pinctrl is for microcontrollers and
robotics boards - Arduino or BeagleBone Black where you have expansion
connectors which could have multiple useful configurations, or be
changed on a hotpluggable attachment.

Even if your bootloader doesn't use the pins, it should at least set
them up for later, for electrical reasons. If the default direction
for a gpio mux is output, who knows what it is for a custom peripheral
mux, and if your peripheral has an output on that pin.. then you're
driving outputs from both sides, which is nonsensical. If the default
direction is input, and your peripheral is an input, you can set up
conditions where essentially the value floats (or at least is
unpredictable) at the peripheral side.

Your hardware guy will usually slap you for leaving it in the wrong
state for the time it takes to load Linux from SD card or SPI NOR, and
decompress, and get to several seconds into the boot process before
configuring pin muxing, or even to past the init daemon, so it can do
a module or firmware load first.

> But there is another case. One SoC pin may be connected to several external
> devices, e.g. through an external analog mux. In that case, the bootloader may
> configure the SoC mux and pad for one usage, while the kernel may afterwards
> change only the mux configuration of this pin for the other usage.

This is the ONLY use case it makes any sense in a static
configuration, but at this point, why not just supply the required
value, even if it's the chip default? If the configuration for "kernel
time" is fixed, the bootloader should quiesce the device and configure
it for the kernel to match the device tree. There are a bunch of
configurations on i.MX51 where the DT is redefining the default pinmux
for the SoC... pointlessly..

> So NO_PAD_CTRL is not strictly required for pinctrl, but it can be handy.

Given that 0x0 (or 0x80000000) takes up exactly the same amount of
space and time to research and put in the tree as the ACTUAL required
pad settings from the manual or empirically supplied, supplying the
pad settings makes more sense (and is far, far more descriptive).
There is a case here for cross-checking ALL DT hardware configuration
details against the actual configuration of the hardware, and
supplying a weird pinctrl definition (for instance, setting a RAZ bit
as 1, or a RAO bit to 0) could be caught this way (there are *lots* of
pin definitions out there in the world for i.MX at least which are
doing this, some of them in the Boot ROM DCD table...)

-- 
Matt Sealey <neko@bakuhatsu.net>
