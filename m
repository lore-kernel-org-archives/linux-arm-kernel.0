From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Sep 2015 19:20:52 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <560571CE.1000304@free.fr>
References: <56001B78.2090001@free.fr> <8912441.4NjM1sFKRe@wuerfel>
 <560571CE.1000304@free.fr>
Message-ID: <2224132.TTB8a0yx1X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 18:09:50 Mason wrote:
> On 25/09/2015 17:52, Arnd Bergmann wrote:
> > On Friday 25 September 2015 17:28:54 Mason wrote:
> >> On 25/09/2015 16:11, Arnd Bergmann wrote:
> >>> On Friday 25 September 2015 15:35:36 Mason wrote:
> >>>>
> >>>> So 'default y' enables ARCH_TANGO4 only if ARCH_TANGOX is selected,
> >>>> right?
> >>>
> >>> You should really only have one of the two.
> >>
> >> I plan to add ARCH_TANGO5 in a few weeks. So I copied the layout used
> >> by Samsung for EXYNOSx and TI for OMAPx.
> >  
> > Better start simple, I wouldn't expect there to be too much code
> > that is specific to just one of them to warrant a top-level Kconfig
> > option like on OMAP.
> 
> I don't understand. If I create only ARCH_TANGO4, then I'll have to
> move everything around when ARCH_TANGO5 shows up... <confused>

just name it ARCH_TANGO, to reflect the name of the directory then.

> >>>> It will build, but it won't run! My port uses the TWD for clockevents,
> >>>> and smp_twd.c is only compiled if HAVE_ARM_TWD. So I must set SMP.
> >>>
> >>> I think this has come up before and should be fixed. Could you
> >>> send a patch that allows using TWD in uniprocessor configurations?
> >>
> >> This was discussed here:
> >> http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=15737
> >>
> >> I can re-post the same patch.
> > 
> > Yes, please include that patch in the series.
> 
> Just to be sure, we are talking about this patch:
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c5021002fe4..774dc59650c5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1407,7 +1407,6 @@ config HAVE_ARM_ARCH_TIMER
>  
>  config HAVE_ARM_TWD
>         bool
> -       depends on SMP
>         select CLKSRC_OF if OF
>         help
>           This options enables support for the ARM timer and watchdog unit
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 172c6a05d27f..877c1d5ec942 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -388,9 +388,6 @@ static void __init twd_local_timer_of_register(struct device_node *np)
>  {
>         int err;
>  
> -       if (!is_smp() || !setup_max_cpus)
> -               return;
> -
>         twd_ppi = irq_of_parse_and_map(np, 0);
>         if (!twd_ppi) {
>                 err = -EINVAL;
> 

Yes.

	Arnd
