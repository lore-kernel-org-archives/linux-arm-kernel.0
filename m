From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 17:41:33 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052250.38986.arnd@arndb.de>
 <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
Message-ID: <201312061741.33427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Rob Herring wrote:
> On Thu, Dec 5, 2013 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 05 December 2013, Rob Herring wrote:
> >> On Thu, Dec 5, 2013 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Thursday 05 December 2013, Rob Herring wrote:
> >> >> select ARM_AMBA
> >> >> select ARM_GIC if CPU_V7
> >> >> select HAVE_SMP if CPU_V7
> >> >> select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
> >> >> select ARCH_HAS_CPUFREQ
> >> >> select ARCH_HAS_OPP
> >> >
> >> > Not sure about ARM_GIC and HAVE_SMP, as they won't typically be
> >> > set on Cortex-A8, Scorpion and PJ4. The other suggestions sound
> >> > good, and your patch looks fine as well.
> >>
> >> HAVE_SMP only enables visibility of the SMP kconfig option. That could
> >> cause randconfig builds that would not boot if SMP_ON_UP was not
> >> enabled, but a "select SMP_ON_UP if SMP" here would fix that though.
> >
> > Ok, I see. "select HAVE_SMP if CPU_V7" maybe "select HAVE_SMP if
> > ARCH_MULTI_V7" sounds reasonable then, at least I'd prefer that over
> > the "select SMP_ON_UP if SMP" option, which would make having SMP_ON_UP
> > as an option pointless, since you could no longer turn it off.
> >
> > If you set HAVE_SMP for CPU_V7, it would be logical to also set it for
> > CPU_V6K, although I'm unsure if we actually still support any SMP V6K
> > platforms in practice: CNS3xxx is the only such platform I'm aware of,
> > and the SMP support for that one was never merged (it's in openwrt
> > though).
> 
> We should be able to boot an SMP kernel on it whether or not the
> platform has SMP support added, right?

Yes, although I don't think anyone has ever tried to boot a UP_ON_SMP
kernel on ARMv5 or earlier. We don't allow that combination at the
moment, and it would be pointless.

> Practically every v6 platform selects v6K. We should probably default
> to V6K for ARCH_MULTI_V6 and let platforms select CPU_V6 instead if
> needed. I believe that will give the v6 versions of code only as
> needed and will give better versions of code if only v6K is selected.
> imx31 is one that doesn't select v6K, but only very early revs did not
> have v6K version of the 1136. I don't think any of those parts went
> into production (maybe into the original Zune?).

Interesting, I had no idea that plain ARMv6 was this rare.

If we could show that all supported platforms are actually v6K anyway
and that nobody has any plans to add new ones, doing away with
v6 in favor of v6k would clean up a lot of confusing (i.e. possibly
wrong) Kconfig logic.

> I assume we expect a v6 SMP kernel to run on a non-v6K v6 platform?

Actually, as far as I can see:

config SMP
        bool "Symmetric Multi-Processing"
        depends on CPU_V6K || CPU_V7
        depends on HAVE_SMP

This prevents you from building a plain v6 SMP kernel, and we've
had a variation of that since CONFIG_SMP was first marked non-BROKEN.

> if so, doing more digging I think we have a problem with
> __kuser_cmpxchg64 on a v6 only platform with v6K enabled in the
> kernel. Adding Nico since he wrote this. The code is ifdef'ed like
> this:
> 
> #if defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
> (only true for pre-v6)
> ...
> #elif defined(CONFIG_CPU_32v6K)
> (true when v6K gets enabled)
> ...
> #elif !defined(CONFIG_SMP)
> #ifdef CONFIG_MMU
> (this is the correct condition for a v6 only platform)
> ...
> #else
> #warning "NPTL on non MMU needs fixing"
> ...
> #endif
> #else
> #error "incoherent kernel configuration"
> #endif
> 
> Any build with v6K enabled will get the double exclusive instructions
> which won't work on v6 only platforms. It seems we need some
> ALT_SMP/ALT_UP magic here.

The above code can already be simplified a lot, since the pre-v6 and
pre-v6k v6 cases are dead code. There are comments in Kconfig like this:

config TLS_REG_EMUL
        bool
        select NEED_KUSER_HELPERS
        help
          An SMP system using a pre-ARMv6 processor (there are apparently
          a few prototypes like that in existence) and therefore access to
          that required register must be emulated.

config NEEDS_SYSCALL_FOR_CMPXCHG
        bool
        select NEED_KUSER_HELPERS
        help
          SMP on a pre-ARMv6 processor?  Well OK then.
          Forget about fast user space cmpxchg support.
          It is just not possible.


added in a commit from Nico back in 2005:

    [PATCH] ARM: 2663/1: straightify TLS register emulation a bit more
    
    Patch from Nicolas Pitre
    
    This better express things, and should cover RMK's weird SMP toys.

I don't know what "weird toys" he is referring to, but maybe he or Russell
can shed some light on that and whether we'd expect to see support for
them added in the future. If anyone else but Russell were to propose
adding new platforms like those, I'd probably say no (or possibly
NOOOOoooo) anyway. 

	Arnd
