From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Oct 2016 01:24:12 +0100
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <f35bbb7a559933abfc559548e860d641@codeaurora.org>
References: <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
 <20161004101208.GA18083@leverpostej>
 <884bd5d3a9a1bcf2a276130ffc17412a@codeaurora.org>
 <20161004191159.GA32596@leverpostej>
 <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
 <20161005151057.GJ3142@twins.programming.kicks-ass.net>
 <a0aa2dba916aafb188f8b1b11aca1599@codeaurora.org>
 <781b6bb229ed566e1b948bfcea18bb61@codeaurora.org>
 <20161013110256.GA436@arm.com>
 <f35bbb7a559933abfc559548e860d641@codeaurora.org>
Message-ID: <20161014002412.GC24167@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 04:00:47PM -0400, bdegraaf at codeaurora.org wrote:
> On 2016-10-13 07:02, Will Deacon wrote:
> >Brent,
> >
> >On Wed, Oct 12, 2016 at 04:01:06PM -0400, bdegraaf at codeaurora.org wrote:
> >
> >Everything from this point down needs clarification.
> >
> >>All arm64 lockref accesses that occur without taking the spinlock must
> >>behave like true atomics, ensuring successive operations are all done
> >>sequentially.
> >
> >What is a "true atomic"? What do you mean by "successive"? What do you
> >mean by "done sequentially"?
> 
> Despite the use case in dentry, lockref itself is a generic locking API, and
> any problems I describe here are with the generic API itself, not necessarily
> the dentry use case.  I'm not patching dentry--I'm fixing lockref.

Having spent the best part of a week looking at this myself, my view is that if
there is any problem it's simply that the semantics of lockref are unclear; we
can fix that by clarifying the imprecise wording in the lockref documentation
(i.e. the comment block in <linux/lockref.h>).

As far as I can tell, the only fundamental requirement is that an agent holding
the lock won't see the count change under its feet. Ordering requirements for
agents performing updates without holding the lock were never strictly defined,
and the de-facto ordering requirements of existing users (e.g. none in the case
of the dentry cache) appear to be met.

[...]

> At the time lockref was introduced, The Linux Foundation gave a presentation
> at LinuxCon 2014 that can be found at the following link:
> 
> https://events.linuxfoundation.org/sites/events/files/slides/linuxcon-2014-locking-final.pdf
> 
> On page 46, it outlines the lockref API. The first lines of the slide give
> the
> relevant details.
> 
> Lockref
> ? *Generic* mechanism to *atomically* update a reference count that is
>   protected by a spinlock without actually acquiring the spinlock itself.

... which is exactly what lockref does today. The count is updated atomically
(i.e. there are no intervening stores between the load and store to the count)
it's just that this atomic update has no enforced ordering against other memory
accesses.

This is a generically useful primitive, as-is.

> >Again, why is this a problem? It's exactly the same as if you did:
> >
> >	spin_lock(lock);
> >	inc_ref_cnt();
> >	spin_unlock(lock);
> >
> >Accesses outside of the critical section can still be reordered. Big deal.
> 
> Since the current code resembles but actually has *fewer* ordering effects
> compared to the example used by your atomic.h commit, even though A->B->C is
> in program order, it could access out of order according to your own commit
> text on commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67.

This case is not comparable. The atomic_* API has a documented requirement that
the atomic operations in question operate as full barriers, as is called out in
the commit message. Lockref has no such documented requirement.

[...]

> Again, this is a generic API, not an API married to dentry. If it were for
> dentry's sole use, it should not be accessible outside of the dentry code.
> While the cmpxchg64_relaxed case may be OK for dentry, it is not OK for the
> generic case.

Again, you are assuming a specific set of semantics that lockref is not
documented as having (and which contemporary code does not require). 

If you have a use-case for which you want stronger semantics, that is a
different story entirely.

Thanks,
Mark.
