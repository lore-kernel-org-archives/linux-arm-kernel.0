From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 21 Jul 2017 20:49:23 +0800
Subject: [linux-sunxi] [PATCH 2/5] arm: allwinner: a64: drop the dummy
 vcc3v3 regulator in Pine64 DT
In-Reply-To: <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
References: <20170719161019.62133-1-icenowy@aosc.io>
 <20170719161019.62133-3-icenowy@aosc.io>
 <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
Message-ID: <7FACC99F-F900-437B-9642-741D7D980D25@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?7?21? GMT+08:00 ??8:45:39, Andre Przywara <andre.przywara@arm.com> ??:
>Hi,
>
>On 19/07/17 17:10, Icenowy Zheng wrote:
>> The Pine64 DT used to contain a dummy vcc3v3 regulator, in order to
>> satisfy some device nodes when proper AXP803 regulator support is
>> available. It's in fact the DCDC1 regulator of AXP803.
>> 
>> Drop the dummy regulator, and fix the reference of this regulator to
>> DCDC1.
>
>Do we really need to have this?
>While I see that this is technically correct, it breaks older kernels,
>which miss the AXP driver. So we can't use this DT for syncing it into
>U-Boot anymore, while still expecting various kernels (for instance
>from
>distribution installers) to work via UEFI (for which U-Boot provides
>the
>DT). That would be a shame, because we start to see generic arm64
>distribution installers to work out of the box.
>
>I see these solutions:
>1) We drop this patch, instead add a comment that technically it's
>DCDC1. I believe we can't really turn off DCDC1 anyway.
>2) We keep theses patches, but don't sync them to U-Boot to have a
>universal DT in there which works with every kernel.
>3) We keep these patches *and* sync them to U-Boot, but add the fixed
>regulator back in via a U-Boot specific .dtsi "overlay" snippet. This
>would take care of the parts that break compatibility. The end result
>would be similar to 2), then.
>
>The easiest and most maintainable would be 1), but I am OK with 3) as
>well, though I am not sure this won't get messy in the future and will
>work for every change that we make.
>
>What do you think?

4) Do nothing.

We only promise old DTs will run with newer kernel, but
we don't promise newer DTs to run with old kernel. And
U-Boot is intended to update less frequently than Linux.

When updateing U-Boot, please update kernel as well.

>
>Cheers,
>Andre.
>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> index ac31c9477b25..68a47d9b07d9 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> @@ -61,13 +61,6 @@
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>> -
>> -	reg_vcc3v3: vcc3v3 {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "vcc3v3";
>> -		regulator-min-microvolt = <3300000>;
>> -		regulator-max-microvolt = <3300000>;
>> -	};
>>  };
>>  
>>  &ehci0 {
>> @@ -108,7 +101,7 @@
>>  &mmc0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&mmc0_pins>;
>> -	vmmc-supply = <&reg_vcc3v3>;
>> +	vmmc-supply = <&reg_dcdc1>;
>>  	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>>  	cd-inverted;
>>  	disable-wp;
>> 
