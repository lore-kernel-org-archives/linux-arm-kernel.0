From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 13 Mar 2014 14:07:43 +0000
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <CAKfTPtC3Y7s=n205MND24tLrsT+-3+JhWHebxcBkwAuaMngDhA@mail.gmail.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
 <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
 <53186A8A.9060406@arm.com>
 <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
 <531B0FDA.2040302@arm.com>
 <20140311131719.GY9987@twins.programming.kicks-ass.net>
 <532060E7.7010203@arm.com>
 <CAKfTPtC3Y7s=n205MND24tLrsT+-3+JhWHebxcBkwAuaMngDhA@mail.gmail.com>
Message-ID: <5321BBAF.8050108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 13:47, Vincent Guittot wrote:
> On 12 March 2014 14:28, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> On 11/03/14 13:17, Peter Zijlstra wrote:
>>> On Sat, Mar 08, 2014 at 12:40:58PM +0000, Dietmar Eggemann wrote:
>>>>>
>>>>> I don't have a strong opinion about using or not a cpu argument for
>>>>> setting the flags of a level (it was part of the initial proposal
>>>>> before we start to completely rework the build of sched_domain)
>>>>> Nevertheless, I see one potential concern that you can have completely
>>>>> different flags configuration of the same sd level of 2 cpus.
>>>>
>>>> Could you elaborate a little bit further regarding the last sentence? Do you
>>>> think that those completely different flags configuration would make it
>>>> impossible, that the load-balance code could work at all at this sd?
>>>
>>> So a problem with such an interfaces is that is makes it far too easy to
>>> generate completely broken domains.
>>
>> I see the point. What I'm still struggling with is to understand why
>> this interface is worse then the one where we set-up additional,
>> adjacent sd levels with new cpu_foo_mask functions plus different static
>> sd-flags configurations and rely on the sd degenerate functionality in
>> the core scheduler to fold these levels together to achieve different
>> per cpu sd flags configurations.
> 
> The main difference is that all CPUs has got the same levels at the
> initial state and then the degenerate sequence can decide that it's
> worth removing a level and if it will not create unsuable domains.
>

Agreed. But what I'm trying to say is that using the approach of
multiple adjacent sd levels with different cpu_mask(int cpu) functions
and static sd topology flags will not prevent us from coding the
enforcement of sane sd topology flags set-ups somewhere inside the core
scheduler.

It is possible to easily introduce erroneous set-ups from the standpoint
of sd topology flags with this approach too.

For the sake of an example on ARM TC2 platform, I changed
cpu_corepower_mask(int cpu) [arch/arm/kernel/topology.c] to simulate
that in socket 1 (3 Cortex-A7) cores can powergate individually whereas
in socket 0 (2 Cortex A15) they can't:

 const struct cpumask *cpu_corepower_mask(int cpu)
 {
-       return &cpu_topology[cpu].thread_sibling;
+       return cpu_topology[cpu].socket_id ?
&cpu_topology[cpu].thread_sibling :
+                       &cpu_topology[cpu].core_sibling;
 }


With this I get the following cpu mask configuration:

dmesg snippet (w/ additional debug in cpu_coregroup_mask(),
cpu_corepower_mask()):

...
CPU0: cpu_corepower_mask=0-1
CPU0: cpu_coregroup_mask=0-1
CPU1: cpu_corepower_mask=0-1
CPU1: cpu_coregroup_mask=0-1
CPU2: cpu_corepower_mask=2
CPU2: cpu_coregroup_mask=2-4
CPU3: cpu_corepower_mask=3
CPU3: cpu_coregroup_mask=2-4
CPU4: cpu_corepower_mask=4
CPU4: cpu_coregroup_mask=2-4
...

And I deliberately introduced the following error into the
arm_topology[] table:

 static struct sched_domain_topology_level arm_topology[] = {
 #ifdef CONFIG_SCHED_MC
-       { cpu_corepower_mask, SD_SHARE_PKG_RESOURCES |
SD_SHARE_POWERDOMAIN, SD_INIT_NAME(GMC) },
+       { cpu_corepower_mask, SD_SHARE_POWERDOMAIN, SD_INIT_NAME(GMC) },
        { cpu_coregroup_mask, SD_SHARE_PKG_RESOURCES, SD_INIT_NAME(MC) },

With this set-up, I get GMC & DIE level for CPU0,1 and MC & DIE level
for CPU2,3,4, i.e. the SD_SHARE_PKG_RESOURCES flag is only set for
CPU2,3,4 and MC level.

dmesg snippet (w/ adapted sched_domain_debug_one(), only CPU0 and CPU2
shown here):

...
CPU0 attaching sched-domain:
domain 0: span 0-1 level GMC
SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
SD_WAKE_AFFINE SD_SHARE_POWERDOMAIN SD_PREFER_SIBLING
groups: 0 1
...
domain 1: span 0-4 level DIE
SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
SD_WAKE_AFFINE SD_PREFER_SIBLING
groups: 0-1 (cpu_power = 2048) 2-4 (cpu_power = 3072)
...
CPU2 attaching sched-domain:
domain 0: span 2-4 level MC
SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES
groups: 2 3 4
...
domain 1: span 0-4 level DIE
SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
SD_WAKE_AFFINE SD_PREFER_SIBLING
groups: 2-4 (cpu_power = 3072) 0-1 (cpu_power = 2048)
...

What I wanted to say is IMHO, it doesn't matter which approach we take
(multiple adjacent sd levels or per-cpu topo sd flag function), we have
to enforce sane sd topology flags set-up inside the core scheduler anyway.

-- Dietmar

>>
>> IMHO, exposing struct sched_domain_topology_level bar_topology[] to the
>> arch is the reason why the core scheduler has to check if the arch
>> provides a sane sd setup in both cases.
>>
>>>
>>> You can, for two cpus in the same domain provide, different flags; such
>>> a configuration doesn't make any sense at all.
>>>
>>> Now I see why people would like to have this; but unless we can make it
>>> robust I'd be very hesitant to go this route.
>>>
>>
>> By making it robust, I guess you mean that the core scheduler has to
>> check that the provided set-ups are sane, something like the following
>> code snippet in sd_init()
>>
>> if (WARN_ONCE(tl->sd_flags & ~TOPOLOGY_SD_FLAGS,
>>                 "wrong sd_flags in topology description\n"))
>>         tl->sd_flags &= ~TOPOLOGY_SD_FLAGS;
>>
>> but for per cpu set-up's.
>> Obviously, this check has to be in sync with the usage of these flags in
>> the core scheduler algorithms. This comprises probably that a subset of
>> these topology sd flags has to be set for all cpus in a sd level whereas
>> other can be set only for some cpus.
[...]
