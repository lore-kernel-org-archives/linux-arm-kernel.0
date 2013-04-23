From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Tue, 23 Apr 2013 10:27:13 +0530
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <5175F09E.1000304@intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtArtgkH5MU_xFAKjLDS-i32g2qQMdvyW=LLkG84tH8Hhg@mail.gmail.com>
 <5174CE96.3060805@linux.vnet.ibm.com>
 <CAKfTPtCCCifC=c+xjjnAH_HSqkR80PiQoddQKXPHuZwZawbvcA@mail.gmail.com>
 <5175F09E.1000304@intel.com>
Message-ID: <517614A9.50600@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

I have one point below.

On 04/23/2013 07:53 AM, Alex Shi wrote:
> Thanks you, Preeti and Vincent to talk the power aware scheduler for
> details! believe this open discussion is helpful to conduct a a more
> comprehensive solution. :)
> 
>> Hi Preeti,
>>
>> I have had a look at Alex patches but i have some concerns with his patches
>> -There no notion of power domain which is quite important when we speak
>> about power saving IMHO. Packing tasks has got an interest if the idle
>> CPUs can reach a useful low power state independently from busy CPUs.
>> Architectures have different low power state capabilities which must be
>> taken into account. In addition, you can have system which have CPUs
>> with better power efficiency and this kind of system are not taken into
>> account.
> 
> I agree with you on this point. and like what's you done to add new flag
> in sched domain. It also make scheduler easy pick up new idea in balancing.
> BTW, Currently, the my balance is trying pack task per SMT, maybe
> packing task per cpu horse power is more compatible for other archs?

Correct me if I am wrong,but the scheduler today does not compare the
task load to the destination cpu power before moving the task to the
destination cpu.This could be during:

1. Load balancing: In move_tasks(), only the imbalance is verified
against the task load before moving tasks and does not necessarily check
if the destination cpu has enough cpu power to handle these tasks.

2. select_task_rq_fair(): For a forked task, the idlest cpu in the group
leader is found during power save balance( I am focussing only on the
power save policy),and is returned as the destination cpu for the forked
task.But I feel we need to check if the idle cpu has the cpu power to
handle the task load.

Why I am bringing about this point is due to a use case which we might
need to handle in the power aware scheduler going ahead.That being the
big.LITTLE cpus. We would ideally want the short running tasks on the
LITTLE cpus and the long running tasks on the big cpus.

While the power aware scheduler strives to pack tasks,it should not end
up packing long running tasks on LITTLE cpus. Not having big cpus to
handle short running tasks is the next step of course but atleast not
throttle the long running tasks by scheduling them on LITTLE cpus.

Thanks

Regards
Preeti U Murthy
