From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 12 Sep 2016 16:21:09 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <1acabcd8-a259-4129-cee3-100401074c9d@redhat.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
 <20160912111749.GB3958@e103592.cambridge.arm.com>
 <1acabcd8-a259-4129-cee3-100401074c9d@redhat.com>
Message-ID: <20160912152108.GC3958@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 02:49:20PM +0200, Florian Weimer wrote:
> On 09/12/2016 01:17 PM, Dave Martin wrote:
> 
> >>>If the stack isn't large enough, we'll still have to SEGV the task
> >>>though.
> >>
> >>You could skip copying the data and not install a pointer to it in the
> >>existing signal context.
> >
> >We could, but then we'd corrupt the task state in sigreturn, since
> >we wouldn't have been able to save/restore part of the state.
> 
> Ah, I wasn't aware that the kernel doesn't have a copy of the state. Could
> the kernel reserve space for it when sigaltstack is called?

Signals can be nested without limit.

If you record some state in the kernel, it's also hard to track when it
can be freed if userspace leaves the signal handler by other means than
sigreturn() (say, longjmp() or setcontext()).

> >The least-wrong thing I can think of to do is:
> >
> >* deprecate but continue to support the existing sigaltstack API/ABI
> >with today's {,MIN}SIGSTKSZ definitions
> 
> There is also PTHREAD_STACK_MIN.  The glibc default for that (which is
> overriden by some architectures) is 16 KiB.  It is also quite small; see the
> sequence of events mentioned here:
> 
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=20249>

It's a related issue, though this doesn't look to me like a bug.  Why
should something like vfprintf() fit in PTHREAD_STACK_MIN bytes of stack?


> >* guarantee (as much as possible) that software using this ABI continues
> >to work (by saving/restoring only data that _must_ be saved/restored at
> >each signal, which may be small enough to fit)
> >
> >* providing a clean failure mode (fatal signal) when this proves
> >impossible at signal delivery/return time;
> >
> >* define a new interface for runtime-querying the required signal stack
> >size;
> >
> >* define a new syscall or new stack_t.ss_flags flags (say, SS_STRICT)
> >that permits the kernel to enforce a runtime-determined minimum greater
> >than MINSIGSTKSZ when calling sigaltstack().
> >
> >
> >Another option would be:
> >
> >* define a new interface for runtime-querying the required signal stack
> >size, and
> >
> >* support the current API/ABI, but make a call to sigaltstack() SEGV or
> >SIGILL the caller if it specifies ss_stack >= MINSIGSTKSZ but smaller
> >than the actual runtime minimum.
> >
> >(this would cause old software to break immediately in an obvious way on
> >new systems, forcing people to fix their software -- which they might or
> >might not actually bother to do).
> 
> The second option looks a bit problematic from a support perspective.

Well, indeed :(

> Do you think it would be possible to block access to hardware features that
> cause signal stack bloat on a per-process basis?  Then we could bump the
> kernel requirement enforced by sigaltstack directly for the default, and
> define a compatibility personality that minimizes the signal stack size for
> old applications.  (A way to query the required alternative signal stack
> size would still come in handy, though.)

This can be done, in general, but it blocks current software from using
libraries that make internal use of a new arch feature, even if those
libraries' exported ABIs don't depend on the feature.

This would make the new feature unusable until/unless you rebuild the
world.


There's no perfect solution; rather I want to arrive at something
pragmatic that doesn't break existing software unnecessarily.

I designed the extra_context mechnism gets added only if something is
allocated to the signal frame at runtime, so software running on
hardware that doesn't have the new extension, and processes that never
make use of the new extension (even in libraries) would be unaffected.


Programs that are unaware of the extension, but use sigaltstack() _and_
also use libraries that use the extension may get SEGV'd due to failed
signal delivery.


If this is still not good enough, I may have to rethink...

We _could_ save some state in the kernel, but that will add a lot of
complexity in the kernel, and probably still won't cover all
cases.

Cheers
---Dave
