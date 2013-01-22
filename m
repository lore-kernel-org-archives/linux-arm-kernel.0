From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Wed, 23 Jan 2013 01:28:21 +0530
Subject: [PATCH v5 01/45] percpu_rwlock: Introduce the global reader-writer
 lock backend
In-Reply-To: <1358883152.21576.55.camel@gandalf.local.home>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
 <1358883152.21576.55.camel@gandalf.local.home>
Message-ID: <50FEEF5D.6080302@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 01:02 AM, Steven Rostedt wrote:
> On Tue, 2013-01-22 at 13:03 +0530, Srivatsa S. Bhat wrote:
>> A straight-forward (and obvious) algorithm to implement Per-CPU Reader-Writer
>> locks can also lead to too many deadlock possibilities which can make it very
>> hard/impossible to use. This is explained in the example below, which helps
>> justify the need for a different algorithm to implement flexible Per-CPU
>> Reader-Writer locks.
>>
>> We can use global rwlocks as shown below safely, without fear of deadlocks:
>>
>> Readers:
>>
>>          CPU 0                                CPU 1
>>          ------                               ------
>>
>> 1.    spin_lock(&random_lock);             read_lock(&my_rwlock);
>>
>>
>> 2.    read_lock(&my_rwlock);               spin_lock(&random_lock);
>>
>>
>> Writer:
>>
>>          CPU 2:
>>          ------
>>
>>        write_lock(&my_rwlock);
>>
> 
> I thought global locks are now fair. That is, a reader will block if a
> writer is waiting. Hence, the above should deadlock on the current
> rwlock_t types.
> 

Oh is it? Last I checked, lockdep didn't complain about this ABBA scenario!

> We need to fix those locations (or better yet, remove all rwlocks ;-)
> 

:-)

The challenge with stop_machine() removal is that the replacement on the
reader side must have the (locking) flexibility comparable to preempt_disable().
Otherwise, that solution most likely won't be viable because we'll hit way
too many locking problems and go crazy by the time we convert them over..(if
we can, that is!)

Regards,
Srivatsa S. Bhat
