From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 10:20:07 +0200
Subject: [PATCH 01/16] ARM: dts: exynos4210: Replace legacy GPIO bank nodes
 with pinctrl bank nodes
In-Reply-To: <CACRpkdZgH9TSr2uWQW+-8-U7BxJCscQgStVOndGixGmRz74TWw@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-2-git-send-email-t.figa@samsung.com>
 <CACRpkdZgH9TSr2uWQW+-8-U7BxJCscQgStVOndGixGmRz74TWw@mail.gmail.com>
Message-ID: <79419580.xJ5hFKormc@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:26:51 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Seuqential patches from this series introduce SoC-specific data parsing
> > from device tree.
> > 
> > This patch removes legacy GPIO bank nodes from exynos4210.dtsi and
> > replaces them with nodes and properties required for these patches.
> 
> So to be clear:
> > +       pinctrl-bank-types {
> > +               bank_off: bank-off {
> > +                       samsung,reg-names = "func", "dat", "pud",
> > +                                               "drv", "conpdn",
> > "pudpdn"; +                       samsung,reg-params = <0x00 4>, <0x04
> > 1>, <0x08 2>, +                                               <0x0C
> > 2>, <0x10 2>, <0x14 2>; +               };
> 
> This is starting to look like a firmware language, I have mixed
> feelings about this. Shall this be read:
> 
> "Poke 4 into 0x00, poke 1 into 0x04, poke 2 into 0x08" etc?

I'm not sure if I understood you correctly, so let me explain how this 
works.

Each specifier defines register offset inside bank registers and how many 
bits are used for one pin in this register to specify configuration value.

E.g. func register is available at offset 0x00 and pin 0 occupies bits 0-3, 
pin 1 bit 4-7, etc.

> 
> We really need to discuss this, Grant has already NACK:ed
> such approaches once.
> 
> If you're still going to do this, it is mandatory
> to NOT use magic hex numbers anymore, because Stephen has
> merged preprocessor support to the DTC compiler so you
> can use #defined macros.
> 
> See commit:
> cd296721a9645f9f28800a072490fa15458d1fb7

That's definitely nice. I have seen the work going on this before, but 
haven't followed it recently. Good to know that now it can be used.
 
> > +       pinctrl at 11400000 {
> > +               gpa0: gpa0 {
> > +                       gpio-controller;
> > +                       samsung,pctl-offset = <0x000>;
> > +                       samsung,pin-count = <8>;
> > +                       samsung,bank-type = <&bank_off>;
> > +                       #gpio-cells = <2>;
> 
> This part is OK.
> 
> > +
> > +                       interrupt-controller;
> > +                       samsung,eint-offset = <0x00>;
> 
> This property is *NOT* OK. IMHO the driver should know these
> offsets, not the device tree. The driver only needs the offset to
> the register range, what registers there are and their names
> should be #defined.

This is an offset inside of EINT register group. EINT registers are 
organized in groups as following:

EINT_CON_0
EINT_CON_1
...
EINT_CON_N

...

EINT_MASK_0
EINT_MASK_1
...
EINT_MASK_N

...

EINT_PEND_0
EINT_PEND_1
...
EINT_PEND_N

With arbitrary order of particular groups, arbitrary space between groups 
and arbitrary mapping of particular registers to pin banks, although the 
mapping is the same for all groups of registers, that's why there is only 
one eint-offset property. Also holes (reserved/unused registers) inside 
groups might exist.

So if we want to access EINT_MASK register of bank A0 (of pinctrl 0), we 
must construct the address as following:

eint_mask_a0 = pinctrl_0_base + pinctrl_0_geint_mask + bank_a0_eint_offset

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
