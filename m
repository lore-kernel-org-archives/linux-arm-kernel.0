From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 11 Feb 2013 00:57:25 +0530
Subject: [PATCH v5 05/45] percpu_rwlock: Make percpu-rwlocks IRQ-safe,
 optimally
In-Reply-To: <20130208234403.GL2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
 <20130208234403.GL2666@linux.vnet.ibm.com>
Message-ID: <5117F49D.2030509@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2013 05:14 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:04:11PM +0530, Srivatsa S. Bhat wrote:
>> If interrupt handlers can also be readers, then one of the ways to make
>> per-CPU rwlocks safe, is to disable interrupts at the reader side before
>> trying to acquire the per-CPU rwlock and keep it disabled throughout the
>> duration of the read-side critical section.
[...]
>> -void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
>> +void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
>>  {
>>  	preempt_disable();
>>
>>  	/* First and foremost, let the writer know that a reader is active */
>> -	this_cpu_inc(*pcpu_rwlock->reader_refcnt);
>> +	this_cpu_add(*pcpu_rwlock->reader_refcnt, READER_PRESENT);
>>
>>  	/*
>>  	 * If we are already using per-cpu refcounts, it is not safe to switch
>>  	 * the synchronization scheme. So continue using the refcounts.
>>  	 */
>>  	if (reader_nested_percpu(pcpu_rwlock)) {
>> -		goto out;
>> +		this_cpu_inc(*pcpu_rwlock->reader_refcnt);
> 
> Hmmm...  If the reader is nested, it -doesn't- need the memory barrier at
> the end of this function.  If there is lots of nesting, it might be
> worth getting rid of it.
> 

Yes, good point! Will get rid of it.

Regards,
Srivatsa S. Bhat
