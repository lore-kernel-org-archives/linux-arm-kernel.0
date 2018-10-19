From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 19 Oct 2018 13:50:43 +0800
Subject: [PATCH 7/9] arm64: allwinner: a64: enable ANX6345 bridge on
 Pinebook
In-Reply-To: <10486569.ZhsSaQbvn5@anarsoul-thinkpad>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20181018073327.64942-8-icenowy@aosc.io>
 <10486569.ZhsSaQbvn5@anarsoul-thinkpad>
Message-ID: <5B167CD3-734F-4AE0-81F5-51749C9AD09C@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?10?18? GMT+08:00 ??11:17:35, Vasily Khoruzhick <anarsoul@gmail.com> ??:
>Hi Icenowy,
>
>On Thursday, October 18, 2018 12:33:25 AM PDT Icenowy Zheng wrote:
>> Pinebook has an ANX6345 bridge connected to the RGB666 LCD output,
>and
>> the I2C controlling signals are connected to R_I2C bus.
>> 
>> Enable it in the device tree, and add a usable EDID from the panel's
>> datasheet (at least 14" Pinebook used a panel without EDID).
>
>There's no EDID in dts and 14" Pinebook uses a panel with EDID. Is it
>leftover 
>of old comment?

Yes, it is.

>
>Regards,
>Vasily
>
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 43
>+++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
>> 77fac84797e9..d7c14d0d61f9 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> @@ -66,6 +66,10 @@
>>  	};
>>  };
>> 
>> +&de {
>> +	status = "okay";
>> +};
>> +
>>  &ehci0 {
>>  	phys = <&usbphy 0>;
>>  	phy-names = "usb";
>> @@ -76,6 +80,10 @@
>>  	status = "okay";
>>  };
>> 
>> +&mixer0 {
>> +	status = "okay";
>> +};
>> +
>>  &mmc0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&mmc0_pins>;
>> @@ -127,6 +135,27 @@
>>  	status = "okay";
>>  };
>> 
>> +&r_i2c {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&r_i2c_pins_a>;
>> +	status = "okay";
>> +
>> +	anx6345: anx6345 at 38 {
>> +		compatible = "analogix,anx6345";
>> +		reg = <0x38>;
>> +		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
>> +		panel-supply = <&reg_dc1sw>;
>> +		dvdd25-supply = <&reg_dldo2>;
>> +		dvdd12-supply = <&reg_fldo1>;
>> +
>> +		port {
>> +			anx6345_in: endpoint {
>> +				remote-endpoint = <&tcon0_out_anx6345>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &r_rsb {
>>  	status = "okay";
>> 
>> @@ -267,6 +296,20 @@
>>  	vcc-hdmi-supply = <&reg_dldo1>;
>>  };
>> 
>> +&tcon0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&lcd_rgb666_pins>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&tcon0_out {
>> +	tcon0_out_anx6345: endpoint at 0 {
>> +		reg = <0>;
>> +		remote-endpoint = <&anx6345_in>;
>> +	};
>> +};
>> +
>>  &uart0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&uart0_pb_pins>;
