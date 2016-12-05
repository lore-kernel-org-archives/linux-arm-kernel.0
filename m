From: triegel@redhat.com (Torvald Riegel)
Date: Mon, 05 Dec 2016 23:42:19 +0100
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161130120654.GJ1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
Message-ID: <1480977739.14990.250.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-30 at 12:06 +0000, Dave Martin wrote:
> So, my key goal is to support _per-process_ vector length control.
> 
> From the kernel perspective, it is easiest to achieve this by providing
> per-thread control since that is the unit that context switching acts
> on.
> 
> How useful it really is to have threads with different VLs in the same
> process is an open question.  It's theoretically useful for runtime
> environments, which may want to dispatch code optimised for different
> VLs

What would be the primary use case(s)?  Vectorization of short vectors
(eg, if having an array of structs or sth like that)?

> -- changing the VL on-the-fly within a single thread is not
> something I want to encourage, due to overhead and ABI issues, but
> switching between threads of different VLs would be more manageable.

So if on-the-fly switching is probably not useful, that would mean we
need special threads for the use cases.  Is that a realistic assumption
for the use cases?  Or do you primarily want to keep it possible to do
this, regardless of whether there are real use cases now?
I suppose allowing for a per-thread setting of VL could also be added as
a feature in the future without breaking existing code.

> For setcontext/setjmp, we don't save/restore any SVE state due to the
> caller-save status of SVE, and I would not consider it necessary to
> save/restore VL itself because of the no-change-on-the-fly policy for
> this.

Thus, you would basically consider VL changes or per-thread VL as in the
realm of compilation internals?  So, the specific size for a particular
piece of code would not be part of an ABI?

> I'm not familiar with resumable functions/executors -- are these in
> the C++ standards yet (not that that would cause me to be familiar
> with them... ;)  Any implementation of coroutines (i.e.,
> cooperative switching) is likely to fall under the "setcontext"
> argument above.

These are not part of the C++ standard yet, but will appear in TSes.
There are various features for which implementations would be assumed to
use one OS thread for several tasks, coroutines, etc.  Some of them
switch between these tasks or coroutines while these are running,
whereas the ones that will be in C++17 only run more than parallel task
on the same OS thread but one after the other (like in a thread pool).

However, if we are careful not to expose VL or make promises about it,
this may just end up being a detail similar to, say, register
allocation, which isn't exposed beyond the internals of a particular
compiler either.
Exposing it as a feature the user can set without messing with the
implementation would introduce additional thread-specific state, as
Florian said.  This might not be a show-stopper by itself, but the more
thread-specific state we have the more an implementation has to take
care of or switch, and the higher the runtime costs are.  C++17 already
makes weaker promises for TLS for parallel tasks, so that
implementations don't have to run TLS constructors or destructors just
because a small parallel task was executed.
