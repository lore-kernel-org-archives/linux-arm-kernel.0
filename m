From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Jan 2014 21:20:22 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <52C56D79.1060506@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com> <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com>
Message-ID: <20140102202022.GK3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> >Also, instead of inventing yet another vendor-specific property, why not re-use
> >a button binding similar to gpio-keys like:
> >
> >        lradc: lradc at 01c22800 {
> >                compatible = "allwinner,sun4i-lradc-keys";
> >                reg = <0x01c22800 0x100>;
> >                interrupts = <31>;
> >                allwinner,chan0-step = <200>;
> >
> >		#address-cells = <1>;
> >		#size-cells = <0>;
> >
> >		button at 0 {
> >			reg = <0>; /* your channel index from above */
> >			linux,code = <115>; /* already used as dt-property */
> >		};
> >
> >		button at 1 {
> >			reg = <1>;
> >			linux,code = <114>;
> >		};
> 
> Ugh no. Having a vendor specific property which is KISS certainly
> beats this, both wrt ease of writing dts files as well as wrt the
> dts parsing code in the driver.

I'd agree with Heiko here. This is pretty much the same construct
that's already in use in other input drivers, like gpio-keys.

This is also something that can really easily be made generic, since
this is something that is rather common.

Speaking of which. I believe this should actually come in two
different drivers:
  - The ADC driver itself, using IIO
  - A generic button handler driver on top of IIO.

The fact that on most board this adc is used for buttons doesn't make
any difference, it's actually a hardware designer choice, we should
support that choice, but we should also be able to use it just as an
ADC.

Carlo Caione already started to work on an IIO driver for the LRADC:
https://github.com/carlocaione/linux/tree/sunxi-lradc
maybe you can take over his work.

I also wonder wether it would be possible in that case to use reg as
the "button" voltage, to get rid of both the chan0-step property, and
those big fat arrays in the driver.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/abfbd9fe/attachment.sig>
