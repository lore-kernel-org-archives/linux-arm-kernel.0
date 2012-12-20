From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Dec 2012 12:06:25 +0200
Subject: [PATCH 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <1355996654-6579-4-git-send-email-hdoyu@nvidia.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <1355996654-6579-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <20121220100625.GB24693@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 20, 2012 at 11:44:01AM +0200, Hiroshi Doyu wrote:
> The method to detect the number of CPU cores on Cortex-A9 MPCore and
> Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
> information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
> have to read it from the system coprocessor(CP15), because the SCU on
> Cortex-A15 MPCore does not have software readable registers. This
> patch selects the correct method at runtime based on the CPU ID.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mach-tegra/platsmp.c |   31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 1b926df..68e76ef 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -23,6 +23,7 @@
>  #include <asm/hardware/gic.h>
>  #include <asm/mach-types.h>
>  #include <asm/smp_scu.h>
> +#include <asm/cputype.h>
>  
>  #include <mach/powergate.h>
>  
> @@ -34,9 +35,13 @@
>  #include "common.h"
>  #include "iomap.h"
>  
> +#define CPU_MASK		0xff0ffff0
> +#define CPU_CORTEX_A9		0x410fc090
> +#define CPU_CORTEX_A15		0x410fc0f0
> +
>  extern void tegra_secondary_startup(void);
>  
> -static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
> +static void __iomem *scu_base;
>  
>  #define EVP_CPU_RESET_VECTOR \
>  	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
> @@ -149,7 +154,26 @@ done:
>   */
>  static void __init tegra_smp_init_cpus(void)
>  {
> -	unsigned int i, ncores = scu_get_core_count(scu_base);
> +	unsigned int i, cpu_id, ncores;
> +	u32 l2ctlr;
> +	phys_addr_t pa;
> +
> +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
> +	switch (cpu_id) {
> +	case CPU_CORTEX_A15:
> +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> +		ncores = ((l2ctlr >> 24) & 3) + 1;
> +		break;
> +	case CPU_CORTEX_A9:
> +		/* Get SCU physical base */
> +		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
> +		scu_base = IO_ADDRESS(pa);
> +		ncores = scu_get_core_count(scu_base);
> +		break;
> +	default:
> +		BUG();

instead of bugging out, how about setting ncores to 1 instead ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121220/03946ec6/attachment.sig>
