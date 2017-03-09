From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 9 Mar 2017 14:13:42 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: enable USB Host Nodes
In-Reply-To: <CANAwSgTUPpYvFWcZOf+j6K+1rDZJNUeu9K1fGAB8TC6TgzRXCg@mail.gmail.com>
References: <1488918961-4666-1-git-send-email-linux.amoon@gmail.com>
 <CANAwSgTUPpYvFWcZOf+j6K+1rDZJNUeu9K1fGAB8TC6TgzRXCg@mail.gmail.com>
Message-ID: <0204bbde-c437-e11b-cb3b-d9f4b55a5810@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 06:22 PM, Anand Moon wrote:
> Hi All,
> 
> On 8 March 2017 at 02:06, Anand Moon <linux.amoon@gmail.com> wrote:
>> From: Anand Moon <linux.amoon@gmail.com>
>>
>> update the regulator supply nodes for usb host to
>> enable usb host on odroid-c2
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>> root at odroid64:/usr/src/odroidxu3-4.y-devel# lsusb -t
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>>         |__ Port 1: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
>>         |__ Port 1: Dev 3, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
>>         |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>>         |__ Port 4: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> index c59403a..304b676 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> @@ -64,6 +64,18 @@
>>                 reg = <0x0 0x0 0x0 0x80000000>;
>>         };
>>
>> +       usb_host_pwr: regulator-usb-pwrs {
>> +               compatible = "regulator-fixed";
>> +
>> +               regulator-name = "USB_HOST_PWR";
>> +
>> +               regulator-min-microvolt = <5000000>;
>> +               regulator-max-microvolt = <5000000>;
>> +
>> +               gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
>> +               enable-active-high;
>> +       };
>> +
>>         usb_otg_pwr: regulator-usb-pwrs {
>>                 compatible = "regulator-fixed";
>>
>> @@ -184,6 +196,7 @@
>>
>>  &usb1_phy {
>>         status = "okay";
>> +       phy-supply = <&usb_host_pwr>;
>>  };
>>
>>  &usb0 {
>> --
>> 2.7.4
>>
> 
> Please ignore this patch, It not working.
> I will try to submit a new patch.
> 
> Best Regards
> -Anand Moon
> 

Hi Anand,

For this specific use case, the only way to manage this is to use the Work-In-Progress
Power Sequence Library proposer by Peter Chen at :
https://lkml.org/lkml/2016/11/13/315

Since this is the USB Hub reset link and has no direct link with either the USB controller
or the USB PHY, and the USB Hus cannot be modeled (yet ?) in the DT.

One intermediate, but crappy, solution would be to add a GPIO hog until the power
sequence code has been merged, with a proper big fat warning in the dts file.

You can find doc about the gpio-hog in :
Documentation/devicetree/bindings/gpio/gpio.txt

It should look like :

usb-hub {
	gpio-hog;
	gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
	output-high;
	line-name = "usb-hub-reset";
};

in the gpio_ao controller node.

Neil
