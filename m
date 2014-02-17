From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Feb 2014 16:21:14 +0900
Subject: [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU
In-Reply-To: <20140217063152.21876.6981.sendpatchset@w520>
References: <20140217063152.21876.6981.sendpatchset@w520>
Message-ID: <20140217072111.GA23528@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 03:31:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> On R-Car Gen2 SoCs such as r8a7790 and r8a7791 the hardware boot
> mode bit MD21 indicates if hardware debug mode is enabled or not.
> 
> In case hardware debug mode is enabled print a warning and refrain
> from booting secondary CPU cores. Without this patch Koelsch boards
> with SW8-4 set to OFF will hang at SMP boot.

Out of interest, is this the solution to your recent SMP troubles?

> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-v3.14-rc2-20140213
> 
>  arch/arm/mach-shmobile/platsmp-apmu.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-02-17 15:11:15.000000000 +0900
> @@ -17,6 +17,7 @@
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
>  #include <mach/common.h>
> +#include <mach/rcar-gen2.h>
>  
>  static struct {
>  	void __iomem *iomem;
> @@ -136,6 +137,12 @@ void __init shmobile_smp_apmu_prepare_cp
>  
>  int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> +	/* Refrain boot when hardware debug mode is enabled */
> +	if (rcar_gen2_read_mode_pins() & BIT(21)) {
> +		pr_warn("Unable to boot CPU%d when MD21 is set\n", cpu);
> +		return -ENOTSUPP;
> +	}
> +
>  	/* For this particular CPU register boot vector */
>  	shmobile_smp_hook(cpu, virt_to_phys(shmobile_invalidate_start), 0);
>  
> 
