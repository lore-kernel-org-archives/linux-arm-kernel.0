From: k@japko.eu (Krzysztof Adamski)
Date: Tue, 2 Feb 2016 10:24:52 +0100
Subject: [PATCH] pinctrl: sunxi: Add H3 R_PIO controller support
In-Reply-To: <CAGb2v65-X2_MoRm1=wAub9Y8Vpt-f-roYUT73jDk5Fnj17zKTw@mail.gmail.com>
References: <20160201101225.GA19687@box2.japko.eu>
 <CAGb2v65-X2_MoRm1=wAub9Y8Vpt-f-roYUT73jDk5Fnj17zKTw@mail.gmail.com>
Message-ID: <20160202092451.GA26944@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 02:25:18PM +0800, Chen-Yu Tsai wrote:
>On Mon, Feb 1, 2016 at 6:12 PM, Krzysztof Adamski <k@japko.eu> wrote:
>> - reg: Should contain the register physical address and length for 
>> the
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
>> b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index 1524130e..745f64c 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -493,5 +493,17 @@
>>                         interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>>                                      <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>>                 };
>> +
>> +               r_pio: pinctrl at 01f02c00 {
>> +                       compatible = "allwinner,sun8i-h3-r-pinctrl";
>> +                       reg = <0x01f02c00 0x400>;
>> +                       interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&bus_gates 69>;
>
>This is probably wrong. According to other SoCs all R_ block peripherals
>have clock gates and reset controls in the PRCM.

This is problematic. I can find information about reset and gates control for
this peripheral on other SoCs user manuals but there is nothing about it in H3
User Manual
(https://www.dropbox.com/s/nkr9slo1o9x6i1z/Allwinner_H3_Datasheet_V1.1.pdf?dl=0).

Similarly, while I think I can find r_pio clock setup for A33:
https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw5.c

I can't find it for H3, though:
https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw7.c

Well, apart from this strange snippet:

// binder r-pio CPUS_APB0_GATE to pio-clk's gate-reset-register
    clk = clk_get(NULL,"pio");
    if(!clk || IS_ERR(clk))
        printk("Error not get clk pio\n");
    else
    {
        struct clk_hw *hw = __clk_get_hw(clk);
        struct sunxi_clk_periph *periph = to_clk_periph(hw);
        struct sunxi_clk_periph_gate *gate = &periph->gate;
        gate->reset = sunxi_clk_cpus_base+CPUS_APB0_GATE ;
        gate->rst_shift = 0;
        clk_put(clk);
    }


Which I have to admit I don't fully understand. This seems to be setting reset
line for first pio, not for r_pio - something we don't have right now. Or am I
wrong here?

I'm new to Allwinner SoCs, any help from veterans?

Also, if that proves anything, I did test this code on OrangePi PC and PL ports
works so their clock is enabled, for sure.

Best regards,
Krzysztof Adamski
