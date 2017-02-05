From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 5 Feb 2017 20:23:14 +0100
Subject: [PATCH 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <CAGb2v65EAJBsNCDNSg=uNm3-h8xAKoiuS_rUdaWS8Be84WMvsQ@mail.gmail.com>
References: <cover.1485456003.git.rask@formelder.dk>
 <82617383a0739458d5c9c95dccaf479675fce593.1485456007.git.rask@formelder.dk>
 <CAGb2v65EAJBsNCDNSg=uNm3-h8xAKoiuS_rUdaWS8Be84WMvsQ@mail.gmail.com>
Message-ID: <20170205192313.iik7fdcygltpjfwt@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 03:36:41PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Jan 27, 2017 at 5:27 AM, Rask Ingemann Lambertsen
> <rask@formelder.dk> wrote:
[...]
> > diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> > new file mode 100644
> > index 0000000..8925093
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
[...]
> > +       leds {
> > +               compatible = "gpio-leds";
> > +
> > +               blue {
> > +                       gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;   /* PG10 */
> > +                       label = "cx-a99:blue:status";
> > +                       default-state = "on";
> 
> Please add a note justifying default-state = "on".

I think I'll remove it instead. The device ships with a U-Boot and Android
installation where blue means "on" and red means "stand-by" (which is simply
implemented by blanking the screen, it seems), but I doubt many people want
to run the rather old Android version available for this device. Instead,
I was going to point to the quick setup guide, but it has no mention of the
LEDs at all, so I guess the user won't expect the blue LED to turn on.

> > +       /* USB 3.0 OTG connector. For now, only Vbus is supported. */
> > +       reg_usb0_vbus: regulator-usb0-vbus {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "usb0-vbus";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +               gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;    /* PH15 */
> > +               enable-active-high;
> > +               regulator-always-on;
> 
> It's bad to leave VBUS for OTG connectors on. You never know
> what is plugged in.

The comment is misleading as the connector is not an OTG one but just a
standard-A receptacle wired to the SoC's OTG port. I'll change the comment.

> > +/* SD card slot. */
> > +&mmc0 {
> > +       bus-width = <4>;
> > +       cd-gpios = <&pio 7 17 GPIO_ACTIVE_LOW>; /* PH17 */
> > +       broken-cd;                              /* Interrupts don't work. */
> 
> This should be handled by the driver.

The MMC core, without broken-cd, requests the GPIO driver to enable
interrupt delivery on the pin and will fall back to polling the GPIO pin
if the GPIO driver refuses to enable interrupt delivery. What I see is
that the GPIO driver accepts to deliver interrupts, but only the first
interrupt is triggered (as evident from /proc/interrupts showing only 1).
The vendor sys_config.fex also sets the GPIO pin to polled operation, so
maybe there is a hardware bug.

The sunxi-mmc driver doesn't really support operation with broken-cd only
because it spams the console and dmesg with useless error messages, see
https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg19963.html
for an example.

The comment should probably read something like "GPIO pin delivers no
interrupts, poll it".

> > +                       /* 1.8 V (enabled). */
> > +                       reg_bldo1: bldo1 {
> > +                               regulator-boot-on;
> > +                               regulator-always-on;    /* Hang if disabled */
> 
> If you specify always-on, you don't need to add boot-on.

Ack.

> > +                       /* 3.3 V (enabled). */
> > +                       reg_dcdce: dcdce {
> > +                               regulator-boot-on;
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt = <3300000>;
> > +                               regulator-max-microvolt = <3300000>;
> > +                               regulator-name = "vcc-pb-pc-pd-pe-pf-ph-mmc-spdif";
> 
> This is probably vcc-io or something shorter.

I'm verbose with the names of the regulators for documentation purposes
because unlike some of the boards aimed at developers, documentation is on
this device is scarse. I see that with -mmc now added after my latest round
of probing with a multimeter, the line went above 80 characters. Will it be
OK with vcc-pb,c,d,e,f,h-mmc-spdif?

-- 
Rask Ingemann Lambertsen
