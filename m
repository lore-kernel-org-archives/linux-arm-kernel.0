From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 20 Nov 2013 16:48:52 +0100
Subject: [PATCH 3/9] ARM: at91/dt: add usb1 vbus and pullup pins
In-Reply-To: <20131120145730.GD14627@ns203013.ovh.net>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687881-10688-1-git-send-email-b.brezillon@overkiz.com>
 <20131120145730.GD14627@ns203013.ovh.net>
Message-ID: <528CD9E4.7060501@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2013 15:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:04 Wed 28 Aug     , Boris BREZILLON wrote:
>> Add vbus and pullup pinctrl definitions.
>> Request the vbus and pullup pins in usb1 node.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   arch/arm/boot/dts/at91rm9200ek.dts |   15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
>> index 37b0880..76f3e87 100644
>> --- a/arch/arm/boot/dts/at91rm9200ek.dts
>> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
>> @@ -29,6 +29,18 @@
>>   
>>   	ahb {
>>   		apb {
>> +			pinctrl at fffff400 {
>> +				usb1 {
>> +					pinctrl_usb1_vbus: usb1_vbus-0 {
>> +						atmel,pins = <AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>> +					};
> it's a gpio no-need

Okay, noted.

I thought I had to declare gpio configured pins in order to detect pin 
conflicts.
But after taking a closer look at the pinctrl core and at91 pinctrl 
driver, it seems this is automatically done
by means of the pinctrl_request_gpio function.


>> +
>> +					pinctrl_usb1_pullup: usb1_pullup-0 {
>> +						atmel,pins = <AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
>> +					};
> no-need multidrive

Then why is it configured with multi-drive option in the board file
( 
http://lxr.free-electrons.com/source/arch/arm/mach-at91/board-rm9200ek.c#L166) 
?

>> +				};
>> +			};
>> +
>>   			dbgu: serial at fffff200 {
>>   				status = "okay";
>>   			};
>> @@ -56,6 +68,9 @@
>>   
>>   			usb1: gadget at fffb0000 {
>>   				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&pinctrl_usb1_vbus
>> +					     &pinctrl_usb1_pullup>;
>>   				status = "okay";
>>   			};
>>   
>> -- 
>> 1.7.9.5
>>
