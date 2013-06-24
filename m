From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 25 Jun 2013 00:04:37 +0800
Subject: [Question] race between spin_lock and spin_unlock
In-Reply-To: <20130624154357.GB25582@mudshark.cambridge.arm.com>
References: <CACVXFVMBL5E5SGwDatn_ay0sPOhqPKTwouCbzjwrhPuRKHNDcg@mail.gmail.com>
 <20130624154357.GB25582@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNgONa79n+7Bg4p4Fx568XaK6gy+L9tCrP=CmOGwKY7ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 11:43 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jun 24, 2013 at 04:13:38PM +0100, Ming Lei wrote:
>> Hi,
>
> Hi Ming Lei,
>
>> When reading the code of arch_spin_lock(), I think there might be
>> a race between arch_spin_lock() and arch_spin_unlock():
>>
>> - arch_spin_unlock() happened just between StoreExcl(lock->next)
>> and comparing lockval.tickets.next with lockval.tickets.owner inside
>> arch_spin_lock()
>>
>> - arch_spin_lock() can't notice the change on lock->owner, so call
>> wfe(), then just waiting for being waken up, but there isn't corresponding
>> unlock to send wake event any more.
>>
>> Maybe the below change may make the race to happen difficultly,
>> but it still can't avoid it completely.
>>
>> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
>> index 6220e9f..e1b239c 100644
>> --- a/arch/arm/include/asm/spinlock.h
>> +++ b/arch/arm/include/asm/spinlock.h
>> @@ -87,10 +87,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>>       : "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
>>       : "cc");
>>
>> -     while (lockval.tickets.next != lockval.tickets.owner) {
>> +     while (lockval.tickets.next != ACCESS_ONCE(lock->tickets.owner))
>>               wfe();
>> -             lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
>> -     }
>>
>>       smp_mb();
>>  }
>>
>> Any comments on the problem?
>
> Not sure I see the problem -- the sev guaranteed by the unlock is pended on
> the core doing the lock by setting the event register, so you can't miss it.
> The wfe will acknowledge the event (by clearing the event register) but it
> won't actually wait.

If so, looks I am afraid too much, :-)

Also I have another question, if two sev() comes from two cores, then the
wfe() in one core will acknowledge both the two sev()? or one wfe() only
acks one sev()?

If the wfe() in one core may acknowledge two sev(), the above problem
might still exists.


Thanks,
-- 
Ming Lei
