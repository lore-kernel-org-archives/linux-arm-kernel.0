From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 May 2018 16:28:25 +0530
Subject: [PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight
In-Reply-To: <2d52e1f8-d321-4465-fdfa-fd0d718c67cf@ti.com>
References: <20180518203335.13878-1-aford173@gmail.com>
 <2d52e1f8-d321-4465-fdfa-fd0d718c67cf@ti.com>
Message-ID: <ca5a8ded-18c2-ef39-6af8-207b0a874c89@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 May 2018 08:21 PM, Sekhar Nori wrote:
> On Saturday 19 May 2018 02:03 AM, Adam Ford wrote:
>> When using the board files the LCD works, but not with the DT.
>> This adds enables the original da850-evm to work with the same
>> LCD in device tree mode.
>>
>> The EVM has a gpio for the regulator and a PWM for dimming the
>> backlight.  The LCD and the vpif display pins are mutually
>> exclusive, so if using the LCD, do not load the vpif driver.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
>> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
>> index 0e82bb988fde..a76c2ddfd23e 100644
>> --- a/arch/arm/boot/dts/da850-evm.dts
>> +++ b/arch/arm/boot/dts/da850-evm.dts
>> @@ -27,6 +27,60 @@
>>  		spi0 = &spi1;
>>  	};
>>  
>> +	backlight: backlight-pwm {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&ecap2_pins>;
>> +		power-supply = <&backlight_lcd>;
>> +		compatible = "pwm-backlight";
>> +		pwms = <&ecap2 0 50000 0>;
> 
> It will be nice to add a comment here: "The PWM here corresponds to 
> production hardware. The schematic needs to be 1015171 (15 March 2010), 
> Rev A or newer."
> 
>> +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
>> +		default-brightness-level = <7>;
>> +	};
>> +
>> +	panel {
>> +		compatible = "ti,tilcdc,panel";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&lcd_pins>;
>> +		/*
>> +		 * The vpif and the LCD are mutually exclusive.
>> +		 * To enable VPIF, change the status below to 'disabled' then
>> +		 * then change the status of the vpif below to 'okay'
>> +		*/
> 
> This results in checkpatch warning:
>  
> [PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight.eml:153: WARNING: Block comments should align the * on each line
> [PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight.eml:239: WARNING: Block comments should align the * on each line
> 
>>  &vpif {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
>> -	status = "okay";
>> +	/*
>> +	 * The vpif and the LCD are mutually exclusive.
>> +	 * To enable VPIF, disable the ti,tilcdc,panel then
>> +	 * changed the status below to 'okay'
>> +	*/
>> +	status = "disabled";
> 
> Are you able to see VPIF is disabled after this? Trying your patch, I 
> still see VPIF probing[1]. Also, only VPIF display has a conflict with 
> LCD, correct (capture should be fine)?

To answer myself, I forgot that VPIF is bit special because it is
registered through pdata-quirks. As such the parent vpif node is used
only for pinmux setting. I do think the platform devices for capture and
display should not be registered if the vpif parent node is disabled in
DT. But thats a subject of another patch.

With that, I fixed up my comments above locally and added this in queue
for v4.19

Thanks,
Sekhar
