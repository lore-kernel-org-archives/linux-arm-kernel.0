From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 17:32:00 +0100
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <524D416B.5090709@asianux.com>
References: <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
 <5247A3FC.9020508@asianux.com>
 <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
 <20131001090119.GA17629@mudshark.cambridge.arm.com>
 <524ABA20.6060106@asianux.com>
 <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
Message-ID: <20131003163200.GE7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 11:05:31AM +0100, Chen Gang wrote:
> If need send patch v2 for it, I should try (if so, need patch 1 also
> send again?).

Almost, comments below.

> > So the related patch is below (still based on Patch 1):
> > 
> > -----------------------------patch begin--------------------------------
> > 
> > arm/include/asm/atomic.h: use 'int' instead of 'unsigned long' for 'oldval' in atomic_cmpxchg().
> > 
> >   For atomic_cmpxchg(), the type of 'oldval' need be 'int' to match the
> >   type of "*ptr" (used by 'ldrex' instruction) and 'old' (used by 'teq'
> >   instruction).
> > 
> > 
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> > ---
> >  arch/arm/include/asm/atomic.h |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> > index a715ac0..9ee7e01 100644
> > --- a/arch/arm/include/asm/atomic.h
> > +++ b/arch/arm/include/asm/atomic.h
> > @@ -114,7 +114,8 @@ static inline int atomic_sub_return(int i, atomic_t *v)
> >  
> >  static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
> >  {
> > -	unsigned long oldval, res;
> > +	int oldval;
> > +	unsigned long res;
> >  
> >  	smp_mb();

I think you should also fix atomic_clear_mask to take (unsigned int mask,
atomic_t *v). That would require a third patch fixing asm-generic, where
atomic_clear_mask and atomic_set_mask have different types for the mask
parameter.

The problem with arm64 is that we're using *unsigned long* for 32-bit
clear_mask, which is definitely wrong because it's 64-bit (another patch to
fix this!).

Finally, is atomic_clear_mask even used anywhere outside of
drivers/s390/scsi/? If not, perhaps we can just drop this function from arm
and arm64 after all.

Will
