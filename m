From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Dec 2016 14:46:46 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <1480977739.14990.250.camel@redhat.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <1480977739.14990.250.camel@redhat.com>
Message-ID: <20161206144642.GV1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 11:42:19PM +0100, Torvald Riegel wrote:

Hi there,

> On Wed, 2016-11-30 at 12:06 +0000, Dave Martin wrote:
> > So, my key goal is to support _per-process_ vector length control.
> > 
> > From the kernel perspective, it is easiest to achieve this by providing
> > per-thread control since that is the unit that context switching acts
> > on.
> > 
> > How useful it really is to have threads with different VLs in the same
> > process is an open question.  It's theoretically useful for runtime
> > environments, which may want to dispatch code optimised for different
> > VLs
> 
> What would be the primary use case(s)?  Vectorization of short vectors
> (eg, if having an array of structs or sth like that)?

I'm not sure exactly what you're asking here.

SVE supports a regular SIMD-type computational model, along with
scalable vectors and features for speculative vectorisation of loops
whose iteration count is not statically known (or, possibly not known
even at loop entry at runtime).  It's intended as a compiler target, so
any algorithm that involves iterative computation may get some benefit
-- though the amount of benefit, and how the benefit scales with vector
length, will depend on the algorithm in question.

So some algorithms may get more benefit more from large VLs than others.
For jobs where performance tends to saturate at a shorter VL, it may
make sense to get the compiler to compile for the shorter VL -- this
may enable the same binary code to perform more optimally on a wider
range of hardware, but that may also mean you want to run that job with
the VL it was compiled for instead of what the hardware
supports.

In high-assurance scenarios, you might also want to restrict a
particular job to run at the VL that you validated for.

> > -- changing the VL on-the-fly within a single thread is not
> > something I want to encourage, due to overhead and ABI issues, but
> > switching between threads of different VLs would be more manageable.
> 
> So if on-the-fly switching is probably not useful, that would mean we
> need special threads for the use cases.  Is that a realistic assumption
> for the use cases?  Or do you primarily want to keep it possible to do
> this, regardless of whether there are real use cases now?
> I suppose allowing for a per-thread setting of VL could also be added as
> a feature in the future without breaking existing code.

Per-thread VL use cases are hypothetical for now.

It's easy to support per-thread VLs in the kernel, but we could deny it
initially and wait for someone to come along with a concrete use case.

> > For setcontext/setjmp, we don't save/restore any SVE state due to the
> > caller-save status of SVE, and I would not consider it necessary to
> > save/restore VL itself because of the no-change-on-the-fly policy for
> > this.
> 
> Thus, you would basically consider VL changes or per-thread VL as in the
> realm of compilation internals?  So, the specific size for a particular
> piece of code would not be part of an ABI?

Basically yes.  For most people, this would be hidden in libc/ld.so/some
framework.  This goes for most prctl()s -- random user code shouldn't
normally touch them unless it knows what it's doing.

> > I'm not familiar with resumable functions/executors -- are these in
> > the C++ standards yet (not that that would cause me to be familiar
> > with them... ;)  Any implementation of coroutines (i.e.,
> > cooperative switching) is likely to fall under the "setcontext"
> > argument above.
> 
> These are not part of the C++ standard yet, but will appear in TSes.
> There are various features for which implementations would be assumed to
> use one OS thread for several tasks, coroutines, etc.  Some of them
> switch between these tasks or coroutines while these are running,

Is the switching ever preemptive?  If not, that these features are
unlikely to be a concern for SVE.  It's preemptive switching that would
require the saving of extra SVE state (which is why we need to care for
signals).

> whereas the ones that will be in C++17 only run more than parallel task
> on the same OS thread but one after the other (like in a thread pool).

If jobs are only run to completion before yielding, that again isn't a
concern for SVE.

> However, if we are careful not to expose VL or make promises about it,
> this may just end up being a detail similar to, say, register
> allocation, which isn't exposed beyond the internals of a particular
> compiler either.
> Exposing it as a feature the user can set without messing with the
> implementation would introduce additional thread-specific state, as
> Florian said.  This might not be a show-stopper by itself, but the more
> thread-specific state we have the more an implementation has to take
> care of or switch, and the higher the runtime costs are.  C++17 already
> makes weaker promises for TLS for parallel tasks, so that
> implementations don't have to run TLS constructors or destructors just
> because a small parallel task was executed.

There's a difference between a feature that exposed by the kernel, and
a feature endorsed by the language / runtime.

For example, random code can enable seccomp via prctl(PR_SET_SECCOMP)
-- this may make most of libc unsafe to use, because under strict
seccomp most syscalls simply kill the thread.  libc doesn't pretend to
support this out of the box, but this feature is also not needlessly
denied to user code that knows what it's doing.

I tend to put setting the VL into this category: it is safe, and
useful or even necessary to change the VL in some situations, but
userspace is responsible for managing this for itself.  The kernel
doesn't have enough information to make these decisions unilaterally.

Cheers
---Dave
