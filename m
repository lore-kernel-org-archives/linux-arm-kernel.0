From: horms@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2012 10:02:46 +0900
Subject: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
In-Reply-To: <20120921010037.GI21660@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
 <5050CD87.4020800@codeaurora.org>
 <20120913010041.GD7622@verge.net.au>
 <CAHkRjk500KGTeBD67YMWy2qSdaoO_=Y9WBT_Q78n9Zxgqtmo4w@mail.gmail.com>
 <20120921010037.GI21660@verge.net.au>
Message-ID: <20120928010246.GA13133@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:00:37AM +0900, Simon Horman wrote:
> On Thu, Sep 20, 2012 at 10:35:50AM +0100, Catalin Marinas wrote:
> > On 13 September 2012 02:00, Simon Horman <horms@verge.net.au> wrote:
> > > On Wed, Sep 12, 2012 at 10:59:35AM -0700, Stephen Boyd wrote:
> > >> On 09/12/12 00:14, Simon Horman wrote:
> > >> > @@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
> > >> >           deadlock. This workaround puts DSB before executing ISB at the
> > >> >           beginning of the abort exception handler.
> > >> >
> > >> > +config ARM_ERRATA_782773
> > >> > +   bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> > >> > +   depends on CPU_V7
> > >> > +   help
> > >> > +     This option enables the workaround for the 782773 Cortex-A9 (all r0,
> > >> > +     ,r2 and r3 revisions) erratum. It might cause MMU exception in case
> > >>
> > >> Seems to be an extra comma here.
> > >
> > > Thanks, here is an updated version.
> > >
> > > From: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> > >
> > > arm: Add ARM ERRATA 782773 workaround
> > >
> > > Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > I would add some text to the commit log as well, even though it
> > matches the Kconfig entry.
> 
> Sure, an updated patch is below.
> I also reworded the text to make it easier on my eyes,
> I don't think the meaning has been altered.
> 
> > Have you hit this in practice? In general the kernel shouldn't access
> > kernel virtual address corresponding to a page table that is being
> > changed. For user address space it is possible but the kernel can
> > handle use translation faults, even though they may be spurious.
> 
> I believe that Abe-san's team have come up against this,
> I can confirm that if it is important.

Hi Catalin,

I was wondering if I could get an Ack on this as you indicated
in another email that you feel that the implementation is an
appropriate workaround.

> 
> ----------------------------------------------------------------
> From: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> 
> arm: Add ARM ERRATA 782773 workaround
> 
> This is a workaround for Errata 782773 which effects all r0, r2 and r3
> revisions.
> 
> The work-around avoids the possibility of an MMU exception in the case
> where a page table walk occurs immediately after a page table update
> that hasn't been flushed from the L1 data cache.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> 
> v2
> * Reword Kconfig description
> * Add some details to changelog entry
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 48c19d4..2b76164 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
>  	 to deadlock. This workaround puts DSB before executing ISB if
>  	 an abort may occur on cache maintenance.
>  
> +config ARM_ERRATA_782773
> +	bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 782773 Cortex-A9 (all r0,
> +	  r2 and r3 revisions) erratum. It might cause MMU exception in case
> +	  page table walk happens just after updating the existing
> +	  with setting page table in L1 data cache.
> +
>  endmenu
>  
>  source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index fd045e7..9207b9f 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -103,9 +103,17 @@ ENTRY(cpu_v7_set_pte_ext)
>  	tstne	r1, #L_PTE_PRESENT
>  	moveq	r3, #0
>  
> +#ifdef CONFIG_ARM_ERRATA_782773
> +	mrs	r2, cpsr			@ save cpsr
> +	cpsid	if				@ disable interrupts
> +	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
> +#endif
>   ARM(	str	r3, [r0, #2048]! )
>   THUMB(	add	r0, r0, #2048 )
>   THUMB(	str	r3, [r0] )
> +#ifdef CONFIG_ARM_ERRATA_782773
> +	msr	cpsr_c, r2			@ load cpsr
> +#endif
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
>  #endif
>  	mov	pc, lr
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
