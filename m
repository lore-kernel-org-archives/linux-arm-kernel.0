From: mnipxh@hotmail.com (pan xinhui)
Date: Fri, 5 May 2017 11:37:11 +0000
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIDAvM10gYXJtNjQ6IHF1ZXVlZCBzcGlubG9j?=
 =?gb2312?Q?ks_and_rw-locks?=
In-Reply-To: <20170504202809.lv222a3oes54ijkj@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>,
 <20170504202809.lv222a3oes54ijkj@yury-N73SV>
Message-ID: <SIXPR0199MB060442A87C42845BC9142E43C5EB0@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2017/5/5 04:28, Yury Norov ??:> On Wed, May 03, 2017 at 06:59:19PM +0000, pan xinhui wrote:
>> ? 2017/5/3 22:51, Yury Norov ??:> The patch 3 adds implementation for queued-based locking on
>>> ARM64, and the option in kernel config to enable it. Patches
>>> 1 and 2 fix some mess in header files to apply patch 3 smoothly.
>>>
>>> Tested on QDF2400 with huge improvements with these patches on
>>> the torture tests, by Adam Wallis.
>>>
>>> Tested on ThunderX, by Andrew Pinski:
>>> 120 thread (30 core - 4 thread/core) CN99xx (single socket):
>>>
>>> benchmark               Units	qspinlocks vs ticket locks
>>> sched/messaging		s	73.91%
>>> sched/pipe		ops/s	104.18%
>>> futex/hash		ops/s	103.87%
>>> futex/wake		ms	71.04%
>>> futex/wake-parallel	ms	93.88%
>>> futex/requeue		ms	96.47%
>>> futex/lock-pi		ops/s	118.33%
>>>
>>> Notice, there's the queued locks implementation for the Power PC introduced
>>> by Pan Xinhui. He largely tested it and also found significant performance
>>> gain. In arch part it is very similar to this patch though.
>>> https://lwn.net/Articles/701137/Hi, Yury
>>      Glad to know you will join locking development :)
>> I have left IBM. However I still care about the queued-spinlock anyway.
>>
>>> RFC: https://www.spinics.net/lists/arm-kernel/msg575575.htmlI notice you raised one question about the performance degradation in the acquisition of rw-lock for read on qemu.
>> This is strange indeed. I once enabled qrwlock on ppc too.
>>
>> I paste your test reseults below.  Is this a result of
>> qspinlock + qrwlock VS qspinlock + normal rwlock or
>> qspinlock + qrwlock VS normal spinlock + normal rwlock?
> 
> Initially it was VS normal spinlock + normal rwlock. But now I checked
> it vs qspinlock + normal rwlock, and results are the same. I don't think
> it's a real use case to have ticket spinlocks and queued rwlocks, or
> vice versa.
>   
>> I am not sure how that should happen.
> 
> Either me. If I understand it correctly, qemu is not suitable for measuring
I do tests in both qemu with kvm and bare metal :)
Usually the performance results are same on the two plamforms.

> performance, so I don't understand why slowing in qemu is important at all,
> if real hardware works better. If it matters, my host CPU is Core i7-2630QM
>> I make one RFC patch below(not based on latest kernel), you could apply it to
>> check if ther is any performance improvement.
>> The idea is that.
>> In queued_write_lock_slowpath(), we did not unlock the ->wait_lock.
>> Because the writer hold the rwlock, all readers are still waiting anyway.
>> And in queued_read_lock_slowpath(), calling rspin_until_writer_unlock() looks
>> like introduce a little overhead, say, spinning at the rwlock.
>>
>> But in the end, queued_read_lock_slowpath() is too heavy, compared with the
>> normal rwlock. such result maybe is somehow reasonable?
> 
> I tried this path, but kernel hangs on boot with it, in
> queued_write_lock_slowpath().
>>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
>> index 54a8e65..28ee01d 100644
>> --- a/include/asm-generic/qrwlock.h
>> +++ b/include/asm-generic/qrwlock.h
>> @@ -28,8 +28,9 @@
>>    * Writer states & reader shift and bias
>>    */
>>   #define	_QW_WAITING	1		/* A writer is waiting	   */
>> -#define	_QW_LOCKED	0xff		/* A writer holds the lock */
>> -#define	_QW_WMASK	0xff		/* Writer mask		   */
>> +#define _QW_KICK	0x80		/* need unlock the spinlock*/
>> +#define	_QW_LOCKED	0x7f		/* A writer holds the lock */
>> +#define	_QW_WMASK	0x7f		/* Writer mask		   */
>>   #define	_QR_SHIFT	8		/* Reader count shift	   */
>>   #define _QR_BIAS	(1U << _QR_SHIFT)
>>   
>> @@ -139,7 +140,10 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>>    */
>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>   {
>> -	smp_store_release((u8 *)&lock->cnts, 0);
>> +	u32 v = atomic_read(&lock->cnts) & (_QW_WMASK | _QW_KICK);
>> +	if (v & _QW_KICK)
>> +		arch_spin_unlock(&lock->wait_lock);
>> +	(void)atomic_sub_return_release(v, &lock->cnts);
>>   }
>>   
>>   /*
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index fec0823..1f0ea02 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -116,7 +116,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>>   
>>   	/* Try to acquire the lock directly if no reader is present */
>>   	if (!atomic_read(&lock->cnts) &&
>> -	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
>> +	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED|_QW_KICK) == 0))
>>   		goto unlock;
>>   
>>   	/*
>> @@ -138,12 +138,13 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>>   		cnts = atomic_read(&lock->cnts);
>>   		if ((cnts == _QW_WAITING) &&
>>   		    (atomic_cmpxchg_acquire(&lock->cnts, _QW_WAITING,
>> -					    _QW_LOCKED) == _QW_WAITING))
>> +					    _QW_LOCKED|_QW_KICK) == _QW_WAITING))
>>   			break;
>>   
>>   		cpu_relax_lowlatency();
> 
> It hangs in this in this loop. It's because lock->cnts may now contain
> _QW_WAITING or _QW_WAITING | _QW_KICK. So the if() condition may never
> meet in 2nd case. To handle it, I changed it like this:No, that should not happen.
Because only writer will set ->wmode(part of ->cnts) to _QW_WAITING in another for-loop before.

>      for (;;) {
>              cnts = atomic_read(&lock->cnts);
>              if (((cnts & _QW_WMASK) == _QW_WAITING) &&
>                  (atomic_cmpxchg_acquire(&lock->cnts, cnts,
>                                          _QW_LOCKED|_QW_KICK) == cnts))This is wrong. Originally we need check if there is any reader holds the rwlock.
But the if condition you wrote could be true even there are readers holding the rwlock.

I have no idea why my patch hangs the kernel. It works on my side. Although the perfromance results on x86 have little difference.
So leave my patch alone anyway.

thanks
xinhui>                      break;
> 
>              cpu_relax();
>      }
> 
> 
> But after that it hanged in queued_spin_lock_slowpath() at the line
> 478             smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
> 
> Backtrace is below.
> 
> Yury
> 
>>   	}
>>   unlock:
>> -	arch_spin_unlock(&lock->wait_lock);
>> +	return;
>>   }
>>   EXPORT_SYMBOL(queued_write_lock_slowpath);
>> -- 
>> 2.4.11
> 
> #0  queued_spin_lock_slowpath (lock=0xffff000008cb051c <proc_subdir_lock+4>, val=<optimized out>)
>      at kernel/locking/qspinlock.c:478
> #1  0xffff0000080ff158 in queued_spin_lock (lock=<optimized out>)
>      at ./include/asm-generic/qspinlock.h:104
> #2  queued_write_lock_slowpath (lock=0xffff000008cb0518 <proc_subdir_lock>)
>      at kernel/locking/qrwlock.c:116
> #3  0xffff000008815fc4 in queued_write_lock (lock=<optimized out>)
>      at ./include/asm-generic/qrwlock.h:135
> #4  __raw_write_lock (lock=<optimized out>) at ./include/linux/rwlock_api_smp.h:211
> #5  _raw_write_lock (lock=<optimized out>) at kernel/locking/spinlock.c:295
> #6  0xffff00000824c4c0 in proc_register (dir=0xffff000008bff2d0 <proc_root>,
>      dp=0xffff80003d807300) at fs/proc/generic.c:342
> #7  0xffff00000824c628 in proc_symlink (name=<optimized out>,
>      parent=0xffff000008b28e40 <proc_root_init+72>, dest=0xffff000008a331a8 "self/net")
>      at fs/proc/generic.c:413
> #8  0xffff000008b2927c in proc_net_init () at fs/proc/proc_net.c:244
> #9  0xffff000008b28e40 in proc_root_init () at fs/proc/root.c:137
> #10 0xffff000008b10b10 in start_kernel () at init/main.c:661
> #11 0xffff000008b101e0 in __primary_switched () at arch/arm64/kernel/head.S:347
> 
> .
> 
