From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Nov 2016 13:56:32 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
Message-ID: <20161130135631.GK1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 01:38:28PM +0100, Florian Weimer wrote:
> On 11/30/2016 01:06 PM, Dave Martin wrote:
> 
> >I'm concerned here that there may be no sensible fixed size for the
> >signal frame.  We would make it ridiculously large in order to minimise
> >the chance of hitting this problem again -- but then it would be
> >ridiculously large, which is a potential problem for massively threaded
> >workloads.
> 
> What's ridiculously large?

The SVE architecture permits VLs up to 2048 bits per vector initially --
but it makes space for future architecture revisions to expand up to
65536 bits per vector, which would result in a signal frame > 270 KB.

It's far from certain we'll ever see such large vectors, but it's hard
to know where to draw the line.

> We could add a system call to get the right stack size.  But as it depends
> on VL, I'm not sure what it looks like.  Particularly if you need determine
> the stack size before creating a thread that uses a specific VL setting.

I think that the most likely time to set the VL is libc startup or ld.so
startup -- so really a process considers the VL fixed, and a
hypothetical getsigstksz() function would return a constant value
depending on the VL that was set.

I'd expect that only specialised code such as libc/ld.so itself or fancy
runtimes would need to cope with the need to synchronise stack
allocation with VL setting.

The initial stack after exec is determined by RLIMIT_STACK -- we can
expect that to be easily large enough for the initial thread, under any
remotely normal scenario.

> >For setcontext/setjmp, we don't save/restore any SVE state due to the
> >caller-save status of SVE, and I would not consider it necessary to
> >save/restore VL itself because of the no-change-on-the-fly policy for
> >this.
> 
> Okay, so we'd potentially set it on thread creation only?  That might not be
> too bad.

Basically, yes.  A runtime _could_ set it at other times, and my view
is that the kernel shouldn't arbitrarily forbid this -- but it's up to
userspace to determine when it's safe to do it, ensure that there's no
VL-dependent data live in memory, and to arrange to reallocate stacks
or pre-arrange that allocations were already big enough etc.

> I really want to avoid a repeat of the setxid fiasco, where we need to run
> code on all threads to get something that approximates the POSIX-mandated
> behavior (process attribute) from what the kernel provides (thread/task
> attribute).

Yeah, that would suck.

However, for the proposed ABI there is no illusion to preserve here,
since the VL is proposed as a per-thread property everywhere, and this
is outside the scope of POSIX.

If we do have distinct "set process VL" and "set thread VL" interfaces,
then my view is that the former should fail if there are already
multiple threads, rather than just setting the VL of a single thread or
(worse) asynchronously changing the VL of threads other than the
caller...

> >I'm not familiar with resumable functions/executors -- are these in
> >the C++ standards yet (not that that would cause me to be familiar
> >with them... ;)  Any implementation of coroutines (i.e.,
> >cooperative switching) is likely to fall under the "setcontext"
> >argument above.
> 
> There are different ways to implement coroutines.  Stack switching (like
> setcontext) is obviously impacted by non-uniform register sizes.  But even
> the most conservative variant, rather similar to switch-based emulation you
> sometimes see in C coroutine implementations, might have trouble restoring
> the state if it just cannot restore the saved state due to register size
> reductions.

Which is not a problem if the variably-sized state is not part of the
switched context?

Because the SVE procedure call standard determines that the SVE
registers are caller-save, they are not live at any external function
boundary -- so in cooperative switching it is useless to save/restore
this state unless the coroutine framework is defined to have a special
procedure call standard.

Similarly, my view is that we don't attempt to magically save and
restore VL itself either.  Code that changes VL after startup would be
expected to be aware of and deal with the consequences itself.

Cheers
---Dave
