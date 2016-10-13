From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Oct 2016 12:02:57 +0100
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <781b6bb229ed566e1b948bfcea18bb61@codeaurora.org>
References: <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
 <20161004101208.GA18083@leverpostej>
 <884bd5d3a9a1bcf2a276130ffc17412a@codeaurora.org>
 <20161004191159.GA32596@leverpostej>
 <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
 <20161005151057.GJ3142@twins.programming.kicks-ass.net>
 <a0aa2dba916aafb188f8b1b11aca1599@codeaurora.org>
 <781b6bb229ed566e1b948bfcea18bb61@codeaurora.org>
Message-ID: <20161013110256.GA436@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brent,

On Wed, Oct 12, 2016 at 04:01:06PM -0400, bdegraaf at codeaurora.org wrote:
> I am still working through some additional analyses for mixed accesses,
> but I thought I'd send along some sample commit text for the fix as it
> currently stands.  Please feel free to comment if you see something that
> needs clarification.

Everything from this point down needs clarification.

> All arm64 lockref accesses that occur without taking the spinlock must
> behave like true atomics, ensuring successive operations are all done
> sequentially.

What is a "true atomic"? What do you mean by "successive"? What do you
mean by "done sequentially"?

The guarantee provided by lockref is that, if you hold the spinlock, then
you don't need to use atomics to inspect the reference count, as it is
guaranteed to be stable. You can't just go around replacing spin_lock
calls with lockref_get -- that's not what this is about.

> Currently
> the lockref accesses, when decompiled, look like the following sequence:
> 
>                     <Lockref "unlocked" Access [A]>
> 
>                     // Lockref "unlocked" (B)
>                 1:  ldxr   x0, [B]         // Exclusive load
>                      <change lock_count B>
>                     stxr   w1, x0, [B]
>                     cbnz   w1, 1b
> 
>                      <Lockref "unlocked" Access [C]>
> 
> Even though access to the lock_count is protected by exclusives, this is not
> enough
> to guarantee order: The lock_count must change atomically, in order, so the
> only
> permitted ordering would be:
>                               A -> B -> C

Says who? Please point me at a piece of code that relies on this. I'm
willing to believe that are bugs in this area, but waving your hands around
and saying certain properties "must" hold is not helpful unless you can
say *why* they must hold and *where* that is required.

> Unfortunately, this is not the case by the letter of the architecture and,
> in fact,
> the accesses to A and C are not protected by any sort of barrier, and hence
> are
> permitted to reorder freely, resulting in orderings such as
> 
>                            Bl -> A -> C -> Bs

Again, why is this a problem? It's exactly the same as if you did:

	spin_lock(lock);
	inc_ref_cnt();
	spin_unlock(lock);

Accesses outside of the critical section can still be reordered. Big deal.

> In this specific scenario, since "change lock_count" could be an
> increment, a decrement or even a set to a specific value, there could be
> trouble. 

What trouble?

> With more agents accessing the lockref without taking the lock, even
> scenarios where the cmpxchg passes falsely can be encountered, as there is
> no guarantee that the the "old" value will not match exactly a newer value
> due to out-of-order access by a combination of agents that increment and
> decrement the lock_count by the same amount.

This is the A-B-A problem, but I don't see why it affects us here. We're
dealing with a single reference count.

> Since multiple agents are accessing this without locking the spinlock,
> this access must have the same protections in place as atomics do in the
> arch's atomic.h.

Why? I don't think that it does. Have a look at how lockref is used by
the dcache code: it's really about keeping a reference to a dentry,
which may be in the process of being unhashed and removed. The
interaction with concurrent updaters to the dentry itself is handled
using a seqlock, which does have the necessary barriers. Yes, the code
is extremely complicated, but given that you're reporting issues based
on code inspection, then you'll need to understand what you're changing.

> Fortunately, the fix is not complicated: merely removing the errant
> _relaxed option on the cmpxchg64 is enough to introduce exactly the same
> code sequence justified in commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67
> to fix arm64 atomics.

I introduced cmpxchg64_relaxed precisely for the lockref case. I still
don't see a compelling reason to strengthen it. If you think there's a bug,
please spend the effort to describe how it manifests and what can actually
go wrong in the existing codebase. Your previous patches fixing so-called
bugs found by inspection have both turned out to be bogus, so I'm sorry,
but I'm not exactly leaping on your contributions to this.

Will
