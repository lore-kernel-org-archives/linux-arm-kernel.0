From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Oct 2017 11:58:58 +0100
Subject: [PATCH 2/4] arm64: prevent instrumentation of LL/SC atomics
In-Reply-To: <20171017105454.drmoezp6yaqmmczg@lakrids.cambridge.arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
 <20171016132440.38098-3-mark.rutland@arm.com>
 <20171017100315.GA22140@arm.com>
 <20171017105454.drmoezp6yaqmmczg@lakrids.cambridge.arm.com>
Message-ID: <20171017105858.GA14051@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:54:54AM +0100, Mark Rutland wrote:
> On Tue, Oct 17, 2017 at 11:03:15AM +0100, Will Deacon wrote:
> > On Mon, Oct 16, 2017 at 02:24:38PM +0100, Mark Rutland wrote:
> > > While we build the LL/SC atomics as a C object file, this does not
> > > follow the AAPCS. This does not interoperate with other C code, and can
> > > only be called from special wrapper assembly.
> > > 
> > > Bulding a kernel with CONFIG_KCOV and CONFIG_ARM64_LSE_ATOMICS results
> > > in the cmopiler inserting calls to __sanitizer_cov_trace_pc within the
> > 
> > cmopiler
> 
> Bulding, too. ;)
> 
> > > LL/SC atomics. As __sanitizer_cov_trace_pc is built per the AAPCS, these
> > > calls corrupt register values, resulting in failures at boot time.
> > > 
> > > Avoid this (and other similar issues) by opting out of all compiler
> > > instrumentation. We can opt-in to specific instrumentation in future if
> > > we want to.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/lib/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> > > index a0abc142c92b..af77516f71b2 100644
> > > --- a/arch/arm64/lib/Makefile
> > > +++ b/arch/arm64/lib/Makefile
> > > @@ -17,5 +17,6 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
> > >  		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
> > >  		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
> > >  		   -fcall-saved-x18
> > > +CC_INSTRUMENT_atomic_ll_sc.o := n
> > 
> > Does this mean we can lose the "notrace" definition of __LL_SC_INLINE
> > when generating the out-of-line atomics?
> 
> Unfortunately not.
> 
> I'd missed -pg, since that isn't handled in scripts/Makefile.lib, and
> doesn't seem to have a makefile-level disable.
> 
> I'll see if that can be remedied.

Thanks. It's a real shame to have a "just use this option to avoid
instrumentation" if it doesn't actually catch everything. We probably
need to think about kprobes too, but not really sure what you can do there
on a per-file basis.

Will
