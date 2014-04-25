From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 25 Apr 2014 16:55:49 +0100
Subject: [PATCH v4 5/5] sched: ARM: create a dedicated scheduler topology
 table
In-Reply-To: <CAKfTPtAq8PXS-n7A0W6ESe08m-6O3u84BcY3==+-0+63+uca9g@mail.gmail.com>
References: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
 <1397209481-28542-6-git-send-email-vincent.guittot@linaro.org>
 <5357A802.1030804@arm.com>
 <CAKfTPtDnw-OZZekdE3oNGS11m6dfpS4veMNZ_Bezs-Lm7zn6QQ@mail.gmail.com>
 <5357DBA5.1010106@arm.com>
 <CAKfTPtAOZqnP=sWeJuqFAqrGT8vLQZKj+tpqiwOTG37paXoGjg@mail.gmail.com>
 <53590835.9090803@arm.com>
 <CAKfTPtAq8PXS-n7A0W6ESe08m-6O3u84BcY3==+-0+63+uca9g@mail.gmail.com>
Message-ID: <535A8585.6030103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/14 08:45, Vincent Guittot wrote:

[...]

>>
>> Back than I had
>>   CPU0: cpu_corepower_mask=0-1
>>   CPU2: cpu_corepower_mask=2
>> so for GMC level the cpumasks are inconsistent across CPUs and it worked.
> 
> The example above is consistent because CPU2 mask and CPU0 mask are
> fully exclusive

OK, got it now. The cpu mask functions on an sd level can return
different (but then exclusive) cpu masks or they all return the same cpu
mask (DIE level in example). Like you said we still have to respect the
topology of the system.

This essentially excludes the DIE level (i.e. the sd level which spawns
all CPUs) from playing this 'sd level folding via sd degenerate' game
for a system which specifies FORCE_SD_OVERLAP to false or don't use this
SDTL_OVERLAP tl flag.

> 
> so
> CPU0: cpu_corepower_mask=0-1
> CPU2: cpu_corepower_mask=2
> are consistent
> 
> CPU0: cpu_corepower_mask=0-2
> CPU2: cpu_corepower_mask=0-2
> are also consistent
> 
> but
> 
> CPU0: cpu_corepower_mask=0-1
> CPU2: cpu_corepower_mask=0-2
> are not consistent
> 
> and your example uses the last configuration
> 
> To be more precise, the rule above applies on default SDT definition
> but the flag SD_OVERLAP enables such kind of overlap between group.
> Have you tried it ?

Setting FORCE_SD_OVERLAP indeed changes the scenario a bit (we're now
using build_overlap_sched_groups() instead of build_sched_groups()). It
looks better, but the groups for CPU0/1 in DIE level are wrong (to get
so far I still have to comment out the check that 'if cpu_map is equal
to sd span of sd then break' in build_sched_domains() though).

dmesg snippet:

 CPU0 attaching sched-domain:
  domain 0: span 0-1 level MC
   groups: 0 1
   domain 1: span 0-4 level DIE
    groups: 0-4 (cpu_power = 5120) 0-1 (cpu_power = 2048) <-- error !!!
 CPU1 attaching sched-domain:
  domain 0: span 0-1 level MC
   groups: 1 0
   domain 1: span 0-4 level DIE
    groups: 0-1 (cpu_power = 2048) 0-4 (cpu_power = 5120) <-- error !!!
 CPU2 attaching sched-domain:
  domain 0: span 2-4 level GMC
   groups: 2 3 4
   domain 1: span 0-4 level GDIE
    groups: 2-4 (cpu_power = 3072) 0-1 (cpu_power = 2048)
 ...

The feature I'm currently working on is to add sd energy information to
sd levels of the sd topology level table. I essentially added another
column of sd energy related func ptr's (next to the flags related one)
and wanted to use 'sd level folding via sd degenerate' in MC and DIE
level to have different sd energy information per CPU.

In any case, this dependency to FORCE_SD_OVERLAP would be less then nice
for this feature though :-( A way out would be a 'int cpu' parameter but
we already discussed this back then for the flag function.

Thanks,

-- Dietmar

> 
> Vincent
> 

[...]
