From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 24 Nov 2017 11:57:45 +0000
Subject: [PATCH v3 0/2] arm: remove cpu_efficiency
In-Reply-To: <316592bf-5aa4-3847-79cd-3a26adbb1231@arm.com>
References: <20171024102718.16113-1-dietmar.eggemann@arm.com>
 <20171024105227.GD20805@n2100.armlinux.org.uk>
 <316592bf-5aa4-3847-79cd-3a26adbb1231@arm.com>
Message-ID: <d441d28a-5a11-6f46-76e9-06cea47e20a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2017 03:31 PM, Dietmar Eggemann wrote:
> Hi Russel,
> 
> Thanks for the review!
> 
> On 24/10/17 11:52, Russell King - ARM Linux wrote:
>> On Tue, Oct 24, 2017 at 11:27:16AM +0100, Dietmar Eggemann wrote:
>>> With the dt related patches for exynos and renesas now in the
>>> appropriated for-next branches for v4.15 there are no Cortex-A15/A7 arm
>>> big.LITTLE systems left relying on the 'cpu_efficiency/clock-frequency
>>> dt property' based solution anymore.
>>
>> This is way too early to remove support for something that has been
>> in place since 2012.  As you've just shown, people are using it with
>> DT files today.  We don't know how long people will persist using
>> older files, and we don't know whether there are DT files out in the
>> wild that we don't know about.
> 
> Understood. But do we really care about out of tree dt files?
> 
> In case the mentioned exynos and renesas Cortex-A15/A7 platforms change
> to using 'capacity-dmips-mhz' in v4.15 there shouldn't be any
> Cortex-A15/A7 platforms in mainline left using the cpu_efficiency
> solution anymore.
> 
>> Our general rule is that we maintain compatibility for older DT.
> 
> OK.
> 
>> NAK.

Morten reminded me that the per-cpu capacity functionality for
heterogeneous systems (different values than the default 1024 
(SCHED_CAPACITY_SCALE)) has been broken since v4.4 (Jan 2016) due to 
8cd5601c5060 "sched/fair: Convert arch_scale_cpu_capacity() from weak 
function to #define".

So even people had cpu clock-frequency specified in their dt for their
Cortex-A15/A7 arm platforms, they didn't noticed (or cared) that the
task scheduler sees all cpus with the capacity of 1024 rather than
different values for the A15's and A7's.

As an example, a v4.3 TC2 (w/ 'clock-frequency = <1000000000>' added for 
A15 and ,clock-frequency = <800000000>, added for a A7) had the 
following cpu capacity values
The log snippet (for cpu0: A15) comes from sched_domain_debug_one() 
[kernel/sched/core.c] which appears if scheduler debugging is enabled:

   ...
   CPU0 attaching sched-domain:
    domain 0: span 0-1 level MC
     groups: 0 (cpu_capacity = 1441) 1 (cpu_capacity = 1441)
     domain 1: span 0-4 level DIE
      groups: 0-1 (cpu_capacity = 2882) 2-4 (cpu_capacity = 1818)
   ...

   So A15 has 1441 and A7 has 606 as cpu capacity.

Whereas with v4.4 it switched back to:

  ...
  CPU0 attaching sched-domain:
   domain 0: span 0-1 level MC
    groups: 0 1
    domain 1: span 0-4 level DIE
     groups: 0-1 (cpu_capacity = 2048) 2-4 (cpu_capacity = 3072)
  ...

    So A15 and A7 have 1024 (SCHED_CAPACITY_SCALE).


So maybe the requirement to maintain compatibility for older DT's is
less important in this specific case and the argument that we can get
rid of a lot of code and make arm/arm64 consistent in this area is more
important than backward compatibility?

BTW, the missing bit, the #define of arch_scale_cpu_capacity, is only
provided with 552c4653bf89 "arm: wire cpu-invariant accounting support
up to the task scheduler" which is currently queued for v4.15-rc1.

-- Dietmar

[...]
