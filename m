From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 12 Aug 2016 08:20:06 -0700
Subject: [PATCH 3/3] ARM: dts: imx6q-evi: Fix onboard hub reset line
In-Reply-To: <20160812031158.GH18967@shlinux2>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
 <1470933632-22133-4-git-send-email-stillcompiling@gmail.com>
 <20160812031158.GH18967@shlinux2>
Message-ID: <57ADE926.8070703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 08/11/2016 08:11 PM, Peter Chen wrote:
> On Thu, Aug 11, 2016 at 09:40:32AM -0700, Joshua Clayton wrote:
>> Previously the onboard hub was made to work by treating its
>> reset gpio as a regulator enable.
>> Get rid of that kludge now that pwseq has added reset gpio support
>> Move pin muxing the hub reset pin into the usbh1 group
>>
>> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx6q-evi.dts | 25 +++++++------------------
>>  1 file changed, 7 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
>> index 4fa5601..49c6f61 100644
>> --- a/arch/arm/boot/dts/imx6q-evi.dts
>> +++ b/arch/arm/boot/dts/imx6q-evi.dts
>> @@ -54,18 +54,6 @@
>>  		reg = <0x10000000 0x40000000>;
>>  	};
>>  
>> -	reg_usbh1_vbus: regulator-usbhubreset {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "usbh1_vbus";
>> -		regulator-min-microvolt = <5000000>;
>> -		regulator-max-microvolt = <5000000>;
>> -		enable-active-high;
>> -		startup-delay-us = <2>;
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&pinctrl_usbh1_hubreset>;
>> -		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
>> -	};
>> -
>>  	reg_usb_otg_vbus: regulator-usbotgvbus {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "usb_otg_vbus";
>> @@ -204,12 +192,18 @@
>>  };
>>  
>>  &usbh1 {
>> -	vbus-supply = <&reg_usbh1_vbus>;
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usbh1>;
>>  	dr_mode = "host";
>>  	disable-over-current;
>>  	status = "okay";
>> +
>> +	usb2415host: hub at 1 {
>> +		compatible = "usb424,2513";
>> +		reg = <1>;
>> +		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>> +		reset-duration-us = <3000>;
>> +	};
>>  };
>>  
>>  &usbotg {
>> @@ -467,11 +461,6 @@
>>  			MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0
>>  			/* usbh1_b OC */
> This comment should be for above pin, do you mind I change it in
> this patch?
Better leave it alone

I checked te schematic. GPIO_0 (below that line) is indeed
connected to a second OC detect line for a second
usb port... It can't possibly be working as designed, but
that is how it is connected up.

I guess I need to consult with my EE colleagues
>
>>  			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
>> -		>;
>> -	};
>> -
>> -	pinctrl_usbh1_hubreset: usbh1hubresetgrp {
>> -		fsl,pins = <
>>  			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x1b0b0
>>  		>;
>>  	};
> This changes remind me that I need to change the same thing for udoo
> board.
>
Sorry I didn't think of it first.
