From: longman@redhat.com (Waiman Long)
Date: Fri, 27 Apr 2018 09:09:21 -0400
Subject: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180427101619.GB21705@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <1adce90b-7627-ed71-fd34-bb33388790d5@redhat.com>
 <20180427101619.GB21705@arm.com>
Message-ID: <d9b1cc76-7878-43d2-bda9-b3bf074b5c9e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2018 06:16 AM, Will Deacon wrote:
> Hi Waiman,
>
> On Thu, Apr 26, 2018 at 04:16:30PM -0400, Waiman Long wrote:
>> On 04/26/2018 06:34 AM, Will Deacon wrote:
>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
>>> index 2711940429f5..2dbad2f25480 100644
>>> --- a/kernel/locking/qspinlock_paravirt.h
>>> +++ b/kernel/locking/qspinlock_paravirt.h
>>> @@ -118,11 +118,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
>>>  	WRITE_ONCE(lock->pending, 1);
>>>  }
>>>  
>>> -static __always_inline void clear_pending(struct qspinlock *lock)
>>> -{
>>> -	WRITE_ONCE(lock->pending, 0);
>>> -}
>>> -
>>>  /*
>>>   * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
>>>   * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
>> There is another clear_pending() function after the "#else /*
>> _Q_PENDING_BITS == 8 */" line that need to be removed as well.
> Bugger, sorry I missed that one. Is the >= 16K CPUs case supported elsewhere
> in Linux? The x86 Kconfig appears to clamp NR_CPUS to 8192 iiuc.
>
> Anyway, additional patch below. Ingo -- please can you apply this on top?
>
I don't think we support >= 16k in any of the distros. However, this
will be a limit that we will reach eventually. That is why I said we can
wait.

Cheers,
Longman
