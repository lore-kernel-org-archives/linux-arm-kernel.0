From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 20:25:52 +0530
Subject: [RFC PATCH v2 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
	<1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E6A28F8.4070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Friday 09 September 2011 08:16 PM, Marc Zyngier wrote:
> Populate the SoC descriptor structure with the SMP and CPU hotplug
> operations. To allow the kernel to continue building, the platform
> hooks are defined as weak symbols which are overrided by the
> platform code. Once all platforms are converted, the "weak" attribute
> will be removed and the function made static.
>
> Cc: Arnd Bergmann<arnd@arndb.de>
> Cc: Nicolas Pitre<nico@fluxnic.net>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> ---
>   arch/arm/include/asm/soc.h |   18 ++++++++++++++++
>   arch/arm/kernel/setup.c    |   11 ++++++++++
>   arch/arm/kernel/smp.c      |   47 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 76 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
> index ce92784..2593f90 100644
> --- a/arch/arm/include/asm/soc.h
> +++ b/arch/arm/include/asm/soc.h
> @@ -12,10 +12,28 @@
>   #ifndef __ASM_ARM_SOC_H
>   #define __ASM_ARM_SOC_H
>
> +struct task_struct;
> +
> +struct arm_soc_smp_ops {
> +	void (*smp_init_cpus)(void);
> +	void (*smp_prepare_cpus)(unsigned int max_cpus);
> +	void (*smp_secondary_init)(unsigned int cpu);
> +	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
> +#ifdef CONFIG_HOTPLUG_CPU
> +	int  (*cpu_kill)(unsigned int cpu);
> +	void (*cpu_die)(unsigned int cpu);
> +	int  (*cpu_disable)(unsigned int cpu);
> +#endif
> +};
Sorry for such a basic question but I don't understand the need
of these wrappers.
I am not upto speed on this topic but what is the motivation
behind the soc_smp_ops(). All of above functions are CPU specific
and not really soc specific though, I agree that every SOC,
implements it's own version.

Regards
Santosh
