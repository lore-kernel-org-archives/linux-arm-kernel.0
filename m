From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 31 Aug 2017 11:49:37 +0100
Subject: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
In-Reply-To: <AM5PR0401MB2545B7C55F634D7B9CABAE629A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1504171424-15536-1-git-send-email-Bharat.Bhushan@nxp.com>
 <06c57ca4-edaa-df26-b1d9-1906141c5065@arm.com>
 <AM5PR0401MB2545B7C55F634D7B9CABAE629A9D0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Message-ID: <10be1849-8071-64fc-5ee2-b6e429c64b9e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Fixing Mark's address...]

On 31/08/17 11:41, Bharat Bhushan wrote:
> 
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>> Sent: Thursday, August 31, 2017 3:02 PM
>> To: Bharat Bhushan <bharat.bhushan@nxp.com>; robh+dt at kernel.org;
>> ark.rutland at arm.com; will.deacon at arm.com; oss at buserror.net; Gang Liu
>> <gang.liu@nxp.com>; devicetree at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> catalin.marinas at arm.com
>> Subject: Re: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
>>
>> On 31/08/17 10:23, Bharat Bhushan wrote:
>>> This patch adds iommu-map property for PCIe, which enables SMMU for
>>> these devices on LS208xA devices.
>>>
>>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
>>> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
>>> index 94cdd30..67cf605 100644
>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
>>> @@ -606,6 +606,7 @@
>>>  			num-lanes = <4>;
>>>  			bus-range = <0x0 0xff>;
>>>  			msi-parent = <&its>;
>>> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by
>> u-boot */
>>
>> What does this do when your version of u-boot doesn't fill this in for you?
> 
> Good question, frankly I have not thought of this case before.
> But if we pass length = 0 in above property then no fixup happen with
> happen with older u-boot. In this case of_iommu_configure() will
> return NULL iommu-ops and it switch to swio-tlb. Will that work?
I really don't like this. You rely on having invalid data in the DT, and
that seems just wrong.

Why can't u-boot just generate that property, and we leave the DT alone?
Or even better, you provide the right information for the few boards
that are based on this SoC, not relying on u-boot for anything that is
in the kernel tree?

Thanks,
	
M.
-- 
Jazz is not dead. It just smells funny...
