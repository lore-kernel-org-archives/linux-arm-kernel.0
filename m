From: longman@redhat.com (Waiman Long)
Date: Mon, 9 Apr 2018 15:33:21 -0400
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180409145409.GA9661@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com> <20180409145409.GA9661@arm.com>
Message-ID: <5e7211d4-43f0-297e-dbbc-8e87721f96b8@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2018 10:54 AM, Will Deacon wrote:
>
>>> I am not against this patch, but we certainly need to find out a way to
>>> bring the performance number up closer to what it is before applying
>>> the patch.
>> We certainly need to *understand* where the drop is coming from, because
>> the two-threaded case is still just a CAS on x86 with and without this
>> patch series. Generally, there's a throughput cost when ensuring fairness
>> and forward-progress otherwise we'd all be using test-and-set.
> Whilst I think we still need to address my questions above, I've had a
> crack at the diff below. Please can you give it a spin? It sticks a trylock
> on the slowpath before setting pending and replaces the CAS-based set
> with an xchg (which I *think* is safe, but will need to ponder it some
> more).
>
> Thanks,
>
> Will
>

Unfortunately, this patch didn't help.

pending count = 777
queuing count = 9,991,272
locking rate = 4,087 kop/s

-Longman
