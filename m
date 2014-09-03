From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 3 Sep 2014 14:49:32 +0200
Subject: [PATCH v5 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <540708DC.9060901@linux.vnet.ibm.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
 <54020F00.2030807@linux.vnet.ibm.com>
 <CAKfTPtBq89SX=7=bXu2za7oXi1Lid_5ara-WputrtE8kCqcZcw@mail.gmail.com>
 <5406DB43.1030506@linux.vnet.ibm.com>
 <CAKfTPtCXBYSbXVgdeyMtvuK8aZaRBzhs9S3=+V2jvXnoCJFqBQ@mail.gmail.com>
 <540708DC.9060901@linux.vnet.ibm.com>
Message-ID: <CAKfTPtDH5-7cW8=x-wooSn9Vui28h-KP6ACX1CefxHZHf=XHHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 September 2014 14:26, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> On 09/03/2014 05:14 PM, Vincent Guittot wrote:
>> On 3 September 2014 11:11, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
>>> On 09/01/2014 02:15 PM, Vincent Guittot wrote:

[snip]

>>>
>>> Ok I understand your explanation above. But I was wondering if you would
>>> need to add this check around rq->cfs.h_nr_running >= 1 in the above two
>>> cases as well.
>>
>> yes you're right for the test if (rq->nr_running >= 2).
>>
>> It's not so straight forward for nr_busy_cpus which reflects how many
>> CPUs have not stopped their tick. The scheduler assumes that the
>> latter are busy with cfs tasks
>>
>>>
>>> I have actually raised this concern over whether we should be using
>>> rq->nr_running or cfs_rq->nr_running while we do load balancing in reply
>>> to your patch3. While all our load measurements are about the cfs_rq
>>
>> I have just replied to your comments on patch 3. Sorry for the delay
>>
>>> load, we use rq->nr_running, which may include tasks from other sched
>>> classes as well. We divide them to get average load per task during load
>>> balancing which is wrong, isn't it? Similarly during nohz_kick_needed(),
>>> we trigger load balancing based on rq->nr_running again.
>>>
>>> In this patch too, even if you know that the cpu is being dominated by
>>> tasks that do not belong to cfs class, you would be triggering a futile
>>> load balance if there are no fair tasks to move.
>> This patch adds one additional condition that is based on
>> rq->cfs.h_nr_running so it should not trigger any futile load balance.
>> Then, I have also take advantage of this patch to clean up
>> nohz_kick_needed as proposed by Peter but the conditions are the same
>> than previously (except the one with rq->cfs.h_nr_running)
>>
>> I can prepare another patchset that will solve the concerns that you
>> raised for nohz_kick_needed and in patch 3 but i would prefer not
>> include them in this patchset which is large enough and which subject
>> is a bit different.
>> Does it seem ok for you ?
>
> Sure Vincent, thanks! I have in fact sent out a mail raising my concern
> over rq->nr_running. If others agree on the issue to be existing, maybe
> we can work on this next patchset that can clean this up in all places
> necessary and not just in nohz_kick_needed().

Ok, let continue this discussion on the other thread

Regards,
Vincent

>
> Regards
> Preeti U Murthy
>>
>> Regards,
>> Vincent
>>>
>>> Regards
>>> Preeti U Murthy
>>>
>>
>
