From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Oct 2012 13:50:12 +0200
Subject: [PATCH 2/2] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <20121024082529.GZ11837@lunn.ch>
References: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
 <1351065841-18654-3-git-send-email-gregory.clement@free-electrons.com>
 <20121024082529.GZ11837@lunn.ch>
Message-ID: <5087D5F4.9060104@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 10:25 AM, Andrew Lunn wrote:
> On Wed, Oct 24, 2012 at 10:04:01AM +0200, Gregory CLEMENT wrote:
>> Armada 370 and XP come with an unit called coherency fabric. This unit
>> allows to use the Armada XP as a nearly coherent architecture. The
>> coherency mechanism uses snoop filters to ensure the coherency between
>> caches, DRAM and devices. This mechanism needs a synchronization
>> barrier which guarantees that all memory write initiated by the
>> devices has reached their target and do not reside in intermediate
>> write buffers. That's why the architecture is not totally coherent and
>> we need to provide our own functions for some DMA operations.
>>
>> Beside the use of the coherency fabric, the device units will have to
>> set the attribute flag to select the accurate coherency process for
>> the memory transaction. This is done each device driver programs the
>> DRAM address windows. The value of the attribute set by the driver is
>> retrieved through the orion_addr_map_cfg struct filled during the
>> early initialization of the platform.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
>> ---
>>  arch/arm/boot/dts/armada-370-xp.dtsi |    3 +-
>>  arch/arm/mach-mvebu/addr-map.c       |    3 ++
>>  arch/arm/mach-mvebu/armada-370-xp.c  |    1 +
>>  arch/arm/mach-mvebu/coherency.c      |   87 ++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-mvebu/common.h         |    2 +
>>  5 files changed, 95 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
>> index 18ba60b..af22e53 100644
>> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
>> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
>> @@ -38,7 +38,8 @@
>>  
>>  	coherency-fabric at d0020200 {
>>  		compatible = "marvell,coherency-fabric";
>> -		reg = <0xd0020200 0xb0>;
>> +		reg = <0xd0020200 0xb0>,
>> +		      <0xd0021010 0x1c>;
>>  	};
> 
> ...
> 
>>  int __init armada_370_xp_coherency_init(void)
>>  {
>>  	struct device_node *np;
>> @@ -82,7 +159,17 @@ int __init armada_370_xp_coherency_init(void)
>>  	if (np) {
>>  		pr_info("Initializing Coherency fabric\n");
>>  		coherency_base = of_iomap(np, 0);
>> +		coherency_cpu_base = of_iomap(np, 1);
> 
> Is this already in the binding documentation?

No indeed, the documentation should be completed. I will do it
the V2

> 
>    Thanks
> 	Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
