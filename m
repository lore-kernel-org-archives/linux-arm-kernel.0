From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 16 Oct 2013 10:09:31 +0800
Subject: [PATCH v10 3/7] ARM: dts: enable hi4511 with device tree
In-Reply-To: <201310152018.10908.arnd@arndb.de>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <1381828577-27998-4-git-send-email-haojian.zhuang@linaro.org>
 <201310152018.10908.arnd@arndb.de>
Message-ID: <CAD6h2NTb8-8nSuaa6eQNYBFk3gv94TptZbX7xmz8WKFfCXZ5fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2013 02:18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 October 2013, Haojian Zhuang wrote:
>> Enable Hisilicon Hi4511 development platform with device tree support.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Based on my other mail, some more comments here:
>
>> +/ {
>> +     clocks {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>
> Since all clocks are in the fc802000 page, I would prefer using a non-empty
> ranges to map the clocks into their own address space, like
>
>                 ranges = <0 0xfc802000 0x1000>;
>
>
OK.

>> +             timer4_mux: timer4_mux at fc802018 {
>> +                     compatible = "hisilicon,clk-mux";
>> +                     #clock-cells = <0>;
>> +                     clocks = <&osc32k &timerclk45>;
>> +                     clock-output-names = "timer4_mux";
>> +                     reg = <0xfc802018 0x4>;
>> +                     clkmux-mask = <0x3>;
>> +                     clkmux-table = <0 0x1>;
>> +             };
>
> which would turn this into
>
>                 timer4_mux: timer4_mux at 18 {
>                         ...
>                         reg = <0x18 0x4>;
>                         ...
>                 };
>
> The code would not be impacted by this.
>
> On a related note, I find it strange that you have multiple devices with the
> same register. Normally, we try to have device node names be generic,
> e.g. 'clock at 18' rather than 'timer4_mux at 18', but that won't work if the
> register is the same for all of them. Maybe some DT expert can comment
> on this.
>
Because multiple clock nodes (clock mux/clock gate/clock divider) are
sharing the same register. I think that it's common on ARM SoC. At
least, I can find this in both Hisilicon & Marvell PXA/MMP SoC.

If I force to merge multiple clock nodes into the same device node,
it'll become mess. Different clock nodes have different properties.
The property won't work any more if they are merged into the same
device node.

>> +
>> +     amba {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             compatible = "arm,amba-bus";
>> +             interrupt-parent = <&gic>;
>> +             ranges;
>> +
>> +             L2: l2-cache {
>> +                     compatible = "arm,pl310-cache";
>> +                     reg = <0xfc10000 0x100000>;
>> +                     interrupts = <0 15 4>;
>> +                     cache-unified;
>> +                     cache-level = <2>;
>> +             };
>
> For this node, we could use the same trick with the non-empty ranges, since
> all amba devices seem to be in the 0xfc000000 range.
>
OK.

> If you do that, it probably makes sense to move the clock controller under here
> as well.
Could I keep them into hi3620-clk.dtsi? Since both hi3620.dtsi &
hi3620-clk.dtsi are not small, merge them together only make people
reading hard.

>
>         Arnd

Best Regards
Haojian
