From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 28 Jan 2016 12:20:58 +0000
Subject: [PATCH 11/13] dtb: amd: Add PCIe SMMU device tree node
In-Reply-To: <20160128111453.GG17123@leverpostej>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1453929121-12171-12-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160128111453.GG17123@leverpostej>
Message-ID: <56AA07AA.7050701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 11:14, Mark Rutland wrote:
> On Wed, Jan 27, 2016 at 03:11:59PM -0600, Suravee Suthikulpanit wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Add PCIe SMMU device tree node for AMD Seattle SOC.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
>> index a7fc059..bfccfea 100644
>> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
>> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
>> @@ -210,6 +210,7 @@
>>   			device_type = "pci";
>>   			bus-range = <0 0x7f>;
>>   			msi-parent = <&v2m0>;
>> +			#stream-id-cells = <16>;
>>   			reg = <0 0xf0000000 0 0x10000000>;
>>
>>   			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>> @@ -230,6 +231,28 @@
>>   				<0x03000000 0x01 0x00000000 0x01 0x00000000 0x7f 0x00000000>;
>>   		};
>>
>> +		pcie0_smmu: smmu at e0a00000 {
>> +			 compatible = "arm,mmu-401";
>> +			 reg = <0 0xe0a00000 0 0x10000>;
>> +			 #global-interrupts = <1>;
>> +			 interrupts = /* Uses combined intr for both
>> +				       * global and context
>> +				       */
>> +				      <0 333 4>,
>> +				      <0 333 4>;
>> +			/* Note:
>> +			 * SID[2:0]  = PCIe function number
>> +			 * SID[7:3]  = PCIe device number
>> +			 * SID[14:8] = PCIe bus number
>> +			 */
>> +			 mmu-masters = <&pcie0
>> +				/* 1:00:[0,3] */ 256 257 258 259
>> +				/* 2:00:[0,3] */ 512 513 514 515
>> +				/* 3:00:[0,3] */ 768 769 770 771
>> +				/* 4:00:[0,3] */ 1024 1025 1026 1027
>> +			 >;
>> +		 };
>
> This doesn't look right to me.
>
> I didn't think that RID->SID mapping was actually defined by any
> binding, so (how) are these numbers used?
>
> I'm uncomfortable with this, given we should be moving towards the
> generic IOMMU binding (and then we'd use the iommu-map binding [1] for
> this).
>
> Will, Robin, thoughts?

Any IDs specified here would only apply to DMA by the "platform device" 
side of the host controller itself (as would an equivalent "iommus" 
property on pcie0 once I finish the SMMUv2 generic binding support I'm 
working on). In terms of PCI devices, the "mmu-masters" property is 
overloaded such that only its existence matters, to identify that there 
_is_ a relationship between the SMMU and the PCI bus(es) behind that 
host controller.

Really, the only binding that's going to make sense for that context is 
"iommu-map". I think that should be pretty straightforward to implement 
entirely in core OF/IOMMU code - we can already figure out a device's 
DMA alias as the host controller sees it, we just need the IOMMU drivers 
to be able to then run that through an additional downstream translation 
(which would be identity-mapped by default).

Robin.

>
> Mark.
>
> [1] https://lkml.org/lkml/2015/7/23/561
>
