From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Jan 2017 15:54:20 +0100
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <577A1794.5040509@gmail.com>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <09eaf7a5-2b18-1ea6-5699-2e968c6b79a4@gmail.com>
 <51441f39-e5b5-2cce-63ab-47bd3cf298b3@gmail.com>
 <1467595950.8420.2.camel@mtksdaap41> <577A1794.5040509@gmail.com>
Message-ID: <5a45da57-9262-b1ff-1c6a-c5c211c1bfd4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/07/16 10:00, Matthias Brugger wrote:
>
>
> On 04/07/16 03:32, Honghui Zhang wrote:
>> On Sun, 2016-07-03 at 21:12 +0200, Matthias Brugger wrote:
>>>
>>> On 07/03/2016 08:24 AM, Matthias Brugger wrote:
>>>>
>>>>
>>>> On 06/08/2016 11:51 AM, honghui.zhang at mediatek.com wrote:
>>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
>>>>>
>>>>> Add the dtsi node of iommu and smi for mt2701.
>>>>>
>>>>> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
>>>>> ---
>>>>>   arch/arm/boot/dts/mt2701.dtsi | 51
>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 51 insertions(+)
>>>>>
>>>>
>>>> Applied,
>>>
>>> Please resend the patch including the infracfg and mmsys node.
>>>
>>
>> Hi, Matthias,
>>
>> Please hold this one.
>> This one is based on CCF "arm: dts: mt2701: Add clock controller device
>> nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
>> support v7"[2],
>> But these two patchset are still being reviewed now.
>>
>> Do you think it's better that I send this one later after ccf and power
>> domain patch got merged? I will send this patch later if it's OK with
>> you.
>>
>
> Sounds good.

Applied now to v4.10-next/dts32

Thanks.

>
> Thanks a lot,
> Matthias
>
>> Thanks.
>> [1] https://patchwork.kernel.org/patch/9109081
>> [2]
>> http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html
>>
>>> Regards,
>>> Matthias
>>>
>>>>
>>>> Thanks.
>>>>
>>>>> diff --git a/arch/arm/boot/dts/mt2701.dtsi
>>>>> b/arch/arm/boot/dts/mt2701.dtsi
>>>>> index 42d5a37..363de0d 100644
>>>>> --- a/arch/arm/boot/dts/mt2701.dtsi
>>>>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>>>>> @@ -16,6 +16,7 @@
>>>>>   #include <dt-bindings/power/mt2701-power.h>
>>>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/memory/mt2701-larb-port.h>
>>>>>   #include "skeleton64.dtsi"
>>>>>   #include "mt2701-pinfunc.h"
>>>>>
>>>>> @@ -160,6 +161,16 @@
>>>>>           clock-names = "system-clk", "rtc-clk";
>>>>>       };
>>>>>
>>>>> +    smi_common: smi at 1000c000 {
>>>>> +        compatible = "mediatek,mt2701-smi-common";
>>>>> +        reg = <0 0x1000c000 0 0x1000>;
>>>>> +        clocks = <&infracfg CLK_INFRA_SMI>,
>>>>> +             <&mmsys CLK_MM_SMI_COMMON>,
>>>>> +             <&infracfg CLK_INFRA_SMI>;
>>>>> +        clock-names = "apb", "smi", "async";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>>>>> +    };
>>>>> +
>>>>>       sysirq: interrupt-controller at 10200100 {
>>>>>           compatible = "mediatek,mt2701-sysirq",
>>>>>                    "mediatek,mt6577-sysirq";
>>>>> @@ -169,6 +180,16 @@
>>>>>           reg = <0 0x10200100 0 0x1c>;
>>>>>       };
>>>>>
>>>>> +    iommu: mmsys_iommu at 10205000 {
>>>>> +        compatible = "mediatek,mt2701-m4u";
>>>>> +        reg = <0 0x10205000 0 0x1000>;
>>>>> +        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
>>>>> +        clocks = <&infracfg CLK_INFRA_M4U>;
>>>>> +        clock-names = "bclk";
>>>>> +        mediatek,larbs = <&larb0 &larb1 &larb2>;
>>>>> +        #iommu-cells = <1>;
>>>>> +    };
>>>>> +
>>>>>       apmixedsys: syscon at 10209000 {
>>>>>           compatible = "mediatek,mt2701-apmixedsys", "syscon";
>>>>>           reg = <0 0x10209000 0 0x1000>;
>>>>> @@ -234,6 +255,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb0: larb at 14010000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x14010000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&mmsys CLK_MM_SMI_LARB0>,
>>>>> +             <&mmsys CLK_MM_SMI_LARB0>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>>>>> +    };
>>>>> +
>>>>>       imgsys: syscon at 15000000 {
>>>>>           compatible = "mediatek,mt2701-imgsys", "syscon";
>>>>>           reg = <0 0x15000000 0 0x1000>;
>>>>> @@ -241,6 +272,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb2: larb at 15001000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x15001000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&imgsys CLK_IMG_SMI_COMM>,
>>>>> +             <&imgsys CLK_IMG_SMI_COMM>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
>>>>> +    };
>>>>> +
>>>>>       vdecsys: syscon at 16000000 {
>>>>>           compatible = "mediatek,mt2701-vdecsys", "syscon";
>>>>>           reg = <0 0x16000000 0 0x1000>;
>>>>> @@ -248,6 +289,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb1: larb at 16010000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x16010000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&vdecsys CLK_VDEC_CKGEN>,
>>>>> +             <&vdecsys CLK_VDEC_LARB>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
>>>>> +    };
>>>>> +
>>>>>       hifsys: syscon at 1a000000 {
>>>>>           compatible = "mediatek,mt2701-hifsys", "syscon";
>>>>>           reg = <0 0x1a000000 0 0x1000>;
>>>>>
>>
>>
