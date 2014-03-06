From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 6 Mar 2014 17:04:57 +0800
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <5317B092.7070805@arm.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
Message-ID: <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2014 07:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 05/03/14 07:18, Vincent Guittot wrote:
>>
>> This patchset was previously part of the larger tasks packing patchset
>> [1].
>> I have splitted the latter in 3 different patchsets (at least) to make the
>> thing easier.
>> -configuration of sched_domain topology (this patchset)
>> -update and consolidation of cpu_power
>> -tasks packing algorithm
>>
>> Based on Peter Z's proposal [2][3], this patchset modifies the way to
>> configure
>> the sched_domain level in order to let architectures to add specific level
>> like
>> the current BOOK level or the proposed power gating level for ARM
>> architecture.
>>
>> [1] https://lkml.org/lkml/2013/10/18/121
>> [2] https://lkml.org/lkml/2013/11/5/239
>> [3] https://lkml.org/lkml/2013/11/5/449
>>
>> Vincent Guittot (6):
>>    sched: remove unused SCHED_INIT_NODE
>>    sched: rework of sched_domain topology definition
>>    sched: s390: create a dedicated topology table
>>    sched: powerpc: create a dedicated topology table
>>    sched: add a new SD_SHARE_POWERDOMAIN for sched_domain
>>    sched: ARM: create a dedicated scheduler topology table
>>
>>   arch/arm/kernel/topology.c        |   26 ++++
>>   arch/ia64/include/asm/topology.h  |   24 ----
>>   arch/metag/include/asm/topology.h |   27 -----
>>   arch/powerpc/kernel/smp.c         |   35 ++++--
>>   arch/s390/include/asm/topology.h  |   13 +-
>>   arch/s390/kernel/topology.c       |   25 ++++
>>   arch/tile/include/asm/topology.h  |   33 ------
>>   include/linux/sched.h             |   30 +++++
>>   include/linux/topology.h          |  128 ++------------------
>>   kernel/sched/core.c               |  235
>> ++++++++++++++++++-------------------
>>   10 files changed, 237 insertions(+), 339 deletions(-)
>>
>
> Hi Vincent,
>
> I reviewed your patch-set carefully (including test runs on TC2), especially
> due to the fact that we want to build our sd_energy stuff on top of it.

Thanks

>
>
> One thing I'm still not convinced of is the fact that specifying additional
> sd levels in the struct sched_domain_topology_level table has an advantage
> over a function pointer for sd topology flags similar to the one we're
> already using for the cpu mask in struct sched_domain_topology_level.
>
>   int (*sched_domain_flags_f)(int cpu);
>

We have to create additional level for some kind of topology as
described in my trial https://lkml.org/lkml/2013/12/18/279 which is
not possible with function pointer.

Have you got a situation in mind where it will be necessary to use the
function pointer with cpu number as an argument ?

In the current example of this patchset, the flags are statically set
in the table but nothing prevents an architecture to update the flags
value before being given to the scheduler

> This function pointer would be simply another member of struct
> sched_domain_topology_level and would replace int sd_flags.  AFAICS, you
> have to create additional cpu mask functions anyway for the additional sd
> levels, like cpu_corepower_mask() for the  GMC level in the ARM case.  There
> could be a set of standard sd topology flags function for the default sd
> layer and archs which want to pass in something special define those
> function locally since they will use them only in their arch specific struct
> sched_domain_topology_level table anyway.  I know that you use the existing
> sd degenerate functionality for this and that the freeing of the redundant
> data structures (sched_domain, sched_group and sched_group_power) is there
> too but it still doesn't seem to me to be the right thing to do.
>
> The problem that we now expose internal data structures (struct sd_data and
> struct sched_domain_topology_level) could be dealt with later.
>
> -- Dietmar
>
