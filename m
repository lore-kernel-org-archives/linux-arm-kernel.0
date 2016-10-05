From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Wed, 05 Oct 2016 10:55:57 -0400
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <20161004191159.GA32596@leverpostej>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
 <20161004101208.GA18083@leverpostej>
 <884bd5d3a9a1bcf2a276130ffc17412a@codeaurora.org>
 <20161004191159.GA32596@leverpostej>
Message-ID: <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-10-04 15:12, Mark Rutland wrote:
> Hi Brent,
> 
> Could you *please* clarify if you are trying to solve:
> 
> (a) a correctness issue (e.g. data corruption) seen in practice.
> (b) a correctness issue (e.g. data corruption) found by inspection.
> (c) A performance issue, seen in practice.
> (d) A performance issue, found by inspection.
> 
> Any one of these is fine; we just need to know in order to be able to
> help effectively, and so far it hasn't been clear.
> 
> On Tue, Oct 04, 2016 at 01:53:35PM -0400, bdegraaf at codeaurora.org 
> wrote:
>> After looking at this, the problem is not with the lockref code per
>> se: it is a problem with arch_spin_value_unlocked(). In the
>> out-of-order case, arch_spin_value_unlocked() can return TRUE for a
>> spinlock that is in fact locked but the lock is not observable yet via
>> an ordinary load.
> 
> Given arch_spin_value_unlocked() doesn't perform any load itself, I
> assume the ordinary load that you are referring to is the READ_ONCE()
> early in CMPXCHG_LOOP().
> 
> It's worth noting that even if we ignore ordering and assume a
> sequentially-consistent machine, READ_ONCE() can give us a stale value.
> We could perform the read, then another agent can acquire the lock, 
> then
> we can move onto the cmpxchg(), i.e.
> 
>     CPU0                              CPU1
>     old = READ_ONCE(x.lock_val)
>                                       spin_lock(x.lock)
>     cmpxchg(x.lock_val, old, new)
>                                       spin_unlock(x.lock)
> 
> If the 'old' value is stale, the cmpxchg *must* fail, and the cmpxchg
> should return an up-to-date value which we will then retry with.
> 
>> Other than ensuring order on the locking side (as the prior patch
>> did), there is a way to make arch_spin_value_unlock's TRUE return
>> value deterministic,
> 
> In general, this cannot be made deterministic. As above, there is a 
> race
> that cannot be avoided.
> 
>> but it requires that it does a write-back to the lock to ensure we
>> didn't observe the unlocked value while another agent was in process
>> of writing back a locked value.
> 
> The cmpxchg gives us this guarantee. If it successfully stores, then 
> the
> value it observed was the same as READ_ONCE() saw, and the update was
> atomic.
> 
> There *could* have been an intervening sequence between the READ_ONCE
> and cmpxchg (e.g. put(); get()) but that's not problematic for lockref.
> Until you've taken your reference it was possible that things changed
> underneath you.
> 
> Thanks,
> Mark.

Mark,

I found the problem.

Back in September of 2013, arm64 atomics were broken due to missing 
barriers
in certain situations, but the problem at that time was undiscovered.

Will Deacon's commit d2212b4dce596fee83e5c523400bf084f4cc816c went in at 
that
time and changed the correct cmpxchg64 in lockref.c to 
cmpxchg64_relaxed.

d2212b4 appeared to be OK at that time because the additional barrier
requirements of this specific code sequence were not yet discovered, and
this change was consistent with the arm64 atomic code of that time.

Around February of 2014, some discovery led Will to correct the problem 
with
the atomic code via commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67, 
which
has an excellent explanation of potential ordering problems with the 
same
code sequence used by lockref.c.

With this updated understanding, the earlier commit
(d2212b4dce596fee83e5c523400bf084f4cc816c) should be reverted.

Because acquire/release semantics are insufficient for the full 
ordering,
the single barrier after the store exclusive is the best approach, 
similar
to Will's atomic barrier fix.

Best regards,
Brent
