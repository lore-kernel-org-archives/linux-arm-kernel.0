From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 17 Aug 2018 09:51:00 +0200
Subject: [PATCH] ARM: dts: socfpga: Add fpga2hps and fpga2sdram bridges
In-Reply-To: <CANk1AXTSE5AF=8HaGuHGKhT-qxepvZSRsjLROtOKiUwvv0jcZA@mail.gmail.com>
References: <20180815125910.24097-1-s.trumtrar@pengutronix.de>
 <6625681f-f64b-462e-7d8c-b48a9437f2e6@kernel.org>
 <CANk1AXTSE5AF=8HaGuHGKhT-qxepvZSRsjLROtOKiUwvv0jcZA@mail.gmail.com>
Message-ID: <73pnyhbfdn.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

Alan Tull <atull@kernel.org> writes:

> On Wed, Aug 15, 2018 at 9:48 AM, Dinh Nguyen 
> <dinguyen@kernel.org> wrote:
>> CC'd Alan Tull
>>
>> Alan, do you have any comments?
>>
>> Dinh
>>
>> On 08/15/2018 07:59 AM, Steffen Trumtrar wrote:
>>> Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.
>
> I left these out on purpose, see below.
>
>>>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> ---
>>>  arch/arm/boot/dts/socfpga.dtsi | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi 
>>> b/arch/arm/boot/dts/socfpga.dtsi
>>> index b38f8c240558..e0fb76107f34 100644
>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>> @@ -543,6 +543,18 @@
>>>                       clocks = <&l4_main_clk>;
>>>               };
>>>
>>> +             fpga_bridge2: fpga-bridge at ff600000 {
>>> +                     compatible = 
>>> "altr,socfpga-fpga2hps-bridge";
>>> +                     reg = <0xff600000 0x100000>;
>>> +                     resets = <&rst FPGA2HPS_RESET>;
>>> +                     clocks = <&l4_main_clk>;
>
> The FPGA has to be programmed before this bridge can be enabled.
> Since we can't guarantee that, we shouldn't add that here.
>

The hardware is there, that is what the binding describes. Maybe a
    status = "disabled";
would be justified here. But the same goes for the other bridges. 
You can't use any of them without a programmed FPGA.

>>> +             };
>>> +
>>> +             fpga_bridge3: fpga-bridge at ffc25080 {
>>> +                     compatible = 
>>> "altr,socfpga-fpga2sdram-bridge";
>>> +                     reg = <0xffc25080 0x4>;
>
> Missing altr,sdr-ctl and altr,sys-mgr which will cause probe 
> failures
> with error messages.  I checked the binding document, I see that 
> these
> properties weren't added and that should be corrected in the 
> bindings
> doc.
>

It doesn't, because the driver uses 
syscon_regmap_lookup_by_compatible and not 
syscon_regmap_lookup_by_phandle.
I don't see any probe failures. Nevertheless, the dependency 
should be documented, yes.

> But the larger issue is this bridge needs to be configured by 
> the
> bootloader before Linux boots.  This requirement is documented 
> at the
> top of drivers/fpga/altera-fpga2sdram.c  Also it needs a handoff 
> from
> the bootloader that may or may not be happening depending on 
> whether
> the bootloader does this or not.  That's why I left this out.
>

Although registration of the driver works fine, you are right, 
that it shouldn't be used without the correct setup.
So, I'd go for status=disabled in the dtsi and would leave 
enabling of the bridges to the board-specific dts file.


Best regards,
Steffen

-- 
Pengutronix e.K.                          | Steffen Trumtrar 
|
Industrial Linux Solutions                | 
http://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone: 
+49-5121-206917-0   |
Amtsgericht Hildesheim, HRA 2686          | Fax: 
+49-5121-206917-5555|
