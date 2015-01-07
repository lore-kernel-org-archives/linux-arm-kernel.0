From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Jan 2015 11:17:20 +0530
Subject: [PATCH v5 4/6] ARM: dts: AM335x: Make charge delay a DT parameter
 for TSC
In-Reply-To: <20150102170933.GB3298@atomide.com>
References: <1419404619-10744-1-git-send-email-vigneshr@ti.com>
 <1419404619-10744-5-git-send-email-vigneshr@ti.com>
 <20150102170933.GB3298@atomide.com>
Message-ID: <54ACC868.7040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 02 January 2015 10:39 PM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [141223 23:07]:
>> The charge delay value is by default 0x400. But it can be set to lower
>> values on some boards, as long as false pen-ups are avoided. Lowering the
>> value increases the sampling rate (though current sampling rate is
>> sufficient for TSC operation). In some boards, the value has to be
>> increased to avoid false pen-up events. Hence, charge delay has been
>> made a DT parameter.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Assuming this binding makes sense for the input people, there should
> be no conflicts merging this patch along with the rest of the series
> via the input tree.
> 

I will post new version moving documentation to driver code and keeping
DT changes as a separate patch.

> Sounds like this value probably depends on the size of the touchscreen
> for the capacitance, so a numeric value is really needed here. 

Its not just dependent on the size of the touchscreen. It varies based
on the individual setups.

> I would personally prefer generic bindings in general, but in any case

There isn't any generic binding that corresponds to charge-delay.
Nothing as been pointed out by input maintainer either.

Regards
Vignesh

> please feel free to merge along with the other input patches:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> 
>> ---
>> v4:
>>  - Set charge delay to 0x400 as default. Most devices function normally
>>    at this value
>>
>>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 15 +++++++++++++++
>>  arch/arm/boot/dts/am335x-evm.dts                          |  1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> index 878549ba814d..6df5028a4ad3 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> @@ -28,6 +28,20 @@ Required properties:
>>  	ti,adc-channels: List of analog inputs available for ADC.
>>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>>  
>> +Optional properties:
>> +- child "tsc"
>> +	ti,charge-delay: Length of touch screen charge delay step in terms of
>> +			 ADC clock cycles. Charge delay value should be large
>> +			 in order to avoid false pen-up events. This value
>> +			 affects the overall sampling speed, hence need to be
>> +			 kept as low as possible, while avoiding false pen-up
>> +			 event. Start from a lower value, say 0x400, and
>> +			 increase value until false pen-up events are avoided.
>> +			 The pen-up detection happens immediately after the
>> +			 charge step, so this does in fact function as a
>> +			 hardware knob for adjusting the amount of "settling
>> +			 time".
>> +
>>  Example:
>>  	tscadc: tscadc at 44e0d000 {
>>  		compatible = "ti,am3359-tscadc";
>> @@ -36,6 +50,7 @@ Example:
>>  			ti,x-plate-resistance = <200>;
>>  			ti,coordiante-readouts = <5>;
>>  			ti,wire-config = <0x00 0x11 0x22 0x33>;
>> +			ti,charge-delay = <0x400>;
>>  		};
>>  
>>  		adc {
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
>> index 54f118c08db8..66342515df20 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -648,6 +648,7 @@
>>  		ti,x-plate-resistance = <200>;
>>  		ti,coordinate-readouts = <5>;
>>  		ti,wire-config = <0x00 0x11 0x22 0x33>;
>> +		ti,charge-delay = <0x400>;
>>  	};
>>  
>>  	adc {
>> -- 
>> 1.9.1
>>
