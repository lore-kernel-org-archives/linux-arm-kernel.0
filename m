From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 17 Apr 2018 10:13:21 +0200
Subject: [PATCH 4/9] ARM: dts: bcm2837: Add Raspberry Pi 3 B+
In-Reply-To: <20180416204331.ft4ehpe5statsw4u@rob-hp-laptop>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
 <1523640478-4448-5-git-send-email-stefan.wahren@i2se.com>
 <20180416204331.ft4ehpe5statsw4u@rob-hp-laptop>
Message-ID: <60625d11-c521-b004-d64c-f72c9c6aac83@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am 16.04.2018 um 22:43 schrieb Rob Herring:
> On Fri, Apr 13, 2018 at 07:27:53PM +0200, Stefan Wahren wrote:
>> The Raspberry Pi 3 B+ has the following major differences compared
>> to the model 3 B:
>> * Microchip LAN7515 (Gigabit Ethernet)
>> * Cypress CYW43455 (802.11n/ac and BT 4.2)
>>
>> We need to add the USB LAN chip so the bootloader can add the MAC address.
>> This is necessary because there ain't a EEPROM or a valid OTP.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   arch/arm/boot/dts/Makefile                 |   1 +
>>   arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 108 +++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi |  27 ++++++++
>>   3 files changed, 136 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
>>   create mode 100644 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
>>
>> ...
>> diff --git a/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
>> new file mode 100644
>> index 0000000..169203c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
> Why the separate file? This can be shared?

this comes from the assumption the RPi 3 B+ won't be the only RPi board 
with a LAN7515. Should i fold it in the dts file as long as we don't 
have a second board?

>
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/ {
>> +	aliases {
>> +		ethernet0 = &ethernet;
>> +	};
>> +};
>> +
>> +&usb {
>> +	usb1 at 1 {
>> +		compatible = "usb424,2514";
>> +		reg = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usb1_1 at 1 {
> usb-port at 1
>
>> +			compatible = "usb424,2514";
> There's really 2 levels of hubs?

Yes, lsusb -t shows the following:

/:? Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
 ??? |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
 ??????? |__ Port 1: Dev 3, If 0, Class=Hub, Driver=hub/3p, 480M
 ??????????? |__ Port 2: Dev 5, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M
 ??????????? |__ Port 1: Dev 6, If 0, Class=Vendor Specific Class, 
Driver=lan78xx, 480M
 ??????? |__ Port 2: Dev 7, If 0, Class=Mass Storage, 
Driver=usb-storage, 480M
 ??????? |__ Port 3: Dev 4, If 0, Class=Human Interface Device, 
Driver=usbhid, 1.5M

>
>> +			reg = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			ethernet: usbether at 1 {
> ethernet at 1
>
>> +				compatible = "usb424,7800";
>> +				reg = <1>;
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.7.4
>>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
