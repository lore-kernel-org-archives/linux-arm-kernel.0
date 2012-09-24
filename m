From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 24 Sep 2012 23:31:05 +0200
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific
 descriptions for pin controllers
In-Reply-To: <50609B77.2060406@wwwdotorg.org>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <2359157.SFB7x6fWGY@flatron> <50609B77.2060406@wwwdotorg.org>
Message-ID: <7891903.Qpoh0EJCQr@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 of September 2012 11:42:15 Stephen Warren wrote:
> On 09/21/2012 01:54 PM, Tomasz Figa wrote:
> > On Friday 21 of September 2012 12:56:41 Stephen Warren wrote:
> >> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> >>> The patch "pinctrl: samsung: Parse pin banks from DT" introduced
> >>> platform-specific data parsing from DT.
> >>> 
> >>> This patch adds all necessary nodes and properties to exynos4210
> >>> device
> >>> tree sources.
> >>> 
> >>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
> >>> 
> >>> +			samsung,pctl-offset = <0x000>;
> >>> +			samsung,pin-bank = "gpa0";
> >>> +			samsung,pin-count = <8>;
> >>> +			samsung,func-width = <4>;
> >>> +			samsung,pud-width = <2>;
> >>> +			samsung,drv-width = <2>;
> >>> +			samsung,conpdn-width = <2>;
> >>> +			samsung,pudpdn-width = <2>;
> >> 
> >> The properties above represent the width of the fields. Must all
> >> fields
> >> always be packed together into say the LSB of the registers? What if
> >> there are gaps between the fields in a future SoC variant, or the
> >> order
> >> of the fields in the register changes? I think you want to add either
> >> a
> >> samsung,func-bit/samsung,func-position property for each of the
> >> fields,
> >> or change from samsung,func-width=<4> to samsung,field-mask=<0xf>.
> >> IIRC,
> >> the generic pinctrl binding used a mask for this purpose.
> >> 
> >> What if a future SoC variant adds more fields to the register? At that
> >> point, you'd need to edit the driver anyway in order to define a new
> >> DT
> >> property to represent the new field. Perhaps instead of having an
> >> explicit named property per field in the register, you want a simple
> >> list of fields:
> >> 
> >> samsung,pin-property-names = "func", "pud", "drv", "conpdn", "pudpdn";
> >> samsung,pin-propert-masks = <0xf 0x30 0xc0 0x300 0xc00>;
> >> 
> >> That would allow a completely arbitrary number of fields and layouts
> >> to
> >> be described.
> >> 
> >> I wonder if for absolute generality you want a samsung,pin-stride
> >> property to represent the difference in register address per pin. I
> >> assume that's hard-coded as 4 right now.
> > 
> > Hmm, considering so many different possible changes, maybe a more
> > conservative solution would be better, like reducing the amount of
> > information held in DT to bank type, e.g.
> > 
> > 	samsung,bank-type = "exynos4";
> > 
> > or maybe
> > 
> > 	compatible = "samsung,exynos4-pin-bank*;
> > 
> > and then define supported bank types in the driver. SoC-specific data
> > would remain in DT, i.e. pctl-offset, pin-bank, pin-count,
> > eint-offset, etc.
> Yes, removing much of the data from DT and putting it into a tiny table
> in the driver makes sense to me in this case.

A hybrid solution came to my mind, define bank types in device tree once 
and then reference them in banks. Something like:

	pinctrl-bank-types {
		bank_off: bank-off {
			samsung,func-width = <4>;
			samsung,pud-width = <2>;
			samsung,drv-width = <2>;
			samsung,conpdn-width = <2>;
			samsung,pudpdn-width = <2>;
		};

		bank_alive: bank-alive {
			samsung,func-width = <4>;
			samsung,pud-width = <2>;
			samsung,drv-width = <2>;
		};
	};

	/* ... */

	pinctrl at 12345678 {
		/* ... */
		gpa0: gpa0 {
			/* ... */
			samsung,bank-type = <&bank_off>;
			/* ... */
		};
		/* ... */
	};

This would add the possibility to define new banks types quickly, but would 
not add too much overhead.

What do you think?

> >>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> >>> b/arch/arm/boot/dts/exynos4210.dtsi index ecbc707..0e93717 100644
> >>> --- a/arch/arm/boot/dts/exynos4210.dtsi
> >>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> >>> @@ -59,6 +59,10 @@
> >>> 
> >>>  		reg = <0x11400000 0x1000>;
> >>>  		interrupts = <0 47 0>;
> >>>  		interrupt-controller;
> >>> 
> >>> +		samsung,geint-con = <0x700>;
> >>> +		samsung,geint-mask = <0x900>;
> >>> +		samsung,geint-pend = <0xA00>;
> >>> +		samsung,svc = <0xB08>;
> >> 
> >> I assume those new properties represent register addresses within the
> >> block. If not, I don't understand what they are.
> > 
> > Yes, they do.
> > 
> >> It's unclear to me why those properties aren't all part of
> >> exynos4210-pinctrl-banks.dtsi. Do you really have multiple SoCs where
> >> the register addresses for the pinctrl registers are the same (hence
> >> can
> >> be in a shared exynos4210-pinctrl-banks.dtsi), yet the register
> >> addresses for the geint registers are different (hence must be in
> >> non-shared exynos4210.dtsi)?
> > 
> > Exynos4210-pincstrl-banks.dtsi isn't shared, it's specific to
> > Exynos4210. Other SoCs are going to have their own
> > whatever-pinctrl-banks.dtsi.
> OK, so my point here is: why not put all the pinctrl-related properties
> into a single file, rather than spreading them across different files.
> Having separate files makes sense if they can be re-used in different
> places, but not if they're single-use.

All the definitions in device tree for pinctrl take lots of lines and so I 
though it would make it more readable if pin groups would have its own 
source file and so would pin banks.

Now that I think of it, they aren't going to be modified too much, so it 
might be better indeed to put them together in a single file.

Best regards,
Tomasz Figa
