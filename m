From: pawelo@king.net.pl (Paul Osmialowski)
Date: Thu, 2 Jul 2015 12:08:39 +0200 (CEST)
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-4-git-send-email-pawelo@king.net.pl>
 <28154735.0HeJqZBqop@wuerfel>
 <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nah, I've found this code hard to maintain. I'm attaching simplified 
version.

Thanks,
Paul

On Wed, 1 Jul 2015, Paul Osmialowski wrote:

> Hi Arnd,
>
> Can you look at attached candidate for the third iteration? Is it any better 
> now?
>
> Thanks,
> Paul
>
> On Tue, 30 Jun 2015, Arnd Bergmann wrote:
>
>>  On Tuesday 30 June 2015 14:27:24 Paul Osmialowski wrote:
>> >  Based on K70P256M150SF3RM.pdf K70 Sub-Family Reference Manual, Rev. 3.
>> > 
>> >  Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
>> >  ---
>> >   .../devicetree/bindings/clock/kinetis-clock.txt    |  63 +++
>> >   arch/arm/boot/dts/kinetis.dtsi                     |  36 ++
>> >   drivers/clk/Makefile                               |   1 +
>> >   drivers/clk/clk-kinetis.c                          | 463 
>> >   +++++++++++++++++++++
>> >   4 files changed, 563 insertions(+)
>> >   create mode 100644 
>> >   Documentation/devicetree/bindings/clock/kinetis-clock.txt
>> >   create mode 100644 drivers/clk/clk-kinetis.c
>> > 
>> >  diff --git a/Documentation/devicetree/bindings/clock/kinetis-clock.txt 
>> >  b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
>> >  new file mode 100644
>> >  index 0000000..63af6a5
>> >  --- /dev/null
>> >  +++ b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
>> >  @@ -0,0 +1,63 @@
>> >  +* Clock bindings for Freescale Kinetis SoC
>> >  +
>> >  +Required properties:
>> >  +- compatible: Should be "fsl,kinetis-cmu".
>> >  +- reg: Two address ranges, one for the Clock Genetator register set,
>> >  +	one for System Integration Module register set.
>> >  +- Set of clock devices: one fixed-rate-root, fixed-rate clocks and 
>> >  clock-gates.
>> >  +
>> >  +For clock-gate addresses see K70 Sub-Family Reference Manual, Rev. 3 
>> >  pg. 341
>> >  +and later. Notice that addresses are zero-based, so SIM_SCGC1 has 
>> >  address 0,
>> >  +SIM_SCGC2 has address 1 and so on. The second address component is the 
>> >  bit
>> >  +index.
>>
>>  Please document the sub-nodes that are allowed, and the format
>>  of the clock specifiers.
>> 
>> >  +
>> >  +Example:
>> >  +
>> >  +cmu at 40064000 {
>> >  +	compatible = "fsl,kinetis-cmu";
>> >  +	reg = <0x40064000 0x14>, <0x40047000 0x1100>;
>> >  +
>> >  +	mcg_outclk: fixed-rate-root at mcgout {
>> >  +		device_type = "mcgout";
>> >  +		#clock-cells = <0>;
>> >  +	};
>> >  +
>> >  +	mcg_cclk: fixed-rate at cclk {
>>
>>  '@' is a reserved character here that is used before the address
>>  of the device, so this has to be a hexadecimal number without leading
>>  '0x', and it should match the 'reg' property of the device.
>> 
>> >  +		device_type = "cclk";
>> >  +		#clock-cells = <0>;
>> >  +		clocks = <&mcg_outclk>;
>> >  +	};
>>
>>  The device_type property here is not a standard identifier,
>>  and you don't list it as an optional or mandatory property.
>>
>>  Please remove it and instead use the compatible property, the
>>  name or the address.
>>
>>   Arnd
>> 
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-arm-twr-k70f120m-clock-driver-for-Kinetis-SoC.patch
Type: text/x-diff
Size: 17977 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150702/d7ac194b/attachment-0001.bin>
