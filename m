From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Nov 2012 22:01:53 +0100
Subject: [PATCH V2 3/3] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <50AA2B0C.7040508@samsung.com>
References: <1353059100-24022-1-git-send-email-gregory.clement@free-electrons.com>
 <1353059100-24022-4-git-send-email-gregory.clement@free-electrons.com>
 <50AA2B0C.7040508@samsung.com>
Message-ID: <50ABEFC1.9090400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/19/2012 01:50 PM, Marek Szyprowski wrote:
> Hello,
> 
> On 11/16/2012 10:45 AM, Gregory CLEMENT wrote:
>> Armada 370 and XP come with an unit called coherency fabric. This unit
>> allows to use the Armada 370/XP as a nearly coherent architecture. The
>> coherency mechanism uses snoop filters to ensure the coherency between
>> caches, DRAM and devices. This mechanism needs a synchronization
>> barrier which guarantees that all the memory writes initiated by the
>> devices have reached their target and do not reside in intermediate
>> write buffers. That's why the architecture is not totally coherent and
>> we need to provide our own functions for some DMA operations.
>>
>> Beside the use of the coherency fabric, the device units will have to
>> set the attribute flag of the decoding address window to select the
>> accurate coherency process for the memory transaction. This is done
>> each device driver programs the DRAM address windows. The value of the
>> attribute set by the driver is retrieved through the
>> orion_addr_map_cfg struct filled during the early initialization of
>> the platform.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
>> ---
>>   .../devicetree/bindings/arm/coherency-fabric.txt   |    9 ++-
>>   arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
>>   arch/arm/mach-mvebu/addr-map.c                     |    3 +
>>   arch/arm/mach-mvebu/coherency.c                    |   73 ++++++++++++++++++++
>>   4 files changed, 85 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
>> index 2bfbf67..17d8cd1 100644
>> --- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
>> +++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
>> @@ -5,12 +5,17 @@ Available on Marvell SOCs: Armada 370 and Armada XP
>>   Required properties:
>>   
>>   - compatible: "marvell,coherency-fabric"
>> -- reg: Should contain,coherency fabric registers location and length.
>> +
>> +- reg: Should contain coherency fabric registers location and
>> +  length. First pair for the coherency fabric registers, second pair
>> +  for the per-CPU fabric registers registers.
>>   
>>   Example:
>>   
>>   coherency-fabric at d0020200 {
>>   	compatible = "marvell,coherency-fabric";
>> -	reg = <0xd0020200 0xb0>;
>> +	reg = <0xd0020200 0xb0>,
>> +		<0xd0021810 0x1c>;
>> +
>>   };
>>   
>> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
>> index b0d075b..98a6b26 100644
>> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
>> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
>> @@ -38,7 +38,8 @@
>>   
>>   	coherency-fabric at d0020200 {
>>   		compatible = "marvell,coherency-fabric";
>> -		reg = <0xd0020200 0xb0>;
>> +		reg = <0xd0020200 0xb0>,
>> +		      <0xd0021810 0x1c>;
>>   	};
>>   
>>   	soc {
>> diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
>> index fe454a4..595f6b7 100644
>> --- a/arch/arm/mach-mvebu/addr-map.c
>> +++ b/arch/arm/mach-mvebu/addr-map.c
>> @@ -108,6 +108,9 @@ static int __init armada_setup_cpu_mbus(void)
>>   
>>   	addr_map_cfg.bridge_virt_base = mbus_unit_addr_decoding_base;
>>   
>> +	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
>> +		addr_map_cfg.hw_io_coherency = 1;
>> +
>>   	/*
>>   	 * Disable, clear and configure windows.
>>   	 */
>> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
>> index 20a0ccc..153fcfa 100644
>> --- a/arch/arm/mach-mvebu/coherency.c
>> +++ b/arch/arm/mach-mvebu/coherency.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/of_address.h>
>>   #include <linux/io.h>
>>   #include <linux/smp.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/platform_device.h>
>>   #include <asm/smp_plat.h>
>>   #include "armada-370-xp.h"
>>   
>> @@ -32,11 +34,14 @@
>>    * value matching its virtual mapping
>>    */
>>   static void __iomem *coherency_base = ARMADA_370_XP_REGS_VIRT_BASE + 0x20200;
>> +static void __iomem *coherency_cpu_base;
>>   
>>   /* Coherency fabric registers */
>>   #define COHERENCY_FABRIC_CTL_OFFSET		   0x0
>>   #define COHERENCY_FABRIC_CFG_OFFSET		   0x4
>>   
>> +#define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
>> +
>>   static struct of_device_id of_coherency_table[] = {
>>   	{.compatible = "marvell,coherency-fabric"},
>>   	{ /* end of list */ },
>> @@ -75,6 +80,70 @@ int set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>>   	return 0;
>>   }
>>   
>> +static inline void mvebu_hwcc_sync_io_barrier(void)
>> +{
>> +	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
>> +	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
>> +}
>> +
>> +static dma_addr_t mvebu_hwcc_dma_map_page(struct device *dev, struct page *page,
>> +				  unsigned long offset, size_t size,
>> +				  enum dma_data_direction dir,
>> +				  struct dma_attrs *attrs)
>> +{
>> +	if (dir != DMA_TO_DEVICE)
>> +		mvebu_hwcc_sync_io_barrier();
>> +	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
>> +}
>> +
>> +
>> +static void mvebu_hwcc_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>> +			      size_t size, enum dma_data_direction dir,
>> +			      struct dma_attrs *attrs)
>> +{
>> +	if (dir != DMA_TO_DEVICE)
>> +		mvebu_hwcc_sync_io_barrier();
>> +}
>> +
>> +static void mvebu_hwcc_dma_sync(struct device *dev, dma_addr_t dma_handle,
>> +			size_t size, enum dma_data_direction dir)
>> +{
>> +	if (dir != DMA_TO_DEVICE)
>> +		mvebu_hwcc_sync_io_barrier();
>> +}
>> +
>> +static struct dma_map_ops mvebu_hwcc_dma_ops = {
>> +	.alloc			= arm_coherent_dma_alloc,
>> +	.free			= arm_coherent_dma_free,
> 
> Are you sure that arm_coherent_dma_{alloc,free} are right functions for Your
> architecture? If I understand right, You need to do implicit synchronization
> (io barrier) between CPU transactions and device transactions.
> 
> dma_alloc_coherent() provides memory which can be used simultaneously by 
> both
> CPU and devices, so without such barrier the memory won't be coherent.
> 
> IMHO You should use arm_dma_{alloc,free} functions as Your hardware is not
> truly coherent. Then Your mvebu_hwcc_dma_ops will look very similar to
> dmabounce_ops from arch/arm/common/dmabounce.c (custom functions only for
> map/unmap page and sync_single_for_cpu/device).

You are totally right. In our first internal version based on older
kernel (3.2 or 3.4). We had set arch_is_coherent() to 1, and added
some hook in __dma_single_cpu_to_dev(), __dma_single_dev_to_cpu(),
__dma_page_cpu_to_dev() and __dma_page_dev_to_cpu(). So when
arch_is_coherent() were removed and when we switched to dma_ops, I had
assumed that we set the architecture as coherent modulo the modified
function. But I didn't realize that in this older kernel there were no
functions for coherent_alloc for arm. So it was wrong to use
the new arm_coherent_dma_alloc.

I made the change you have suggested and I will sent a new version
very soon.

Thanks for you review!

> 
>> +	.mmap			= arm_dma_mmap,
>> +	.unmap_page		= mvebu_hwcc_dma_unmap_page,
> 
> Please reorder entries to get map and unmap together.

OK, I will.

Gregory
