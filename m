From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 24 Aug 2013 12:13:07 +0800
Subject: [PATCH v7 02/11] clk: hi3xxx: add clock support
In-Reply-To: <20130821212946.8231.30933@quantum>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-3-git-send-email-haojian.zhuang@linaro.org>
 <20130821212946.8231.30933@quantum>
Message-ID: <CAD6h2NQ4-1e1U8_y+JrC4g3f2we=6fvyNekETKYDdTxG4bMsEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 August 2013 05:29, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Haojian Zhuang (2013-08-19 19:31:04)
>> Add clock support with device tree on Hisilicon SoC.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> ---
>>  .../devicetree/bindings/clock/hisilicon.txt        | 118 +++++++++
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/clk-hi3xxx.c                           | 272 +++++++++++++++++++++
>>  3 files changed, 391 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
>>  create mode 100644 drivers/clk/clk-hi3xxx.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
>> new file mode 100644
>> index 0000000..e8ee618
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
>> @@ -0,0 +1,118 @@
>> +Device Tree Clock bindings for arch-hi3xxx
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +All the mux, gate & divider are in clock container of DTS file.
>> +
>> +Required properties for mux clocks:
>> + - compatible : shall be "hisilicon,clk-mux".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +       be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - reg : the mux register address. It should be the offset of the container.
>> + - clkmux-mask : mask bits of the mux register.
>> + - clkmux-table : array of mux select bits.
>> +
>> +Optional properties for mux clocks:
>> + - clkmux-hiword-mask : indicates that the bit[31:16] are the hiword mask
>> +       of mux selected bits (bit[15:0]). The bit[15:0] is valid only when
>> +       bit[31:16] is set.
>
> Instead of putting this as a flag I'm tempted to say this should be a
> separate compatible string. Any thoughts from the DT experts?
>

Since they're different divider types or mux types (with or without HIWORD) in
the same dts, it'll only make people hard to check the node with
compatible name.
So I hope to use the same compatible name with different property. It could be
easy on checking them with register table.

In this driver, I'll only use one compatible string for one clock type
on one SoC.
Since it's easier to developers on tracking with register tables.
Otherwise, they
frustrated that there're too much compatible string on the same clock
type. It only
increased unnecessary time on understanding the driver.

>> +
>> +
>> +
>> +Required properties for gate clocks:
>> + - compatible : shall be "hisilicon,clk-gate".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +       be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - reg : the mux register address. It should be the offset of the container.
>> + - clkgate : bit index to control the clock gate in the gate register.
>> +
>> +Optional properties for gate clocks:
>> + - clkgate-inverted : it indicates that setting 0 could enable the clock gate
>> +       and setting 1 could disable the clock gate.
>> + - clkgate-seperated-reg : it indicates that there're three continuous
>> +       registers (enable, disable & status) for the same clock gate.
>
> I responded to this in the other thread but clkgate-separated-reg is a
> bad idea. You'll need your own gate clock type which handles this
> instead of pushing it into the common gate implementation. Use the
> existing 'reg' property to list the registers needed by this clock.
>
OK. I'll use my own gate clock.

>> +
>> +
>> +
>> +Required properties for divider clocks:
>> + - compatible : shall be "hisilicon,clk-div".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +       be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - reg : the divider register address. It should be the offset of the
>> +       container.
>> + - clkdiv-mask : mask bits of the divider register.
>> + - clkdiv-min : the minimum divider of the clock divider.
>> + - clkdiv-max : the maximum divider of the clock divider.
>
> Are these details necessary? Do the mask, min & max values change from
> clock to clock? It's nicer to have these in the driver if possible. This
> looks like building a binding from a struct, which is considered bad.
>
Since there're too much divider values for one divider, likes 32 or 64. Then I
abandon to use clkdiv-table property. Because those divider values are
continuous
ascending, I use min & max instead. It could make the node simpler.

>> +
>> +Optional properties for divider clocks:
>> + - clkdiv-hiword-mask : indicates that the bit[31:16] are the hiword mask
>> +       of divider selected bits (bit[15:0]). The bit[15:0] is valid only when
>> +       bit[31:16] is set.
>
> Same here. Again you might need a different compatible string for these
> types of clocks.

Since they're different divider types or mux types (with or without HIWORD) in
the same dts, it'll only make people hard to check the node with
compatible name.
So I hope to use the same compatible name with different property. It could be
easy on checking them with register table.

Regards
Haojian

>
> Regards,
> Mike
>
