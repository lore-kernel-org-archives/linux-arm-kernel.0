From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 4 Oct 2011 19:30:48 +0900
Subject: [PATCH v4 02/10] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1317663356-5114-3-git-send-email-marc.zyngier@arm.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAH9JG2UpQqy8w8qbze9KHBAkSrP_5jAeTTg9obb63F9Kz=fRqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 4, 2011 at 2:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Populate the SoC descriptor structure with the SMP and CPU hotplug
> operations. To allow the kernel to continue building, the platform
> hooks are defined as weak symbols which are overrided by the
> platform code. Once all platforms are converted, the "weak" attribute
> will be removed and the function made static.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> ?arch/arm/include/asm/soc.h | ? 48 ++++++++++++++++++++++++++++++++++++++++++-
> ?arch/arm/kernel/setup.c ? ?| ? 29 ++++++++++++++++++++++---
> ?arch/arm/kernel/smp.c ? ? ?| ? 47 +++++++++++++++++++++++++++++++++++++++++++
> ?3 files changed, 118 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
> index ce92784..f1dd657 100644
> --- a/arch/arm/include/asm/soc.h
> +++ b/arch/arm/include/asm/soc.h
> @@ -12,10 +12,54 @@
> ?#ifndef __ASM_ARM_SOC_H
> ?#define __ASM_ARM_SOC_H
>
> +struct task_struct;
> +
> +struct arm_soc_smp_init_ops {
> + ? ? ? /*
> + ? ? ? ?* Setup the set of possible CPUs (via set_cpu_possible)
> + ? ? ? ?*/
> + ? ? ? void (*smp_init_cpus)(void);
> + ? ? ? /*
> + ? ? ? ?* Initialize cpu_possible map, and enable coherency
> + ? ? ? ?*/
> + ? ? ? void (*smp_prepare_cpus)(unsigned int max_cpus);
> +};
> +
> +struct arm_soc_smp_ops {
> + ? ? ? /*
> + ? ? ? ?* Perform platform specific initialisation of the specified CPU.
> + ? ? ? ?*/
> + ? ? ? void (*smp_secondary_init)(unsigned int cpu);
> + ? ? ? /*
> + ? ? ? ?* Boot a secondary CPU, and assign it the specified idle task.
> + ? ? ? ?* This also gives us the initial stack to use for this CPU.
> + ? ? ? ?*/
> + ? ? ? int ?(*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
> +#ifdef CONFIG_HOTPLUG_CPU
> + ? ? ? int ?(*cpu_kill)(unsigned int cpu);
> + ? ? ? void (*cpu_die)(unsigned int cpu);
> + ? ? ? int ?(*cpu_disable)(unsigned int cpu);
> +#endif
> +};
> +
> ?struct arm_soc_desc {
> - ? ? ? const char ? ? ? ? ? ? ?*name;
> + ? ? ? const char ? ? ? ? ? ? ? ? ? ? ?*name;
> +#ifdef CONFIG_SMP
> + ? ? ? struct arm_soc_smp_init_ops ? ? *smp_init_ops;
> + ? ? ? struct arm_soc_smp_ops ? ? ? ? ?*smp_ops;
> +#endif
> ?};
>
> -extern const struct arm_soc_desc ? ? ? *soc_desc;
> +#ifdef CONFIG_SMP
> +#define soc_smp_init_ops(ops) ?.smp_init_ops = &(ops),
> +#define soc_smp_ops(ops) ? ? ? .smp_ops = &(ops),
> +#else
> +#define soc_smp_init_ops(ops) ?/* empty */
> +#define soc_smp_ops(ops) ? ? ? /* empty */
> +#endif
> +
> +extern const struct arm_soc_desc ? ? ? ? ? ? ? *soc_desc;
> +extern const struct arm_soc_smp_init_ops ? ? ? *soc_smp_init_ops;
> +extern const struct arm_soc_smp_ops ? ? ? ? ? ?*soc_smp_ops;
>
> ?#endif /* __ASM_ARM_SOC_H */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 34ffb2e..351ae18 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -141,8 +141,12 @@ static const char *cpu_name;
> ?static const char *machine_name;
> ?static char __initdata cmd_line[COMMAND_LINE_SIZE];
> ?struct machine_desc *machine_desc __initdata;
> -const struct arm_soc_desc *soc_desc;
> -static struct arm_soc_desc __soc_desc __read_mostly;
> +const struct arm_soc_desc *soc_desc __initdata;
> +#ifdef CONFIG_SMP
> +const struct arm_soc_smp_init_ops *soc_smp_init_ops ?__initdata;
> +const struct arm_soc_smp_ops *soc_smp_ops ?__cpuinitdata;
> +static struct arm_soc_smp_ops __soc_smp_ops __cpuinitdata;
> +#endif
>
> ?static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
> ?static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
> @@ -917,11 +921,28 @@ void __init setup_arch(char **cmdline_p)
> ? ? ? ?machine_desc = mdesc;
> ? ? ? ?machine_name = mdesc->name;
> ? ? ? ?if (mdesc->soc) {
> - ? ? ? ? ? ? ? __soc_desc = *mdesc->soc;
> - ? ? ? ? ? ? ? soc_desc = &__soc_desc;
> + ? ? ? ? ? ? ? soc_desc = mdesc->soc;
> ? ? ? ? ? ? ? ?pr_info("SoC: %s\n", soc_desc->name);
> ? ? ? ?} else
> ? ? ? ? ? ? ? ?soc_desc = NULL;
> +#ifdef CONFIG_SMP
> + ? ? ? if (soc_desc && soc_desc->smp_init_ops)
> + ? ? ? ? ? ? ? soc_smp_init_ops = soc_desc->smp_init_ops;
> + ? ? ? else
> + ? ? ? ? ? ? ? soc_smp_ops = NULL;
It should be "soc_smp_init_ops = NULL;"

Thank you,
Kyungmin Park
> +
> + ? ? ? /*
> + ? ? ? ?* Warning: we're copying an __initdata structure into a
> + ? ? ? ?* __cpuinitdata structure. We *know* it is valid because only
> + ? ? ? ?* __cpuinit (or more persistant) functions should be pointed
> + ? ? ? ?* to by soc_smp_ops. Still, this is borderline ugly.
> + ? ? ? ?*/
> + ? ? ? if (soc_desc && soc_desc->smp_ops) {
> + ? ? ? ? ? ? ? __soc_smp_ops = *soc_desc->smp_ops;
> + ? ? ? ? ? ? ? soc_smp_ops = &__soc_smp_ops;
> + ? ? ? } else
> + ? ? ? ? ? ? ? soc_smp_ops = NULL;
> +#endif
>
> ? ? ? ?if (mdesc->soft_reboot)
> ? ? ? ? ? ? ? ?reboot_setup("s");
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 8bb30c2..e08d2e8 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -28,6 +28,7 @@
> ?#include <linux/completion.h>
>
> ?#include <linux/atomic.h>
> +#include <asm/soc.h>
> ?#include <asm/cacheflush.h>
> ?#include <asm/cpu.h>
> ?#include <asm/cputype.h>
> @@ -155,9 +156,55 @@ int __cpuinit __cpu_up(unsigned int cpu)
> ? ? ? ?return ret;
> ?}
>
> +/* SoC helpers */
> +void __attribute__((weak)) __init smp_init_cpus(void)
> +{
> + ? ? ? if (soc_smp_init_ops && soc_smp_init_ops->smp_init_cpus)
> + ? ? ? ? ? ? ? soc_smp_init_ops->smp_init_cpus();
> +}
> +
> +void __attribute__((weak)) __init platform_smp_prepare_cpus(unsigned int max_cpus)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_init_ops->smp_prepare_cpus)
> + ? ? ? ? ? ? ? soc_smp_init_ops->smp_prepare_cpus(max_cpus);
> +}
> +
> +void __attribute__((weak)) __cpuinit platform_secondary_init(unsigned int cpu)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_ops->smp_secondary_init)
> + ? ? ? ? ? ? ? soc_smp_ops->smp_secondary_init(cpu);
> +}
> +
> +int __attribute__((weak)) __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_ops->smp_boot_secondary)
> + ? ? ? ? ? ? ? return soc_smp_ops->smp_boot_secondary(cpu, idle);
> + ? ? ? return -ENOSYS;
> +}
> +
> ?#ifdef CONFIG_HOTPLUG_CPU
> ?static void percpu_timer_stop(void);
>
> +int __attribute__((weak)) __cpuinit platform_cpu_kill(unsigned int cpu)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_ops->cpu_kill)
> + ? ? ? ? ? ? ? return soc_smp_ops->cpu_kill(cpu);
> + ? ? ? return 0;
> +}
> +
> +void __attribute__((weak)) __cpuinit platform_cpu_die(unsigned int cpu)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_ops->cpu_die)
> + ? ? ? ? ? ? ? soc_smp_ops->cpu_die(cpu);
> +}
> +
> +int __attribute__((weak)) __cpuinit platform_cpu_disable(unsigned int cpu)
> +{
> + ? ? ? if (soc_smp_ops && soc_smp_ops->cpu_disable)
> + ? ? ? ? ? ? ? return soc_smp_ops->cpu_disable(cpu);
> + ? ? ? return -EPERM;
> +}
> +
> ?/*
> ?* __cpu_disable runs on the processor to be shutdown.
> ?*/
> --
> 1.7.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
