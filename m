From: michal.simek@xilinx.com (Michal Simek)
Date: Sat, 27 Oct 2012 13:40:33 +0000
Subject: [PATCH v4 2/5] zynq: use pl310 device tree bindings
In-Reply-To: <20121024200337.GC6713@beefymiracle.amer.corp.natinst.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200337.GC6713@beefymiracle.amer.corp.natinst.com>
Message-ID: <cd33234d-7122-4c64-a750-d4a6c2fc83bd@CO1EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Wednesday, October 24, 2012 10:04 PM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 2/5] zynq: use pl310 device tree bindings
>
> The Zynq has a PL310 L2 cache controller.  Convert in-tree uses to using the
> device tree.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts           | 9 +++++++++
>  arch/arm/mach-zynq/common.c                | 9 +--------
>  arch/arm/mach-zynq/include/mach/zynq_soc.h | 4 ----
>  3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-ep107.dts b/arch/arm/boot/dts/zynq-
> ep107.dts
> index 7bfff4a..87204d7 100644
> --- a/arch/arm/boot/dts/zynq-ep107.dts
> +++ b/arch/arm/boot/dts/zynq-ep107.dts
> @@ -44,6 +44,15 @@
>                             <0xF8F00100 0x100>;
>               };
>
> +             L2: cache-controller {
> +                     compatible = "arm,pl310-cache";
> +                     reg = <0xF8F02000 0x1000>;
> +                     arm,data-latency = <2 3 2>;
> +                     arm,tag-latency = <2 3 2>;
> +                     cache-unified;
> +                     cache-level = <2>;
> +             };
> +
>               uart0: uart at e0000000 {
>                       compatible = "xlnx,xuartps";
>                       reg = <0xE0000000 0x1000>;
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index d73963b..056091a 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -45,12 +45,10 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
>   */
>  static void __init xilinx_init_machine(void)  { -#ifdef CONFIG_CACHE_L2X0
>       /*
>        * 64KB way size, 8-way associativity, parity disabled
>        */
> -     l2x0_init(PL310_L2CC_BASE, 0x02060000, 0xF0F0FFFF);
> -#endif
> +     l2x0_of_init(0x02060000, 0xF0F0FFFF);
>
>       of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);  } @@ -83,11
> +81,6 @@ static struct map_desc io_desc[] __initdata = {
>               .pfn            = __phys_to_pfn(SCU_PERIPH_PHYS),
>               .length         = SZ_8K,
>               .type           = MT_DEVICE,
> -     }, {
> -             .virtual        = PL310_L2CC_VIRT,
> -             .pfn            = __phys_to_pfn(PL310_L2CC_PHYS),
> -             .length         = SZ_4K,
> -             .type           = MT_DEVICE,
>       },
>
>  #ifdef CONFIG_DEBUG_LL
> diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-
> zynq/include/mach/zynq_soc.h
> index 3d1c6a6..218283a 100644
> --- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
> +++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
> @@ -25,9 +25,6 @@
>  #define TTC0_PHYS                    0xF8001000
>  #define TTC0_VIRT                    TTC0_PHYS
>
> -#define PL310_L2CC_PHYS                      0xF8F02000
> -#define PL310_L2CC_VIRT                      PL310_L2CC_PHYS
> -
>  #define SCU_PERIPH_PHYS                      0xF8F00000
>  #define SCU_PERIPH_VIRT                      SCU_PERIPH_PHYS
>
> @@ -35,7 +32,6 @@
>
>  #define TTC0_BASE                    IOMEM(TTC0_VIRT)
>  #define SCU_PERIPH_BASE                      IOMEM(SCU_PERIPH_VIRT)
> -#define PL310_L2CC_BASE                      IOMEM(PL310_L2CC_VIRT)
>
>  /*
>   * Mandatory for CONFIG_LL_DEBUG, UART is mapped virtual = physical
> --
> 1.8.0
>

This is ok. No changes are necessary.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Please add my acked-by line to this patch to the v5 series.
When all patches are ready I will apply it to zynq next branch at git.xilnx.com.

Thanks,
Michal



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
