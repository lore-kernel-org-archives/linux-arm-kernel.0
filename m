From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Mar 2013 11:33:58 -0500
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <20130327133811.GE18429@mudshark.cambridge.arm.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130327133811.GE18429@mudshark.cambridge.arm.com>
Message-ID: <51531F76.2090200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 08:38 AM, Will Deacon wrote:
> Hi Stefano,
> 
> On Wed, Mar 27, 2013 at 12:50:39PM +0000, Stefano Stabellini wrote:
>> Check for the presence of PSCI before setting smp_ops, use PSCI if it is
>> available.
>>
>> This is useful because at least when running on Xen it's possible to have a
>> PSCI node for example on a Versatile Express or an Exynos5 machine. In these
>> cases the PSCI SMP calls should be the ones to be called.
>>
>> Remove virt_smp_ops and platsmp.c from mach-virt because they aren't needed
>> anymore.
> 
> [...]
> 
>> +struct psci_operations psci_ops = {
>> +	.cpu_suspend = psci_cpu_suspend,
>> +	.cpu_off     = psci_cpu_off,
>> +	.cpu_on      = psci_cpu_on,
>> +	.migrate     = psci_migrate,
>> +};
>> +
>> +#ifdef CONFIG_SMP
>> +static void __init psci_smp_init_cpus(void)
>> +{
>> +}
>> +
>> +static void __init psci_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +}
>> +
>> +static int __cpuinit psci_boot_secondary(unsigned int cpu,
>> +					 struct task_struct *idle)
>> +{
>> +	return psci_cpu_on(cpu_logical_map(cpu), __pa(secondary_startup));
>> +}
>> +
>> +static void __cpuinit psci_secondary_init(unsigned int cpu)
>> +{
>> +	gic_secondary_init(0);
>> +}
>> +
>> +struct smp_operations __initdata psci_smp_ops = {
>> +	.smp_init_cpus		= psci_smp_init_cpus,
>> +	.smp_prepare_cpus	= psci_smp_prepare_cpus,
>> +	.smp_secondary_init	= psci_secondary_init,
>> +	.smp_boot_secondary	= psci_boot_secondary,
>> +};
>> +#endif
> 
> As I said before, I don't agree with bolting these two interfaces together
> like this and, as it stands, I'm afraid I have to NAK this patch.
> 
> A potential alternative is to have a set of virt_smp_ops, which have
> wrappers around the psci functions, but that requires agreement from Xen and
> KVM to implement the same PSCI interface, which feels unfair to me.

I need the same smp ops for highbank. By using mach-virt Xen is using
the same interface as KVM. This patch does not change that, but rather
allows other platforms to use the same smp ops as well.

Isn't the whole point of PSCI to have a common interface? No one is
making Xen use PSCI at all. It is a choice and since they are making
that choice, why would the PSCI interface be different?

Rob
