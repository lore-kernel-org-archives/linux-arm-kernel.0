From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 11:44:58 +0000
Subject: [PATCH 3/4] ARM: Alpine: smp support
In-Reply-To: <54c53660.F+mWFCmG+/oPpFS5%tsahee@annapurnalabs.com>
References: <54c53660.F+mWFCmG+/oPpFS5%tsahee@annapurnalabs.com>
Message-ID: <20150126114458.GC23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 06:30:56PM +0000, Tsahee Zidenberg wrote:
> This patch introduces support for waking up secondary CPU cores on
> Alpine platform.
> 
> Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  arch/arm/mach-alpine/Kconfig             |  1 +
>  arch/arm/mach-alpine/Makefile            |  1 +
>  arch/arm/mach-alpine/alpine_cpu_pm.c     | 68 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-alpine/alpine_cpu_pm.h     | 26 ++++++++++++
>  arch/arm/mach-alpine/alpine_cpu_resume.h | 38 ++++++++++++++++++
>  arch/arm/mach-alpine/platsmp.c           | 48 ++++++++++++++++++++++
>  6 files changed, 182 insertions(+)
>  create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
>  create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
>  create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
>  create mode 100644 arch/arm/mach-alpine/platsmp.c

[...]

> +/* NB registers */
> +#define AL_SYSFAB_POWER_CONTROL_OFFSET(cpu)	(0x2000 + (cpu)*0x100 + 0x20)
> +
> +static void __iomem *al_sysfabric_service_base;
> +static struct al_cpu_resume_regs __iomem *al_cpu_resume_regs;
> +static int wakeup_supported;
> +
> +int alpine_cpu_wakeup(unsigned int cpu, uint32_t phys_resume_addr)
> +{
> +	if (!wakeup_supported)
> +		return -ENOSYS;
> +
> +	/* Set CPU resume address */
> +	writel(phys_resume_addr, &al_cpu_resume_regs->per_cpu[cpu].resume_addr);
> +
> +	/* Power-up the CPU */
> +	writel(0, (al_sysfabric_service_base + AL_SYSFAB_POWER_CONTROL_OFFSET(cpu)));

Surely you want to map from the logical ID to the physical ID first?
That caller didn't.

Mark.
