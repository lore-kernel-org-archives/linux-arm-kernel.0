From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 13 Sep 2011 19:22:16 +0200
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110913133258.GA6267@n2100.arm.linux.org.uk>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
Message-ID: <CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2011 15:32, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 13, 2011 at 07:00:53PM +0530, amit kachhap wrote:
>> Hi Thomas,
>>
>> This movement of set_cpu_online before percpu_timer_setup is usefull
>> for samsung exyno4 platforms where the external gic timer
>> initialisation needs the secondary cpu to be online.
>> In addition to your modifications the following changes fixes the race
>> condition crash happening when sched_mc configuration flags
>> (CONFIG_ARM_CPU_TOPOLOGY, CONFIG_SCHED_MC ,CONFIG_SCHED_SMT) are
>> enabled. Sched_mc patches are recently submitted by Vincent and
>> accepted by Russell.(https://lkml.org/lkml/2011/7/5/209). I have not
>> attached the crash log here. If needed i can do so.
>>
>> ---
>> ?arch/arm/kernel/smp.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>> index 8cb94c8..04a8630 100644
>> --- a/arch/arm/kernel/smp.c
>> +++ b/arch/arm/kernel/smp.c
>> @@ -316,6 +316,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
>> ? ? ? ? ?* interrupts otherwise a wakeup of a kernel thread affine to
>> ? ? ? ? ?* this CPU might break the affinity and let hell break lose.
>> ? ? ? ? ?*/
>> + ? ? ? smp_store_cpu_info(cpu);
>> ? ? ? ? set_cpu_online(cpu, true);
>> ? ? ? ? while (!cpu_active(cpu))
>> ? ? ? ? ? ? ? ? cpu_relax();
>> @@ -330,7 +331,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
>>
>> ? ? ? ? calibrate_delay();
>>
>> - ? ? ? smp_store_cpu_info(cpu);
>
> This is totally wrong - the order of things here is quite specific.
> You can't store the CPU info until after you've calibrated the delay
> loop.
>
> Please continue playing cat-and-mouse with this.
>

The assumption done in the 1st patch that smp_store_cpu_info can be
delayed is no more true. The smp_store_cpu_info is now also used to
store the cpu topology information
(https://lkml.org/lkml/2011/7/5/209). This must be done before calling
sched_init_smp, which will use this information for building
sched_domain.
If we move set_cpu_online before smp_store_cpu_info, sched_init_smp
can be called before having called smp_store_cpu_info on all cpus.

Regards,
Vincent
