From: robherring2@gmail.com (Rob Herring)
Date: Wed, 17 Aug 2011 09:01:54 -0500
Subject: [PATCH 4/6] ARM: highbank: add SMP support
In-Reply-To: <20110817073748.GA1006@n2100.arm.linux.org.uk>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-5-git-send-email-robherring2@gmail.com>
	<20110817073748.GA1006@n2100.arm.linux.org.uk>
Message-ID: <4E4BC9D2.9090908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2011 02:37 AM, Russell King - ARM Linux wrote:
> On Tue, Aug 16, 2011 at 03:34:56PM -0500, Rob Herring wrote:
>> +int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +	gic_raise_softirq(cpumask_of(cpu), 1);
> 
> Can this raise IPI0 instead of IPI1 ?
> 
>> +void __init smp_init_cpus(void)
>> +{
>> +	void __iomem *scu_base = a9_base_addr;
>> +	unsigned int i, ncores;
>> +
>> +	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> 
> Is scu_base ever NULL?

Only if something is wrong and the mapping did not get setup. The system
should still boot with 1 core without accessing the the SCU in this case.

This BTW is the only reason we need a static mapping of the SCU. So I
could just hard code it or use device tree to get the number of cores
and eliminate the static mapping.

Rob
