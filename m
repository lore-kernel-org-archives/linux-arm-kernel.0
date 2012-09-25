From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Sep 2012 20:35:16 +0200
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific
 descriptions for pin controllers
In-Reply-To: <5061F64B.5@wwwdotorg.org>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <6920043.WDO1laKTfY@flatron> <5061F64B.5@wwwdotorg.org>
Message-ID: <1634883.GDdJlvHhnl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of September 2012 12:22:03 Stephen Warren wrote:
> On 09/25/2012 11:41 AM, Tomasz Figa wrote:
> > On Tuesday 25 of September 2012 10:49:11 Stephen Warren wrote:
> >> On 09/25/2012 03:37 AM, Tomasz Figa wrote:
> >>> Hi Stephen,
> >>> 
> >>> On Monday 24 of September 2012 17:14:38 Stephen Warren wrote:
> >>>> On 09/24/2012 03:31 PM, Tomasz Figa wrote:
> >>>>> On Monday 24 of September 2012 11:42:15 Stephen Warren wrote:
> >>>>>> On 09/21/2012 01:54 PM, Tomasz Figa wrote:
> >>>>>>> On Friday 21 of September 2012 12:56:41 Stephen Warren wrote:
> >>>>>>>> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> >>>>>>>>> The patch "pinctrl: samsung: Parse pin banks from DT"
> >>>>>>>>> introduced
> >>>>>>>>> platform-specific data parsing from DT.
> >>>>>>>>> 
> >>>>>>>>> This patch adds all necessary nodes and properties to
> >>>>>>>>> exynos4210
> >>>>>>>>> device
> >>>>>>>>> tree sources.
> >>>>>>>>> 
> >>>>>>>>> +++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
> >>>>>>>>> 
> >>>>>>>>> +			samsung,pctl-offset = <0x000>;
> >>>>>>>>> +			samsung,pin-bank = "gpa0";
> >>>>>>>>> +			samsung,pin-count = <8>;
> >>>>>>>>> +			samsung,func-width = <4>;
> >>>>>>>>> +			samsung,pud-width = <2>;
> >>>>>>>>> +			samsung,drv-width = <2>;
> >>>>>>>>> +			samsung,conpdn-width = <2>;
> >>>>>>>>> +			samsung,pudpdn-width = <2>;
> >> 
> >> ...
> >> 
> >>> Hmm, could you elaborate on the idea of using mask instead of field
> >>> widths?
> >> 
> >> For background: With e.g.:
> >> 
> >> samsung,func-width = <4>;
> >> samsung,pud-width = <2>;
> >> samsung,drv-width = <2>;
> >> 
> >> How do you know if the layout is:
> >> 
> >> bits:    7-4  | 3-2 | 1-0
> >> meaning: func | pud | drv
> >> 
> >> or:
> >> 
> >> bits:    7-6 | 5-4 | 3-0  |
> >> meaning: drv | pud | func |
> >> 
> >> or:
> >> 
> >> bits:    15-12 | 13-8   | 7-6 | 5-3    | 2-1 | 0
> >> meaning: func  | unused | pud | unused | drv | unused
> >> 
> >> I suppose what you're saying is that for all currently extant Samsung
> >> SoCs, there's some rule that defines this; perhaps the fields are
> >> always
> >> in order MSB to LSB func, pud, drv, and there are never any unused
> >> bits
> >> between the fields? If so, I suppose that's reasonable, even if it
> >> does
> >> restrict the binding's ability to support any unanticipated future SoC
> >> register layout changes.
> > 
> > I think we have a little misunderstanding here.
> > 
> > All the Samsung SoCs currently available have separate registers for
> > particular configuration types. Each register is used to configure all
> > pins in a bank. The width field specifies how many bits are used per
> > pin, not per configuration type.
> 
> Oh I see. In that case, I guess just having "width" properties is fine,
> and I can see how it's much more likely this scheme would be extensible
> to any future SoC that sticks with the same overall kind of register
> structure.
> 
> It'd be a good idea to describe this explicitly in the binding
> documentation.

OK.

> BTW, how does the driver know what register addresses to use; I can see
> the base for each pin controller bank is in samsung,pctl-offset, but
> what describes the offset for each of the func, pud, drv, ... registers
> from there? Are the offsets the same for all current Samsung SoCs?

The offsets are defined as constants in the driver.

They are the same in all cases, but the "4bit2" bank type of S3C64xx, which 
can have up to 16 pins with 4-bit function specifiers, so two registers are 
required for function configuration. In this case all the remaining 
registers are offset by 0x04.

I couldn't think about any good solution for this special case, but still, 
I haven't been thinking a lot about it, as the driver is targetted at 
current Exynos SoCs primarily.

Best regards,
Tomasz Figa
