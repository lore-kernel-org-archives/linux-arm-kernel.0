From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 19:35:20 +0100
Subject: [PATCH 1/2] ARM: dts: sun5i: Add touchscreen node to
 reference-design-tablet.dtsi
In-Reply-To: <0c3a9e9c-d310-c6c3-ae10-1ae9e520963e@redhat.com>
References: <20161113192203.7101-1-hdegoede@redhat.com>
 <20161114200802.vdduhyxnkgmpsyd5@lukather>
 <0c3a9e9c-d310-c6c3-ae10-1ae9e520963e@redhat.com>
Message-ID: <20161117183520.vpyw72mchynpqx7d@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Nov 15, 2016 at 11:12:35AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 14-11-16 21:08, Maxime Ripard wrote:
> > Hi,
> > 
> > On Sun, Nov 13, 2016 at 08:22:02PM +0100, Hans de Goede wrote:
> > > Just like on sun8i all sun5i tablets use the same interrupt and power
> > > gpios for their touchscreens. I've checked all known a13 fex files and
> > > only the UTOO P66 uses a different gpio for the interrupt.
> > > 
> > > Add a touchscreen node to sun5i-reference-design-tablet.dtsi, which
> > > fills in the necessary gpios to avoid duplication in the tablet dts files,
> > > just like we do in sun8i-reference-design-tablet.dtsi.
> > > 
> > > This will make future patches adding touchscreen nodes to a13 tablets
> > > simpler.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           | 38 ++++++++--------------
> > >  .../boot/dts/sun5i-reference-design-tablet.dtsi    | 25 ++++++++++++++
> > >  2 files changed, 39 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> > > index a8b0bcc..3d7ff10 100644
> > > --- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> > > +++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> > > @@ -83,22 +83,6 @@
> > >  	allwinner,pins = "PG3";
> > >  };
> > > 
> > > -&i2c1 {
> > > -	icn8318: touchscreen at 40 {
> > > -		compatible = "chipone,icn8318";
> > > -		reg = <0x40>;
> > > -		interrupt-parent = <&pio>;
> > > -		interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
> > > -		pinctrl-names = "default";
> > > -		pinctrl-0 = <&ts_wake_pin_p66>;
> > > -		wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> > > -		touchscreen-size-x = <800>;
> > > -		touchscreen-size-y = <480>;
> > > -		touchscreen-inverted-x;
> > > -		touchscreen-swapped-x-y;
> > > -	};
> > > -};
> > > -
> > >  &mmc2 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&mmc2_pins_a>;
> > > @@ -121,20 +105,26 @@
> > >  		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > >  		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> > >  	};
> > > -
> > > -	ts_wake_pin_p66: ts_wake_pin at 0 {
> > > -		allwinner,pins = "PB3";
> > > -		allwinner,function = "gpio_out";
> > > -		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > -		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > -	};
> > > -
> > >  };
> > > 
> > >  &reg_usb0_vbus {
> > >  	gpio = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
> > >  };
> > > 
> > > +&touchscreen {
> > > +	compatible = "chipone,icn8318";
> > > +	reg = <0x40>;
> > > +	/* The P66 uses a different EINT then the reference design */
> > > +	interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
> > > +	/* The icn8318 binding expects wake-gpios instead of power-gpios */
> > > +	wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> > > +	touchscreen-size-x = <800>;
> > > +	touchscreen-size-y = <480>;
> > > +	touchscreen-inverted-x;
> > > +	touchscreen-swapped-x-y;
> > > +	status = "okay";
> > > +};
> > > +
> > >  &uart1 {
> > >  	/* The P66 uses the uart pins as gpios */
> > >  	status = "disabled";
> > > diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> > > index 20cc940..7af488a 100644
> > > --- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> > > +++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> > > @@ -41,6 +41,7 @@
> > >   */
> > >  #include "sunxi-reference-design-tablet.dtsi"
> > > 
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > >  #include <dt-bindings/pwm/pwm.h>
> > > 
> > >  / {
> > > @@ -84,6 +85,23 @@
> > >  };
> > > 
> > >  &i2c1 {
> > > +	/*
> > > +	 * The gsl1680 is rated at 400KHz and it will not work reliable at
> > > +	 * 100KHz, this has been confirmed on multiple different q8 tablets.
> > > +	 * All other devices on this bus are also rated for 400KHz.
> > > +	 */
> > > +	clock-frequency = <400000>;
> > > +
> > > +	touchscreen: touchscreen {
> > > +		interrupt-parent = <&pio>;
> > > +		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&ts_power_pin>;
> > > +		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
> > > +		/* Tablet dts must provide reg and compatible */
> > > +		status = "disabled";
> > > +	};
> > > +
> > >  	pcf8563: rtc at 51 {
> > >  		compatible = "nxp,pcf8563";
> > >  		reg = <0x51>;
> > > @@ -125,6 +143,13 @@
> > >  		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> > >  	};
> > > 
> > > +	ts_power_pin: ts_power_pin {
> > > +		allwinner,pins = "PB3";
> > > +		allwinner,function = "gpio_out";
> > > +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > > +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > > +	};
> > > +
> > 
> > For the next release, we'll switch to the generic pin mux properties
> > ("pins" and "function"), and we actually implemented the fact that the
> > drive and pull properties are optional, so you can drop them both.
> > 
> > You'll need next + http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/467123.html
> 
> Ok, before I send a v2 first a question about this, for the touchscreen
> case I actually need:
> 
> 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> 
> Because otherwise when the touchscreen controller is powered by a separate
> regulator and that regulator is off, then it may draw just enough current
> from its enable pin to be sort-of listening to the i2c bus and mess up
> that bus.
> 
> So is this the default, or do we get the power-on default when not
> specifying these? If it is the power-on default then we do need to
> specify these, because AFAICT the power-on drive strength typically
> is 20 mA.

Leaving them out will keep whatever state has been programmed. Putting
them in the DT will force them to whatever value has been set.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/a4f82915/attachment.sig>
