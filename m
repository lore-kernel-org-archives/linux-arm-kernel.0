From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 23 Oct 2010 16:18:38 +0200
Subject: [PATCH] pxafb: correct the vertical back porch macro
In-Reply-To: <AANLkTinb3hNdp5evit9Ga0Z-gLCfPrPzE1VdCvwQVB3o@mail.gmail.com>
References: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
	<AANLkTinb3hNdp5evit9Ga0Z-gLCfPrPzE1VdCvwQVB3o@mail.gmail.com>
Message-ID: <201010231618.39191.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 23. ??jna 2010 03:07:34 Eric Miao napsal(a):
> On Sat, Oct 23, 2010 at 5:26 AM, Matt Reimer <mreimer@sdgsystems.com> wrote:
> > Fix an off-by-one bug in the LCCR2_BegFrmDel() macro. The vertical back
> > porch knob LCCR2[BFW] specifies the number of clock periods minus one,
> > but the macro wasn't doing the subtraction.
> > ---
> >  arch/arm/mach-pxa/include/mach/regs-lcd.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
> > b/arch/arm/mach-pxa/include/mach/regs-lcd.h index f82dcea..5074d18
> > 100644
> > --- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
> > +++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
> > @@ -107,7 +107,7 @@
> >  #define LCCR2_EndFrmDel(Tln)   ((Tln) << FShft (LCCR2_EFW))
> > 
> >  #define LCCR2_BFW      Fld (8, 24)     /* Beginning-of-Frame line clock
> > */ -#define LCCR2_BegFrmDel(Tln)   ((Tln) << FShft (LCCR2_BFW))
> > +#define LCCR2_BegFrmDel(Tln)   (((Tln) - 1) << FShft (LCCR2_BFW))
> 
> Nothing in the spec suggests that this minus 1 is necessary. Could you
> please double check?

It doesn't fit the settings in U-Boot or something ... it's a long known thing. I 
remember in U-Boot, one had to actually subtract one in the LCD configuration 
data structure so it'd be programmer correctly.

> 
> >  #define LCCR3_API      (0xf << 16)     /* AC Bias pin trasitions per
> > interrupt */ #define LCCR3_API_S    16
> > --
> > 1.7.0.4
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
