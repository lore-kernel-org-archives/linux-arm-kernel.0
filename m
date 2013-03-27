From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 08:40:36 +0100
Subject: [PATCH v2 01/10] arm: zynq: Use standard timer binding
In-Reply-To: <20130326201401.GA19679@pengutronix.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <dcbc38c6f1e319a31693ef0d69195fafc42a5de0.1364319776.git.michal.simek@xilinx.com>
 <20130326201401.GA19679@pengutronix.de>
Message-ID: <CAHTX3d+OPOmjCTBkgiSy5mjbLw+zEOe9G39g0kDmn=pWFdcrUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> On Tue, Mar 26, 2013 at 06:43:33PM +0100, Michal Simek wrote:
>> Use cdns,ttc because this driver is Cadence Rev06
>> Triple Timer Counter and everybody can use it
>> without xilinx specific function name or probing.
>>
>> Also use standard dt description for timer
>> and also prepare for moving to clocksource
>> initialization.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> v2: Update year in copyright
>>     Fix typo fault
>>     Remove all zynq specific names
>>
>> Steffen: I have done this change based on our discussion.
>> Moving to generic location will be done in the next patch.
>>
>> Josh: We have talked about this change at ELC.
>> Using standard dt binding as other timers.
>>
>> I have also discussed this with Rob some time ago.
>> https://patchwork.kernel.org/patch/2112791/
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi |   45 +------
>>  arch/arm/boot/dts/zynq-zc702.dts |   10 --
>>  arch/arm/mach-zynq/common.c      |    1 +
>>  arch/arm/mach-zynq/timer.c       |  261 +++++++++++++++++++++++++++-----------
>>  4 files changed, 195 insertions(+), 122 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 5914b56..51243db 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -111,56 +111,23 @@
>>               };
>>
>>               ttc0: ttc0 at f8001000 {
>> -                     #address-cells = <1>;
>> -                     #size-cells = <0>;
>> -                     compatible = "xlnx,ttc";
>> +                     interrupt-parent = <&intc>;
>> +                     interrupts = < 0 10 4 0 11 4 0 12 4 >;
>> +                     compatible = "cdns,ttc";
>>                       reg = <0xF8001000 0x1000>;
>>                       clocks = <&cpu_clk 3>;
>>                       clock-names = "cpu_1x";
>>                       clock-ranges;
>> -
>> -                     ttc0_0: ttc0.0 {
>> -                             status = "disabled";
>> -                             reg = <0>;
>> -                             interrupts = <0 10 4>;
>> -                     };
>> -                     ttc0_1: ttc0.1 {
>> -                             status = "disabled";
>> -                             reg = <1>;
>> -                             interrupts = <0 11 4>;
>> -                     };
>> -                     ttc0_2: ttc0.2 {
>> -                             status = "disabled";
>> -                             reg = <2>;
>> -                             interrupts = <0 12 4>;
>> -                     };
>>               };
>>
>>               ttc1: ttc1 at f8002000 {
>> -                     #interrupt-parent = <&intc>;
>> -                     #address-cells = <1>;
>> -                     #size-cells = <0>;
>> -                     compatible = "xlnx,ttc";
>> +                     interrupt-parent = <&intc>;
>> +                     interrupts = < 0 37 4 0 38 4 0 39 4 >;
>> +                     compatible = "cdns,ttc";
>>                       reg = <0xF8002000 0x1000>;
>>                       clocks = <&cpu_clk 3>;
>>                       clock-names = "cpu_1x";
>>                       clock-ranges;
>> -
>> -                     ttc1_0: ttc1.0 {
>> -                             status = "disabled";
>> -                             reg = <0>;
>> -                             interrupts = <0 37 4>;
>> -                     };
>> -                     ttc1_1: ttc1.1 {
>> -                             status = "disabled";
>> -                             reg = <1>;
>> -                             interrupts = <0 38 4>;
>> -                     };
>> -                     ttc1_2: ttc1.2 {
>> -                             status = "disabled";
>> -                             reg = <2>;
>> -                             interrupts = <0 39 4>;
>> -                     };
>>               };
>>       };
>>  };
>
> Hi Michal!
>
> Thought about this a little more. I'm not seeing the improvment this gives us.
> The ttcs give us 6 counters that could be used however one likes. Linux wants
> a clocksource and clockevent provider, but I could use the Cortex timer as
> clocksource and would only have to sacrifice one of the 6 counters.
> With this patch I have to sacrifice 3 counters and would only use 2 of them.
> Then there is pinmuxing. That can be handled by one driver, so I think that is
> doable with both versions and I think I'm okay with that.
> So what am I missing? Why would I want it like this and not the way it is right
> now?

There is a big move because previous DT description was incorrect.
Device-tree should describe hardware and there is no something like
ttc-counter-clocksource or ttc-counter-clockevent compatible driver.
Every ttc counter can be used as clocksource or clockevent.
Changing/Setting compatible properties for linux purpose is not correct.

Just read this thread about.
https://patchwork.kernel.org/patch/2112791/

Utilization of the core or using different timers in the system for clock
is different discussion. We can just try to utilize timers in the arm core
or add bunch of them to PL to see how kernel behaves.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
