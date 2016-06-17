From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jun 2016 16:42:05 +0100
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
In-Reply-To: <20160617153803.GA1284@arm.com>
References: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
 <20160617142738.GA20181@leverpostej>
 <20160617153803.GA1284@arm.com>
Message-ID: <20160617154205.GA32754@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 04:38:03PM +0100, Will Deacon wrote:
> On Fri, Jun 17, 2016 at 03:27:42PM +0100, Mark Rutland wrote:
> > On Fri, Jun 17, 2016 at 02:12:15PM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > > index 510c7b404454..84b83e521edc 100644
> > > --- a/arch/arm64/include/asm/cmpxchg.h
> > > +++ b/arch/arm64/include/asm/cmpxchg.h
> > > @@ -224,4 +224,56 @@ __CMPXCHG_GEN(_mb)
> > >  	__ret;								\
> > >  })
> > >  
> > > +#define __CMPWAIT_CASE(w, sz, name, acq, cl)				\
> > > +static inline void __cmpwait_case_##name(volatile void *ptr,		\
> > > +					 unsigned long val)		\
> > > +{									\
> > > +	unsigned long tmp;						\
> > > +									\
> > > +	asm volatile(							\
> > > +	"	ld" #acq "xr" #sz "\t%" #w "[tmp], %[v]\n"		\
> > > +	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> > > +	"	cbnz	%" #w "[tmp], 1f\n"				\
> > > +	"	wfe\n"							\
> > > +	"1:"								\
> > > +	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
> > > +	: [val] "r" (val)						\
> > > +	: cl);								\
> > > +}
> > > +
> > > +__CMPWAIT_CASE(w, b, acq_1, a, "memory");
> > > +__CMPWAIT_CASE(w, h, acq_2, a, "memory");
> > > +__CMPWAIT_CASE(w,  , acq_4, a, "memory");
> > > +__CMPWAIT_CASE( ,  , acq_8, a, "memory");
> > > +
> > > +#undef __CMPWAIT_CASE
> > 
> > From my understanding of the intent, I believe that the asm is correct.
> 
> Cheers for having a look.
> 
> > I'm guessing from the way this and __CMPWAIT_GEN are parameterised that
> > there is a plan for variants of this with different ordering semantics,
> > though I'm having difficulty envisioning them. Perhaps I lack
> > imagination. ;)
> 
> Originally I also had a cmpwait_relaxed implementation, since Peter had
> a generic cmpwait utility. That might be resurrected some day, so I
> figured leaving the code like this makes it easily extensible to other
> memory-ordering semantics without adding much in the way of complexity.

Ok.

> > Is there any case for waiting with anything other than acquire
> > semantics? If not, we could fold the acq parameter and acq_ prefix from
> > the name parameter.
> > 
> > Do we expect this to be used outside of smp_cond_load_acquire? If not,
> > can't we rely on the prior smp_load_acquire for the acquire semantics
> > (and use pain LDXR* here)? Then the acq part can go from the cmpwait
> > cases entirely.
> 
> Yeah, I think we can rely on the read-after-read ordering here and
> use __cmpwait_relaxed to the job for the inner loop.

Great!
 
> > Is there any case where we wouldn't want the memory clobber?
> 
> I don't think you'd need it for cmpwait_relaxed, because the CPU could
> reorder stuff anyway, so anything the compiler does is potentially futile.
> So actually, I can respin this without the clobber. I'll simplify
> the __CMPWAIT_CASE macro to drop the last two parameters as well.

I assume that means you're only implementing __cmpwait_relaxed for now.

If so, that sounds good to me!

Thanks,
Mark.
