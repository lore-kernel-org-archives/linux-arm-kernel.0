From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 6 Jul 2018 10:05:32 +0100
Subject: [linux-sunxi] [PATCH 03/10] arm64: dts: allwinner: a64:
 Olinuxino: fix DRAM voltage
In-Reply-To: <859578FF-AB96-4B51-8E7E-2F144E35C47A@aosc.io>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-4-andre.przywara@arm.com>
 <859578FF-AB96-4B51-8E7E-2F144E35C47A@aosc.io>
Message-ID: <bdf35591-82ad-7f4e-f900-7ecc532bc54e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/07/18 09:55, Icenowy Zheng wrote:
> 
> 
> ? 2018?7?6? GMT+08:00 ??4:52:03, Andre Przywara <andre.przywara@arm.com> ??:
>> The Olinuxino board uses DDR3L chips which are supposed to be driven
>> with 1.35V. The reset default of the AXP is properly set to 1.36V.
>>
>> While technically the chips can also run at 1.5 volts, changing the
>> voltage on the fly while booting Linux is asking for trouble. Also
>> running at a lower voltage saves power.
>>
>> So fix the DCDC5 value to match the actual board design.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> index 3f531393eaee..f945c70f3a80 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> @@ -140,12 +140,14 @@
>> 	regulator-name = "vdd-cpux";
>> };
>>
>> -/* DCDC3 is polyphased with DCDC2 */
>> -
>> +/*
>> + * DCDC3 is polyphased with DCDC2 to supply the DDR3L DRAM chips.
>> + * 1.36V is the closest to the nominal 1.35V that the PMIC can drive.
> 
> The comment is a mess. DCDC2+3 is for CPU, and 5 is for DRAM.

Aargh, true. I was misled by that lonely comment.

> Personally I suggest to use two comment blocks, one sit at
> where dcdc3 should appear, and the second before dcdc5.

Yeah, sounds like the right thing to do.

Thanks for having a look!

Cheers,
Andre.

>> + */
>> &reg_dcdc5 {
>> 	regulator-always-on;
>> -	regulator-min-microvolt = <1500000>;
>> -	regulator-max-microvolt = <1500000>;
>> +	regulator-min-microvolt = <1360000>;
>> +	regulator-max-microvolt = <1360000>;
>> 	regulator-name = "vcc-ddr3";
>> };
>>
