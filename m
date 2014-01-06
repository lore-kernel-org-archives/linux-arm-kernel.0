From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Jan 2014 11:13:51 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <20140103182349.GA13489@core.coreip.homeip.net>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com> <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com> <20140102202022.GK3144@lukather>
 <52C5E9F1.9010700@redhat.com> <20140103173605.GN3144@lukather>
 <20140103182349.GA13489@core.coreip.homeip.net>
Message-ID: <20140106101351.GO3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 10:23:50AM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 03, 2014 at 06:36:05PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 11:36:33PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> > > >On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >>>Also, instead of inventing yet another vendor-specific property, why not re-use
> > > >>>a button binding similar to gpio-keys like:
> > > >>>
> > > >>>        lradc: lradc at 01c22800 {
> > > >>>                compatible = "allwinner,sun4i-lradc-keys";
> > > >>>                reg = <0x01c22800 0x100>;
> > > >>>                interrupts = <31>;
> > > >>>                allwinner,chan0-step = <200>;
> > > >>>
> > > >>>		#address-cells = <1>;
> > > >>>		#size-cells = <0>;
> > > >>>
> > > >>>		button at 0 {
> > > >>>			reg = <0>; /* your channel index from above */
> > > >>>			linux,code = <115>; /* already used as dt-property */
> > > >>>		};
> > > >>>
> > > >>>		button at 1 {
> > > >>>			reg = <1>;
> > > >>>			linux,code = <114>;
> > > >>>		};
> > > >>
> > > >>Ugh no. Having a vendor specific property which is KISS certainly
> > > >>beats this, both wrt ease of writing dts files as well as wrt the
> > > >>dts parsing code in the driver.
> > > >
> > > >I'd agree with Heiko here. This is pretty much the same construct
> > > >that's already in use in other input drivers, like gpio-keys.
> > > 
> > > In the gpio case there is a 1 on 1 relation between a single hw
> > > entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
> > > which maps to an array of key-codes, certainly using an array rather
> > > then a much more complicated construct is the correct data-structure
> > > to represent this.
> > 
> > You can build an array in your driver out of this very easily, it's 10
> > lines in your probe. And you gain from this something that is more
> > generic, can be shared by other similar drivers and is consistent with
> > what is already in use.
> 
> How will it be shared? Surely not code-wise, but basically in spirit
> only. It seems to me that the originally proposed binding is simple and
> concise and works well for the driver.

See Heiko's answer, but I do believe the code can be shared as well if
needs be.

> > > >This is also something that can really easily be made generic,
> > > >since this is something that is rather common.
> > > >
> > > >Speaking of which. I believe this should actually come in two
> > > >different drivers:
> > > >   - The ADC driver itself, using IIO
> > > >   - A generic button handler driver on top of IIO.
> > > >
> > > > The fact that on most board this adc is used for buttons doesn't make
> > > > any difference, it's actually a hardware designer choice, we should
> > > > support that choice, but we should also be able to use it just as an
> > > > ADC.
> > > 
> > > No, this is not a generic adc, as mentioned in the commit msg, this
> > > adc is specifically designed to be used this way.
> > > 
> > > The adc won't start sampling data, and won't generate any interrupts
> > > until a button is pressed. That is until the input voltage drops below
> > > 2/3 of Vref, this is checked through a built-in analog comparator, which
> > > hooks into the control logic.
> > > 
> > > It has button down and button up interrupts, and can detect long
> > > presses (unused) and generate a second type of down interrupt for those.
> > > 
> > > This really is an input device, which happens to use an adc.
> > 
> > Hmm, yes, ok.
> > 
> > > >Carlo Caione already started to work on an IIO driver for the LRADC:
> > > >https://github.com/carlocaione/linux/tree/sunxi-lradc
> > > >maybe you can take over his work.
> > > 
> > > That won't work because the adc won't sample if the input gets above
> > > 2/3 of Vref. There may be some other mode which does not do that, but
> > > that is not clearly documented.
> > > 
> > > Even if an IIO driver turns out to be doable, I strongly believe that
> > > having a separate input driver for this is best, since this device
> > > was designed to be used as such. Building input on top of IIO would
> > > mean polling the adc, while with my driver it actually generates
> > > button down / up interrupts without any polling being involved.
> > 
> > Not really. iio_channel_read calls the read_raw function (in that
> > case) of your driver. If the read_raw function in your driver wants to
> > poll the device, fine, but most of the time, it will just block
> > waiting for an interrupt to come and return the data to the caller,
> > which is obviously the saner behaviour, and you don't actually end up
> > polling the device. Which is pretty much the architecture you're using
> > already, just with an intermediate layer in between.
> 
> What is the benefit of the IIO layer if device can't really be used as
> IIO? I am all for moving as many generic devices as we can to IIO but we
> should recognize that sometimes the device is not an IIO device.

Yes, I've agreed to that. I was just clarifying Hans' statement.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/7fcbda8b/attachment.sig>
