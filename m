From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 6 Jan 2017 08:41:13 +0000
Subject: [PATCHv3 2/5] arm: mvebu: support for SMP on 98DX3336 SoC
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-3-chris.packham@alliedtelesis.co.nz>
 <20170106063602.GM17126@codeaurora.org>
Message-ID: <231adc7f589743e7a425be19cc28047a@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 19:44, Stephen Boyd wrote:
> On 01/06, Chris Packham wrote:
>> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
>> index 46c742d3bd41..3c9ab9a008ad 100644
>> --- a/arch/arm/mach-mvebu/platsmp.c
>> +++ b/arch/arm/mach-mvebu/platsmp.c
>> @@ -182,5 +182,48 @@ const struct smp_operations armada_xp_smp_ops __initconst = {
>>  #endif
>>  };
>>
>> +static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +	int ret, hw_cpu;
>> +
>> +	pr_info("Booting CPU %d\n", cpu);
>
> Doesn't the core already print something when bringing up CPUs?
> This message seems redundant.
>

Copied from armada_xp_boot_secondary but that's no reason to keep it. 
Will remove in v4.

>> +
>> +	hw_cpu = cpu_logical_map(cpu);
>> +	set_secondary_cpu_clock(hw_cpu);
>> +	mv98dx3236_resume_set_cpu_boot_addr(hw_cpu,
>> +					    armada_xp_secondary_startup);
>> +
>> +	/*
>> +	 * This is needed to wake up CPUs in the offline state after
>> +	 * using CPU hotplug.
>> +	 */
>> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>> +
>> +	/*
>> +	 * This is needed to take secondary CPUs out of reset on the
>> +	 * initial boot.
>> +	 */
>> +	ret = mvebu_cpu_reset_deassert(hw_cpu);
>> +	if (ret) {
>> +		pr_warn("unable to boot CPU: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +struct smp_operations mv98dx3236_smp_ops __initdata = {
>
> static const __initconst?
>

Will do.

>> +	.smp_init_cpus		= armada_xp_smp_init_cpus,
>> +	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
>> +	.smp_boot_secondary	= mv98dx3236_boot_secondary,
>> +	.smp_secondary_init     = armada_xp_secondary_init,
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	.cpu_die		= armada_xp_cpu_die,
>> +	.cpu_kill               = armada_xp_cpu_kill,
>> +#endif
>> +};
>> +
>>  CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
>>  		      &armada_xp_smp_ops);
>> +CPU_METHOD_OF_DECLARE(mv98dx3236_smp, "marvell,98dx3236-smp",
>> +		      &mv98dx3236_smp_ops);
>> diff --git a/arch/arm/mach-mvebu/pmsu-98dx3236.c b/arch/arm/mach-mvebu/pmsu-98dx3236.c
>> new file mode 100644
>> index 000000000000..1052674dd439
>> --- /dev/null
>> +++ b/arch/arm/mach-mvebu/pmsu-98dx3236.c
>> @@ -0,0 +1,52 @@
>> +/**
>> + * CPU resume support for 98DX3236 internal CPU (a.k.a. MSYS).
>> + */
>> +
>> +#define pr_fmt(fmt) "mv98dx3236-resume: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/of_address.h>
>> +#include <linux/io.h>
>> +#include "common.h"
>> +
>> +static void __iomem *mv98dx3236_resume_base;
>> +#define MV98DX3236_CPU_RESUME_CTRL_OFFSET	0x08
>> +#define MV98DX3236_CPU_RESUME_ADDR_OFFSET	0x04
>> +
>> +static const struct of_device_id of_mv98dx3236_resume_table[] = {
>> +	{.compatible = "marvell,98dx3336-resume-ctrl",},
>> +	{ /* end of list */ },
>> +};
>> +
>> +void mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>> +{
>> +	WARN_ON(hw_cpu != 1);
>> +
>> +	writel(0, mv98dx3236_resume_base + MV98DX3236_CPU_RESUME_CTRL_OFFSET);
>> +	writel(virt_to_phys(boot_addr), mv98dx3236_resume_base +
>> +	       MV98DX3236_CPU_RESUME_ADDR_OFFSET);
>> +}
>> +
>> +static int __init mv98dx3236_resume_init(void)
>> +{
>> +	struct device_node *np;
>> +	void __iomem *base;
>> +
>> +	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
>> +	if (!np)
>> +		return 0;
>
> Is there any reason we can't just look for this node from the
> smp_ops and map it if it isn't mapped yet? Seems simpler than a
> whole new file and initcall.
>

That's at least 2 votes for rolling it into platsmp.c. The amount of 
code has been significantly reduced so I think I will do it for v4.

>> +
>> +	base = of_io_request_and_map(np, 0, of_node_full_name(np));
>> +	if (IS_ERR(base)) {
>> +		pr_err("unable to map registers\n");
>
> Doesn't of_io_request_and_map() spit out an error on failure
> already?
>

Not that I can see. But as has been previously mentioned a CPU failing 
to come online is reasonably obvious already.

>> +		of_node_put(np);
>
> This could be done before the if statement and then the duplicate
> statement deleted.
>

Will do.

>> +		return PTR_ERR(mv98dx3236_resume_base);
>
> Should be PTR_ERR(base)?

Yes. I decided to add the local variable at the last minute.

>
>> +	}
>> +
>> +	mv98dx3236_resume_base = base;
>> +	of_node_put(np);
>> +	return 0;
>> +}
>
