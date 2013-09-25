From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Sep 2013 14:26:58 +0900
Subject: [PATCH] ARM: shmobile: r8a7791 Architected timer support
In-Reply-To: <20130912004228.24348.15536.sendpatchset@w520>
References: <20130912004228.24348.15536.sendpatchset@w520>
Message-ID: <20130925052656.GA1916@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 09:42:28AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Enable the ARM architected timer included in the CA15 cluster.
> Also make use of the shared R-Car Gen2 code that initializes
> the arch timer frequency based on the MD pins.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-20130906 and
>  [PATCH] ARM: shmobile: Break out R-Car Gen2 setup code
> 
>  arch/arm/boot/dts/r8a7791.dtsi                |    8 ++++++++
>  arch/arm/mach-shmobile/Makefile               |    2 +-
>  arch/arm/mach-shmobile/board-koelsch.c        |    1 +
>  arch/arm/mach-shmobile/include/mach/r8a7791.h |    2 ++
>  arch/arm/mach-shmobile/setup-r8a7791.c        |    1 +
>  5 files changed, 13 insertions(+), 1 deletion(-)

Hi Magnus,

please split this into three patches.

1. An SoC patch: The r8a7791.[ch] and Kconfig changes
2. A board patch: The board-koelsh.c change
3. A dt patch: The .dtsi change

> 
> --- 0003/arch/arm/boot/dts/r8a7791.dtsi
> +++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-09-12 09:12:16.000000000 +0900
> @@ -39,6 +39,14 @@
>  		interrupts = <1 9 0xf04>;
>  	};
>  
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <1 13 0xf08>,
> +				<1 14 0xf08>,
> +				<1 11 0xf08>,
> +				<1 10 0xf08>;
> +	};
> +
>  	irqc0: interrupt-controller at e61c0000 {
>  		compatible = "renesas,irqc";
>  		#interrupt-cells = <2>;
> --- 0002/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2013-09-12 09:10:42.000000000 +0900
> @@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7
>  obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
> -obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
> +obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>  
>  # Clock objects
> --- 0003/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-09-12 09:10:05.000000000 +0900
> @@ -39,6 +39,7 @@ static const char * const koelsch_boards
>  
>  DT_MACHINE_START(KOELSCH_DT, "koelsch")
>  	.init_early	= r8a7791_init_early,
> +	.init_time	= rcar_gen2_timer_init,
>  	.init_machine	= koelsch_add_standard_devices,
>  	.dt_compat	= koelsch_boards_compat_dt,
>  MACHINE_END
> --- 0003/arch/arm/mach-shmobile/include/mach/r8a7791.h
> +++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2013-09-12 09:09:22.000000000 +0900
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_R8A7791_H__
>  #define __ASM_R8A7791_H__
>  
> +#include <mach/rcar-gen2.h>
> +

Is this the best place for this include.
It does not seem to be used inside r8a7791.h and for
that reason it seems to me that it would be better
to add it to both board-koelsch.c and setup-r8a7791.c.

>  void r8a7791_add_standard_devices(void);
>  void r8a7791_add_dt_devices(void);
>  void r8a7791_clock_init(void);
> --- 0003/arch/arm/mach-shmobile/setup-r8a7791.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-09-12 09:10:20.000000000 +0900
> @@ -176,6 +176,7 @@ static const char *r8a7791_boards_compat
>  
>  DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
>  	.init_early	= r8a7791_init_early,
> +	.init_time	= rcar_gen2_timer_init,
>  	.dt_compat	= r8a7791_boards_compat_dt,
>  MACHINE_END
>  #endif /* CONFIG_USE_OF */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
