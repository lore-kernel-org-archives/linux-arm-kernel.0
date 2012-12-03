From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Dec 2012 10:24:43 +0000
Subject: [PATCH 07/10] arm: arch_timer: add arch_counter_enable_user_access
In-Reply-To: <20121130193254.GA12819@mudshark.cambridge.arm.com>
References: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
 <1354297568-26366-8-git-send-email-mark.rutland@arm.com>
 <20121130193254.GA12819@mudshark.cambridge.arm.com>
Message-ID: <20121203102443.GH14454@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 07:32:54PM +0000, Will Deacon wrote:
> On Fri, Nov 30, 2012 at 05:46:05PM +0000, Mark Rutland wrote:
> > Several bits in CNTKCTL reset to 0, including PL0VTEN. For platforms
> > using the generic timer which wish to have a fast gettimeofday vDSO
> > implementation, these bits must be set to 1 by the kernel.
> > 
> > Add an arch_counter_enable_user_access function for this. As we don't
> > (currently) use the counter from PL0 on arm, the implementation is an
> > empty stub.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/arch_timer.h |    7 +++++++
> >  arch/arm/kernel/arch_timer.c      |    2 ++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> > index 701f2b7..c50e415 100644
> > --- a/arch/arm/include/asm/arch_timer.h
> > +++ b/arch/arm/include/asm/arch_timer.h
> > @@ -108,6 +108,13 @@ static inline u64 arch_counter_get_cntvct(void)
> >  	return cval;
> >  }
> >  
> > +static inline void __cpuinit arch_counter_enable_user_access(void)
> > +{
> > +	/*
> > +	 * Do nothing - the counter is never mapped to userspace threads,
> > +	 * so we don't care whether access is enabled or not.
> > +	 */
> > +}
> 
> Might be worth explicitly *disabling* userspace access for the time being
> then (and rename this function to arch_counter_set_user_access?).

Agreed on the name. The current form was an attempt to minimise churn, but
given half the code gets moved later anyway, there's no real benefit.

I'm happy with whatever actually gets written to PL0{V,P}{C,}TEN.

Thanks,
Mark
