From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 15 Aug 2018 01:09:43 +0530
Subject: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
In-Reply-To: <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org>
 <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
Message-ID: <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Jordan here.

On Tue, Aug 14, 2018 at 4:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Vivek,
>
> On 14/08/18 11:27, Vivek Gautam wrote:
>>
>> Add device node for qcom,smmu-v2 available on sdm845.
>> This smmu is available only to GPU device.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 1c2be2082f33..bd1ec5fa5146 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -6,6 +6,7 @@
>>    */
>>     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> @@ -989,6 +990,28 @@
>>                         cell-index = <0>;
>>                 };
>>   +             gpu_smmu: iommu at 5040000 {
>> +                       compatible = "qcom,sdm845-smmu-v2",
>> "qcom,smmu-v2";
>
>
> Which of "sdm845" or "msm8996"[1] is the actual SoC name here?

Well, the bindings use the SoC prefix with smmu-v2, so it should be
sdm845 for this SoC. This is same as I posted in my v1 of the series [2].
Using 8996 based string in sdm845 makes things look awful.

Thanks
Vivek

[2] https://patchwork.kernel.org/patch/10534989/

>
> Robin.
>
> [1]
> https://www.mail-archive.com/freedreno at lists.freedesktop.org/msg02659.html
>
>> +                       reg = <0x5040000 0x10000>;
>> +                       #iommu-cells = <1>;
>> +                       #global-interrupts = <2>;
>> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
>> +                                    <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
>> +                       clock-names = "bus", "iface";
>> +                       clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +                                <&gcc GCC_GPU_CFG_AHB_CLK>;
>> +
>> +                       /*power-domains = <&gpucc GPU_CX_GDSC>;*/
>> +               };
>> +
>>                 apps_smmu: iommu at 15000000 {
>>                         compatible = "qcom,sdm845-smmu-500",
>> "arm,mmu-500";
>>                         reg = <0x15000000 0x80000>;
>>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
