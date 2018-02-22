From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 16:33:30 +0000
Subject: [PATCH v4] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
In-Reply-To: <32c8cfd3-2883-177b-7736-1bb6ab679df4@arm.com>
References: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
 <20180222152244.zozx2tlptgnnfu6b@lakrids.cambridge.arm.com>
 <32c8cfd3-2883-177b-7736-1bb6ab679df4@arm.com>
Message-ID: <20180222163330.o5lqant4fjenapcz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 04:28:03PM +0000, Robin Murphy wrote:
> [Apologies to keep elbowing in, and if I'm being thick here...]
> 
> On 22/02/18 15:22, Mark Rutland wrote:
> > On Thu, Feb 22, 2018 at 08:51:30AM -0600, Shanker Donthineni wrote:
> > > +#define CTR_B31_SHIFT		31
> > 
> > Since this is just a RES1 bit, I think we don't need a mnemonic for it,
> > but I'll defer to Will and Catalin on that.
> > 
> > >   ENTRY(invalidate_icache_range)
> > > +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> > > +alternative_if ARM64_HAS_CACHE_DIC
> > > +	mov	x0, xzr
> > > +	dsb	ishst
> > > +	isb
> > > +	ret
> > > +alternative_else_nop_endif
> > > +#endif
> > 
> > As commented on v3, I don't believe you need the DSB here. If prior
> > stores haven't been completed at this point, the existing implementation
> > would not work correctly here.
> 
> True in terms of ordering between stores prior to entry and the IC IVAU
> itself, but what about the DSH ISH currently issued *after* the IC IVAU
> before returning? Is provably impossible that existing callers might be
> relying on that ordering *anything*, or would we risk losing something
> subtle by effectively removing it?

AFAIK, the only caller of this is KVM, before page table updates occur
to add execute permissions to the page this is applied to.

At least in that case, I do not beleive there would be breakage.

If we're worried about subtleties in callers, then we'd need to stick
with DSB ISH rather than optimising to DSH ISHST.

Thanks,
Mark.
