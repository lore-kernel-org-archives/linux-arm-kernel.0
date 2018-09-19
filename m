From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 19 Sep 2018 14:06:53 +0000
Subject: [PATCH 18/21] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
In-Reply-To: <fe2af486-3d7d-a38f-ef62-6754f809298f@arm.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-19-laurentiu.tudor@nxp.com>
 <fe2af486-3d7d-a38f-ef62-6754f809298f@arm.com>
Message-ID: <a4324a5b-abeb-f43a-cac3-7721577e183d@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 19.09.2018 16:41, Robin Murphy wrote:
> On 19/09/18 13:36, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> The StreamID entering the SMMU is actually a concatenation of the
>> SMMU TBU ID and the ICID configured in software.
>> Since the TBU ID is internal to the SoC and since we want that the
>> actual the ICID configured in software to enter the SMMU witout any
>> additional set bits, mask out the TBU ID bits and leave only the
>> relevant ICID bits to enter SMMU.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>> ? arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>> ? arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>> ? 2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi 
>> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
>> index 8b3eba167508..90296b9fb171 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
>> @@ -226,6 +226,7 @@
>> ????????????? compatible = "arm,mmu-500";
>> ????????????? reg = <0 0x9000000 0 0x400000>;
>> ????????????? dma-coherent;
>> +??????????? stream-match-mask = <0x7f00>;
> 
> The TBU ID only forms the top 5 bits, so also ignoring bits 9:8 raises 
> an eyebrow - if the LS104x SMMU really is configured for 8-bit SID input 
> then it's harmless, 

On these lower-end platforms the SID input is configured and documented 
as 8-bit.

> but if it's actually a 9 or 10-bit configuration 
> then you probably want to avoid masking them (or at least document why) 
> - IIRC there *was* stuff wired there on LS2085 at least.

Yes, on LS2s there are 2 extra-bits in there carrying some signaling. 
However, on LS1s they are not present.

---
Thanks & Best Regards, Laurentiu

> 
>> ????????????? #global-interrupts = <2>;
>> ????????????? #iommu-cells = <1>;
>> ????????????? interrupts = <0 142 4>, /* global secure fault */
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi 
>> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> index 06863d3e4a7d..15094dd8400e 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> @@ -232,6 +232,7 @@
>> ????????????? compatible = "arm,mmu-500";
>> ????????????? reg = <0 0x9000000 0 0x400000>;
>> ????????????? dma-coherent;
>> +??????????? stream-match-mask = <0x7f00>;
>> ????????????? #global-interrupts = <2>;
>> ????????????? #iommu-cells = <1>;
>> ????????????? interrupts = <0 142 4>, /* global secure fault */
>>
