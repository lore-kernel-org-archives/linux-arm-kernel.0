From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 18:41:29 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <alpine.LFD.2.02.1211071035220.21033@xanadu.home>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <20121106220458.GP28327@n2100.arm.linux.org.uk>
 <20121107095106.GA23305@mudshark.cambridge.arm.com>
 <20121107095635.GV28327@n2100.arm.linux.org.uk>
 <20121107100835.GB23305@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211071035220.21033@xanadu.home>
Message-ID: <20121107184129.GB18293@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 06:03:40PM +0000, Nicolas Pitre wrote:
> On Wed, 7 Nov 2012, Will Deacon wrote:
> > On Wed, Nov 07, 2012 at 09:56:35AM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Nov 07, 2012 at 09:51:06AM +0000, Will Deacon wrote:
> > > > Wouldn't the L2 flush in this case be included with the code that turns off
> > > > caching? For reboot, that's currently done in __sort_restart -- the cache
> > > > flush in setup_mm_for_reboot is just to ensure that the idmap tables are
> > > > visible to the hardware walker iirc.
> > > 
> > > Good point - but it does raise another issue.  Why do we do this flush and
> > > TLB invalidate afterwards in setup_mm_for_reboot() ?  It makes sense if
> > > we change existing page tables, but we don't anymore, we're just switching
> > > them, and cpu_switch_mm() will do whatever's necessary to make the new
> > > page tables visible.  So I think we can get rid of that flusing in there.
> > 
> > Hmm, I'm not sure about that. Looking at cpu_v7_switch_mm (the 2-level
> > version) for example, we set the ASID and then set the new TTBR. There's no
> > flushing of page tables like we get in set_pte and no TLB flushing either.
> > 
> > Now, given that the idmap_pgd is populated as an early_initcall, I really
> > doubt we need that flush_cache_all but the TLB invalidate is surely
> > required?
> 
> Why wouldn't cpu_switch_mm() take care of that already if that is 
> necessary?  Hmmm, I suppose the asid of the init task isn't associated 
> with the idmap in any way, hence the need for flushing the tlbs.

Yes, cpu_switch_mm can't know about whether tables are visible or an ASID is
dirty so all it can do is defer that to the caller or do the cleaning and
invalidation every time.

> I'd not rely on the early_initcall to assume the new page table is moved 
> out of the cache though.

Yeah, it's not nice, I was just pointing out that it's all hanging off an
initcall now (before it was created ad-hoc by its users).

> What about this alternate patch:
> 
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index ab88ed4f8e..1ab429761c 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -92,6 +92,9 @@ static int __init init_static_idmap(void)
>  		(long long)idmap_start, (long long)idmap_end);
>  	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
>  
> +	/* Flush L1 for the hardware to see this page table content */
> +	flush_cache_louis();
> +
>  	return 0;
>  }

Yep, we can do this now. Good thinking! At some point I'll get around to
making this conditional, as I don't think it's needed on A5, A7, A9 or A15.

>  early_initcall(init_static_idmap);
> @@ -103,12 +106,12 @@ early_initcall(init_static_idmap);
>   */
>  void setup_mm_for_reboot(void)
>  {
> -	/* Clean and invalidate L1. */
> -	flush_cache_all();
> -
>  	/* Switch to the identity mapping. */
>  	cpu_switch_mm(idmap_pgd, &init_mm);
>  
> -	/* Flush the TLB. */
> +	/*
> +	 * On ARMv7, the ASID of the init task is not associated with
> +	 * this mapping.  TLBs must be flushed.
> +	 */
>  	local_flush_tlb_all();
>  }

Can we change this comment slightly please? Basically, we don't have a clean
ASID for the identity mapping, which may clash with virtual addresses of the
previous page tables and therefore potentially in the TLB. That's why
we need the invalidation: so that we don't hit stale entries from before.

Other than that, looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
