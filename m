From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Nov 2012 11:04:19 +0100
Subject: [PATCH V4 3/3] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <1353490783-23101-4-git-send-email-gregory.clement@free-electrons.com>
References: <1353490783-23101-1-git-send-email-gregory.clement@free-electrons.com>
 <1353490783-23101-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50ACA723.7070600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/21/2012 10:39 AM, Gregory CLEMENT wrote:
> Armada 370 and XP come with an unit called coherency fabric. This unit
> allows to use the Armada 370/XP as a nearly coherent architecture. The
> coherency mechanism uses snoop filters to ensure the coherency between
> caches, DRAM and devices. This mechanism needs a synchronization
> barrier which guarantees that all the memory writes initiated by the
> devices have reached their target and do not reside in intermediate
> write buffers. That's why the architecture is not totally coherent and
> we need to provide our own functions for some DMA operations.
>
> Beside the use of the coherency fabric, the device units will have to
> set the attribute flag of the decoding address window to select the
> accurate coherency process for the memory transaction. This is done
> each device driver programs the DRAM address windows. The value of the
> attribute set by the driver is retrieved through the
> orion_addr_map_cfg struct filled during the early initialization of
> the platform.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Yehuda Yitschak <yehuday@marvell.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   .../devicetree/bindings/arm/coherency-fabric.txt   |    9 ++-
>   arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
>   arch/arm/mach-mvebu/addr-map.c                     |    3 +
>   arch/arm/mach-mvebu/coherency.c                    |   73 ++++++++++++++++++++
>   4 files changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> index 2bfbf67..17d8cd1 100644
> --- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> +++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
> @@ -5,12 +5,17 @@ Available on Marvell SOCs: Armada 370 and Armada XP
>   Required properties:
>   
>   - compatible: "marvell,coherency-fabric"
> -- reg: Should contain,coherency fabric registers location and length.
> +
> +- reg: Should contain coherency fabric registers location and
> +  length. First pair for the coherency fabric registers, second pair
> +  for the per-CPU fabric registers registers.
>   
>   Example:
>   
>   coherency-fabric at d0020200 {
>   	compatible = "marvell,coherency-fabric";
> -	reg = <0xd0020200 0xb0>;
> +	reg = <0xd0020200 0xb0>,
> +		<0xd0021810 0x1c>;
> +
>   };
>   
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index b0d075b..98a6b26 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -38,7 +38,8 @@
>   
>   	coherency-fabric at d0020200 {
>   		compatible = "marvell,coherency-fabric";
> -		reg = <0xd0020200 0xb0>;
> +		reg = <0xd0020200 0xb0>,
> +		      <0xd0021810 0x1c>;
>   	};
>   
>   	soc {
> diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
> index fe454a4..595f6b7 100644
> --- a/arch/arm/mach-mvebu/addr-map.c
> +++ b/arch/arm/mach-mvebu/addr-map.c
> @@ -108,6 +108,9 @@ static int __init armada_setup_cpu_mbus(void)
>   
>   	addr_map_cfg.bridge_virt_base = mbus_unit_addr_decoding_base;
>   
> +	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
> +		addr_map_cfg.hw_io_coherency = 1;
> +
>   	/*
>   	 * Disable, clear and configure windows.
>   	 */
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index 1bc02d0..9413bd5 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -22,6 +22,8 @@
>   #include <linux/of_address.h>
>   #include <linux/io.h>
>   #include <linux/smp.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
>   #include <asm/smp_plat.h>
>   #include "armada-370-xp.h"
>   
> @@ -32,10 +34,13 @@
>    * value matching its virtual mapping
>    */
>   static void __iomem *coherency_base = ARMADA_370_XP_REGS_VIRT_BASE + 0x20200;
> +static void __iomem *coherency_cpu_base;
>   
>   /* Coherency fabric registers */
>   #define COHERENCY_FABRIC_CFG_OFFSET		   0x4
>   
> +#define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
> +
>   static struct of_device_id of_coherency_table[] = {
>   	{.compatible = "marvell,coherency-fabric"},
>   	{ /* end of list */ },
> @@ -66,6 +71,70 @@ int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>   	return 0;
>   }
>   
> +static inline void mvebu_hwcc_sync_io_barrier(void)
> +{
> +	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
> +	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
> +}
> +
> +static dma_addr_t mvebu_hwcc_dma_map_page(struct device *dev, struct page *page,
> +				  unsigned long offset, size_t size,
> +				  enum dma_data_direction dir,
> +				  struct dma_attrs *attrs)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		mvebu_hwcc_sync_io_barrier();
> +	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
> +}
> +
> +
> +static void mvebu_hwcc_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			      size_t size, enum dma_data_direction dir,
> +			      struct dma_attrs *attrs)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		mvebu_hwcc_sync_io_barrier();
> +}
> +
> +static void mvebu_hwcc_dma_sync(struct device *dev, dma_addr_t dma_handle,
> +			size_t size, enum dma_data_direction dir)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		mvebu_hwcc_sync_io_barrier();
> +}
> +
> +static struct dma_map_ops mvebu_hwcc_dma_ops = {
> +	.alloc			= arm_dma_alloc,
> +	.free			= arm_dma_free,
> +	.mmap			= arm_dma_mmap,
> +	.map_page		= mvebu_hwcc_dma_map_page,
> +	.unmap_page		= mvebu_hwcc_dma_unmap_page,
> +	.get_sgtable		= arm_dma_get_sgtable,
> +	.map_sg			= arm_dma_map_sg,
> +	.unmap_sg		= arm_dma_unmap_sg,
> +	.sync_single_for_cpu	= mvebu_hwcc_dma_sync,
> +	.sync_single_for_device	= mvebu_hwcc_dma_sync,
> +	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
> +	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
> +	.set_dma_mask		= arm_dma_set_mask,
> +};
> +
> +static int mvebu_hwcc_platform_notifier(struct notifier_block *nb,
> +				       unsigned long event, void *__dev)
> +{
> +	struct device *dev = __dev;
> +
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +	set_dma_ops(dev, &mvebu_hwcc_dma_ops);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block mvebu_hwcc_platform_nb = {
> +	.notifier_call = mvebu_hwcc_platform_notifier,
> +};
> +
>   int __init coherency_init(void)
>   {
>   	struct device_node *np;
> @@ -74,6 +143,10 @@ int __init coherency_init(void)
>   	if (np) {
>   		pr_info("Initializing Coherency fabric\n");
>   		coherency_base = of_iomap(np, 0);
> +		coherency_cpu_base = of_iomap(np, 1);
> +		set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
> +		bus_register_notifier(&platform_bus_type,
> +					&mvebu_hwcc_platform_nb);
>   	}
>   
>   	return 0;

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
