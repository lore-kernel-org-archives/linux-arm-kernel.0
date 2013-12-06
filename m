From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Dec 2013 11:59:36 -0500 (EST)
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <201312061741.33427.arnd@arndb.de>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052250.38986.arnd@arndb.de>
 <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
 <201312061741.33427.arnd@arndb.de>
Message-ID: <alpine.LFD.2.10.1312061148200.15948@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Dec 2013, Arnd Bergmann wrote:

> On Friday 06 December 2013, Rob Herring wrote:
> > I assume we expect a v6 SMP kernel to run on a non-v6K v6 platform?
> 
> Actually, as far as I can see:
> 
> config SMP
>         bool "Symmetric Multi-Processing"
>         depends on CPU_V6K || CPU_V7
>         depends on HAVE_SMP
> 
> This prevents you from building a plain v6 SMP kernel, and we've
> had a variation of that since CONFIG_SMP was first marked non-BROKEN.

I don't think the code currently support SMP if v6k is not available.
Therefore...

> > if so, doing more digging I think we have a problem with
> > __kuser_cmpxchg64 on a v6 only platform with v6K enabled in the
> > kernel. Adding Nico since he wrote this. The code is ifdef'ed like
> > this:
> > 
> > #if defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
> > (only true for pre-v6)
> > ...
> > #elif defined(CONFIG_CPU_32v6K)
> > (true when v6K gets enabled)
> > ...
> > #elif !defined(CONFIG_SMP)
> > #ifdef CONFIG_MMU
> > (this is the correct condition for a v6 only platform)
> > ...
> > #else
> > #warning "NPTL on non MMU needs fixing"
> > ...
> > #endif
> > #else
> > #error "incoherent kernel configuration"
> > #endif
> > 
> > Any build with v6K enabled will get the double exclusive instructions
> > which won't work on v6 only platforms. It seems we need some
> > ALT_SMP/ALT_UP magic here.
> 
> The above code can already be simplified a lot, since the pre-v6 and
> pre-v6k v6 cases are dead code. There are comments in Kconfig like this:
> 
> config TLS_REG_EMUL
>         bool
>         select NEED_KUSER_HELPERS
>         help
>           An SMP system using a pre-ARMv6 processor (there are apparently
>           a few prototypes like that in existence) and therefore access to
>           that required register must be emulated.
> 
> config NEEDS_SYSCALL_FOR_CMPXCHG
>         bool
>         select NEED_KUSER_HELPERS
>         help
>           SMP on a pre-ARMv6 processor?  Well OK then.
>           Forget about fast user space cmpxchg support.
>           It is just not possible.
> 
> 
> added in a commit from Nico back in 2005:
> 
>     [PATCH] ARM: 2663/1: straightify TLS register emulation a bit more
>     
>     Patch from Nicolas Pitre
>     
>     This better express things, and should cover RMK's weird SMP toys.
> 
> I don't know what "weird toys" he is referring to, but maybe he or Russell
> can shed some light on that and whether we'd expect to see support for
> them added in the future.

If my memory is right, Russell had a Versatile Express with one of the 
first SMP implementations available on ARM which was based on a quad 
ARM9 (ARMv5) core.  I'm pretty sure this is no longer in service, and 
the current state of the kernel wouldn't accommodate it either.

> If anyone else but Russell were to propose
> adding new platforms like those, I'd probably say no (or possibly
> NOOOOoooo) anyway. 

Such a platform would be broken wrt atomic operations across all cores 
anyway.


Nicolas
