From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 6 Apr 2018 10:00:33 +0300
Subject: [PATCH] ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck
 for twl
In-Reply-To: <1b05ea2c-fa95-e5c7-2a37-4e0b46f62abc@ti.com>
References: <20180405115239.17370-1-peter.ujfalusi@ti.com>
 <1b05ea2c-fa95-e5c7-2a37-4e0b46f62abc@ti.com>
Message-ID: <065d346a-12a4-3dc6-d8a3-e5351a73a7ab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-04-05 16:15, Peter Ujfalusi wrote:
> 
> 
> On 2018-04-05 14:52, Peter Ujfalusi wrote:
>> The board uses 26MHz oscillator for the twl4030 HFCLK.
>> This way we will not depend on the bootloader to configure the
>> CFG_BOOT:HFCLK_FREQ
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> there might be other boards (all omap3 boards with twl4030?) which uses the same
>> setup, but I only have schematics for beagle-xm.
>>
>> In order for the driver to actually use the clock the 
>> [PATCH] mfd: twl-core: Fix clock initialization
>> need to be applied. W/o the twl-core patch the clock is just ignored.
>>
>> Regards,
>> Peter
>>
>>  arch/arm/boot/dts/omap3-beagle-xm.dts | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> index 0349fcc9dc26..d80587de0bbf 100644
>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> @@ -30,6 +30,13 @@
>>  		ethernet = &ethernet;
>>  	};
>>  
>> +	/* fixed 26MHz oscillator */
>> +	hfclk_26m: oscillator {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <26000000>;
>> +	};
>> +
>>  	leds {
>>  		compatible = "gpio-leds";
>>  
>> @@ -274,6 +281,9 @@
>>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>>  		interrupt-parent = <&intc>;
>>  
>> +		clocks = <&hfclk_26m>;
>> +		clock-names = "fck";
> 
> I wonder if we should rename this to hfclk...
> The DT documentation does not mention it and afaik it is not specified
> in DT files either.
> 
> After all it is the HFCLK clock for the twl4030.

We should not as it would break compatibility with stable kernels where
the code expects 'fck' and not hfclk.

> 
> I'm fine keeping it as 'fck' but it looks a bit weird.
> 
>> +
>>  		twl_audio: audio {
>>  			compatible = "ti,twl4030-audio";
>>  			codec {
>>
> 
> - P?ter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
