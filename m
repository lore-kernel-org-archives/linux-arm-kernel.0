From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 22:37:51 +0530
Subject: [RFC PATCH v2 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <4E6A2D32.90600@arm.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
	<1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
	<4E6A28F8.4070606@ti.com> <4E6A2D32.90600@arm.com>
Message-ID: <4E6A47E7.5020006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011 08:43 PM, Marc Zyngier wrote:
> Hi Santosh,
>
> On 09/09/11 15:55, Santosh wrote:
>> Marc,
>>
>> On Friday 09 September 2011 08:16 PM, Marc Zyngier wrote:
>>> Populate the SoC descriptor structure with the SMP and CPU hotplug
>>> operations. To allow the kernel to continue building, the platform
>>> hooks are defined as weak symbols which are overrided by the
>>> platform code. Once all platforms are converted, the "weak" attribute
>>> will be removed and the function made static.
>>>
>>> Cc: Arnd Bergmann<arnd@arndb.de>
>>> Cc: Nicolas Pitre<nico@fluxnic.net>
>>> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
>>> ---
>>>    arch/arm/include/asm/soc.h |   18 ++++++++++++++++
>>>    arch/arm/kernel/setup.c    |   11 ++++++++++
>>>    arch/arm/kernel/smp.c      |   47 ++++++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 76 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
>>> index ce92784..2593f90 100644
>>> --- a/arch/arm/include/asm/soc.h
>>> +++ b/arch/arm/include/asm/soc.h
>>> @@ -12,10 +12,28 @@
>>>    #ifndef __ASM_ARM_SOC_H
>>>    #define __ASM_ARM_SOC_H
>>>
>>> +struct task_struct;
>>> +
>>> +struct arm_soc_smp_ops {
>>> +	void (*smp_init_cpus)(void);
>>> +	void (*smp_prepare_cpus)(unsigned int max_cpus);
>>> +	void (*smp_secondary_init)(unsigned int cpu);
>>> +	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +	int  (*cpu_kill)(unsigned int cpu);
>>> +	void (*cpu_die)(unsigned int cpu);
>>> +	int  (*cpu_disable)(unsigned int cpu);
>>> +#endif
>>> +};
>> Sorry for such a basic question but I don't understand the need
>> of these wrappers.
>> I am not upto speed on this topic but what is the motivation
>> behind the soc_smp_ops(). All of above functions are CPU specific
>> and not really soc specific though, I agree that every SOC,
>> implements it's own version.
>
> My understanding is that they really are SoC specific. If you compare
> OMAP4, Tegra and VExpress (for example), you'll notice that these
> functions are quite different, despite using the same A9 CPU.
>
> For example, you boot a secondary CPU on OMAP4 by trapping into secure
> mode, on Tegra by powering it on, and on VE by writing the expected
> value to some location.
>
> Indirecting these functions makes it possible to compile support for
> multiple SMP platforms into the same image. Probably it is possible to
> reduce the differences to something smaller than the above, but I'd
> rather change one thing at a time.
>
> Let's add the indirection first (which essentially preserves the
> existing internal API), and only then let's see if we can spot common
> patterns across the whole range of SMP implementations.
>
Thanks Marc for the heads up. I agree with the current approach
