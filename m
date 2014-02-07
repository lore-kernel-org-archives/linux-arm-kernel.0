From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 6 Feb 2014 20:04:56 -0800
Subject: [PATCH v3 05/11] ARM: LPAE: provide an IPA capable pmd_addr_end
In-Reply-To: <20140206104328.GB29446@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-6-git-send-email-marc.zyngier@arm.com>
 <20140206104328.GB29446@arm.com>
Message-ID: <20140207040456.GN9157@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 10:43:28AM +0000, Catalin Marinas wrote:
> On Wed, Feb 05, 2014 at 07:55:45PM +0000, Marc Zyngier wrote:
> > The default pmd_addr_end macro uses an unsigned long to represent
> > the VA. When used with KVM and stage-2 translation, the VA is
> > actually an IPA, which is up to 40 bits. This also affect the
> > SMMU driver, which also deals with stage-2 translation.
> > 
> > Instead, provide an implementation that can cope with larger VAs
> > by using a u64 instead. This version will overload the default
> > one provided in include/asm-generic/pgtable.h.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/pgtable-3level.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index 03243f7..594867b 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -262,6 +262,11 @@ static inline int has_transparent_hugepage(void)
> >  	return 1;
> >  }
> >  
> > +#define pmd_addr_end(addr, end)						\
> > +({	u64 __boundary = ((addr) + PMD_SIZE) & PMD_MASK;		\
> > +	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> > +})
> 
> I see why you need this but it affects all the other uses of
> pmd_addr_end() with 32-bit VA. It would be slight performance, I don't
> think it's noticeable.
> 
> A different approach could be something like (untested):
> 
> #define pmd_addr_end(addr, end)					\
> ({	__typeof__(addr) __boundary = ...
> 	...
> })
> 
> What about the pgd_addr_end(), do we need this or it's not used by KVM?
> 

What about pud_addr_end(), is that defined as a noop on LPAE, or?

I would be in favor of introducing them all using your approach to avoid
somebody being inspired by the KVM code when dealing with IPAs and
breaking things unknowingly.

-Christoffer
