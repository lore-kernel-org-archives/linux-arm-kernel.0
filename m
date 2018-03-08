From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Mar 2018 08:36:22 +0100
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
In-Reply-To: <5AA0DD39.3040108@samsung.com>
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
 <20180307171111.14551-1-s.nawrocki@samsung.com>
 <5AA0B59F.3070402@samsung.com>
 <3c68c3da-a0c3-4e4e-da6b-3e4b1af6d19d@samsung.com>
 <5AA0DD39.3040108@samsung.com>
Message-ID: <9f1e8619-974d-cd07-79c3-c6d9a4dc0f97@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

On 2018-03-08 07:50, Inki Dae wrote:
> 2018? 03? 08? 15:29? Marek Szyprowski ?(?) ? ?:
>> On 2018-03-08 05:01, Inki Dae wrote:
>>> 2018? 03? 08? 02:11? Sylwester Nawrocki ?(?) ? ?:
>>>> The #sound-dai-cells DT property is required to describe link between
>>>> the HDMI IP block and the SoC's audio subsystem.
>>>>
>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
>>>> index 8715ff06c457..6b2a526ec586 100644
>>>> --- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
>>>> +++ b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
>>>> @@ -50,6 +50,9 @@ Required properties for Exynos 5433:
>>>>    - clock-names: aliases for above clock specfiers.
>>>>    - samsung,sysreg: handle to syscon used to control the system registers.
>>>>    +Optional properties for Exynos 4210, 4212, 5420 and 5433:
>>>> + - #sound-dai-cells: should be 0.
>>>> +
>>> Just trivial question. 'sound-dai-cells' property could affect hdmi driver? I looked into HDMI codec driver but I didn't find relevat code.
>>> I mean that if this property never affect HDMI driver then this property would be a dead thing even through this can be declared optionally.
>> This property is used by ASoC framework when it is building connections
>> between all elements of the virtual 'sound card'. It allows generic
>> code to find proper driver for the digital audio interface (DAI) object.
> I also assumed that some place of ASoC framework checks this property. For this I looked into HDMI codec driver(sound/soc/codecs/hdmi-codec.c) and relevant interfaces of ASoC framework.
> But I couldn't find it. :( Could you let me know which code of ASoC framework checks this? I saw this property only in 'snd_soc_of_get_dai_name' and 'snd_soc_of_get_dai_link_codecs' functions but seems these functions aren't called by the HDMI codec driver.

It is used by snd_soc_of_get_dai_link_codecs() function, which is called
from respective board/machine driver. See sound/soc/samsung/odroid.c for
good example. It allows to automatically create connection to max98090 and
hdmi codec devices, which are specified in 'sound/codec' node (see
exynos5422-odroidxu3-audio.dtsi).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
