From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 24 Oct 2013 16:13:17 -0500
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <980466485.3024975.1382487431031.JavaMail.zimbra@advansee.com>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
 <20131022123544.GB31304@pengutronix.de>
 <CAHCPf3tLovKaCWAQn13c+ifvzQH4ojcXyevYxbh018XYYK=xJA@mail.gmail.com>
 <20131022215747.GC31304@pengutronix.de>
 <1608328105.3024513.1382481731286.JavaMail.zimbra@advansee.com>
 <CAHCPf3vPCTmKOWEMNeJBEd7eXO_Z-cWX=-hqcYT81K6BFQqa2g@mail.gmail.com>
 <980466485.3024975.1382487431031.JavaMail.zimbra@advansee.com>
Message-ID: <CAHCPf3s0hwCX6pzx5Ksq3VXQC6h-pKkLdN7HLFwW_UZayZytJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 7:17 PM, Beno?t Th?baudeau
<benoit.thebaudeau@advansee.com> wrote:
> Hi Matt,

Hello Beno?t,

> On Wednesday, October 23, 2013 1:06:44 AM, Matt Sealey wrote:
>
>> No, that's totally illogical. The magic bit to "leave my pad controls
>> alone" makes no sense since you're re-configuring mux mode and input
>> select (even if they're the same as the bootloader, you're doing it
>> twice).
>>
>> There are two reasons this gets done, both of which are very very odd..
>>
>> 1) The definition of the pinmux tuple of 3 register/value pairs is
>> ordered such that the pad control can be set independently of the
>> preprocessor definition for the pad (which supplies the first 5 values
>> in the 6 value pin definition). This is weird since one of the values
>> doesn't belong to the register the value pair is intended for, and
>> saying "do not
>>
>> 2) The reason we have to define the three registers even if we "don't
>> change values" is so users (or userspace) can fiddle with the GPIOs
>> through some never-used non-existent (since it doesn't expose these
>> values) sysfs pinmuxing API.
>>
>> In this case, you don't "set the pad control to 'do not touch'" but
>> supply the exact values from the manual or empirically derived from
>> inspection at SoC power on. There is ZERO use for a 'do not touch'
>> bit. In the case where it turns out the bootloader is wrong, you'll
>> have to supply a value here anyway. So supply the default.
>
> That makes sense, but it has the disadvantage of being more error prone than
> keeping reset values if they're fine, because errors in pad settings may lead to
> bugs less obvious than bugs in mux settings.

That is true, but programmer error is programmer error.. you can
introduce it on either side.

The major use right now for "I want my pads not to be touched" is to
get past the restriction that pinctrl MUST be specified (and people
don't like adding empty, dummy entries) and to make trees more
readable (but kilobytes bigger), and the use cases where it seems
expected to redefine pad settings that are either chip defaults on POR
(hence the special pad control bit) or that the bootloader can
absolutely be guaranteed to have done, for some reason.

If you MUST specify a pinmux, specify the whole damn thing - mux,
input and pad. Not a half-way mux, input, "pad register but please
ignore me."

Having fewer ways of defining it means having fewer things to expect
when debugging.

> developers to check all pad settings has the advantage of not using reset values
> that may be wrong for some applications. All in all, removing NO_PAD_CTRL seems
> better here.

Thanks.

>> Your hardware guy will usually slap you for leaving it in the wrong
>> state for the time it takes to load Linux from SD card or SPI NOR, and
>> decompress, and get to several seconds into the boot process before
>> configuring pin muxing, or even to past the init daemon, so it can do
>> a module or firmware load first.
>
> I agree, except that a properly designed board should not connect pins set as
> outputs upon reset to the outputs of external devices, since this leaves
> potential electrical level conflicts from reset at least until the software
> cleans the mess.

True, but you cannot just say "well all my IOs on my chip default to
GPIO inputs so I cannot connect any peripheral inputs to any of them
until I have configured them". Sometimes you are at the mercy of your
SoC designer and peripheral designer, and the pad layout of your chip.

> However, you're right that such things happen and should be
> handled as you say.
>
> But if some SoC pins are used as inputs, set up as inputs by the SoC reset but
> with the wrong mux value, and unused by the bootloader, there is no reason to
> set up these pins in the bootloader rather than in the DT.

There's all the reason in the world; this SHOULD be the preferred,
default practice.

> connected to a bus disabled by default and unused in the bootloader. Actually,
> the bootloader really has to set up pins because it uses them, or for electrical
> reasons, or to disable some unused feature, but the two latter are most of the
> time an exception among all connected pins.

To give the Efika MX as an example, the bootloader needs to set up
maybe 60-70 out of a possible 80-90 pins (DDR in the DCD or BootROM
plugin, PATA, SD card (twice on some configs), LEDs, board id inputs,
pmic interrupt, spi + chipselects, uart, usb, i2c, clock outs, reset
toggles for all of the above peripherals to effectively make sure
everything is quiesced for the OS).

The things not really set up - video and audio. But a bootloader could
support video, so you could expect this will need to be set up
eventually. It may even play a sound at a future point.

When you are left with basically adding 10 or 15 more pins, and you
already implemented 70.. this is not really a difficult task. On i.MX
at least, you have the opportunity to do a lot of this inside the boot
ROM stage, and considering you want to give user interactivity,
multiple boot sources, and be sure the system is running and powered
okay before you get to the OS, you're stuck doing it.

You could do the bare minimum internally but externally - when it goes
upstream in U-Boot or something - it should all be there. Any pin
definitions in DT would be firmware bug workarounds or dynamically
configured items which can ONLY be determined at runtime (DDR mode or
voltage level selects on SDHC for example) and that are safe to
change. It is not true on i.MX, but on some SoC in the world, changing
pad mux is NOT going to be glitchless and encouraging huge amounts of
reconfiguration at OS boot time is possibly the worst thing ever.

> Agreed. It may be better to drop NO_PAD_CTRL from DT, but I still find debatable
> whether to compel to move all pin configurations to the bootloader for static
> configurations, since the less the kernel has to rely on the bootloader, the
> more reliable and self-sufficient it is (with DT).

There's a status quo of not doing it, and putting the definitions in
Linux, but I am just saying it should be encouraged to do this in the
bootloader and save the device tree space (and hassle) and reserve the
tree definitions for when you REALLY have no other choice in doing so.

I would prefer bootloaders were written with as much care as the DT should be ;)

I can't enforce it, but it can be made to be something developers
might get a 'gold star' and a smile, if they do so.

> Note that in the patch above, 0 may be intended to be the actual pad setting,
> and not to mean by mistake NO_PAD_CTRL.

It could be, but 0 for a pad setting doesn't make a lot of sense for
the vast majority of pins.. in this case, it kind of does.

In this case, I'd prefer 0x00000000 rather than just a 0. The DTC is
going to expand it to a 32-bit cell anyway.. but it'd go a long way to
knowing the intent.. (this is kind of why I don't like the idea of
specifying the pad settings and preprocessor macros, it hides
implementation details which give information to reviewers about what
they're looking at..)

--
Matt Sealey <neko@bakuhatsu.net>
