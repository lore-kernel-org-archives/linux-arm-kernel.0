From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Oct 2017 13:55:16 +0100
Subject: [PATCH 2/4] arm64: prevent instrumentation of LL/SC atomics
In-Reply-To: <20171017113813.GD14051@arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
 <20171016132440.38098-3-mark.rutland@arm.com>
 <20171017100315.GA22140@arm.com>
 <20171017105454.drmoezp6yaqmmczg@lakrids.cambridge.arm.com>
 <20171017105858.GA14051@arm.com>
 <20171017111033.zfjr5ap7kbiwfmvm@lakrids.cambridge.arm.com>
 <20171017113813.GD14051@arm.com>
Message-ID: <20171017125516.7d7l5jczqwsm5vxn@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 12:38:14PM +0100, Will Deacon wrote:
> On Tue, Oct 17, 2017 at 12:10:33PM +0100, Mark Rutland wrote:
> > On Tue, Oct 17, 2017 at 11:58:58AM +0100, Will Deacon wrote:
> > > On Tue, Oct 17, 2017 at 11:54:54AM +0100, Mark Rutland wrote:
> > > > On Tue, Oct 17, 2017 at 11:03:15AM +0100, Will Deacon wrote:
> > > > > On Mon, Oct 16, 2017 at 02:24:38PM +0100, Mark Rutland wrote:
> > > > > > While we build the LL/SC atomics as a C object file, this does not
> > > > > > follow the AAPCS. This does not interoperate with other C code, and can
> > > > > > only be called from special wrapper assembly.
> > > > > > 
> > > > > > Bulding a kernel with CONFIG_KCOV and CONFIG_ARM64_LSE_ATOMICS results
> > > > > > in the cmopiler inserting calls to __sanitizer_cov_trace_pc within the
> > > > > > LL/SC atomics. As __sanitizer_cov_trace_pc is built per the AAPCS, these
> > > > > > calls corrupt register values, resulting in failures at boot time.
> > > > > > 
> > > > > > Avoid this (and other similar issues) by opting out of all compiler
> > > > > > instrumentation. We can opt-in to specific instrumentation in future if
> > > > > > we want to.
> > 
> > > > > > diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> > > > > > index a0abc142c92b..af77516f71b2 100644
> > > > > > --- a/arch/arm64/lib/Makefile
> > > > > > +++ b/arch/arm64/lib/Makefile
> > > > > > @@ -17,5 +17,6 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
> > > > > >  		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
> > > > > >  		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
> > > > > >  		   -fcall-saved-x18
> > > > > > +CC_INSTRUMENT_atomic_ll_sc.o := n
> > > > > 
> > > > > Does this mean we can lose the "notrace" definition of __LL_SC_INLINE
> > > > > when generating the out-of-line atomics?
> > > > 
> > > > Unfortunately not.
> > > > 
> > > > I'd missed -pg, since that isn't handled in scripts/Makefile.lib, and
> > > > doesn't seem to have a makefile-level disable.
> > > > 
> > > > I'll see if that can be remedied.
> > > 
> > > Thanks. It's a real shame to have a "just use this option to avoid
> > > instrumentation" if it doesn't actually catch everything. 
> > 
> > Agreed; it defeats the purpose of the exercise.
> > 
> > > We probably need to think about kprobes too, but not really sure what
> > > you can do there on a per-file basis.
> > 
> > Ugh; that's a much more painful one, yes. :(
> > 
> > Does that rely on any compiler options at all? I thought was all a
> > runtime thing.
> > 
> > Arguably it is somewhat separate for compiler instrumentation, and it
> > might make sense for that to be a separate option.
> 
> Yes, I suppose the problem here is that opting out of dynamic tracing
> requires function attributes such as notrace and __kprobes, rather than a
> compiler flag.  If there's no way to say to the compiler "act as though
> every function in this compilation unit is tagged with this attribute" then
> we probably can't do anything to solve this easily.

Unfortunately, I'm not aware of any way to do that short of using a
linker script to rewrite sections.

> We should probably add __kprobes to __LL_SC_INLINE though.

Agreed.

It's a different case, but kprobes can use atomics behind the scenes
(e.g. via aarch64_insn_patch_text_cb()), and so those need to be
blacklisted.

I'll add a patch to this series, unless you plan to put one together.

Thanks,
Mark.
