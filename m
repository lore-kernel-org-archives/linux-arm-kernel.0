From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 Apr 2015 19:57:18 +0800
Subject: [PATCH] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <CAGsJ_4zUcZY2_rTeav521-1j-QGeHWF+ArO_dYoOSOYCJDNvEA@mail.gmail.com>
References: <1419495845-4345-1-git-send-email-21cnbao@gmail.com>
 <20150411002358.18916.16856@quantum>
 <CAGsJ_4zUcZY2_rTeav521-1j-QGeHWF+ArO_dYoOSOYCJDNvEA@mail.gmail.com>
Message-ID: <CAGsJ_4wibCzTOkfxz6HzCa86+eYSaaDo3q7h+JRrXfDuifCLxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-12 18:24 GMT+08:00, Barry Song <21cnbao@gmail.com>:
> 2015-04-11 8:23 GMT+08:00 Michael Turquette <mturquette@linaro.org>:
>> Quoting Barry Song (2014-12-25 00:24:05)
>>> From: Zhiwu Song <Zhiwu.Song@csr.com>
>>>
>>> the hardware node includes both clock and reset support, so it
>>> is named as "car".
>>> this patch implements Flexible clocks(mux, divider, gate), Selectable
>>> clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
>>> it also implements the reset controller functionality.
>>>
>>> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>  .../devicetree/bindings/clock/csr,atlas7-car.txt   |   46 +
>>>  drivers/clk/sirf/Makefile                          |    2 +-
>>>  drivers/clk/sirf/clk-atlas7.c                      | 1652
>>> ++++++++++++++++++++
>>>  3 files changed, 1699 insertions(+), 1 deletion(-)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
>>>  create mode 100644 drivers/clk/sirf/clk-atlas7.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
>>> b/Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
>>> new file mode 100644
>>> index 0000000..a1a9499
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
>>> @@ -0,0 +1,46 @@
>>> +* Clock and reset bindings for CSR atlas7
>>> +
>>> +Required properties:
>>> +- compatible: Should be "sirf,atlas7-car"
>>> +- reg: Address and length of the register set
>>> +- #clock-cells: Should be <1>
>>> +- #reset-cells: Should be <1>
>>> +
>>> +The clock consumer should specify the desired clock by having the clock
>>> +ID in its "clocks" phandle cell.
>>> +The ID list atlas7_clks defined in drivers/clk/sirf/clk-atlas7.c
>>> +
>>> +The reset consumer should specify the desired reset by having the reset
>>> +ID in its "reset" phandle cell.
>>> +The ID list atlas7_reset_unit defined in drivers/clk/sirf/clk-atlas7.c
>>> +
>>> +Examples:
>>> +
>>> +timer at 10dc0000 {
>>> +       compatible = "sirf,macro-tick";
>>> +       reg = <0x10dc0000 0x1000>;
>>> +       clocks = <&car 54>;
>>> +       interrupts = <0 0 0>,
>>> +                  <0 1 0>,
>>> +                  <0 2 0>,
>>> +                  <0 49 0>,
>>> +                  <0 50 0>,
>>> +                  <0 51 0>;
>>> +};
>>> +
>>> +uart1: uart at 18020000 {
>>> +       cell-index = <1>;
>>> +       compatible = "sirf,macro-uart";
>>> +       reg = <0x18020000 0x1000>;
>>> +       clocks = <&clks 95>;
>>> +       interrupts = <0 18 0>;
>>> +       fifosize = <32>;
>>> +};
>>> +
>>> +vpp at 13110000 {
>>> +       compatible = "sirf,prima2-vpp";
>>> +       reg = <0x13110000 0x10000>;
>>> +       interrupts = <0 31 0>;
>>> +       clocks = <&car 85>;
>>> +       resets = <&car 29>;
>>> +};
>>
>> It would be nice to provide an example of the clock provider node,
>> "sirf,atlas7-car".
>
> ok. Mike, thanks for reviewing.

hi mike,  the example of the clock provider node has been done by the
v2 patch sent two days ago.is there enough time to push it to 4.1?

>
>> Also do you have a patch which adds this node to a
>> dts file somewhere?
>>
>
> this has been done when atlas7 platform was added. see:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/atlas7.dtsi
>
> there is a node:
>             car: clock-controller at 18620000 {
>                 compatible = "sirf,atlas7-car";
>                 reg = <0x18620000 0x1000>;
>                 #clock-cells = <1>;
>                 #reset-cells = <1>;
>             };
>
>> Otherwise the rest of this patch looks OK.
>>
>> Regards,
>> Mike
>
> -barry
>

-barry
