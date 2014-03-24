From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Mar 2014 19:07:46 +0000
Subject: [PATCH v2 02/19] arm64: initial support for GICv3
In-Reply-To: <53308177.9090809@arm.com>
References: <1395316386-12617-1-git-send-email-marc.zyngier@arm.com>
 <1395316386-12617-3-git-send-email-marc.zyngier@arm.com>
 <53308177.9090809@arm.com>
Message-ID: <53308282.4010106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 24/03/14 19:03, Sudeep Holla wrote:
> Hi Marc,
> 
> On 20/03/14 11:52, Marc Zyngier wrote:
>> The Generic Interrupt Controller (version 3) offers services that are
>> similar to GICv2, with a number of additional features:
>> - Affinity routing based on the CPU MPIDR (ARE)
>> - System register for the CPU interfaces (SRE)
>> - Support for more that 8 CPUs
>> - Locality-specific Peripheral Interrupts (LPIs)
>> - Interrupt Translation Services (ITS)
>>
>> This patch adds preliminary support for GICv3 with ARE and SRE,
>> non-secure mode only. It relies on higher exception levels to grant ARE
>> and SRE access.
>>
>> Support for LPI and ITS will be added at a later time.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> [...]
> 
>> +#ifdef CONFIG_SMP
>> +static int __init gic_secondary_init(struct notifier_block *nfb,
>> +                                    unsigned long action, void *hcpu)
>> +{
>> +       if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>> +               gic_cpu_init();
>> +       return NOTIFY_OK;
>> +}
>> +
>> +/*
>> + * Notifier for enabling the GIC CPU interface. Set an arbitrarily high
>> + * priority because the GIC needs to be up before the ARM generic timers.
>> + */
>> +static struct notifier_block __initdata gic_cpu_notifier = {
>> +       .notifier_call = gic_secondary_init,
>> +       .priority = 100,
>> +};
>> +
> 
> You need to remove __init annotations in gic_populate_rdist, gic_cpu_init,
> and gic_secondary_init for CPU hotplug to work.

Ah, who needs hotplug? ;-)

Very good point, thanks for noticing that. I'll fix it in the next revision!

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
