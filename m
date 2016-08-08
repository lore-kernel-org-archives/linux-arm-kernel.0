From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 8 Aug 2016 13:29:50 +0800
Subject: [PATCH] arm64: Support hard limit of cpu count by nr_cpus
In-Reply-To: <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
References: <1470377035-1591-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160805083238.GA13272@arm.com>
 <e2f3ee03-24e7-fd28-4172-ff0c87f9f539@huawei.com>
 <02d77415-9eb0-92f4-7cb6-9b941cda9a4d@arm.com>
Message-ID: <f0f9af57-4150-dce7-5bb7-aa7fcfe77aee@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/5 18:19, Suzuki K Poulose wrote:
> On 05/08/16 10:58, Kefeng Wang wrote:
>>
>>
>> On 2016/8/5 16:32, Will Deacon wrote:
>>> On Fri, Aug 05, 2016 at 02:03:55PM +0800, Kefeng Wang wrote:
>>>> Enable the hard limit of cpu count by nr_cpus on arm64.
>>>> The code is borrowed from MIPS.
>>>>
[...]
> 
> Or is this even better ?

Agree, and let's show a better warning.

> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 490db85..dbd6a5e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -659,9 +659,9 @@ void __init smp_init_cpus(void)
>                 acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
>                                       acpi_parse_gic_cpu_interface, 0);
>  
> -       if (cpu_count > NR_CPUS)
> +       if (cpu_count > nr_cpu_ids)
>                 pr_warn("no. of cores (%d) greater than configured maximum of %d - clipping\n",

  change to 	  pr_warn("%d cores exceeds configured maximum of %d - clipping\n",

Thanks,
Kefeng

> -                       cpu_count, NR_CPUS);
> +                       cpu_count, nr_cpu_ids);
>  
>         if (!bootcpu_valid) {
>                 pr_err("missing boot CPU MPIDR, not enabling secondaries\n");
> @@ -675,7 +675,7 @@ void __init smp_init_cpus(void)
>          * with entries in cpu_logical_map while initializing the cpus.
>          * If the cpu set-up fails, invalidate the cpu_logical_map entry.
>          */
> -       for (i = 1; i < NR_CPUS; i++) {
> +       for (i = 1; i < nr_cpu_ids; i++) {
>                 if (cpu_logical_map(i) != INVALID_HWID) {
>                         if (smp_cpu_setup(i))
>                                 cpu_logical_map(i) = INVALID_HWID;
> 
> 
> Cheers
> Suzuki
> 
> .
> 
