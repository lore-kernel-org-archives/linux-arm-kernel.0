From: longman@redhat.com (Waiman Long)
Date: Wed, 11 Apr 2018 16:35:25 -0400
Subject: [PATCH v2 04/13] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <674fd9c0-e3f3-9ae0-dd0a-7ccc085c1706@redhat.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-5-git-send-email-will.deacon@arm.com>
 <674fd9c0-e3f3-9ae0-dd0a-7ccc085c1706@redhat.com>
Message-ID: <d0fb47ef-bfd7-a2b8-7c0d-14d8f18aa608@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2018 03:34 PM, Waiman Long wrote:
> On 04/11/2018 02:01 PM, Will Deacon wrote:
>> @@ -485,15 +499,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>  	 * claim the lock:
>>  	 *
>>  	 * n,0,0 -> 0,0,1 : lock, uncontended
>> -	 * *,0,0 -> *,0,1 : lock, contended
>> +	 * *,*,0 -> *,*,1 : lock, contended
>>  	 *
>> -	 * If the queue head is the only one in the queue (lock value == tail),
>> -	 * clear the tail code and grab the lock. Otherwise, we only need
>> -	 * to grab the lock.
>> +	 * If the queue head is the only one in the queue (lock value == tail)
>> +	 * and nobody is pending, clear the tail code and grab the lock.
>> +	 * Otherwise, we only need to grab the lock.
>>  	 */
>>  	for (;;) {
>>  		/* In the PV case we might already have _Q_LOCKED_VAL set */
>> -		if ((val & _Q_TAIL_MASK) != tail) {
>> +		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
>>  			set_locked(lock);
>>  			break;
>>  		}
> I don't think it is right to just grab the lock when the pending bit is
> set. I believe it will cause problem.
>
> Preserving the the pending bit should be just
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 35367cc..76d9124 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -511,7 +511,8 @@ void queued_spin_lock_slowpath(struct qspinlock
> *lock, u32 v
>                  * necessary acquire semantics required for locking. At most
>                  * two iterations of this loop may be ran.
>                  */
> -               old = atomic_cmpxchg_relaxed(&lock->val, val,
> _Q_LOCKED_VAL);
> +               old = atomic_cmpxchg_relaxed(&lock->val, val,
> +                       _Q_LOCKED_VAL | (val & _Q_PENDING_MASK));
>                 if (old == val)
>                         goto release;   /* No contention */

After some more thought and reviewing the rests of the patchset, I now
think your change here is OK. Sorry for the noise.

Cheers,
Longman
