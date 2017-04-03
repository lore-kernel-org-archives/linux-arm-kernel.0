From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 3 Apr 2017 15:24:40 +0530
Subject: [PATCH v9 09/12] ARM: EXYNOS: introduce exynos_cpu_info struct
In-Reply-To: <d4b29918-e0ab-af01-4f54-90b964b6f854@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131438epcas1p459ce93da17fcd05249eddaef18d5021e@epcas1p4.samsung.com>
 <1490879826-16754-10-git-send-email-pankaj.dubey@samsung.com>
 <d4b29918-e0ab-af01-4f54-90b964b6f854@samsung.com>
Message-ID: <b37502cc-bb63-8742-4bfb-d43a34231488@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Monday 03 April 2017 01:27 PM, Marek Szyprowski wrote:
> Hi Pankaj,
> 
> On 2017-03-30 15:17, Pankaj Dubey wrote:
>> Various Exynos SoC has different CPU related information, such as CPU
>> boot register, programming sequence making CPU up/down. Currently this
>> is handled by adding lots of soc_is_exynosMMM checks in the code, in
>> an attempt to remove the dependency of such helper functions specific to
>> each SoC, let's separate this information pertaining to CPU by
>> introducing
>> a new "struct exynos_cpu_info". This struct will contain differences
>> associated with CPU on various Exynos SoC. This can be matched by using
>> generic API "soc_device_match".
>>

>> +
>> +static const struct of_device_id exynos_pmu_of_device_ids[]
>> __initconst = {
> 
> exynos_pmuc_of_device_ids is a bit too easy to confuse with
> drivers/soc/samsung/exynos_*pmu.c drivers and its device tree nodes.
> IMHO exynos_soc_of_device_ids is a bit more appropriate here.
> 

Yes you are right, I will update this name.

>> +    {
>> +        .compatible = "samsung,exynos3250",
>> +        .data = &exynos3250_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos4212",
>> +        .data = &exynos_common_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos4412",
>> +        .data = &exynos4412_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5250",
>> +        .data = &exynos_common_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5260",
>> +        .data = &exynos_common_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5410",
>> +        .data = &exynos_common_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5420",
>> +        .data = &exynos5420_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5440",
>> +        .data = &exynos_common_cpu_info
>> +    }, {
>> +        .compatible = "samsung,exynos5800",
>> +        .data = &exynos5420_cpu_info
>> +    },
>> +    { /*sentinel*/ },
>> +};
>> +
>>   static int exynos_boot_secondary(unsigned int cpu, struct
>> task_struct *idle)
>>   {
>>       unsigned long timeout;
>> +    const struct soc_device_attribute *match;
>>       u32 mpidr = cpu_logical_map(cpu);
>>       u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>       int ret = -ENOSYS;
>>   +    if (of_machine_is_compatible("samsung,exynos4210")) {
>> +        match = soc_device_match(exynos_soc_revision);
>> +        if (match)
>> +            cpu_info = (const struct exynos_cpu_info *) match->data;
>> +    }
>> +
>>       /*
>>        * Set synchronisation state between this boot processor
>>        * and the secondary one
>> @@ -387,6 +499,18 @@ static int exynos_boot_secondary(unsigned int
>> cpu, struct task_struct *idle)
>>     static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>>   {
>> +    const struct of_device_id *match;
>> +    struct device_node *np;
>> +
>> +    if (!of_machine_is_compatible("samsung,exynos4210")) {
>> +        np = of_find_matching_node_and_match(NULL,
>> +                exynos_pmu_of_device_ids, &match);
>> +        if (!np)
>> +            pr_err("failed to find supported CPU\n");
>> +        else
>> +            cpu_info = (const struct exynos_cpu_info *) match->data;
>> +    }
>> +
> 
> This approach nukes on Exynos4210 booted with maxcpus=1, because
> exynos_boot_secondary()
> is not called in such case:

argh :(

If you see I have handled Exynos4210 case in a different manner, because
as per code-flow I can see following order of sequence:

1: exynos_smp_prepare_cpus
2: exynos_chipid_early_init
3: exynos_boot_secondary

We can't handle differentiation of Exynos4210 case in smp_prepare_cpus
only based on compatible property of root node, as it has different
revision boards and chipid is not getting initialized before
smp_prepare_cpus, even though I have marked it as early_initcall, I am
not sure how I can make chipid initialization much early than this? Any
idea?

So I decided to handle it in exynos_boot_secondary and populate its
cpu_info based on match found via "soc_device_match" API.

But as you tested and mentioned exynos_boot_secondary will not be called
if nr_cpus is capped to 1 and this will lead to crash, I missed this point.

I feel I am forced to add such work-around as there is need of some I/Ps
such as chipid to be probed or initialized at very early stage, but
currently I am not seeing any such initcall or feature (early probe or
something similar) exist to make this work

Let me think again how we can make it work.. any suggestion will be
helpful for me :)

Thanks,
Pankaj Dubey


> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 805 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.11.0-rc5-00013-g7aa5680b6c53-dirty #1185
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> task: c0b08640 task.stack: c0b00000
> PC is at exynos_set_boot_addr+0x64/0x84
> LR is at exynos_enter_coupled_lowpower+0x1c/0x74
> pc : [<c0117890>]    lr : [<c052f654>]    psr: 60000093
> sp : c0b01f00  ip : 02800000  fp : c0b2f7e4
> r10: c0b86e44  r9 : 00000001  r8 : dbb97e10
> r7 : 00000001  r6 : dbb97e10  r5 : 00000001  r4 : 40116c50
> r3 : 00000000  r2 : 00000001  r1 : 40116c50  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000404a  DAC: 00000051
> Process swapper/0 (pid: 0, stack limit = 0xc0b00210)
> Stack: (0xc0b01f00 to 0xc0b02000)
> 1f00: c01165f8 c0b86e4c c0b05508 c052f654 c052f638 c0b2f844 c0b05508
> 90442e5c
> 1f20: 00000000 c052d528 00041fc9 00000000 00000000 00000000 00000001
> 00000001
> 1f40: c0b05508 dbb97e10 c0b2f7e4 dbb97e10 dae522c0 c0b86e44 c0b86e44
> c052f3b0
> 1f60: 00000000 c0b05424 00000001 dae522e8 c0b05424 c0b05480 c0b05424
> c0a66e08
> 1f80: c0b0548c c0b10b0e c0b2f7e4 dbb97e10 00000000 c0152eb0 000000bb
> ffffffff
> 1fa0: c0b47000 c0a34a38 dbfffb40 412fc091 00000001 c01531cc c0b08640
> c0a00c00
> 1fc0: ffffffff ffffffff 00000000 c0a00680 00000000 c0a34a38 00000000
> c0b473d4
> 1fe0: c0b05418 c0a34a34 c0b09870 4000406a 00000000 4000807c 00000000
> 00000000
> [<c0117890>] (exynos_set_boot_addr) from [<c052f654>]
> (exynos_enter_coupled_lowpower+0x1c/0x74)
> [<c052f654>] (exynos_enter_coupled_lowpower) from [<c052d528>]
> (cpuidle_enter_state+0x64/0x264)
> [<c052d528>] (cpuidle_enter_state) from [<c052f3b0>]
> (cpuidle_enter_state_coupled+0x394/0x3e4)
> [<c052f3b0>] (cpuidle_enter_state_coupled) from [<c0152eb0>]
> (do_idle+0x178/0x200)
> [<c0152eb0>] (do_idle) from [<c01531cc>] (cpu_startup_entry+0x18/0x1c)
> [<c01531cc>] (cpu_startup_entry) from [<c0a00c00>]
> (start_kernel+0x330/0x398)
> [<c0a00c00>] (start_kernel) from [<4000807c>] (0x4000807c)
> Code: e1a00005 e12fff33 e3700a01 8a000004 (e5804000)
> ---[ end trace 46ced8ec429feb82 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> 
>>       exynos_sysram_init();
>>         exynos_set_delayed_reset_assertion(true);
> 
> Best regards
