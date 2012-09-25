From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Sep 2012 19:41:51 +0200
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific
 descriptions for pin controllers
In-Reply-To: <5061E087.6030801@wwwdotorg.org>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <40868705.kP2fEHozCi@amdc1227> <5061E087.6030801@wwwdotorg.org>
Message-ID: <6920043.WDO1laKTfY@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of September 2012 10:49:11 Stephen Warren wrote:
> On 09/25/2012 03:37 AM, Tomasz Figa wrote:
> > Hi Stephen,
> > 
> > On Monday 24 of September 2012 17:14:38 Stephen Warren wrote:
> >> On 09/24/2012 03:31 PM, Tomasz Figa wrote:
> >>> On Monday 24 of September 2012 11:42:15 Stephen Warren wrote:
> >>>> On 09/21/2012 01:54 PM, Tomasz Figa wrote:
> >>>>> On Friday 21 of September 2012 12:56:41 Stephen Warren wrote:
> >>>>>> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> >>>>>>> The patch "pinctrl: samsung: Parse pin banks from DT" introduced
> >>>>>>> platform-specific data parsing from DT.
> >>>>>>> 
> >>>>>>> This patch adds all necessary nodes and properties to exynos4210
> >>>>>>> device
> >>>>>>> tree sources.
> >>>>>>> 
> >>>>>>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
> >>>>>>> 
> >>>>>>> +			samsung,pctl-offset = <0x000>;
> >>>>>>> +			samsung,pin-bank = "gpa0";
> >>>>>>> +			samsung,pin-count = <8>;
> >>>>>>> +			samsung,func-width = <4>;
> >>>>>>> +			samsung,pud-width = <2>;
> >>>>>>> +			samsung,drv-width = <2>;
> >>>>>>> +			samsung,conpdn-width = <2>;
> >>>>>>> +			samsung,pudpdn-width = <2>;
> 
> ...
> 
> > Hmm, could you elaborate on the idea of using mask instead of field
> > widths?
> For background: With e.g.:
> 
> samsung,func-width = <4>;
> samsung,pud-width = <2>;
> samsung,drv-width = <2>;
> 
> How do you know if the layout is:
> 
> bits:    7-4  | 3-2 | 1-0
> meaning: func | pud | drv
> 
> or:
> 
> bits:    7-6 | 5-4 | 3-0  |
> meaning: drv | pud | func |
> 
> or:
> 
> bits:    15-12 | 13-8   | 7-6 | 5-3    | 2-1 | 0
> meaning: func  | unused | pud | unused | drv | unused
> 
> I suppose what you're saying is that for all currently extant Samsung
> SoCs, there's some rule that defines this; perhaps the fields are always
> in order MSB to LSB func, pud, drv, and there are never any unused bits
> between the fields? If so, I suppose that's reasonable, even if it does
> restrict the binding's ability to support any unanticipated future SoC
> register layout changes.

I think we have a little misunderstanding here.

All the Samsung SoCs currently available have separate registers for 
particular configuration types. Each register is used to configure all pins 
in a bank. The width field specifies how many bits are used per pin, not 
per configuration type.

> > I don't see how this could be better and there is an additional
> > drawback of having to calculate width and pos from every mask.
> 
> With the DT properties just defining "width", the driver still has to
> calculate the pos from every width by adding up the widths of all fields
> lower in the register, right? Or, does each field always start at a
> hard-coded bit position?
> 
> Anyway, you could completely avoid this question by using masks instead:
> 
> samsung,func-mask = <0xf0>;
> samsung,pud-mask = <0xc>;
> samsung,drv-mask = <0x3>;
> 
> The mask defines exactly which bits are included in the register field,
> so it implicitly defines both the position and width of the field.
> 
> Finding the shift/size is very easy. I believe Tony Lindgren's generic
> pinctrl already does this along these lines. Very roughly:
> 
> func_pos = ffs(func_mask);
> func_width = ffs(~(func_mask >> func_pos));

Right, this looks fine.

> > Anyway, back to your concern, the values that are written to the bit
> > fields specified by those bindings are arbitrary SoC-specific values
> > anyway, so if, for example, we get a SoC with following register
> > layout:
> > 
> > bits:    7 | 6 - 4  | 3 | 2 - 0
> > meaning: 0 | func 1 | 0 | func 0
> > 
> > or
> > 
> > bits:    7 - 5  | 4 | 3 - 1  | 0
> > meaning: func 1 | 0 | func 0 | 0
> > 
> > we can easily define the width as 4 and use appropriate 4-bit function
> > values with zeroes on reserved positions.
> 
> The problem with that is that if the datasheet documents "func" values
> of 0, 1, 2, 3, whereas your driver expects values that are shifted left
> one bit in order to fit into the field, the DT would need to contain 0,
> 2, 4, 6. So, the DT values then don't match the documentation, which
> would end up being confusing.
> 
> >> I forget, do you actually have multiple different SoCs right now (or
> >> in
> >> the near future where the HW design is known now for certain even if
> >> the
> >> chip isn't available) that have different values for all these *-width
> >> properties and hence can be represented just using this binding and
> >> without altering the driver at all? If so, I suppose the original
> >> binding is at least useful (although I would certainly still request
> >> to
> >> use *-mask instead of *-width properties).
> > 
> > The binding I proposed covers all Samsung SoCs currently available,
> > starting from s3c24xx, through s3c64xx (except 4bit2 bank type, with
> > two
> > function registers), to the whole Exynos series, including latest
> > Exynos5.
> OK, the HW is nice and consistent then. In that case, the binding is
> probably reasonable. Hopefully the HW designers are aware they shouldn't
> randomly break the uniformity!

Let's hope so.

Best regards,
Tomasz Figa
