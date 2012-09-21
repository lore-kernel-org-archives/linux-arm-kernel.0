From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 21:54:43 +0200
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific
 descriptions for pin controllers
In-Reply-To: <505CB869.5030307@wwwdotorg.org>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <1348131197-25506-7-git-send-email-t.figa@samsung.com>
 <505CB869.5030307@wwwdotorg.org>
Message-ID: <2359157.SFB7x6fWGY@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your comments.

On Friday 21 of September 2012 12:56:41 Stephen Warren wrote:
> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> > The patch "pinctrl: samsung: Parse pin banks from DT" introduced
> > platform-specific data parsing from DT.
> > 
> > This patch adds all necessary nodes and properties to exynos4210 device
> > tree sources.
> > 
> > +++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
> > 
> > +/ {
> > +	pinctrl at 11400000 {
> > +		gpa0: pin-bank at 0 {
> 
> If you're going to put a unit address ("@0")into the DT node name, the
> node should have a reg property containing the same value, and the
> parent node should have #address-cells and #size-cells properties.
> 
> However, I believe you can actually get unique node names without using
> a unit address; instead name the nodes after the object they represent,
> so e.g. s/pin-bank at 0/gpa0/ above.

Good point. I wasn't aware of the relation between unit address and reg 
property. I thought it was just for readability.

> 
> > +			gpio-controller;
> 
> You need a #gpio-cells property too.

It will be added in further patches that add per-bank GPIO addressing.

In this RFC, this property is just used to distinguish pin bank nodes from 
pin group nodes.
 
> > +			samsung,pctl-offset = <0x000>;
> > +			samsung,pin-bank = "gpa0";
> > +			samsung,pin-count = <8>;
> > +			samsung,func-width = <4>;
> > +			samsung,pud-width = <2>;
> > +			samsung,drv-width = <2>;
> > +			samsung,conpdn-width = <2>;
> > +			samsung,pudpdn-width = <2>;
> 
> The properties above represent the width of the fields. Must all fields
> always be packed together into say the LSB of the registers? What if
> there are gaps between the fields in a future SoC variant, or the order
> of the fields in the register changes? I think you want to add either a
> samsung,func-bit/samsung,func-position property for each of the fields,
> or change from samsung,func-width=<4> to samsung,field-mask=<0xf>. IIRC,
> the generic pinctrl binding used a mask for this purpose.
> 
> What if a future SoC variant adds more fields to the register? At that
> point, you'd need to edit the driver anyway in order to define a new DT
> property to represent the new field. Perhaps instead of having an
> explicit named property per field in the register, you want a simple
> list of fields:
> 
> samsung,pin-property-names = "func", "pud", "drv", "conpdn", "pudpdn";
> samsung,pin-propert-masks = <0xf 0x30 0xc0 0x300 0xc00>;
> 
> That would allow a completely arbitrary number of fields and layouts to
> be described.
> 
> I wonder if for absolute generality you want a samsung,pin-stride
> property to represent the difference in register address per pin. I
> assume that's hard-coded as 4 right now.

Hmm, considering so many different possible changes, maybe a more 
conservative solution would be better, like reducing the amount of 
information held in DT to bank type, e.g.

	samsung,bank-type = "exynos4";

or maybe

	compatible = "samsung,exynos4-pin-bank*;

and then define supported bank types in the driver. SoC-specific data would 
remain in DT, i.e. pctl-offset, pin-bank, pin-count, eint-offset, etc.

> > +			interrupt-controller;
> You need a #interrupt-cells property too.

Just as with gpio-controller before, in this RFC this is just a mark to 
distinguish banks with interrupts from banks without interrupts.

Further patches will allow to use it properly (and will add #interrupt-
cells property too).

> > +		gpd0: pin-bank at 5 {
> > +			gpio-controller;
> > +			samsung,pctl-offset = <0x0A0>;
> 
> I think hex number are usually lower-case in DT, but I may be
> extrapolating a generality from a limited set of examples.

I have seen both variants, with upper-case being more popular across 
Samsung's dts files and so I have chosen to use it. (Personally I prefer 
lower-case, though, if it does matter.)

> > +		gpy5: pin-bank at 19{
> 
> Missing a space before the { there.

Right.

> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> > b/arch/arm/boot/dts/exynos4210.dtsi index ecbc707..0e93717 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -59,6 +59,10 @@
> > 
> >  		reg = <0x11400000 0x1000>;
> >  		interrupts = <0 47 0>;
> >  		interrupt-controller;
> > 
> > +		samsung,geint-con = <0x700>;
> > +		samsung,geint-mask = <0x900>;
> > +		samsung,geint-pend = <0xA00>;
> > +		samsung,svc = <0xB08>;
> 
> I assume those new properties represent register addresses within the
> block. If not, I don't understand what they are.

Yes, they do.

> It's unclear to me why those properties aren't all part of
> exynos4210-pinctrl-banks.dtsi. Do you really have multiple SoCs where
> the register addresses for the pinctrl registers are the same (hence can
> be in a shared exynos4210-pinctrl-banks.dtsi), yet the register
> addresses for the geint registers are different (hence must be in
> non-shared exynos4210.dtsi)?

Exynos4210-pincstrl-banks.dtsi isn't shared, it's specific to Exynos4210. 
Other SoCs are going to have their own whatever-pinctrl-banks.dtsi.

> Do these properties interact with samsung,eint-offset at all? Oh,
> perhaps these properties are defining a top-level interrupt controller
> that aggregates all the banks together, whereas samsung,eint-offset is
> per-bank?

Yes. There is a bunch of CON registers one after another, for each bank, 
which supports interrupts and similarly for MASK and PEND. All those geint-
xxx properties define the location of first register and eint-offset 
defines location of register for particular bank.

Best regards,
Tomasz Figa
