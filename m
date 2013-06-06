From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Jun 2013 10:13:27 +0100
Subject: [PATCH 5/8] arm: mvebu: don't hardcode a physical address in
 headsmp.S
In-Reply-To: <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130606091327.GF15208@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Jun 05, 2013 at 08:04:58AM +0100, Thomas Petazzoni wrote:
> Now that the coherency_init() function is called a bit earlier, we can
> actually read the physical address of the coherency unit registers
> from the Device Tree, and communicate that to the headsmp.S code,
> which avoids hardcoding a physical address.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c |  4 ++++
>  arch/arm/mach-mvebu/headsmp.S   | 19 +++++++++++--------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index d74794a..3d8f40f 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -27,6 +27,7 @@
>  #include <asm/smp_plat.h>
>  #include "armada-370-xp.h"
>  
> +unsigned long __cpuinitdata coherency_phys_base;
>  static void __iomem *coherency_base;
>  static void __iomem *coherency_cpu_base;
>  
> @@ -124,7 +125,10 @@ int __init coherency_init(void)
>  
>  	np = of_find_matching_node(NULL, of_coherency_table);
>  	if (np) {
> +		struct resource res;
>  		pr_info("Initializing Coherency fabric\n");
> +		of_address_to_resource(np, 0, &res);
> +		coherency_phys_base = res.start;

So you have the primary CPU writing this address, before it is coherent...

>  		coherency_base = of_iomap(np, 0);
>  		coherency_cpu_base = of_iomap(np, 1);
>  		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
> diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
> index a06e0ed..f500e9c 100644
> --- a/arch/arm/mach-mvebu/headsmp.S
> +++ b/arch/arm/mach-mvebu/headsmp.S
> @@ -21,12 +21,6 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  
> -/*
> - * At this stage the secondary CPUs don't have acces yet to the MMU, so
> - * we have to provide physical addresses
> - */
> -#define ARMADA_XP_CFB_BASE	     0xD0020200
> -
>  	__CPUINIT
>  
>  /*
> @@ -35,15 +29,24 @@
>   * startup
>   */
>  ENTRY(armada_xp_secondary_startup)
> +	/* Get coherency fabric base physical address */
> +	adr	r0, 1f
> +	ldmia	r0, {r1, r2}
> +	sub	r0, r0, r1
> +	add	r2, r2, r0
> +	ldr	r0, [r2]

... and the secondaries reading it, before they are coherent.
How do you ensure that the write is indeed visible?

Furthermore, it's worth noting that of_find_matching_node takes the
devtree_lock spinlock, so you need to be careful calling that if you're not
coherent.

Will
