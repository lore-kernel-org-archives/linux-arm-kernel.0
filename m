From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 12 Aug 2013 18:07:44 +0100
Subject: [PATCH] ARM: shmobile: Shared APMU SMP support code
In-Reply-To: <20130807224510.9832.38560.sendpatchset@w520>
References: <20130807224510.9832.38560.sendpatchset@w520>
Message-ID: <52091660.5030201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/13 23:45, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Introduce shared APMU SMP code for mach-shmobile. Both SMP boot up
> and CPU Hotplug is supported. DT is used for configuration of the
> APMU hardware block, as the following r8a73a4 example shows:
> 
>        apmu at e6152000 {
>                compatible = "renesas,r8a73a4-apmu", "renesas,apmu";
>                reg = <0 0xe6152000 0 0x88>;
>                cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
>        };
> 
This is introducing a new DT binding which needs to be documented. Also
you need to cc devicetree mailing list in case you need to add new
bindings. But I think you should not require this new binding.

> The code is designed around CONFIG_NR_CPUS and should in theory support
> any number of APMUs. At this point only the APMU that includes the
> boot CPU is enabled - this to prevent non-deterministic scheduling on
> upstream in case of multi-cluster hardware with varying performance.
>  
I couldn't understand this patch completely but I believe you are
trying to solve multi-cluster power management and in your own custom
way.

But there are 2 ways to handle this in a generic way:
1. If Linux runs in non-secure mode, you need to use PSCI.
   You can refer Calxeda platform for reference[1]
2. If Linux runs in secure mode, you need to use MPCM
   You can refer Vexpress CA15_CA7/TC2 platform for reference[2]

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git renesas-devel-20130806v4 and
>  [PATCH 00/05] ARM: shmobile: Yet another SMP series
>  [PATCH 00/02] ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()
> 
>  arch/arm/mach-shmobile/include/mach/common.h |    5 
>  arch/arm/mach-shmobile/platsmp-apmu.c        |  197 ++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
> 
[...]

> +#ifdef CONFIG_HOTPLUG_CPU
> +/* nicked from arch/arm/mach-exynos/hotplug.c */
> +static inline void cpu_enter_lowpower_a15(void)
> +{
> +	unsigned int v;
> +
> +	asm volatile(
> +	"       mrc     p15, 0, %0, c1, c0, 0\n"
> +	"       bic     %0, %0, %1\n"
> +	"       mcr     p15, 0, %0, c1, c0, 0\n"
> +	: "=&r" (v)
> +	: "Ir" (CR_C)
> +	: "cc");
> +
> +	flush_cache_louis();
> +
> +	asm volatile(
> +	/*
> +	 * Turn off coherency
> +	 */
> +	"       mrc     p15, 0, %0, c1, c0, 1\n"
> +	"       bic     %0, %0, %1\n"
> +	"       mcr     p15, 0, %0, c1, c0, 1\n"
> +	: "=&r" (v)
> +	: "Ir" (0x40)
> +	: "cc");
> +
> +	isb();
> +	dsb();
> +}

This sequences exactly matches the power-down sequence for CA15/A7.
(implemented in [2]). Unless your platform needs a different sequence,
you can re-use the code. Nico was trying to consolidate the power-down
sequence for all ARM Cortex-A15/A7 implementations[3].

Regards,
Sudeep

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187130.html
[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/184372.html
[3] http://www.spinics.net/lists/arm-kernel/msg260472.html
