From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Oct 2016 13:32:46 +0300
Subject: [PATCH RFC v2 4/12] ARM: shmobile: r8a7743: basic SoC support
In-Reply-To: <3178356.WuR0emdY7D@wasted.cogentembedded.com>
References: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
 <3178356.WuR0emdY7D@wasted.cogentembedded.com>
Message-ID: <3685233.dpr7L9QmAC@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for the patch.

On Friday 30 Sep 2016 01:23:52 Sergei Shtylyov wrote:
> Add minimal support for the RZ/G1M (R8A7743) SoC.
> 
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> Changes in version 2:
> - removed "select I2C" from the R8A7743 Kconfig entry;
> - documented the R8A7743 device tree binding;
> - added Geert's tag.
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 +
>  arch/arm/mach-shmobile/Kconfig                     |    4 ++
>  arch/arm/mach-shmobile/Makefile                    |    1
>  arch/arm/mach-shmobile/setup-r8a7743.c             |   34 +++++++++++++++++

We should work towards removing files from arch/arm/mach-shmobile/, not adding 
new ones :-) I've just sent a patch to do so ("[PATCH] ARM: shmobile: 
Consolidate R8A779[234] machine definitions'") and CC'ed you.

>  4 files changed, 41 insertions(+)
> 
> Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
> ===================================================================
> --- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -13,6 +13,8 @@ SoCs:
>      compatible = "renesas,r8a73a4"
>    - R-Mobile A1 (R8A77400)
>      compatible = "renesas,r8a7740"
> +  - RZ/G1M (R8A77430)
> +    compatible = "renesas,r8a7743"
>    - R-Car M1A (R8A77781)
>      compatible = "renesas,r8a7778"
>    - R-Car H1 (R8A77790)
> Index: renesas/arch/arm/mach-shmobile/Kconfig
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/Kconfig
> +++ renesas/arch/arm/mach-shmobile/Kconfig
> @@ -68,6 +68,10 @@ config ARCH_R8A7740
>  	select ARCH_RMOBILE
>  	select RENESAS_INTC_IRQPIN
> 
> +config ARCH_R8A7743
> +	bool "RZ/G1M (R8A77430)"
> +	select ARCH_RCAR_GEN2
> +
>  config ARCH_R8A7778
>  	bool "R-Car M1A (R8A77781)"
>  	select ARCH_RCAR_GEN1
> Index: renesas/arch/arm/mach-shmobile/Makefile
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/Makefile
> +++ renesas/arch/arm/mach-shmobile/Makefile
> @@ -9,6 +9,7 @@ obj-y				:= timer.o
>  obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o
>  obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
>  obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
> +obj-$(CONFIG_ARCH_R8A7743)	+= setup-r8a7743.o
>  obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
> Index: renesas/arch/arm/mach-shmobile/setup-r8a7743.c
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7743.c
> @@ -0,0 +1,34 @@
> +/*
> + * r8a7743 processor support
> + *
> + * Copyright (C) 2016 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation; of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +
> +#include <asm/mach/arch.h>
> +
> +#include "common.h"
> +#include "rcar-gen2.h"
> +
> +static const char * const r8a7743_boards_compat_dt[] __initconst = {
> +	"renesas,r8a7743",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(R8A7743_DT, "Generic R8A7743 (Flattened Device Tree)")
> +	.init_early	= shmobile_init_delay,
> +	.init_time	= rcar_gen2_timer_init,
> +	.init_late	= shmobile_init_late,
> +	.reserve	= rcar_gen2_reserve,
> +	.dt_compat	= r8a7743_boards_compat_dt,
> +MACHINE_END

-- 
Regards,

Laurent Pinchart
