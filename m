From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 09 Sep 2011 14:17:38 -0400 (EDT)
Subject: [RFC PATCH v2 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
	<1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.00.1109091402330.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2011, Marc Zyngier wrote:

> Populate the SoC descriptor structure with the SMP and CPU hotplug
> operations. To allow the kernel to continue building, the platform
> hooks are defined as weak symbols which are overrided by the
> platform code. Once all platforms are converted, the "weak" attribute
> will be removed and the function made static.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Comments below.

> ---
>  arch/arm/include/asm/soc.h |   18 ++++++++++++++++
>  arch/arm/kernel/setup.c    |   11 ++++++++++
>  arch/arm/kernel/smp.c      |   47 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
> index ce92784..2593f90 100644
> --- a/arch/arm/include/asm/soc.h
> +++ b/arch/arm/include/asm/soc.h
> @@ -12,10 +12,28 @@
>  #ifndef __ASM_ARM_SOC_H
>  #define __ASM_ARM_SOC_H
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

I don't like this aggregation.  Some of those functions are marked 
__init while some are not.  This is going to cause all sorts of bugs 
because people will confuse the lifetime rules for those functions.  The 
SMP init stuff has to be clearly separated from the functions that 
remain alive after boot.

>  struct arm_soc_desc {
>  	const char		*name;
> +#ifdef CONFIG_SMP
> +	struct arm_soc_smp_ops	*smp_ops;
> +#endif
>  };
>  
>  extern const struct arm_soc_desc	*soc_desc;
> +extern const struct arm_soc_smp_ops	*soc_smp_ops;
>  
>  #endif	/* __ASM_ARM_SOC_H */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 6bfa5f6..972e43f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -143,6 +143,10 @@ static char __initdata cmd_line[COMMAND_LINE_SIZE];
>  struct machine_desc *machine_desc __initdata;
>  const struct arm_soc_desc *soc_desc;
>  static struct arm_soc_desc __soc_desc __read_mostly;
> +#ifdef CONFIG_SMP
> +const struct arm_soc_smp_ops *soc_smp_ops;
> +static struct arm_soc_smp_ops __soc_smp_ops __read_mostly;
> +#endif

Here in both cases you declare a pointer and storage for this data.  I 
suppose you did so in order to have the various SOC structures be marked 
__initdata discarded and only preserve the used one after boot.  But 
in doing so you are completely bypassing the linker's ability to identify 
bad cross section references (such as non __init code calling into an 
__init function).

I think this would be more appropriate to explicitly copy _only_ the 
references to data/code that is not located in a discarded section.  In 
practice the stuff here is probably going to be almost initialization 
stuff anyway and copying a reference to it into permanent storage is 
wrong.



Nicolas
