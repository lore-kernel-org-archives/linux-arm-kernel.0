From: atull@kernel.org (Alan Tull)
Date: Wed, 15 Aug 2018 15:04:13 -0500
Subject: [PATCH] ARM: dts: socfpga: Add fpga2hps and fpga2sdram bridges
In-Reply-To: <6625681f-f64b-462e-7d8c-b48a9437f2e6@kernel.org>
References: <20180815125910.24097-1-s.trumtrar@pengutronix.de>
 <6625681f-f64b-462e-7d8c-b48a9437f2e6@kernel.org>
Message-ID: <CANk1AXTSE5AF=8HaGuHGKhT-qxepvZSRsjLROtOKiUwvv0jcZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2018 at 9:48 AM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> CC'd Alan Tull
>
> Alan, do you have any comments?
>
> Dinh
>
> On 08/15/2018 07:59 AM, Steffen Trumtrar wrote:
>> Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.

I left these out on purpose, see below.

>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/socfpga.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index b38f8c240558..e0fb76107f34 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -543,6 +543,18 @@
>>                       clocks = <&l4_main_clk>;
>>               };
>>
>> +             fpga_bridge2: fpga-bridge at ff600000 {
>> +                     compatible = "altr,socfpga-fpga2hps-bridge";
>> +                     reg = <0xff600000 0x100000>;
>> +                     resets = <&rst FPGA2HPS_RESET>;
>> +                     clocks = <&l4_main_clk>;

The FPGA has to be programmed before this bridge can be enabled.
Since we can't guarantee that, we shouldn't add that here.

>> +             };
>> +
>> +             fpga_bridge3: fpga-bridge at ffc25080 {
>> +                     compatible = "altr,socfpga-fpga2sdram-bridge";
>> +                     reg = <0xffc25080 0x4>;

Missing altr,sdr-ctl and altr,sys-mgr which will cause probe failures
with error messages.  I checked the binding document, I see that these
properties weren't added and that should be corrected in the bindings
doc.

But the larger issue is this bridge needs to be configured by the
bootloader before Linux boots.  This requirement is documented at the
top of drivers/fpga/altera-fpga2sdram.c  Also it needs a handoff from
the bootloader that may or may not be happening depending on whether
the bootloader does this or not.  That's why I left this out.

Alan

>> +             };
>> +
>>               fpgamgr0: fpgamgr at ff706000 {
>>                       compatible = "altr,socfpga-fpga-mgr";
>>                       reg = <0xff706000 0x1000
>>
