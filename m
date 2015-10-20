From: puck.chen@hisilicon.com (chenfeng)
Date: Tue, 20 Oct 2015 20:33:35 +0800
Subject: [PATCH V2 1/3] Documentation for system mmu in hi6220 platform.
In-Reply-To: <20151020103402.GB968@leverpostej>
References: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
 <20151020103402.GB968@leverpostej>
Message-ID: <5626349F.3040108@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark, thanks very much.

On 2015/10/20 18:34, Mark Rutland wrote:
> On Tue, Oct 20, 2015 at 04:45:22PM +0800, Chen Feng wrote:
>> docs: iommu: Documentation for smmu in hi6220 SoC.
>>
>> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Yu Dongbin <yudongbin@hisilicon.com>
>> ---
>>  .../bindings/iommu/hisi,hi6220-iommu.txt           | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
>> new file mode 100644
>> index 0000000..93e0701
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
>> @@ -0,0 +1,52 @@
>> +Hi6220 SoC SMMU Device Driver devicetree document
>> +=======================================================================
>> +The Architecture of SMMU on Hi6220 SoC:
>> +
>> +   +------------------------------------------------------------------+
>> +   |                                                                  |
>> +   |         +---------+  +--------+  +-------------+   +-------+     |
>> +   |         |   ADE   |  |  ISP   |  |  V/J codec  |   |  G3D  |     |
>> +   |         +----|----+  +---|----+  +------|------+   +---|---|     |
>> +   |              |           |              |              |         |
>> +   |     ---------v-----------v--------------v--------------v-----    |
>> +   |                           Media Bus                              |
>> +   |     --------------------------------|---------------|--------    |
>> +   |                                     |               |            |
>> +   |                                 +---v---------------v--------+   |
>> +   |                                 |            SMMU            |   |
>> +   |                                 +----------|---------|-------+   |
>> +   |                                            |         |           |
>> +   +--------------------------------------------|---------|-----------+
>> +                                                |         |
>> +                                   +------------v---------v-----------+
>> +                                   |              DDRC                |
>> +                                   +----------------------------------+
>> +
>> +Note:
>> +The media system shared the same smmu IP. to access DDR memory. And all
> 
> Nit: s/IP./IP/
> 
>> +media IP used the same page table.
>> +
>> +Below binding describes the system mmu for media system in hi6220 platform
>> +
>> +Required properties:
>> +- compatible: Should be "hisilicon,hi6220-smmu" example:
>> +		compatible = "hisilicon,hi6220-smmu";
> 
> No need for the example here.
> 
> Just say:
> 
> - compatible: should contain "hisilicon,hi6220-smmu".
> 
ok,
>> +- reg: A tuple of base address and size of System MMU registers.
>> +- interrupts: An interrupt specifier for interrupt signal of System MMU.
>> +- clocks: The clock used for smmu IP.
>> +- clock-names: The name to enable clock with clock framework.
> 
> The description of clocks and clock-names makes no sense.
> 
> You must define the exact set of names you expect, and the relationship
> between clocks and clock names. e.g.
> 
ok
> - clocks: a list of phandle + clock-specifier pairs, one for each entry
>   in clock-names
> 
> - clock-names: should contain:
>   * "smmu_clk"
>   * "media_sc_clk"
>   * "smmu_peri_clk"
> 
>> +- #iommu-cells: The iommu-cells should be 1 for muti-master to use.
> 
> s/muti/multi/
> 
> You must define what that one cell corresponds to in the hardware.
> 
> Thanks,
> Mark.
> 

I will change this next version.
>> +
>> +Examples:
>> +	smmu at f4210000 {
>> +		compatible = "hisilicon,hi6220-smmu";
>> +		reg = <0x0 0xf4210000 0x0 0x1000>;
>> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&sys_ctrl HI6220_MMU_CLK>,
>> +		         <&media_ctrl HI6220_MED_MMU>,
>> +		         <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
>> +		clock-names = "smmu_clk",
>> +			      "media_sc_clk",
>> +			      "smmu_peri_clk";
>> +		#iommu-cells = <1>;
>> +	};
>> -- 
>> 1.9.1
>>
> 
> .
> 
