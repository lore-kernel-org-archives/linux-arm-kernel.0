From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Wed, 12 Oct 2016 16:01:06 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <a0aa2dba916aafb188f8b1b11aca1599@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
 <20161004101208.GA18083@leverpostej>
 <884bd5d3a9a1bcf2a276130ffc17412a@codeaurora.org>
 <20161004191159.GA32596@leverpostej>
 <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
 <20161005151057.GJ3142@twins.programming.kicks-ass.net>
 <a0aa2dba916aafb188f8b1b11aca1599@codeaurora.org>
Message-ID: <781b6bb229ed566e1b948bfcea18bb61@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-10-05 11:30, bdegraaf at codeaurora.org wrote:
> On 2016-10-05 11:10, Peter Zijlstra wrote:
>> On Wed, Oct 05, 2016 at 10:55:57AM -0400, bdegraaf at codeaurora.org 
>> wrote:
>>> On 2016-10-04 15:12, Mark Rutland wrote:
>>> >Hi Brent,
>>> >
>>> >Could you *please* clarify if you are trying to solve:
>>> >
>>> >(a) a correctness issue (e.g. data corruption) seen in practice.
>>> >(b) a correctness issue (e.g. data corruption) found by inspection.
>>> >(c) A performance issue, seen in practice.
>>> >(d) A performance issue, found by inspection.
>>> >
>>> >Any one of these is fine; we just need to know in order to be able to
>>> >help effectively, and so far it hasn't been clear.
>> 
>> Brent, you forgot to state which: 'a-d' is the case here.
>> 
>>> I found the problem.
>>> 
>>> Back in September of 2013, arm64 atomics were broken due to missing 
>>> barriers
>>> in certain situations, but the problem at that time was undiscovered.
>>> 
>>> Will Deacon's commit d2212b4dce596fee83e5c523400bf084f4cc816c went in 
>>> at
>>> that
>>> time and changed the correct cmpxchg64 in lockref.c to 
>>> cmpxchg64_relaxed.
>>> 
>>> d2212b4 appeared to be OK at that time because the additional barrier
>>> requirements of this specific code sequence were not yet discovered, 
>>> and
>>> this change was consistent with the arm64 atomic code of that time.
>>> 
>>> Around February of 2014, some discovery led Will to correct the 
>>> problem with
>>> the atomic code via commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67, 
>>> which
>>> has an excellent explanation of potential ordering problems with the 
>>> same
>>> code sequence used by lockref.c.
>>> 
>>> With this updated understanding, the earlier commit
>>> (d2212b4dce596fee83e5c523400bf084f4cc816c) should be reverted.
>>> 
>>> Because acquire/release semantics are insufficient for the full 
>>> ordering,
>>> the single barrier after the store exclusive is the best approach, 
>>> similar
>>> to Will's atomic barrier fix.
>> 
>> This again does not in fact describe the problem.
>> 
>> What is the problem with lockref, and how (refer the earlier a-d
>> multiple choice answer) was this found.
>> 
>> Now, I have been looking, and we have some idea what you _might_ be
>> alluding to, but please explain which accesses get reordered how and
>> cause problems.
> 
> Sorry for the confusion, this was a "b" item (correctness fix based on 
> code
> inspection. I had sent an answer to this yesterday, but didn't realize 
> that
> it was in a separate, private email thread.
> 
> I'll work out the before/after problem scenarios and send them along 
> once
> I've hashed them out (it may take a while for me to paint a clear 
> picture).
> In the meantime, however, consider that even without the spinlock code 
> in
> the picture, lockref needs to treat the cmpxchg as a full system-level 
> atomic,
> because multiple agents could access the value in a variety of timings. 
> Since
> atomics similar to this are barriered on arm64 since 8e86f0b, the 
> access to
> lockref should be similar.
> 
> Brent

I am still working through some additional analyses for mixed accesses, 
but I
thought I'd send along some sample commit text for the fix as it 
currently stands.
Please feel free to comment if you see something that needs 
clarification.

Brent



Text:

All arm64 lockref accesses that occur without taking the spinlock must 
behave like
true atomics, ensuring successive operations are all done sequentially.  
Currently
the lockref accesses, when decompiled, look like the following sequence:

                     <Lockref "unlocked" Access [A]>

                     // Lockref "unlocked" (B)
                 1:  ldxr   x0, [B]         // Exclusive load
                      <change lock_count B>
                     stxr   w1, x0, [B]
                     cbnz   w1, 1b

                      <Lockref "unlocked" Access [C]>

Even though access to the lock_count is protected by exclusives, this is 
not enough
to guarantee order: The lock_count must change atomically, in order, so 
the only
permitted ordering would be:
                               A -> B -> C

Unfortunately, this is not the case by the letter of the architecture 
and, in fact,
the accesses to A and C are not protected by any sort of barrier, and 
hence are
permitted to reorder freely, resulting in orderings such as

                            Bl -> A -> C -> Bs

In this specific scenario, since "change lock_count" could be an 
increment, a decrement
or even a set to a specific value, there could be trouble.  With more 
agents accessing
the lockref without taking the lock, even scenarios where the cmpxchg 
passes falsely
can be encountered, as there is no guarantee that the the "old" value 
will not match
exactly a newer value due to out-of-order access by a combination of 
agents that
increment and decrement the lock_count by the same amount.

Since multiple agents are accessing this without locking the spinlock, 
this access
must have the same protections in place as atomics do in the arch's 
atomic.h.
Fortunately, the fix is not complicated: merely removing the errant 
_relaxed option
on the cmpxchg64 is enough to introduce exactly the same code sequence 
justified
in commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67 to fix arm64 atomics.

                    1:  ldxr   x0, [B]
                        <change lock_count>
                        stlxr   w1, x0, [B]
                        cbnz   w1, 1b
                        dmb    ish
