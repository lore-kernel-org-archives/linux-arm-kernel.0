From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 31 Jul 2014 12:29:29 +0200
Subject: [PATCH] ARM: dt: sun7i: Add Banana Pi board
In-Reply-To: <20140731095800.GA3952@lukather>
References: <1406653348-16638-1-git-send-email-hdegoede@redhat.com>
 <20140731095800.GA3952@lukather>
Message-ID: <53DA1A89.4000104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/31/2014 11:58 AM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Tue, Jul 29, 2014 at 07:02:28PM +0200, Hans de Goede wrote:
>> The Banana Pi is an A20 based development board using Raspberry Pi compatible
>> IO headers. It comes with 1 GB RAM, 1 Gb ethernet, 2x USB host, sata, hdmi
>> and stereo audio out + various expenansion headers:
>>
>> http://www.bananapi.org/
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/Makefile               |   1 +
>>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 183 +++++++++++++++++++++++++++++++
>>  2 files changed, 184 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index bdbc84a..440e037 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -379,6 +379,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>>  	sun6i-a31-hummingbird.dtb \
>>  	sun6i-a31-m9.dtb
>>  dtb-$(CONFIG_MACH_SUN7I) += \
>> +	sun7i-a20-bananapi.dtb \
>>  	sun7i-a20-cubieboard2.dtb \
>>  	sun7i-a20-cubietruck.dtb \
>>  	sun7i-a20-i12-tvbox.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> new file mode 100644
>> index 0000000..0332b82
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> @@ -0,0 +1,183 @@
>> +/*
>> + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "sun7i-a20.dtsi"
>> +/include/ "sunxi-common-regulators.dtsi"
>> +
>> +/ {
>> +	model = "LeMaker Banana Pi";
>> +	compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
>> +
>> +	soc at 01c00000 {
>> +		spi0: spi at 01c05000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&spi0_pins_a>;
>> +			status = "okay";
>> +		};
>> +
>> +		mmc0: mmc at 01c0f000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
>> +			vmmc-supply = <&reg_vcc3v3>;
>> +			bus-width = <4>;
>> +			cd-gpios = <&pio 7 10 0>; /* PH10 */
>> +			cd-inverted;
>> +			status = "okay";
>> +		};
>> +
>> +		usbphy: phy at 01c13400 {
>> +			usb1_vbus-supply = <&reg_usb1_vbus>;
>> +			usb2_vbus-supply = <&reg_usb2_vbus>;
>> +			status = "okay";
>> +		};
>> +
>> +		ehci0: usb at 01c14000 {
>> +			status = "okay";
>> +		};
>> +
>> +		ohci0: usb at 01c14400 {
>> +			status = "okay";
>> +		};
>> +
>> +		ahci: sata at 01c18000 {
>> +			status = "okay";
>> +		};
>> +
>> +		ehci1: usb at 01c1c000 {
>> +			status = "okay";
>> +		};
>> +
>> +		ohci1: usb at 01c1c400 {
>> +			status = "okay";
>> +		};
>> +
>> +		pinctrl at 01c20800 {
>> +			uart3_pins_bananapi: uart3_pin at 0 {
>> +				allwinner,pins = "PH0", "PH1";
>> +				allwinner,function = "uart3";
>> +				allwinner,drive = <0>;
>> +				allwinner,pull = <0>;
>> +			};
> 
> That node should be in the DTSI

I deliberately put it here because it is non standard, uart3
has 4 pins rx, tx, cts and rts, which can be mapped to either
PG6-9 or PH0-3 but here only 2 are used, it seemed appropriate
to put this inside the dts, if we start also taking pinctrl
variants where a subset of the pins are used into the dtsi
then we will end up with a lot of pinctrl entries there.

Note if you decide to take this as is, please
s/bananapi.org/lemaker.org/ in the commit message, bananapi.org
is an unofficial site, I should have put lemaker.org there.

Note btw that we already have this problem for spi1, the
current spi1_pins_a does not include the cs1 pin, because it
was added for use in sun7i-a20-olinuxino-micro.dts where
only cs0 is hooked up, but I decided to leave that as is for now.

Also the "primary" binding for spi2 is to PORTB, but
our spi2_pins_a binds it to PORTC, so it should be renamed
spi2_pins_b IMHO.

Regards,

Hans
