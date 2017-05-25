From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 25 May 2017 21:54:53 +0800
Subject: [linux-sunxi] [PATCH 1/2] ARM: sun8i: v3s: add device nodes for
 DE2 display pipeline
In-Reply-To: <CAGb2v65bZ+VJYwcP24ipQ+4kuY28Babt-Cpm7uscjmWpcoeJ9g@mail.gmail.com>
References: <20170524111724.28431-1-icenowy@aosc.io>
 <CAGb2v65bZ+VJYwcP24ipQ+4kuY28Babt-Cpm7uscjmWpcoeJ9g@mail.gmail.com>
Message-ID: <5FF9B3F8-01F6-4B17-958C-9A4245199716@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?25? GMT+08:00 ??4:37:31, Chen-Yu Tsai <wens@csie.org> ??:
>On Wed, May 24, 2017 at 7:17 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner V3s SoC features a "Display Engine 2.0" with only one mixer
>> and only one TCON connected to this mixer, which have RGB LCD output.
>>
>> Add device nodes for this display pipeline.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sun8i-v3s.dtsi | 83
>++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
>b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> index a49ebef53c91..3a06dc5b3746 100644
>> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> @@ -61,6 +61,12 @@
>>                 };
>>         };
>>
>> +       de: display-engine {
>> +               compatible = "allwinner,sun8i-v3s-display-engine";
>> +               allwinner,pipelines = <&mixer0>;
>> +               status = "disabled";
>> +       };
>> +
>>         timer {
>>                 compatible = "arm,armv7-timer";
>>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>IRQ_TYPE_LEVEL_LOW)>,
>> @@ -95,6 +101,83 @@
>>                 #size-cells = <1>;
>>                 ranges;
>>
>> +               display_clocks: clock at 1000000 {
>> +                       compatible = "allwinner,sun8i-v3s-de2-clk";
>> +                       reg = <0x01000000 0x100000>;
>> +                       clocks = <&ccu CLK_DE>,
>> +                                <&ccu CLK_BUS_DE>;
>> +                       clock-names = "mod",
>> +                                     "bus";
>> +                       resets = <&ccu RST_BUS_DE>;
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +               };
>> +
>> +               mixer0: mixer at 1100000 {
>
>Since there's only one, can you drop the numbering suffix?
>Same with the TCON.

I just want to keep the consistency with dual-pipeline SoCs. (H3, A64, H5, etc)

However, if dropping it is better, I will drop it -- I think usually for things
that is available for multiple on some SoCs and single on others,
we keep the 0 in node name...

>
>> +                       compatible = "allwinner,sun8i-v3s-de2-mixer";
>> +                       reg = <0x01100000 0x100000>;
>
>The display engine also has an interrupt. Please list it

It's a overall interrupt for DE2, not mixer interrupt.

I will add it after we have proper interrupt chaining facility for DE2.

It cannot fit here in mixer node.

>
>ChenYu
