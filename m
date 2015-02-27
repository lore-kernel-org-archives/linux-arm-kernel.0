From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 20:20:47 +0100
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <CAL_JsqJyhKQQ-9SdFkWu_Z1MKzHfxUtDjEPrDg=hYm3rnbsrFQ@mail.gmail.com>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <1425043775-3106827-4-git-send-email-arnd@arndb.de>
 <CAL_JsqJyhKQQ-9SdFkWu_Z1MKzHfxUtDjEPrDg=hYm3rnbsrFQ@mail.gmail.com>
Message-ID: <8633095.JZKP2JGaT3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 February 2015 11:53:47 Rob Herring wrote:
> > diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> > index 819777d0e91f..7bc66e22afd7 100644
> > --- a/arch/arm/include/asm/cputype.h
> > +++ b/arch/arm/include/asm/cputype.h
> > @@ -228,10 +228,33 @@ static inline int cpu_is_xsc3(void)
> >  }
> >  #endif
> >
> > -#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
> > +#if !defined(CONFIG_CPU_XSCALE)
> 
> You could use IS_ENABLED here.

We use #ifdef for the same thing in the rest of the file, so I
kept the coding style.

I could convert all three here and the PJ4, but the others
wouldn't work because they require some other macros to be
defined.

I think I'd rather keep it  this way for consistency, unless Russell
prefers it to be changed to

static inline int cpu_is_xscale(void)
{
        unsigned int id;

	if (!IS_ENABLED(CONFIG_XSCALE))
		return 0;

        id = read_cpuid_id() & 0xffffe000;

        if ((id == 0x69052000) || (id == 0x69054000))
                return 1;

        return 0;
}

> > @@ -152,6 +153,11 @@ static int __init xscale_cp0_init(void)
> >  {
> >         u32 cp_access;
> >
> > +       /* do not attempt to probe iwmmxt on non-xscale family CPUs */
> > +       if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM) &&
> 
> Do you really need this condition?
> 
> > +           !(cpu_is_xscale() || cpu_is_xsc3() || cpu_is_mohawk()))
> > +               return 0;
> > +

No, it was just an optimization for the other (non-multi) platforms to
avoid reading the cpuid. I'll just drop it.

	Arnd
