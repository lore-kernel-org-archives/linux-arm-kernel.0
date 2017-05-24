From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 13:36:53 +0800
Subject: [linux-sunxi] [RFC PATCH 10/11] ARM: sun8i: h3: add display
 engine pipeline for TVE
In-Reply-To: <CAGb2v64-3TYDgCBhGFNDqvoTa1ch=j3k__rnbB80dsFQn3JsKw@mail.gmail.com>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-11-icenowy@aosc.io>
 <CAGb2v64nVA=hHjXkVNMN68vQizMBE6vyYfaE895b0L6umv_Ycw@mail.gmail.com>
 <299627EE-8D9C-451A-9F74-0C5037D19DCC@aosc.io>
 <CAGb2v64-3TYDgCBhGFNDqvoTa1ch=j3k__rnbB80dsFQn3JsKw@mail.gmail.com>
Message-ID: <8358C867-68B8-43CB-A6FA-76A073B29958@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?24? GMT+08:00 ??1:34:58, Chen-Yu Tsai <wens@csie.org> ??:
>On Wed, May 24, 2017 at 1:28 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>>
>> ? 2017?5?24? GMT+08:00 ??1:24:29, Chen-Yu Tsai <wens@csie.org> ??:
>>>On Thu, May 18, 2017 at 12:43 AM, Icenowy Zheng <icenowy@aosc.io>
>>>wrote:
>>>> As we have already the support for the TV encoder on Allwinner H3,
>>>add
>>>> the display engine pipeline device tree nodes to its DTSI file.
>>>>
>>>> The H5 pipeline has some differences and will be enabled later.
>>>>
>>>> The currently-unused mixer0 and tcon0 are also needed, for the
>>>> completement of the pipeline.
>>>>
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>>  arch/arm/boot/dts/sun8i-h3.dtsi | 189
>>>++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 189 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>> index b36f9f423c39..20172ef92415 100644
>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>>>> @@ -41,6 +41,8 @@
>>>>   */
>>>>
>>>>  #include "sunxi-h3-h5.dtsi"
>>>> +#include <dt-bindings/clock/sun8i-de2.h>
>>>> +#include <dt-bindings/reset/sun8i-de2.h>
>>>>
>>>>  / {
>>>>         cpus {
>>>> @@ -72,6 +74,193 @@
>>>>                 };
>>>>         };
>>>>
>>>> +       de: display-engine {
>>>> +               compatible = "allwinner,sun8i-h3-display-engine";
>>>> +               allwinner,pipelines = <&mixer0>,
>>>> +                                     <&mixer1>;
>>>> +               status = "disabled";
>>>> +       };
>>>> +
>>>> +       soc {
>>>> +               display_clocks: clock at 1000000 {
>>>> +                       compatible =
>"allwinner,sun8i-a83t-de2-clk";
>>>> +                       reg = <0x01000000 0x100000>;
>>>> +                       clocks = <&ccu CLK_BUS_DE>,
>>>> +                                <&ccu CLK_DE>;
>>>> +                       clock-names = "bus",
>>>> +                                     "mod";
>>>> +                       resets = <&ccu RST_BUS_DE>;
>>>> +                       #clock-cells = <1>;
>>>> +                       #reset-cells = <1>;
>>>> +                       assigned-clocks = <&ccu CLK_DE>;
>>>> +                       assigned-clock-parents = <&ccu CLK_PLL_DE>;
>>>> +                       assigned-clock-rates = <432000000>;
>>>> +               };
>>>> +
>>>> +               mixer0: mixer at 1100000 {
>>>> +                       compatible =
>"allwinner,sun8i-h3-de2-mixer0";
>>>> +                       reg = <0x01100000 0x100000>;
>>>> +                       clocks = <&display_clocks CLK_BUS_MIXER0>,
>>>> +                                <&display_clocks CLK_MIXER0>;
>>>> +                       clock-names = "bus",
>>>> +                                     "mod";
>>>> +                       resets = <&display_clocks RST_MIXER0>;
>>>> +                       status = "disabled";
>>>> +
>>>> +                       ports {
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +
>>>> +                               mixer0_out: port at 1 {
>>>> +                                       #address-cells = <1>;
>>>> +                                       #size-cells = <0>;
>>>> +                                       reg = <1>;
>>>> +
>>>> +                                       mixer0_out_tcon0:
>endpoint at 0
>>>{
>>>> +                                               reg = <0>;
>>>> +                                               remote-endpoint =
>>><&tcon0_in_mixer0>;
>>>> +                                       };
>>>> +
>>>> +                                       mixer0_out_tcon1:
>endpoint at 1
>>>{
>>>> +                                               reg = <1>;
>>>> +                                               remote-endpoint =
>>><&tcon1_in_mixer0>;
>>>> +                                       };
>>>> +                               };
>>>> +                       };
>>>> +               };
>>>> +
>>>> +               mixer1: mixer at 1200000 {
>>>> +                       compatible =
>"allwinner,sun8i-h3-de2-mixer1";
>>>> +                       reg = <0x01200000 0x100000>;
>>>> +                       clocks = <&display_clocks CLK_BUS_MIXER1>,
>>>> +                                <&display_clocks CLK_MIXER1>;
>>>> +                       clock-names = "bus",
>>>> +                                     "mod";
>>>> +                       resets = <&display_clocks RST_WB>;
>>>> +
>>>> +                       ports {
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +
>>>> +                               mixer1_out: port at 1 {
>>>> +                                       #address-cells = <1>;
>>>> +                                       #size-cells = <0>;
>>>> +                                       reg = <1>;
>>>> +
>>>> +                                       mixer1_out_tcon1:
>endpoint at 0
>>>{
>>>> +                                               reg = <0>;
>>>
>>>I would prefer if you could stick to the numbering scheme we're using
>>>for
>>>Display Engine 1.0, as in endpoint 0 links to component 0 of whatever
>>>type.
>>
>> If we keep this we will need a ugly id property in mixer node,
>> otherwise we cannot know which TCON to be bind.
>
>Why? You can simply change the logic in your driver from:
>
>    if (remote_endpoint.id) { continue; }
>
>to:
>
>    if (local_endpoint.id != remote_endpoint.id) { continue; }

Thanks, I forgot that there's two endpoint ids...

So silly I am.

>
>I don't see the need for any ID property in the mixer node in this
>case.
>The ID is already encoded into the endpoint IDs.
>
>ChenYu
>
>>>
>>>We're probably going to stick to that for the R40's incredibly
>>>complicated
>>>pipeline. I don't want to have any outliers unless absolutely
>>>necessary.
>>>
>>>ChenYu
>>>
>>>> +                                               remote-endpoint =
>>><&tcon1_in_mixer1>;
>>>> +                                       };
>>>> +
>>>> +                                       mixer1_out_tcon0:
>endpoint at 1
>>>{
>>>> +                                               reg = <1>;
>>>> +                                               remote-endpoint =
>>><&tcon0_in_mixer1>;
>>>> +                                       };
>>>> +                               };
>>>> +                       };
>>>> +               };
>>>> +
>>>> +               tcon0: lcd-controller at 1c0c000 {
>>>> +                       compatible = "allwinner,sun8i-h3-tcon0";
>>>> +                       reg = <0x01c0c000 0x1000>;
>>>> +                       interrupts = <GIC_SPI 86
>>>IRQ_TYPE_LEVEL_HIGH>;
>>>> +                       clocks = <&ccu CLK_BUS_TCON0>,
>>>> +                                <&ccu CLK_TCON0>;
>>>> +                       clock-names = "ahb",
>>>> +                                     "tcon-ch1";
>>>> +                       resets = <&ccu RST_BUS_TCON0>;
>>>> +                       reset-names = "lcd";
>>>> +                       status = "disabled";
>>>> +
>>>> +                       ports {
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +
>>>> +                               tcon0_in: port at 0 {
>>>> +                                       #address-cells = <1>;
>>>> +                                       #size-cells = <0>;
>>>> +                                       reg = <0>;
>>>> +
>>>> +                                       tcon0_in_mixer0: endpoint at 0
>{
>>>> +                                               reg = <0>;
>>>> +                                               remote-endpoint =
>>><&mixer0_out_tcon0>;
>>>> +                                       };
>>>> +
>>>> +                                       tcon0_in_mixer1: endpoint at 1
>{
>>>> +                                               reg = <1>;
>>>> +                                               remote-endpoint =
>>><&mixer1_out_tcon0>;
>>>> +                                       };
>>>> +                               };
>>>> +                       };
>>>> +               };
>>>> +
>>>> +               tcon1: lcd-controller at 1c0d000 {
>>>> +                       compatible = "allwinner,sun8i-h3-tcon1";
>>>> +                       reg = <0x01c0d000 0x1000>;
>>>> +                       interrupts = <GIC_SPI 87
>>>IRQ_TYPE_LEVEL_HIGH>;
>>>> +                       clocks = <&ccu CLK_BUS_TCON1>;
>>>> +                       clock-names = "ahb";
>>>> +                       resets = <&ccu RST_BUS_TCON1>;
>>>> +                       reset-names = "lcd";
>>>> +                       status = "disabled";
>>>> +
>>>> +                       ports {
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +
>>>> +                               tcon1_in: port at 0 {
>>>> +                                       #address-cells = <1>;
>>>> +                                       #size-cells = <0>;
>>>> +                                       reg = <0>;
>>>> +
>>>> +                                       tcon1_in_mixer1: endpoint at 0
>{
>>>> +                                               reg = <0>;
>>>> +                                               remote-endpoint =
>>><&mixer1_out_tcon1>;
>>>> +                                       };
>>>> +
>>>> +                                       tcon1_in_mixer0: endpoint at 1
>{
>>>> +                                               reg = <1>;
>>>> +                                               remote-endpoint =
>>><&mixer0_out_tcon1>;
>>>> +                                       };
>>>> +                               };
>>>> +
>>>> +                               tcon1_out: port at 1 {
>>>> +                                       #address-cells = <1>;
>>>> +                                       #size-cells = <0>;
>>>> +                                       reg = <1>;
>>>> +
>>>> +                                       tcon1_out_tve0: endpoint at 1
>{
>>>> +                                               reg = <1>;
>>>> +                                               remote-endpoint =
>>><&tve0_in_tcon1>;
>>>> +                                       };
>>>> +                               };
>>>> +                       };
>>>> +               };
>>>> +
>>>> +               tve0: tv-encoder at 1e00000 {
>>>> +                       compatible =
>"allwinner,sun8i-h3-tv-encoder";
>>>> +                       reg = <0x01e00000 0x1000>;
>>>> +                       clocks = <&ccu CLK_BUS_TVE>, <&ccu
>CLK_TVE>;
>>>> +                       clock-names = "bus", "mod";
>>>> +                       resets = <&ccu RST_BUS_TVE>;
>>>> +                       status = "disabled";
>>>> +
>>>> +                       assigned-clocks = <&ccu CLK_TVE>;
>>>> +                       assigned-clock-parents = <&ccu CLK_PLL_DE>;
>>>> +                       assigned-clock-rates = <216000000>;
>>>> +
>>>> +                       port {
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +
>>>> +                               tve0_in_tcon1: endpoint at 0 {
>>>> +                                       reg = <0>;
>>>> +                                       remote-endpoint =
>>><&tcon1_out_tve0>;
>>>> +                               };
>>>> +                       };
>>>> +               };
>>>> +       };
>>>> +
>>>>         timer {
>>>>                 compatible = "arm,armv7-timer";
>>>>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>>>IRQ_TYPE_LEVEL_LOW)>,
>>>> --
>>>> 2.12.2
>>>>
>>>> --
>>>> You received this message because you are subscribed to the Google
>>>Groups "linux-sunxi" group.
>>>> To unsubscribe from this group and stop receiving emails from it,
>>>send an email to linux-sunxi+unsubscribe at googlegroups.com.
>>>> For more options, visit https://groups.google.com/d/optout.
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
