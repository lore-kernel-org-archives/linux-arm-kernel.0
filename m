From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 16 Sep 2016 18:39:45 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <ad89f920-897c-47cb-d584-4b306bc24d1c@redhat.com>
References: <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
 <20160912111749.GB3958@e103592.cambridge.arm.com>
 <57D6C33D.9020003@arm.com>
 <20160912153015.GD3958@e103592.cambridge.arm.com>
 <9969568a-f969-d904-52b3-14f80c3abec4@redhat.com>
 <20160913155151.GA1574@e103592.cambridge.arm.com>
 <d2e8f4f5-1229-9733-174d-b3123c5e887b@redhat.com>
 <20160915164543.GB1574@e103592.cambridge.arm.com>
 <ad89f920-897c-47cb-d584-4b306bc24d1c@redhat.com>
Message-ID: <20160916173942.GC1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 02:10:53PM +0200, Florian Weimer wrote:
> On 09/15/2016 06:45 PM, Dave Martin wrote:
> >On Tue, Sep 13, 2016 at 06:02:45PM +0200, Florian Weimer wrote:
> >>On 09/13/2016 05:52 PM, Dave Martin wrote:
> >>
> >>>Agreed.  I'll need to think some more about how this should work in
> >>>general.
> >>
> >>Thanks.
> >>
> >>Depending on some SVE implementations details (which I know nothing about, I
> >>only saw some public overview slides), we may also need additional storage
> >>space to preserve SVE registers in the dynamic linker.  Due to lazy binding,
> >>this code cn be called from a signal handler, so this needs to be factored
> >>into stack size requirements as well.
> >
> >Yes and no.  The kernel SIGSTKSZ constants don't care about ld.so --
> >that's userspace overhead, not kernel overhead.
> 
> Well yes, so is jmp_buf.  But I think you still should consider the full
> picture. :)
> 
> At least the lazy binding stack overhead can be avoided with LD_BIND_NOW=1.

I am considering the wider picture, but we're a bit out of scope for the
patch series, except that I will split out the ability to grow the
signal frame out as a separate patch.

> 
> >>Problematic are register width extensions used for argument passing and
> >>callee-saved registers whose width has been extended.  Both are particularly
> >>challenging to deal with if existing vector instructions clear the extension
> >>part (which may be desirable for other reasons).
> >>
> >>The size of the jmp_buf type is a concern as well.
> >
> >The default PCS for SVE will not be introducing any extra save/restore
> >requirements for SVE -- i.e., everything is caller-save at public
> >interfaces, except for the FPSIMD register bits that are already callee-
> >save under the existing PCS.
> 
> Is it possible to pass arguments in the register extension parts?  If
> existing non-SVE code can clobber these bits, we need some adjustments in
> libc to save and restore SVE state in some places (which may need further
> stack space).

Arguments can be passed the the extended vector registers in theory, but
this is expected only at private interfaces and within compilation units
to begin with.  General-purpose libraries including libc would not be
using those bits at their interfaces, at least for now.

When calling any public interface using the default PCS, all the SVE
registers can be clobbered -- the caller must compensate for this if
it cares.  So, the compensation is always in the _new_ binaries where
code gen in the compiler can take care of it automatically -- not
the current and non-SVE binaries.  libc needs to update for this
specifically, so long as only the default PCS is supported for all
dynamic symbols (which I think will be the case to begin with).

A similar argument applies to all libc entry points, including
setjmp()/longjmp()/jmp_buf.

Notwithstanding this, a binary built for SVE _may_ use more stack
than a binary built without SVE support.  This can always happen when
compiling with different options or even after a minor compiler or
library upgrade, so any software that doesn't already have some safety
buffer in its stack allocations is running a risk even without SVE.  SVE
will probably tend to grow frames rather than shrink them, so there will
be increased pressure on stack allocations, but I don't have a good
answer about the scale of the impact at this point.

For now, I don't expect to fix everything in one go.

[...]

Cheers
---Dave
