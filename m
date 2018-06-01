From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 1 Jun 2018 09:44:33 +0100
Subject: [PATCH v5 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <20180531172049.GA28915@arm.com>
References: <1527261428-6662-1-git-send-email-Dave.Martin@arm.com>
 <1527261428-6662-3-git-send-email-Dave.Martin@arm.com>
 <20180529204230.GG591@arm.com>
 <20180530104853.GB22983@e103592.cambridge.arm.com>
 <20180531172049.GA28915@arm.com>
Message-ID: <20180601084429.GC22983@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 06:20:49PM +0100, Will Deacon wrote:
> On Wed, May 30, 2018 at 11:48:59AM +0100, Dave Martin wrote:
> > On Tue, May 29, 2018 at 09:42:31PM +0100, Will Deacon wrote:
> > > On Fri, May 25, 2018 at 04:17:08PM +0100, Dave Martin wrote:
> > > > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > > > index fac1c4d..8cf112b 100644
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
> > > > +	 * Should always be nonzero unless there's a kernel bug.	\
> > > > +	 * If we haven't determined a sensible value to give to		\
> > > > +	 * userspace, omit the entry:					\
> > > > +	 */								\
> > > > +	if (likely(signal_minsigstksz))					\
> > > > +		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz);	\
> > > >  } while (0)
> > > 
> > > I think this is the desired behaviour, but now I'm worried that we're forced
> > > to have AT_VECTOR_SIZE_ARCH defined as 2 and, whilst you're correct that the
> > > ELF loader deals with this gracefuly, the FDPIC loader looks a lot less
> > > robust (in particular, my reading is that it decrements the stack pointer
> > > and then pushes these entries in reverse order by overloading NEW_AUX_ENT).
> > 
> > config BINFMT_ELF_FDPIC
> > 	/* ... */
> > 	depends on (ARM || (SUPERH32 & !MMU) || C6X)
> 
> Ok, that's a relief. The checkpoint stuff is still a bit worrying though
> (prctl_set_mm_map).

This looks like a non-issue to me, although stuffing the gap with
AT_IGNORE reduces the scope for unexpected consequences here.

Apart from avoiding buffer overruns in the kernel when stashing the
data, I don't really see why we care what garbage userspace puts in the
auxv that it gives to itself.  It can be invalid in many ways that the
code doesn't check, such as a bad pointer for AT_PLATFORM etc. etc.

> > The FDPIC loader seems to assume it's 32-bit only and also looks broken
> > with regard to auxv:
> > 
> > 	/* force 16 byte _final_ alignment here for generality */
> > #define DLINFO_ITEMS 15
> > 
> > /* ... */
> > 
> > 		nr = 0;
> > 		csp -= 2 * sizeof(unsigned long);
> > 		NEW_AUX_ENT(AT_EXECFD, ...);
> > 	}
> > 
> > /* ... */
> > 
> > 	csp -= DLINFO_ITEMS * 2 * sizeof(unsigned long);
> > 	NEW_AUX_ENT(AT_HWCAP,   ELF_HWCAP);
> > #ifdef ELF_HWCAP2
> > 	NEW_AUX_ENT(AT_HWCAP2,  ELF_HWCAP2);
> > #endif
> > 	/* 14 more NEW_AUX_ENT() */
> > 
> > 
> > Looks like commit 2171364d1a92 ("powerpc: Add HWCAP2 aux entry") added
> > HWCAP2 without ensuring that space is reserved.
> > 
> > I can try to draft a patch to handle the auxv in a more sane way for
> > FDPIC, but either way I don't see that it should be relevant to arm64.
> > 
> > 
> > AT_IGNORE feels like a bit of a fig leaf, but it's harmless enough.  I'm
> > happy to add it if you prefer.
> 
> The only userspace code I could find that uses it is something that prints
> out auxv, but I'd still better spitting it out so we don't have to worry
> about being smaller than AT_VECTOR_SIZE_ARCH.

OK, I'll add AT_IGNORE and respin.

I wondered whether we can just get rid of AT_VECTOR_SIZE{,_ARCH}, since
they're just asking to be wrong in any case.  But that would be a battle
for another day.

Cheers
---Dave
