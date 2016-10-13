From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Thu, 13 Oct 2016 16:00:47 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <20161013110256.GA436@arm.com>
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
 <20161013110256.GA436@arm.com>
Message-ID: <f35bbb7a559933abfc559548e860d641@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-10-13 07:02, Will Deacon wrote:
> Brent,
> 
> On Wed, Oct 12, 2016 at 04:01:06PM -0400, bdegraaf at codeaurora.org 
> wrote:
> 
> Everything from this point down needs clarification.
> 
>> All arm64 lockref accesses that occur without taking the spinlock must
>> behave like true atomics, ensuring successive operations are all done
>> sequentially.
> 
> What is a "true atomic"? What do you mean by "successive"? What do you
> mean by "done sequentially"?
> 

Despite the use case in dentry, lockref itself is a generic locking API, 
and
any problems I describe here are with the generic API itself, not 
necessarily
the dentry use case.  I'm not patching dentry--I'm fixing lockref.

By necessity, the API must do its update atomically, as keeping things 
correct
involves potential spinlock access by other agents which may opt to use 
the
spinlock API or the lockref API at their discretion.  With the current 
arm64
spinlock implementation, it is possible for the lockref to observe the 
changed
contents of the protected count without observing the spinlock being 
locked,
which could lead to missed changes to the lock_count itself, because any
calculations made on it could be overwritten or completed in a different
sequence.

(Spinlock locked access is obtained with a simple store under certain
scenarios. My attempt to fix this in the spinlock code was met with 
resistance
saying it should be addressed in lockref, since that is the API that 
would
encounter the issue.  These changes were initiated in response to that 
request.
Additional ordering problems were uncovered when I looked into lockref 
itself.)

The example below involves only a single agent exactly as you explain 
the
problem in commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67.  Even for a 
single
execution agent, this means that the code below could access out of 
order.
As lockref is a generic API, it doesn't matter whether dentry does this 
or not.
By "done sequentially," I mean "accessed in program order."

As far as "true atomic" goes, I am referring to an atomic in the same 
sense you
did in commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67.

> The guarantee provided by lockref is that, if you hold the spinlock, 
> then
> you don't need to use atomics to inspect the reference count, as it is
> guaranteed to be stable. You can't just go around replacing spin_lock
> calls with lockref_get -- that's not what this is about.
> 

I am not sure where you got the idea that I was referring to replacing 
spinlocks
with lockref calls.  That is not the foundation for this fix.

>> Currently
>> the lockref accesses, when decompiled, look like the following 
>> sequence:
>> 
>>                     <Lockref "unlocked" Access [A]>
>> 
>>                     // Lockref "unlocked" (B)
>>                 1:  ldxr   x0, [B]         // Exclusive load
>>                      <change lock_count B>
>>                     stxr   w1, x0, [B]
>>                     cbnz   w1, 1b
>> 
>>                      <Lockref "unlocked" Access [C]>
>> 
>> Even though access to the lock_count is protected by exclusives, this 
>> is not
>> enough
>> to guarantee order: The lock_count must change atomically, in order, 
>> so the
>> only
>> permitted ordering would be:
>>                               A -> B -> C
> 
> Says who? Please point me at a piece of code that relies on this. I'm
> willing to believe that are bugs in this area, but waving your hands 
> around
> and saying certain properties "must" hold is not helpful unless you can
> say *why* they must hold and *where* that is required.
> 

The lockref code must access in order, because other agents can observe 
it via
spinlock OR lockref APIs.  Again, this is a generic API, not an explicit 
part of
dentry. Other code will use it, and the manner in which it is used in 
dentry is not
relevant.  What lock_count is changed to is not proscribed by the 
lockref
API.  There is no guarantee whether it be an add, subtract, multiply, 
divide, set
to some explicit value, etc.  But the changes must be done in program 
order and
observable in that same order by other agents:  Therefore, the spinlock 
and lock_count
must be accessed atomically, and observed to change atomically at the 
system level.

I am not off base saying lockref is an atomic access.  Here are some 
references:

Under Documentation/filesystems/path-lookup.md, the dentry->d_lockref 
mechanism
is described as an atomic access.

At the time lockref was introduced, The Linux Foundation gave a 
presentation at
LinuxCon 2014 that can be found at the following link:

https://events.linuxfoundation.org/sites/events/files/slides/linuxcon-2014-locking-final.pdf

On page 46, it outlines the lockref API. The first lines of the slide 
give the
relevant details.

Lockref
? *Generic* mechanism to *atomically* update a reference count that is
   protected by a spinlock without actually acquiring the spinlock 
itself.

While dentry's use is mentioned, this API is not restricted to the use 
case of dentry.

>> Unfortunately, this is not the case by the letter of the architecture 
>> and,
>> in fact,
>> the accesses to A and C are not protected by any sort of barrier, and 
>> hence
>> are
>> permitted to reorder freely, resulting in orderings such as
>> 
>>                            Bl -> A -> C -> Bs
> 
> Again, why is this a problem? It's exactly the same as if you did:
> 
> 	spin_lock(lock);
> 	inc_ref_cnt();
> 	spin_unlock(lock);
> 
> Accesses outside of the critical section can still be reordered. Big 
> deal.
> 

Since the current code resembles but actually has *fewer* ordering 
effects
compared to the example used by your atomic.h commit, even though 
A->B->C is in
program order, it could access out of order according to your own commit 
text
on commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67.

Taking spin_lock/spin_unlock, however, includes ordering by nature of 
the
load-acquire observing the store-release of a prior unlock, so ordering 
is
enforced with the spinlock version of accesses. The lockref itself has 
*no*
ordering enforced, unless a locked state is encountered and it falls 
back
to the spinlock code.  So this is a fundamental difference between 
lockref and
spinlock.  So, no, lockref ordering is currently not exactly the same as
spinlock--but it should be.

>> In this specific scenario, since "change lock_count" could be an
>> increment, a decrement or even a set to a specific value, there could 
>> be
>> trouble.
> 
> What trouble?
> 

Take, for example, a use case where the ref count is either positive or 
zero.
If increments and decrements hit out of order, a decrement that was 
supposed
to come after an increment would instead do nothing if the value of the 
lock
started at zero.  Then when the increment hit later, the ref count would 
remain
positive with a net effect of +1 to the ref count instead of +1-1=0.  
Again,
however, the lockref does not specify how the contents of lock_count are
manipulated, it was only meant to guarantee that they are done 
atomically when
the lock is not held.

>> With more agents accessing the lockref without taking the lock, even
>> scenarios where the cmpxchg passes falsely can be encountered, as 
>> there is
>> no guarantee that the the "old" value will not match exactly a newer 
>> value
>> due to out-of-order access by a combination of agents that increment 
>> and
>> decrement the lock_count by the same amount.
> 
> This is the A-B-A problem, but I don't see why it affects us here. 
> We're
> dealing with a single reference count.
> 

If lockref accesses were to occur on many Pe's, there are all sorts of
things that could happen in terms of who wins what, and what they set 
the
lock_count to.  My point is simply that each access should be atomic 
because
lockref is a generic API and was intended to be a lockless atomic 
access.
Leaving this problem open until someone else introduces a use that 
exposes
it, which could happen in the main kernel code, is probably not a good
idea, as it could prove difficult to track down.

>> Since multiple agents are accessing this without locking the spinlock,
>> this access must have the same protections in place as atomics do in 
>> the
>> arch's atomic.h.
> 
> Why? I don't think that it does. Have a look at how lockref is used by
> the dcache code: it's really about keeping a reference to a dentry,
> which may be in the process of being unhashed and removed. The
> interaction with concurrent updaters to the dentry itself is handled
> using a seqlock, which does have the necessary barriers. Yes, the code
> is extremely complicated, but given that you're reporting issues based
> on code inspection, then you'll need to understand what you're 
> changing.
> 

Again, this is a generic API, not an API married to dentry. If it were 
for
dentry's sole use, it should not be accessible outside of the dentry 
code.
While the cmpxchg64_relaxed case may be OK for dentry, it is not OK for 
the
generic case.

>> Fortunately, the fix is not complicated: merely removing the errant
>> _relaxed option on the cmpxchg64 is enough to introduce exactly the 
>> same
>> code sequence justified in commit 
>> 8e86f0b409a44193f1587e87b69c5dcf8f65be67
>> to fix arm64 atomics.
> 
> I introduced cmpxchg64_relaxed precisely for the lockref case. I still
> don't see a compelling reason to strengthen it. If you think there's a 
> bug,
> please spend the effort to describe how it manifests and what can 
> actually
> go wrong in the existing codebase. Your previous patches fixing 
> so-called
> bugs found by inspection have both turned out to be bogus, so I'm 
> sorry,
> but I'm not exactly leaping on your contributions to this.
> 
> Will

I have detailed the problems here, and they are with the generic case, 
no
hand waving required.

On a further note, it is not accurate to say that my prior patches were
bogus: One called to attention a yet-to-be-corrected problem in the 
ARMv8
Programmer's Guide, and the other was sidestepped by a refactor that
addressed the problem I set out to fix with a control flow change. Since
that problem was the fundamental reason I had worked on the gettime code
in the first place, I abandoned my effort. The refactor that fixed the
control-flow problem, however, is still missing on v4.7 and earlier 
kernels
(sequence lock logic should be verified prior to the isb that demarcates
the virtual counter register read). I have confirmed this is an issue on
various armv8 hardware, sometimes obtaining identical register values
between multiple reads that were delayed such that they should have 
shown
changes, evidence that the register read accessed prior to the seqlock
update having finished (the control flow problem).

Brent
