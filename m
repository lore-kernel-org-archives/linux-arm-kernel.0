From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 20 Jan 2016 09:09:03 +0800
Subject: [PATCH v7 5/5] ARM: dts: rockchip: add support mipi panel
 tv080wum-nl0
In-Reply-To: <1649978.zzK0Pex4sR@phil>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
 <1452053038-32098-6-git-send-email-zyw@rock-chips.com>
 <1649978.zzK0Pex4sR@phil>
Message-ID: <569EDE2F.6060400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

On 01/20/2016 03:26 AM, Heiko Stuebner wrote:
> Hi Chris,
>
> Am Mittwoch, 6. Januar 2016, 12:03:57 schrieb Chris Zhong:
>> This tv080wum-nl0 panel is a mipi panel, it can use in MIPI_TX socket
>> of rk3288 evb board.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> [...]
>
>> diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts
>> b/arch/arm/boot/dts/rk3288-evb-act8846.dts index e662147..7d5475b 100644
>> --- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
>> +++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
>> @@ -50,6 +50,8 @@
>>   		gpio = <&gpio7 3 GPIO_ACTIVE_HIGH>;
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&lcd_en>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
> Is this only needed for the panel itself and can you try to get the panel
> supplies set up correctly instead in that case please?
It is not only for panel, LCDC_VDD need this supply too.
And rk3288-evb-rk808.dts has set this regulator to always on, so I do 
the same thing in here.
>
>
>>   		regulator-name = "vcc_lcd";
>>   		vin-supply = <&vcc_io>;
>>   	};
>> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi
>> b/arch/arm/boot/dts/rk3288-evb.dtsi index 4faabdb..0c91858 100644
>> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
>> @@ -47,7 +47,7 @@
>>   		reg = <0x0 0x80000000>;
>>   	};
>>
>> -	backlight {
>> +	backlight: backlight {
>>   		compatible = "pwm-backlight";
>>   		brightness-levels = <
>>   			  0   1   2   3   4   5   6   7
>> @@ -183,6 +183,16 @@
>>   	status = "okay";
>>   };
>>
>> +&mipi_dsi {
>> +	status = "okay";
>> +	panel {
>> +		compatible ="boe,tv080wum-nl0";
>> +		reg = <0>;
>> +		backlight = <&backlight>;
>> +		status = "okay";
> in the evb-schematics I see, vcc_lcd as supply for the panel.
>
> So I'd think the panel node here should have a
> 	power-supply = <&vcc_lcd>;
> instead of having the always-on above?
>
>
> Thanks
> Heiko
>
>> +	};
>> +};
>> +
>>   &sdmmc {
>>   	bus-width = <4>;
>>   	cap-mmc-highspeed;
>
>
>
