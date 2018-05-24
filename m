From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 18:07:13 +0100
Subject: [PATCH v4 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <20180524165045.GP8689@arm.com>
References: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
 <1527097616-25214-3-git-send-email-Dave.Martin@arm.com>
 <20180524124918.GG8689@arm.com>
 <20180524155516.GW13470@e103592.cambridge.arm.com>
 <20180524165045.GP8689@arm.com>
Message-ID: <20180524170713.GY13470@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 05:50:48PM +0100, Will Deacon wrote:
> On Thu, May 24, 2018 at 04:55:17PM +0100, Dave Martin wrote:
> > On Thu, May 24, 2018 at 01:49:21PM +0100, Will Deacon wrote:
> > > On Wed, May 23, 2018 at 06:46:56PM +0100, Dave Martin wrote:
> > > > Stateful CPU architecture extensions may require the signal frame
> > > > to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> > > > However, changing this #define is an ABI break.
> > > > 
> > > > To allow userspace the option of determining the signal frame size
> > > > in a more forwards-compatible way, this patch adds a new auxv entry
> > > > tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> > > > size that the process can observe during its lifetime.
> > > > 
> > > > If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> > > > assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> > > > a consistent interface with older kernels that do not provide
> > > > AT_MINSIGSTKSZ.
> > > > 
> > > > The idea is that libc could expose this via sysconf() or some
> > > > similar mechanism.
> > > > 
> > > > There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> > > > about userspace's own stack overheads and should not pretend to
> > > > know.
> > > 
> > > [...]
> > > 
> > > > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > > > index fac1c4d..9c18f0e 100644
> > > > --- a/arch/arm64/include/asm/elf.h
> > > > +++ b/arch/arm64/include/asm/elf.h
> > > > @@ -121,6 +121,9 @@
> > > >  
> > > >  #ifndef __ASSEMBLY__
> > > >  
> > > > +#include <linux/bug.h>
> > > > +#include <asm/processor.h> /* for signal_minsigstksz, used by ARCH_DLINFO */
> > > > +
> > > >  typedef unsigned long elf_greg_t;
> > > >  
> > > >  #define ELF_NGREG (sizeof(struct user_pt_regs) / sizeof(elf_greg_t))
> > > > @@ -148,6 +151,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
> > > >  do {									\
> > > >  	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
> > > >  		    (elf_addr_t)current->mm->context.vdso);		\
> > > > +									\
> > > > +	/*								\
> > > > +	 * Should always be nonzero unless there's a kernel bug.  If	\
> > > > +	 * the we haven't determined a sensible value to give to	\
> > > 
> > > "If the we"?
> > 
> > Dang, fixed locally now.
> > 
> > [...]
> > 
> > > > diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
> > > > index ec0a86d..743c0b8 100644
> > > > --- a/arch/arm64/include/uapi/asm/auxvec.h
> > > > +++ b/arch/arm64/include/uapi/asm/auxvec.h
> > > > @@ -19,7 +19,8 @@
> > > >  
> > > >  /* vDSO location */
> > > >  #define AT_SYSINFO_EHDR	33
> > > > +#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
> > > 
> > > Curious: but how do we avoid/detect conflicts at -rc1? I guess somebody just
> > > needs to remember to run grep? (I know you have another series consolidating
> > > the ID allocations).
> > 
> > We basically can't.  These are spread over various arch headers today,
> > so the solution is to (a) grep, and (b) know that you needed to do that.
> > 
> > This is the main motivation for collecting the definitions together.
> > 
> > Short of having some script that checks these at build-time, I couldn't
> > see another obvious solution.  It's nonetheless a bit ugly because of
> > things like AT_VECTOR_SIZE_ARCH which is masquerading a tag but isn't
> > one, and obviously does vary across arches...
> > 
> > [...]
> > 
> > > > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > > > index 154b7d3..00b9990 100644
> > > > --- a/arch/arm64/kernel/signal.c
> > > > +++ b/arch/arm64/kernel/signal.c
> > 
> > [...]
> > 
> > > > @@ -936,3 +949,28 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> > > >  		thread_flags = READ_ONCE(current_thread_info()->flags);
> > > >  	} while (thread_flags & _TIF_WORK_MASK);
> > > >  }
> > > > +
> > > > +unsigned long __ro_after_init signal_minsigstksz;
> > > > +
> > > > +/*
> > > > + * Determine the stack space required for guaranteed signal devliery.
> > > > + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> > > > + * cpufeatures setup is assumed to be complete.
> > > > + */
> > > > +void __init minsigstksz_setup(void)
> > > > +{
> > > > +	struct rt_sigframe_user_layout user;
> > > > +
> > > > +	init_user_layout(&user);
> > > > +
> > > > +	/*
> > > > +	 * If this fails, SIGFRAME_MAXSZ needs to be enlarged.  It won't
> > > > +	 * be big enough, but it's our best guess:
> > > > +	 */
> > > > +	if (WARN_ON(setup_sigframe_layout(&user, true)))
> > > > +		signal_minsigstksz = SIGFRAME_MAXSZ;
> > > 
> > > Can we not leave signal_minsigstksz as zero in this case?
> > 
> > I prefer to distinguish the "kernel went wrong" case (where we just omit
> > AT_MINSIGSTKSZ for backwards compatibilty) from the "sigframe too
> > large" case.
> 
> Hmm, so I'm confused as to the distinction here. Wouldn't an allocation
> failure in setup_sigframe_layout be indicative of "kernel went wrong"?
> 
> To put it another way, if we could determine the maximum sigframe size
> at build time, surely we'd fail the build if SIGFRAME_MAXSZ wasn't big
> enough? In that case, detecting this at runtime is also pretty bad (hence

Yup

> the WARN_ON) and I think we should drop the aux entry rather than provide
> a value that is known to be incorrect.

Telling userspace the signal frame size is not optional: by omitting
AT_MINSIGSTKSZ we implicitly tell userspace than MINSIGSTKSZ
is sufficient.  But in this case we not only know that this is false, we
know that SIGFRAME_MAXSZ is not sufficient either.  But we also know
that SIGFRAME_MAXSZ is a closer estimate to the true requirement, because
it's the larger value.

This falls under the heading of "being no more wrong than necessary".

Either way, this is trying to paper over a kernel bug, by telling
userspace something "sensible".  This may not be a sensible course
of action...

So if you feel strongly I'm happy to not distinguish the two cases and
just WARN() in minsigstksz_setup() as at present.

Cheers
---Dave
