From: lkml.js@gmail.com (jungseung lee)
Date: Tue, 6 Nov 2012 15:55:59 +0900
Subject: arm: Add ARM ERRATA 775420 workaround
Message-ID: <CACEL3L3O-9v8T1ELVK3gUBaqG0=+vkuLhbQ=dx3-5kJHg6t9UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have question the work-around code.
The below code will be enter after handling exception handling path. (that
is fix-up code)
As far as i know, the dsb instruction should be inserted before the any isb
instruction on exception handling code for breaking erratum condition .
It could meet the requirement?

> source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 39e3fb3..3b17227 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -211,6 +211,9 @@ ENTRY(v7_coherent_user_range)
>   * isn't mapped, fail with -EFAULT.
>   */
> 9001:
> +#ifdef CONFIG_ARM_ERRATA_775420
> + dsb
> +#endif
>   mov r0, #-EFAULT
>   mov pc, lr
>   UNWIND(.fnend )
>
>
thanks

> On Thu, Sep 20, 2012 at 10:58:53AM +0100, Catalin Marinas wrote:
> > On 12 September 2012 08:14, Simon Horman wrote:
> > > +config ARM_ERRATA_775420
> > > +       bool "ARM errata: A data cache maintenance operation which
aborts, might lead to deadlock"
> > > +       depends on CPU_V7
> > > +       help
> > > +         This option enables the workaround for the 775420 Cortex-A9
(r2p2,
> > > +         r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache
maintenance
> > > +         operation aborts with MMU exception, it might cause the
processor
> > > +         deadlock. This workaround puts DSB before executing ISB at
the
> > > +         beginning of the abort exception handler.
> > > +
> > >  endmenu
> >
> > The only case where we can get an abort on cache maintenance is
> > v7_coherent_user_range(). I don't think we have any ISB on the
> > exception handling path for this function, so we could just add the
> > DSB there:
>
> I think that an advantage of Abe-san's implementation is that
> it might to be a bit more robust. But your proposal is certainly
> much cleaner and for that reason I agree it is a good option.
>
> I've updated the patch, but since the code is now all yours
> I'm unsure if the author should be changed or not.
>
> ----------------------------------------------------------------
> From: Kouei Abe
>
> arm: Add ARM ERRATA 775420 workaround
>
> Workaround for the 775420 Cortex-A9 (r2p2, r2p6,r2p8,r2p10,r3p0) erratum.
> In case a date cache maintenance operation aborts with MMU exception, it
> might cause the processor to deadlock. This workaround puts DSB before
> executing ISB if an abort may occur on cache maintenance.
>
> Based on work by Kouei Abe and feedback from Catalin Marinas.
>
> Cc: Catalin Marinas
> Signed-off-by: Kouei Abe
> Signed-off-by: Simon Horman
>
> ---
>
> v2
> * Add some details to changelog entry
> * Alternate implementation suggested by Catalin Marinas
>   - Add the dsb directly to v7_coherent_user_range() rather
>     than the exception handler
> ---
> arch/arm/Kconfig       |   10 ++++++++++
> arch/arm/mm/cache-v7.S |    3 +++
> 2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2f88d8d..48c19d4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1413,6 +1413,16 @@ config PL310_ERRATA_769419
>    on systems with an outer cache, the store buffer is drained
>    explicitly.
>
> +config ARM_ERRATA_775420
> +       bool "ARM errata: A data cache maintenance operation which
aborts, might lead to deadlock"
> +       depends on CPU_V7
> +       help
> + This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> + r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> + operation aborts with MMU exception, it might cause the processor
> + to deadlock. This workaround puts DSB before executing ISB if
> + an abort may occur on cache maintenance.
> +
> endmenu
>
> source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 39e3fb3..3b17227 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -211,6 +211,9 @@ ENTRY(v7_coherent_user_range)
>   * isn't mapped, fail with -EFAULT.
>   */
> 9001:
> +#ifdef CONFIG_ARM_ERRATA_775420
> + dsb
> +#endif
>   mov r0, #-EFAULT
>   mov pc, lr
>   UNWIND(.fnend )
> --
> 1.7.10.4
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121106/43b68033/attachment-0001.html>
