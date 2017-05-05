From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 05 May 2017 16:53:43 +0800
Subject: [linux-sunxi] [PATCH v6 11/13] ARM: dts: sun8i: add DE2 nodes for
 V3s SoC
In-Reply-To: <CAGb2v67uE2iuP+wrL2t0fSMY8C1qnX=pYru7pZGX+0WhC_z2EA@mail.gmail.com>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-12-icenowy@aosc.io>
 <CAGb2v67uE2iuP+wrL2t0fSMY8C1qnX=pYru7pZGX+0WhC_z2EA@mail.gmail.com>
Message-ID: <8ad5de02ffc13348dfc71e9ec203205c@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-05 11:31?Chen-Yu Tsai ???
> On Thu, May 4, 2017 at 7:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner V3s SoC features a "Display Engine 2.0" with only one TCON
>> which have RGB LCD output.
> 
> Please also mention that it only has one mixer.
> 
> For the subject, you could just say "Add device nodes for the display 
> pipeline".
> 
>> 
>> Add device nodes for it as well as the TCON.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sun8i-v3s.dtsi | 87 
>> ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi 
>> b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> index 71075969e5e6..0a895179d8ae 100644
>> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> @@ -41,6 +41,10 @@
>>   */
>> 
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/sun8i-v3s-ccu.h>
>> +#include <dt-bindings/clock/sun8i-de2.h>
>> +#include <dt-bindings/reset/sun8i-v3s-ccu.h>
>> +#include <dt-bindings/reset/sun8i-de2.h>
>> 
>>  / {
>>         #address-cells = <1>;
>> @@ -59,6 +63,12 @@
>>                 };
>>         };
>> 
>> +       de: display-engine {
>> +               compatible = "allwinner,sun8i-v3s-display-engine";
>> +               allwinner,pipelines = <&de2_mixer0>;
>> +               status = "disabled";
>> +       };
>> +
>>         timer {
>>                 compatible = "arm,armv7-timer";
>>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> @@ -93,6 +103,83 @@
>>                 #size-cells = <1>;
>>                 ranges;
>> 
>> +               de2_clocks: clock at 1000000 {
>> +                       compatible = "allwinner,sun50i-h5-de2-clk";
> 
> I am a bit skeptical about this. Since the V3S only has one mixer, do 
> the clocks
> for the second one even exist?

It's described in the de_clock.c in the BSP source code, and in hardware
these bits can be really set (although without clock output).

So I use this compatible which has still the extra clocks.

> 
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
>> +               de2_mixer0: mixer at 1100000 {
>> +                       compatible = "allwinner,sun8i-v3s-de2-mixer";
>> +                       reg = <0x01100000 0x100000>;
>> +                       clocks = <&de2_clocks CLK_MIXER0>,
>> +                                <&de2_clocks CLK_BUS_MIXER0>;
>> +                       clock-names = "mod",
>> +                                     "bus";
> 
> Nit: could you list the bus clock first?
> 
> Regards
> ChenYu
> 
>> +                       resets = <&de2_clocks RST_MIXER0>;
>> +                       assigned-clocks = <&de2_clocks CLK_MIXER0>;
>> +                       assigned-clock-rates = <150000000>;
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               mixer0_out: port at 1 {
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
>> +                                       reg = <1>;
>> +
>> +                                       mixer0_out_tcon0: endpoint at 0 {
>> +                                               reg = <0>;
>> +                                               remote-endpoint = 
>> <&tcon0_in_mixer0>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +
>> +               tcon0: lcd-controller at 1c0c000 {
>> +                       compatible = "allwinner,sun8i-v3s-tcon";
>> +                       reg = <0x01c0c000 0x1000>;
>> +                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&ccu CLK_BUS_TCON0>,
>> +                                <&ccu CLK_TCON0>;
>> +                       clock-names = "ahb",
>> +                                     "tcon-ch0";
>> +                       clock-output-names = "tcon-pixel-clock";
>> +                       resets = <&ccu RST_BUS_TCON0>;
>> +                       reset-names = "lcd";
>> +                       status = "disabled";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               tcon0_in: port at 0 {
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
>> +                                       reg = <0>;
>> +
>> +                                       tcon0_in_mixer0: endpoint at 0 {
>> +                                               reg = <0>;
>> +                                               remote-endpoint = 
>> <&mixer0_out_tcon0>;
>> +                                       };
>> +                               };
>> +
>> +                               tcon0_out: port at 1 {
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
>> +                                       reg = <1>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +
>>                 mmc0: mmc at 01c0f000 {
>>                         compatible = "allwinner,sun7i-a20-mmc";
>>                         reg = <0x01c0f000 0x1000>;
>> --
>> 2.12.2
>> 
>> --
>> You received this message because you are subscribed to the Google 
>> Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send 
>> an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
