From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 1 Sep 2016 12:54:36 +0100
Subject: [PATCH] arm64: spinlock: clarify implementation details of
 arch_spin_lock
In-Reply-To: <20160901112726.GC6721@arm.com>
References: <1472726820-32959-1-git-send-email-vladimir.murzin@arm.com>
 <20160901112726.GC6721@arm.com>
Message-ID: <57C816FC.5090403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 12:27, Will Deacon wrote:
> On Thu, Sep 01, 2016 at 11:47:00AM +0100, Vladimir Murzin wrote:
>> It seems to be quite confusing to see atomic load not being paired
>> with atomic store down to arch_spin_lock function. To prevent the same
>> questions/patches around this add a comment block explaining what is
>> going on there.
>>
>> The comment has been stolen from Catalin's reply [1].
>>
>> [1] https://lkml.org/lkml/2016/8/30/127
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm64/include/asm/spinlock.h |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
>> index e875a5a..9a2155c 100644
>> --- a/arch/arm64/include/asm/spinlock.h
>> +++ b/arch/arm64/include/asm/spinlock.h
>> @@ -113,6 +113,18 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>>  	 */
>>  "	sevl\n"
>>  "2:	wfe\n"
>> +	/*
>> +	 * Don't be confused with atomic load bellow not being paired
>> +	 * with atomic store. This is needed because the
>> +	 * arch_spin_unlock() code only uses an STLR without an
>> +	 * explicit SEV (like we have on AArch32). An event is
>> +	 * automatically generated when the exclusive monitor is
>> +	 * cleared by STLR. But without setting it with a load
>> +	 * exclusive in arch_spin_lock() (even though it does not
>> +	 * acquire the lock), there won't be anything to clear, hence
>> +	 * no event to be generated. In this case, the WFE would wait
>> +	 * indefinitely.
>> +	 */
> 
> So the purpose of our spin_lock implementation is to provide a spin_lock
> primitive to kernel code which follows the semantics of Linux spin locks.
> It's not intended to teach people the ARMv8 architecture.
> 
> If we comment this (and I don't think your comment is necessarily helpful),
> then do we also comment arch_spin_unlock_wait, __cmpwait, the rwlocks, ...?
> 
> At some point we have to assume that people attempting to understand the
> low-level locking primitives for an architecture will bother to read the
> documentation :/ Hell, the ARMv8 ARM even has an example ticket lock
> implementation in "K10.3.4 Use of Wait For Event (WFE) and Send Event
> (SEV) with locks" that uses this trick.
> 

So, NAK? ;)

Cheers
Vladimir

> Will
> 
> 
