From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 04 Oct 2011 22:16:11 +0900
Subject: [PATCH v4 06/10] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <1317663356-5114-7-git-send-email-marc.zyngier@arm.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <019701cc8297$c91bd9e0$5b538da0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> 
> Convert Exynos4 to use the SoC descriptor to provide its SMP
> and CPU hotplug operations.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-exynos4/core.h                |    9 +++++++++
>  arch/arm/mach-exynos4/cpu.c                 |    8 ++++++++
>  arch/arm/mach-exynos4/hotplug.c             |    8 +++++---
>  arch/arm/mach-exynos4/mach-armlex4210.c     |    3 +++
>  arch/arm/mach-exynos4/mach-nuri.c           |    3 +++
>  arch/arm/mach-exynos4/mach-origen.c         |    3 +++
>  arch/arm/mach-exynos4/mach-smdk4212.c       |    3 +++
>  arch/arm/mach-exynos4/mach-smdkv310.c       |    4 ++++
>  arch/arm/mach-exynos4/mach-universal_c210.c |    3 +++
>  arch/arm/mach-exynos4/platsmp.c             |   25
> +++++++++++++++++++++----
>  10 files changed, 62 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/core.h
> 
> diff --git a/arch/arm/mach-exynos4/core.h b/arch/arm/mach-exynos4/core.h
> new file mode 100644
> index 0000000..ba9fcc8
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/core.h

Is there any reason to add core.h in mach-exynos4 not
mach-exynos4/include/mach?

> @@ -0,0 +1,9 @@
> +#include <asm/soc.h>
> +
> +extern struct arm_soc_smp_init_ops	exynos4_soc_smp_init_ops;
> +extern struct arm_soc_smp_ops		exynos4_soc_smp_ops;
> +extern struct arm_soc_desc		exynos4_soc_desc;
> +
> +extern int  exynos4_cpu_kill(unsigned int cpu);
> +extern void exynos4_cpu_die(unsigned int cpu);
> +extern int  exynos4_cpu_disable(unsigned int cpu);
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index 2aa3df0..a15dce8 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -33,6 +33,8 @@
>  #include <mach/regs-irq.h>
>  #include <mach/regs-pmu.h>
> 
> +#include "core.h"
> +
>  extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
>  			 unsigned int irq_start);
>  extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int
irq);
> @@ -282,3 +284,9 @@ int __init exynos4_init(void)
> 
>  	return sysdev_register(&exynos4_sysdev);
>  }
> +
> +struct arm_soc_desc exynos4_soc_desc __initdata = {
> +	.name		= "Samsung Exynos4",

If you're ok, I preferred 'Samsung EXYNOS4'

> +	soc_smp_init_ops(exynos4_soc_smp_init_ops)
> +	soc_smp_ops(exynos4_soc_smp_ops)
> +};
> diff --git a/arch/arm/mach-exynos4/hotplug.c
b/arch/arm/mach-exynos4/hotplug.c
> index da70e7e..15fe884 100644
> --- a/arch/arm/mach-exynos4/hotplug.c
> +++ b/arch/arm/mach-exynos4/hotplug.c
> @@ -19,6 +19,8 @@
> 
>  #include <mach/regs-pmu.h>
> 
> +#include "core.h"
> +
>  extern volatile int pen_release;
> 
>  static inline void cpu_enter_lowpower(void)
> @@ -93,7 +95,7 @@ static inline void platform_do_lowpower(unsigned int
cpu, int
> *spurious)
>  	}
>  }
> 
> -int platform_cpu_kill(unsigned int cpu)
> +int exynos4_cpu_kill(unsigned int cpu)
>  {
>  	return 1;
>  }
> @@ -103,7 +105,7 @@ int platform_cpu_kill(unsigned int cpu)
>   *
>   * Called with IRQs disabled
>   */
> -void platform_cpu_die(unsigned int cpu)
> +void exynos4_cpu_die(unsigned int cpu)
>  {
>  	int spurious = 0;
> 
> @@ -123,7 +125,7 @@ void platform_cpu_die(unsigned int cpu)
>  		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
>  }
> 
> -int platform_cpu_disable(unsigned int cpu)
> +int exynos4_cpu_disable(unsigned int cpu)
>  {
>  	/*
>  	 * we don't allow CPU 0 to be shutdown (it is still too special
> diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-
> exynos4/mach-armlex4210.c
> index f0ca6c1..8c82c6b 100644
> --- a/arch/arm/mach-exynos4/mach-armlex4210.c
> +++ b/arch/arm/mach-exynos4/mach-armlex4210.c
> @@ -28,6 +28,8 @@
> 
>  #include <mach/map.h>
> 
> +#include "core.h"
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define ARMLEX4210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -208,6 +210,7 @@ static void __init armlex4210_machine_init(void)
>  MACHINE_START(ARMLEX4210, "ARMLEX4210")
>  	/* Maintainer: Alim Akhtar <alim.akhtar@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= armlex4210_map_io,
>  	.init_machine	= armlex4210_machine_init,
> diff --git a/arch/arm/mach-exynos4/mach-nuri.c
b/arch/arm/mach-exynos4/mach-
> nuri.c
> index 2204911..5780ee3 100644
> --- a/arch/arm/mach-exynos4/mach-nuri.c
> +++ b/arch/arm/mach-exynos4/mach-nuri.c
> @@ -48,6 +48,8 @@
> 
>  #include <mach/map.h>
> 
> +#include <asm/soc.h>
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -1187,6 +1189,7 @@ static void __init nuri_machine_init(void)
>  MACHINE_START(NURI, "NURI")
>  	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= nuri_map_io,
>  	.init_machine	= nuri_machine_init,
> diff --git a/arch/arm/mach-exynos4/mach-origen.c
b/arch/arm/mach-exynos4/mach-
> origen.c
> index 421294b..06250fc 100644
> --- a/arch/arm/mach-exynos4/mach-origen.c
> +++ b/arch/arm/mach-exynos4/mach-origen.c
> @@ -33,6 +33,8 @@
> 
>  #include <mach/map.h>
> 
> +#include "core.h"
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define ORIGEN_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -210,6 +212,7 @@ static void __init origen_machine_init(void)
>  MACHINE_START(ORIGEN, "ORIGEN")
>  	/* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= origen_map_io,
>  	.init_machine	= origen_machine_init,
> diff --git a/arch/arm/mach-exynos4/mach-smdk4212.c b/arch/arm/mach-
> exynos4/mach-smdk4212.c
> index 8c41ae1..cf92514 100644
> --- a/arch/arm/mach-exynos4/mach-smdk4212.c
> +++ b/arch/arm/mach-exynos4/mach-smdk4212.c
> @@ -36,6 +36,8 @@
> 
>  #include <mach/map.h>
> 
> +#include "core.h"
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define SMDK4212_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -285,6 +287,7 @@ static void __init smdk4212_machine_init(void)
>  MACHINE_START(SMDK4212, "SMDK4212")
>  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= smdk4212_map_io,
>  	.init_machine	= smdk4212_machine_init,
> diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-
> exynos4/mach-smdkv310.c
> index cec2afa..525b042 100644
> --- a/arch/arm/mach-exynos4/mach-smdkv310.c
> +++ b/arch/arm/mach-exynos4/mach-smdkv310.c
> @@ -43,6 +43,8 @@
> 
>  #include <mach/map.h>
> 
> +#include "core.h"
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -373,6 +375,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
>  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>  	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= smdkv310_map_io,
>  	.init_machine	= smdkv310_machine_init,
> @@ -383,6 +386,7 @@ MACHINE_END
>  MACHINE_START(SMDKC210, "SMDKC210")
>  	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= smdkv310_map_io,
>  	.init_machine	= smdkv310_machine_init,
> diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-
> exynos4/mach-universal_c210.c
> index a023faa..0c94673 100644
> --- a/arch/arm/mach-exynos4/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos4/mach-universal_c210.c
> @@ -47,6 +47,8 @@
>  #include <media/s5p_fimc.h>
>  #include <media/m5mols.h>
> 
> +#include "core.h"
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers
*/
>  #define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -1061,6 +1063,7 @@ static void __init universal_machine_init(void)
>  MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
>  	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
>  	.atag_offset	= 0x100,
> +	.soc		= &exynos4_soc_desc,
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= universal_map_io,
>  	.init_machine	= universal_machine_init,
> diff --git a/arch/arm/mach-exynos4/platsmp.c
b/arch/arm/mach-exynos4/platsmp.c
> index 500453f..1f419fa 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -32,6 +32,8 @@
> 
>  #include <plat/cpu.h>
> 
> +#include "core.h"
> +
>  extern void exynos4_secondary_startup(void);
> 
>  #define CPU1_BOOT_REG		(samsung_rev() ==
> EXYNOS4210_REV_1_1 ? \
> @@ -89,7 +91,7 @@ static void __cpuinit exynos4_gic_secondary_init(void)
>  	__raw_writel(1, cpu_base + GIC_CPU_CTRL);
>  }
> 
> -void __cpuinit platform_secondary_init(unsigned int cpu)
> +static void __cpuinit exynos4_secondary_init(unsigned int cpu)
>  {
>  	/*
>  	 * if any interrupts are already enabled for the primary
> @@ -113,7 +115,7 @@ void __cpuinit platform_secondary_init(unsigned int
cpu)
>  	set_cpu_online(cpu, true);
>  }
> 
> -int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +static int __cpuinit exynos4_boot_secondary(unsigned int cpu, struct
task_struct
> *idle)
>  {
>  	unsigned long timeout;
> 
> @@ -188,7 +190,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct
> task_struct *idle)
>   * which may be present or become present in the system.
>   */
> 
> -void __init smp_init_cpus(void)
> +static void __init exynos4_smp_init_cpus(void)
>  {
>  	void __iomem *scu_base = scu_base_addr();
>  	unsigned int i, ncores;
> @@ -210,7 +212,7 @@ void __init smp_init_cpus(void)
>  	set_smp_cross_call(gic_raise_softirq);
>  }
> 
> -void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> +static void __init exynos4_smp_prepare_cpus(unsigned int max_cpus)
>  {
> 
>  	scu_enable(scu_base_addr());
> @@ -224,3 +226,18 @@ void __init platform_smp_prepare_cpus(unsigned int
> max_cpus)
>  	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
>  			CPU1_BOOT_REG);
>  }
> +
> +struct arm_soc_smp_init_ops exynos4_soc_smp_init_ops __initdata = {
> +	.smp_init_cpus		= exynos4_smp_init_cpus,
> +	.smp_prepare_cpus	= exynos4_smp_prepare_cpus,
> +};
> +
> +struct arm_soc_smp_ops exynos4_soc_smp_ops __initdata = {
> +	.smp_secondary_init	= exynos4_secondary_init,
> +	.smp_boot_secondary	= exynos4_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_kill		= exynos4_cpu_kill,
> +	.cpu_die		= exynos4_cpu_die,
> +	.cpu_disable		= exynos4_cpu_disable,
> +#endif
> +};
> --
> 1.7.0.4

And could you please re-work this based on latest my for-next because there
are updated board file.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
