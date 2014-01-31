From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Jan 2014 11:38:08 -0600
Subject: [PATCH] ARM: zynq: Reserve not DMAable space in front of the
 kernel
In-Reply-To: <780bb8c8fd752eeace2fd2fbe1d8ed8572dc0d76.1391170073.git.michal.simek@xilinx.com>
References: <780bb8c8fd752eeace2fd2fbe1d8ed8572dc0d76.1391170073.git.michal.simek@xilinx.com>
Message-ID: <CAL_Jsq+4Ea7=WP+mj_k1Q3q7DKm-hk6WXpv2DOBQwefp-zxzjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 6:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> Reserve space from 0x0 - __pa(swapper_pg_dir),
> if kernel is loaded from 0, which is not DMAable.
> It is causing problem with MMC driver and others
> which want to add dma buffers to this space.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Jason: I don't think it is worth to bring 0x8000 magic
> value and count minimum from it and phys_addr of swapper_pg_dir.
> Full 512k of memory shouldn't be used by DMA.
>
> ---
>  arch/arm/mach-zynq/common.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

The existing DT reserved range can't be used for this purpose?

Rob

>
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 1db2a5ca..8c09a83 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/of.h>
> +#include <linux/memblock.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic.h>
>
> @@ -41,6 +42,18 @@
>
>  void __iomem *zynq_scu_base;
>
> +/**
> + * zynq_memory_init - Initialize special memory
> + *
> + * We need to stop things allocating the low memory as DMA can't work in
> + * the 1st 512K of memory.
> + */
> +static void __init zynq_memory_init(void)
> +{
> +       if (!__pa(PAGE_OFFSET))
> +               memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));
> +}
> +
>  static struct platform_device zynq_cpuidle_device = {
>         .name = "cpuidle-zynq",
>  };
> @@ -117,5 +130,6 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>         .init_machine   = zynq_init_machine,
>         .init_time      = zynq_timer_init,
>         .dt_compat      = zynq_dt_match,
> +       .reserve        = zynq_memory_init,
>         .restart        = zynq_system_reset,
>  MACHINE_END
> --
> 1.8.2.3
>
