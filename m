From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 12:43:09 +0200
Subject: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
In-Reply-To: <7aabd35a-0b4a-4d03-9976-ef3926929ddc@BL2FFO11FD027.protection.gbl>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-6-git-send-email-afaerber@suse.de>
 <ddb38ce5-9e31-4c94-967c-7784c7fba75c@BN1BFFO11FD028.protection.gbl>
 <53D20E5B.9070501@monstr.eu> <53D21887.2020305@suse.de>
 <53D2258B.9000609@xilinx.com>
 <7aabd35a-0b4a-4d03-9976-ef3926929ddc@BL2FFO11FD027.protection.gbl>
Message-ID: <53D234BD.2040005@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harini,

Am 25.07.2014 12:31, schrieb Harini Katakam:
>> -----Original Message-----
>> From: Michal Simek [mailto:michal.simek at xilinx.com]
>> Sent: Friday, July 25, 2014 3:08 PM
>> To: Andreas F?rber; monstr at monstr.eu; Soren Brinkmann
>> Cc: Harini Katakam; Michal Simek; Andreas Olofsson; Matteo Vit; Sean
>> Rickerd; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-kernel at vger.kernel.org; Rob Herring; Pawel Moll; Mark Rutland; Ian
>> Campbell; Kumar Gala; Russell King
>> Subject: Re: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
>>
>> On 07/25/2014 10:42 AM, Andreas F?rber wrote:
>>> Am 25.07.2014 09:59, schrieb Michal Simek:
>>>> On 07/25/2014 01:18 AM, S?ren Brinkmann wrote:
>>>>> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>>>>>> Prepare SPI0 and SPI1 while at it.
>>>
>>>> Patch subject is incorrect. You are adding SPI and QSPI.
>>>
>>> Yes, it originally added only QSPI, but I considered it a good deed to
>>> add SPI as well while already reading that part of the TRM. :)
>>>
>>>>>>
>>>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de> --- v2: New
>>>>>>
>>>>>> arch/arm/boot/dts/zynq-7000.dtsi      | 37
>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>> arch/arm/boot/dts/zynq-parallella.dts |  4 ++++ 2 files
>>>>>> changed, 41 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi
>>>>>> b/arch/arm/boot/dts/zynq-7000.dtsi index 8fd826a..eed3df0
>>>>>> 100644 --- a/arch/arm/boot/dts/zynq-7000.dtsi +++
>>>>>> b/arch/arm/boot/dts/zynq-7000.dtsi @@ -122,6 +122,30 @@
>>>>>> interrupts = <0 50 4>; };
>>>>>>
>>>>>> +		spi0: spi at e0006000 { +			compatible =
>> "xlnx,zynq-spi-r1p6";
>>>>>> +			reg = <0xe0006000 0x1000>; +			status
>> = "disabled"; +
>>>>>> interrupt-parent = <&intc>; +			interrupts = <0 26 4>;
>> +
>>>>>> clocks = <&clkc 25>, <&clkc 34>; +			clock-names =
>> "ref_clk",
>>>>>> "pclk"; +			#address-cells = <1>; +			#size-
>> cells = <0>; +		};
>>>>>> + +		spi1: spi at e0007000 { +			compatible =
>>>>>> "xlnx,zynq-spi-r1p6"; +			reg = <0xe0007000 0x1000>; +
>> 			status
>>>>>> = "disabled"; +			interrupt-parent = <&intc>; +
>> 		interrupts =
>>>>>> <0 49 4>; +			clocks = <&clkc 26>, <&clkc 35>; +
>> 		clock-names
>>>>>> = "ref_clk", "pclk"; +			#address-cells = <1>; +
>> 		#size-cells
>>>>>> = <0>; +		}; +
>>>>> Until here things look good.
>>>>>
>>>>>> gem0: ethernet at e000b000 { compatible = "cdns,gem"; reg =
>>>>>> <0xe000b000 0x4000>; @@ -140,6 +164,19 @@ clock-names = "pclk",
>>>>>> "hclk", "tx_clk"; };
>>>>>>
>>>>>> +		qspi: qspi at e000d000 { +			compatible =
>>>>>> "xlnx,zynq-spi-r1p6"; +			reg = <0xe000d000 0x1000>; +
>> 			status
>>>>>> = "disabled"; +			interrupt-parent = <&intc>; +
>> 		interrupts =
>>>>>> <0 19 4>; +			clocks = <&clkc 10>, <&clkc 43>; +
>> 		clock-names
>>>>>> = "ref_clk", "pclk"; +			num-cs = <1>; +
>> 	#address-cells =
>>>>>> <1>; +			#size-cells = <0>; +		}; +
>>>>> I'm not sure what the status of this driver is. I think QSPI is
>>>>> still under review on the mailing lists and I don't think we
>>>>> should add this yet.
>>>
>>>> Driver for qspi is not in the mainline yet but it doesn't mean that
>>>> this fragment won't work. Harini: Can you please correct me if I am
>>>> wrong?
>>>
> 
> It can be added but it will have to be disabled as there is no qspi driver
> at the moment in mainline.

Did you read the actual patch? It's using the upstream SPI driver for
now, and it's disabled for anything but the new board I'm adding.

https://patchwork.kernel.org/patch/4620201/

Wouldn't a dedicated QSPI driver only result in a compatible string
being prepended before the SPI compatible string?

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
