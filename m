From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 07 Jul 2018 11:37:52 +0800
Subject: [linux-sunxi] [PATCH v2 8/9] arm64: allwinner: dts: h6: add USB3
 device nodes
In-Reply-To: <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
References: <20180706153805.25842-1-icenowy@aosc.io>
 <20180706153805.25842-9-icenowy@aosc.io>
 <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
Message-ID: <76682488-74B8-4CEE-ACD5-29C667C438AE@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?7? GMT+08:00 ??11:35:22, Chen-Yu Tsai <wens@csie.org> ??:
>On Fri, Jul 6, 2018 at 11:38 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner H6 SoC features USB3 functionality, with a DWC3 controller
>and
>> a custom PHY.
>>
>> Add device tree nodes for them.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Rebased on top of the USB2 support patch.
>> - Dropped the dwc3-of-simple device.
>>
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24
>++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index 62fc0f5e10ba..6738e97ee37f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -229,6 +229,30 @@
>>                         status = "disabled";
>>                 };
>>
>> +               dwc3: dwc3 {
>> +                       compatible = "snps,dwc3";
>> +                       reg = <0x5200000 0x10000>;
>> +                       interrupts = <GIC_SPI 26
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       /* The only clock is shared. */
>> +                       clocks = <&ccu CLK_BUS_XHCI>,
>> +                                <&ccu CLK_BUS_XHCI>,
>> +                                <&ccu CLK_BUS_XHCI>;
>> +                       clock-names = "ref", "bus_early", "suspend";
>
>The diagram in the user manual also shows the low speed 32k oscillator
>being fed into DWC3. Maybe someone with more knowledge of what the IP
>block expects can give us a clue about which one of these it is.

If possible, I think it's suspend clock.

I have checked RK3399 clk tree and USB3 ref is just a gate
on 24M osc, and bus clock is surely CLK_BUS_XHCI.

>
>ChenYu
>
>> +                       resets = <&ccu RST_BUS_XHCI>;
>> +                       /*
>> +                        * The datasheet of the chip doesn't declare
>the
>> +                        * peripheral function, and there's no boards
>known
>> +                        * to have a USB Type-B port routed to the
>port.
>> +                        * In addition, no one has tested the
>peripheral
>> +                        * function yet.
>> +                        * So set the dr_mode to "host" in the DTSI
>file.
>> +                        */
>> +                       dr_mode = "host";
>> +                       phys = <&usb3phy>;
>> +                       phy-names = "usb3-phy";
>> +                       status = "disabled";
>> +               };
>> +
>>                 usb3phy: phy at 5210000 {
>>                         compatible = "allwinner,sun50i-h6-usb3-phy";
>>                         reg = <0x5210000 0x10000>;
>> --
>> 2.17.1
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
