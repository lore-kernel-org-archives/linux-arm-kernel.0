From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 25 Jun 2013 18:54:23 +0800
Subject: [Question] race between spin_lock and spin_unlock
In-Reply-To: <20130625084805.GB31006@mudshark.cambridge.arm.com>
References: <CACVXFVMBL5E5SGwDatn_ay0sPOhqPKTwouCbzjwrhPuRKHNDcg@mail.gmail.com>
 <20130624154357.GB25582@mudshark.cambridge.arm.com>
 <CACVXFVNgONa79n+7Bg4p4Fx568XaK6gy+L9tCrP=CmOGwKY7ig@mail.gmail.com>
 <20130624163732.GC25582@mudshark.cambridge.arm.com>
 <CACVXFVMW39SD2YvW-+_A_kv0YgyOToB7xqhHgT7eZKxxWL0-mA@mail.gmail.com>
 <20130625084805.GB31006@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNq111U5OvVNXX-xm8RodQoXSjLUSFHzehRvtdk9jMCzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 4:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jun 25, 2013 at 05:31:44AM +0100, Ming Lei wrote:
>> On Tue, Jun 25, 2013 at 12:37 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > You mean, if you had two CPUs spinning on a lock held by a third CPU? In
>> > this case, the third CPU would have to release the lock, then one of the
>> > waiters would have to acquire it, complete its critical section and finally
>> > release it before the other waiter had executed its wfe (about three
>> > instructions)...
>>
>> I mean the below situation:
>>
>> CPU0                                                                          CPU1
>>
>> spin_lock(&A)
>>       StoreExcl(lock->next)
>>                                                                                       spin_unlock(&A)
>>                                                                                               Store(&lock->owner)
>>                                                                                               dsb_sev()
>>       interrupt comes
>>               - wfe() called in the
>>               irq handler
>
> Is this just a vanilla wfe, or as part of a spin_lock? If it's part of a
> spin_lock, then we'll do a sev when we unlock it. An opencoded wfe in an

Suppose it is part of spin_lock(&B), and the sev in spin_unlock(&B) may happen
in CPU2 or CPU3, then two sev() will come in CPU0.

My question is that if the wfe in spin_lock(&B) called from irq
handler may clear
the two sev().

If yes, the wfe() in spin_lock(&A) may still wait for later sev, right?  If not,
it should be fine.

Thanks,
-- 
Ming Lei
