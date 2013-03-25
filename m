From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 15:01:59 +0100
Subject: [PATCH 1/3] ARM: zynq: read scu base from SoC
In-Reply-To: <1364043450-18700-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
 <1364043450-18700-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3dK30HZxJXcNjwVqgqW_Qqag=26PEFWra6r7H6JGnpPHXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> Instead of hardcoding the base address of the SCU get it from the device.
> While at it, add the SCU to the DT.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi |  5 +++++
>  arch/arm/mach-zynq/common.c      | 34 ++++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 88564fa..c103082 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -199,6 +199,11 @@
>                         };
>                 };
>
> +               scu: scu at f8f000000 {
> +                       compatible = "arm,cortex-a9-scu";
> +                       reg = <0xf8f00000 0x58>;
> +               };
> +
>                 timer: timer at f8f00600 {
>                         compatible = "arm,cortex-a9-twd-timer";
>                         reg = <0xf8f00600 0x20>;
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 920e20a..014131c 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -32,11 +32,14 @@
>  #include <asm/mach-types.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> +#include <asm/smp_scu.h>
>  #include <asm/smp_twd.h>
>  #include <asm/hardware/cache-l2x0.h>
>
>  #include "common.h"
>
> +void __iomem *scu_base;

This must be defined in header - will produce sparse warning.

> +
>  static struct of_device_id zynq_of_bus_ids[] __initdata = {
>         { .compatible = "simple-bus", },
>         {}
> @@ -56,17 +59,6 @@ static void __init xilinx_init_machine(void)
>         of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>  }
>
> -#define SCU_PERIPH_PHYS                0xF8F00000
> -#define SCU_PERIPH_SIZE                SZ_8K
> -#define SCU_PERIPH_VIRT                (VMALLOC_END - SCU_PERIPH_SIZE)
> -
> -static struct map_desc scu_desc __initdata = {
> -       .virtual        = SCU_PERIPH_VIRT,
> -       .pfn            = __phys_to_pfn(SCU_PERIPH_PHYS),
> -       .length         = SCU_PERIPH_SIZE,
> -       .type           = MT_DEVICE,
> -};
> -
>  static void __init xilinx_zynq_timer_init(void)
>  {
>         struct device_node *np;
> @@ -82,13 +74,31 @@ static void __init xilinx_zynq_timer_init(void)
>         xttcps_timer_init();
>  }
>
> +static struct map_desc zynq_cortex_a9_scu_map __initdata = {
> +       .length = SZ_8K,

That's bogus. Size 8k is too big because it also cover gic which is wrong.
As you can see from xilinx git repo correct size is 256 or less.

> +       .type   = MT_DEVICE,
> +};
> +
> +void __init zynq_scu_map_io(void)

Should be static.

> +{
> +       if (scu_a9_has_base()) {

I am not calling this function because I think it is not necessary to do so
because it is run only on a9 where scu_a9_get_base will just work.
Of did I miss anything?


> +               unsigned long base;
> +
> +               base = scu_a9_get_base();
> +               zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
> +               zynq_cortex_a9_scu_map.virtual = base;
> +               iotable_init(&zynq_cortex_a9_scu_map, 1);
> +               scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
> +       }
> +}
> +
>  /**
>   * xilinx_map_io() - Create memory mappings needed for early I/O.
>   */
>  static void __init xilinx_map_io(void)
>  {
>         debug_ll_io_init();
> -       iotable_init(&scu_desc, 1);
> +       zynq_scu_map_io();
>  }

You are using a little bit different names than we have in xilinx git tree
but maybe worth to call it as you.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
