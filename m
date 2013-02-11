From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 11 Feb 2013 18:26:10 +0530
Subject: [PATCH v5 01/45] percpu_rwlock: Introduce the global reader-writer
 lock backend
In-Reply-To: <30708.1360586491@warthog.procyon.org.uk>
References: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
 <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <30708.1360586491@warthog.procyon.org.uk>
Message-ID: <5118EA6A.9040002@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 06:11 PM, David Howells wrote:
> Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> 
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
> 
> The lock order on CPU 0 is unsafe if CPU2 can do:
> 
> 	write_lock(&my_rwlock);
> 	spin_lock(&random_lock);
> 
> and on CPU 1 if CPU2 can do:
> 
> 	spin_lock(&random_lock);
> 	write_lock(&my_rwlock);
> 

Right..

> I presume you were specifically excluding these situations?
>

Yes.. Those cases are simple to find out and fix (by changing the
lock ordering). My main problem was with CPU 0 and CPU 1 as shown above..
... and using a global rwlock helps ease that part out.

Regards,
Srivatsa S. Bhat
