From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Mar 2018 13:47:59 +0000
Subject: [PATCH v7] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
In-Reply-To: <20180309134439.76b43chxnrw7okrw@lakrids.cambridge.arm.com>
References: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
 <20180309134439.76b43chxnrw7okrw@lakrids.cambridge.arm.com>
Message-ID: <20180309134759.GB15537@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 01:44:40PM +0000, Mark Rutland wrote:
> On Wed, Mar 07, 2018 at 09:00:08AM -0600, Shanker Donthineni wrote:
> >  static inline void __flush_icache_all(void)
> >  {
> > -	asm("ic	ialluis");
> > -	dsb(ish);
> > +	/* Instruction cache invalidation is not required for I/D coherence? */
> > +	if (!cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> > +		asm("ic	ialluis");
> > +		dsb(ish);
> > +	}
> >  }
> 
> I don't think we need the comment here. We don't have this in the other
> cases we look at the ARM64_HAS_CACHE_{IDC,DIC} caps.
> 
> This would also be slightly nicer as an early return:
> 
> static inline void __flush_icache_all(void)
> {
> 	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> 		return;
> 	
> 	asm("ic ialluis");
> 	dsb(ish);
> }
> 
> ... which minimizes indentation, and the diffstat.
> 
> The rest looks fine to me, so with the above changes:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

I've already queued this, but not pushed out yet so I'll fold these changes
in.

Will
