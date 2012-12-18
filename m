From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 17 Dec 2012 19:12:59 -0600
Subject: devicetree support for efikasb
In-Reply-To: <20121217115016.GN26326@pengutronix.de>
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org>
 <20121217115016.GN26326@pengutronix.de>
Message-ID: <CAKGA1bmAghH9DRt4ppLpg5zuRgo0Nn=Ae3-gTAbWYuYUispjcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 5:50 AM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> On Mon, Dec 17, 2012 at 12:27:56PM +0100, Arnaud Patard wrote:
> > Sascha Hauer <s.hauer@pengutronix.de> writes:
> >
> > > Hi all,
> >
> > > - USB
> >
> > Is it working or not ? Or you meant that it's working only if you merge
> > the usbmisc-related for imx5* patches ?
>
> It's working with the patches in the git branch. It requires usbmisc
> patches and also ULPI support for the chipidea driver. I only bashed
> the chipidea driver until it worked. The last time I looked at the
> chipidea driver patches on the mailing list they were so much in flux
> that it didn't make sense to me to post even more patches. I hope
> this settles soon.



Oh my, I found out the real "Efika MX has a hardware bug" (referenced in
Sascha's "add ULPI" patch) issue just now and we all really have to discuss
this with Michael and Peter who are doing a bunch of chipidea stuff.. it's
actually far more complicated than just setting that bit as actually the
Smarttop doesn't need it, but the Smartbook does - but while setting that
bit would technically violate the USB specification because of the *intent*
of that bit, the implementation of the SMSC3317 PHY in use means it is
completely harmless *as long as* you are not intending to use it as a real
OTG port.

FYI, on the SMSC3317 ChrgVBus bit in ULPI OTG control simply connects the
VDD33 supply to VBUS. It does not perform or initiate any SRP or OTG
operations, it is just an internal switch for supply.

On Smarttop you don't need to touch this bit; the Smarttop has this
properly implemented in that if you enable DrvVBus or DrvVBusExternal bits
in OTG control (actually also technically a weird hack, but SMSC recommends
this configuration for hosts) then the SMSC3317 "CPEN" pin is activated. On
Smarttop, this enables supply of +5V (that is the rail name in the
schematic..) to VBUS, which is supplied to a Terminus FE1.1 HUB. This is
absolutely correct behavior and completely in line with the SMSC datasheets
for their USB PHYs.

Also on Smarttop, the USB DR port in Host mode is used to directly connect
an ASIX ethernet controller. On the current drivers, otg_set_vbus is called
on this port, but in actual fact it isn't required to be driven from the
MX51 at all (it isn't even traced out). The ASIX VBUS input is driven by
the same +5V rail as the H1 VBUS. Overcurrent protection could also be
disabled here since the regulator is quite solid and there's no hotplug
mess to deal with.

On Smartbook, H1 and H2 require this bit set since they connect PHY_VBUS to
HUB_VBUS_DET - this is a 3.3V IO to enable the hub downstream logic, so
while this is quite FREAKISH behavior, it is not technically violating any
USB specification in the broadest sense since PHY_VBUS isn't being used to
actually *drive* VBUS anywhere. All USB ports are backed by SMSC2514 hubs
and those hub ports where necessary are protected by ESD devices which
correctly handle and use the +5V supply for port VBUS and report
overcurrent.

We need to codify the ability to;

* set DrvVbus and/or DrvVbusExternal depending on port configuration, even
if it's a dedicated Host port. Or not, as the case may be. I can't find
anything in the USB specs that says DrvVbus should be enabled or disabled
on any basis that it controls any external logic. I am not sure they need
to be enabled at all on the SMSC3317 for Smartbook.. they do for Smarttop
for the H1 PHY but not for the internal UTMI PHY. I guess this is supposed
to be predicated on the presence or not of the "vbus-supply" property, so
this may actually be basically done already.

* Hack ChrgVBus for the Smartbook ports. I have a theory.. could we give it
a vbus-supply regulator, and call it "chrgvbus" and look for it and use it
to predicate setting the bit in the ULPI OTG control?

> Given that you wrote something for the mlt017, do you happen to have a
> > sii9022 driver too ? :)
>
> Only a very old one which won't work with the current code.


We are working on this internally and have been for some time.. people keep
moving the goalposts (and DRM is fundamentally not suited for the way it
needs to be done anyway).

> > - Battery
> >
> > I've not noticed something for the ac power supply in the dts. Did I
> miss something?
>
> I only added the following for the battery which is enough to detect it:
>
>         battery: battery at 0b {
>                 compatible = "sbs,sbs-battery";
>                 reg = <0x0b>;
>                 sbs,battery-detect-gpios = <&gpio3 6 1>;
>         };
>
> I haven't done anything with the ac power supply yet. I suppose it's
> detectable via a gpio, right?


It is but apart from notifying userspace there's not a lot of point in it.
We experimented with it on the ancient kernel we shipped originally by
hooking it up to SW_DOCK or something (or was it SW_AC? I dunno) and inside
the battery driver looking for that input event rather than fixing GPIOs
into the driver. I guess if the sbs battery driver is using GPIOs directly,
we should do that too (but I do wonder, if the battery detect stuff is
behind some extra management controller via i2c or spi like on a Chromebook
or our MX53 design, we need far more code and a brand new binding here,
*or* a fake GPIO-expander-like controller driver to handle it just because
it isn't abstracted this way yet...)

> > - Sound (used to work, currently broken)
> > > - Wifi
> >
> > How did you enable it ? Did you configure the gpios to always enable it ?
>
> I configured the corresponding gpio as input, so it seems to get
> overwritten by the wifi switch. I don't know the schematics, but I'm
> able to turn Wifi off and on with the switch.


There are individual unit enables for 3G, Wifi and Bluetooth.

Think of the switch as a hardware override - "Airplane Mode" which forces
all of the individual unit enables off if you flick it to the "rf off"
position.

Quite literally, in the "rf on" position, the individual unit enables are
truly individual so you can have a working combination or preference of 3G,
Wifi and Bluetooth in the terminal to save battery, and just flick that
switch when the cabin crew asks :)


> > > - LEDs
> >
> > You're not mentionning pata. Is it working or not ?
>
> Ah, missed that. PATA is working aswell. Only PIO though.


We still have patches staged for PIO4 timings around which gives it a
teeeeeensy performance bump. One day we're all going to have to sit down
and figure out ATA SDMA. BTW I think we should change it to fsl,imx51-pata
to the compatibility (and add a match for fsl,imx35-pata too to the driver)
since there are implementation differences that might appear later (i.MX35
can't run DMA depending on certain clock speeds for example, and uses ADMA,
and i.MX5 uses SDMA)

> > I'm not posting the patches here since I do not consider them ready, but
> > > for everyone interested you can pull the following git tree. I have no
> > > idea if the patches work together with the preinstalled U-Boot, I use
> > > barebox on the Smartbook.
> >
> > I've (very quickly) tested it yesterday and it didn't even boot. I've
> > yet to look at the serial port output to check if it's a problem on my
> > side or a bug in the kernel.
>
> Do you mean barebox doesn't boot or the kernel doesn't boot?


Arnaud; it won't boot off the standard (or mainline) U-Boot because the
pins aren't muxed properly in either for some of the peripherals. We have a
plan;

1) update U-Boot to adequately set the pins up
2) add the correct pinctrls to the device tree (0x80000000 is imx-pinctrl
for "do not touch it" which is what is in Sascha's DT, so assumes that the
bootloader fixed it up already)

That way modern U-Boot people will have it muxed properly and people with
older U-Boots will still get working hardware. We still didn't release the
new U-Boot though, it simply didn't pass QA and there are some obvious bugs
(see above USB hack which is not perfect, and some problems booting kernels
of very specific sizes), regulator support is completely hosed (wrong
voltages *everywhere* and missing setup for some things).

We have an in-development device tree which essentially fixes all the
regulator issues Linux-side, too, and adds led triggers and all kinds of
stuff, in various stages of development and testing, but without USB we
can't QA wireless/3g/bluetooth/keyboard/touchpad/ethernet functionality and
display is obviously stalled because DRM sucks and because we got lazy on
the driver writing (because DRM sucks). I reckon that we'll push something
by the end of the week though for U-Boot and kernel like we did a couple
months ago.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/89db25c0/attachment-0001.html>
