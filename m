From: baohua@kernel.org (Barry Song)
Date: Thu, 22 May 2014 20:14:37 +0800
Subject: [PATCH 65/97] ARM: l2c: prima2: convert to generic l2c
 initialisation
In-Reply-To: <E1WerHE-0001Y8-2Z@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHE-0001Y8-2Z@rmk-PC.arm.linux.org.uk>
Message-ID: <CAGsJ_4xSerVN6A_NymMaRqjy9ZA3j542DVE=gvmz=DNF470H2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-29 3:31 GMT+08:00 Russell King <rmk+kernel@arm.linux.org.uk>:
> Along with this change, we can delete l2x0.c from prima2.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

if the information you want is l2c_aux_val, l2c_aux_mask for prima2 platform.

it is (0, 0xfdffffff), you can cleary know that from the v1 i sent on
April 15, which was much earlier than your this patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247423.html

and you gave many comments on that, and you read the (0, 0xFDFFFFFUL)
and disliked the upper letter.

but you just complained that i didn't provide any information to you
and you felt "frustrated".

i think that man who should fell frustrated is me not you. i feel very
frustrated for the moment.

> ---
>  arch/arm/boot/dts/marco.dtsi  |  2 +-
>  arch/arm/boot/dts/prima2.dtsi |  2 +-
>  arch/arm/mach-prima2/Makefile |  1 -
>  arch/arm/mach-prima2/common.c |  6 ++++++
>  arch/arm/mach-prima2/l2x0.c   | 30 ------------------------------
>  5 files changed, 8 insertions(+), 33 deletions(-)
>  delete mode 100644 arch/arm/mach-prima2/l2x0.c
>
> diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
> index 0c9647d28765..fb354225740a 100644
> --- a/arch/arm/boot/dts/marco.dtsi
> +++ b/arch/arm/boot/dts/marco.dtsi
> @@ -36,7 +36,7 @@
>                 ranges = <0x40000000 0x40000000 0xa0000000>;
>
>                 l2-cache-controller at c0030000 {
> -                       compatible = "sirf,marco-pl310-cache", "arm,pl310-cache";
> +                       compatible = "arm,pl310-cache";
>                         reg = <0xc0030000 0x1000>;
>                         interrupts = <0 59 0>;
>                         arm,tag-latency = <1 1 1>;
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 1e82571d6823..0d6588d549bf 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -48,7 +48,7 @@
>                 ranges = <0x40000000 0x40000000 0x80000000>;
>
>                 l2-cache-controller at 80040000 {
> -                       compatible = "arm,pl310-cache", "sirf,prima2-pl310-cache";
> +                       compatible = "arm,pl310-cache";
>                         reg = <0x80040000 0x1000>;
>                         interrupts = <59>;
>                         arm,tag-latency = <1 1 1>;
> diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
> index 7a6b4a323125..8846e7d87ea5 100644
> --- a/arch/arm/mach-prima2/Makefile
> +++ b/arch/arm/mach-prima2/Makefile
> @@ -2,7 +2,6 @@ obj-y += rstc.o
>  obj-y += common.o
>  obj-y += rtciobrg.o
>  obj-$(CONFIG_DEBUG_LL) += lluart.o
> -obj-$(CONFIG_CACHE_L2X0) += l2x0.o
>  obj-$(CONFIG_SUSPEND) += pm.o sleep.o
>  obj-$(CONFIG_SMP) += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
> index 47c7819edb9b..a860ea27e8ae 100644
> --- a/arch/arm/mach-prima2/common.c
> +++ b/arch/arm/mach-prima2/common.c
> @@ -34,6 +34,8 @@ static const char *atlas6_dt_match[] __initconst = {
>
>  DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,
>         .map_io         = sirfsoc_map_io,
>         .init_late      = sirfsoc_init_late,
>         .dt_compat      = atlas6_dt_match,
> @@ -48,6 +50,8 @@ static const char *prima2_dt_match[] __initconst = {
>
>  DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,
>         .map_io         = sirfsoc_map_io,
>         .dma_zone_size  = SZ_256M,
>         .init_late      = sirfsoc_init_late,
> @@ -63,6 +67,8 @@ static const char *marco_dt_match[] __initconst = {
>
>  DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,
>         .smp            = smp_ops(sirfsoc_smp_ops),
>         .map_io         = sirfsoc_map_io,
>         .init_late      = sirfsoc_init_late,
> diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
> deleted file mode 100644
> index dbd837bdb7f7..000000000000
> --- a/arch/arm/mach-prima2/l2x0.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * l2 cache initialization for CSR SiRFprimaII
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> - *
> - * Licensed under GPLv2 or later.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <asm/hardware/cache-l2x0.h>
> -
> -static const struct of_device_id sirf_l2x0_ids[] __initconst = {
> -       { .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
> -       { .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
> -       {},
> -};
> -
> -static int __init sirfsoc_l2x0_init(void)
> -{
> -       struct device_node *np;
> -
> -       np = of_find_matching_node(NULL, sirf_l2x0_ids);
> -       if (np)
> -               return l2x0_of_init(0, ~0);
> -
> -       return 0;
> -}
> -early_initcall(sirfsoc_l2x0_init);
> --
> 1.8.3.1
>

-barry
