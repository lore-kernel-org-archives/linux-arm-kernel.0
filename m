From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 11:09:25 +0100
Subject: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
In-Reply-To: <20140221181519.GC3931@lukather>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
 <20140221181519.GC3931@lukather>
Message-ID: <53087755.3090608@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 02/21/2014 07:15 PM, Maxime Ripard wrote:
> Hi Hans,
>
> On Wed, Feb 19, 2014 at 01:01:59PM +0100, Hans de Goede wrote:
>> From: Oliver Schinagl <oliver@schinagl.nl>
>>
>> This patch adds sunxi sata support to A10 boards that have such a connector.
>> Some boards also feature a regulator via a GPIO and support for this is also
>> added.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
>>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
>>   arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
>>   arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 36 ++++++++++++++++++++++++++++++
>>   4 files changed, 54 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> index cbd2e13..d6ec839 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> @@ -35,6 +35,10 @@
>>   			};
>>   		};
>>
>> +		ahci: sata at 01c18000 {
>> +			status = "okay";
>> +		};
>> +
>>   		pinctrl at 01c20800 {
>>   			emac_power_pin_a1000: emac_power_pin at 0 {
>>   				allwinner,pins = "PH15";
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index b139ee6..6df237d8 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -12,6 +12,7 @@
>>
>>   /dts-v1/;
>>   /include/ "sun4i-a10.dtsi"
>> +/include/ "sunxi-ahci-reg.dtsi"
>>
>>   / {
>>   	model = "Cubietech Cubieboard";
>> @@ -33,6 +34,11 @@
>>   			};
>>   		};
>>
>> +		ahci: sata at 01c18000 {
>> +			target-supply = <&reg_ahci_5v>;
>> +			status = "okay";
>> +		};
>> +
>>   		pinctrl at 01c20800 {
>>   			led_pins_cubieboard: led_pins at 0 {
>>   				allwinner,pins = "PH20", "PH21";
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index 336dbec..454077a 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -338,6 +338,14 @@
>>   			#size-cells = <0>;
>>   		};
>>
>> +		ahci: sata at 01c18000 {
>> +			compatible = "allwinner,sun4i-a10-ahci";
>> +			reg = <0x01c18000 0x1000>;
>> +			interrupts = <56>;
>> +			clocks = <&pll6 0>, <&ahb_gates 25>;
>> +			status = "disabled";
>> +		};
>> +
>>   		intc: interrupt-controller at 01c20400 {
>>   			compatible = "allwinner,sun4i-ic";
>>   			reg = <0x01c20400 0x400>;
>> diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>> new file mode 100644
>> index 0000000..7072af1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>> @@ -0,0 +1,36 @@
>> +/*
>> + * sunxi boards sata target power supply common code
>
>
> Since IIRC we have pretty much the same needs for the USB, can't we
> just drop the SATA specific mention and use it as the common DTSI for
> the usual regulators?

On most boards with sata, there will also be 1 or 2 usb regulators,
so we need differently named regulator nodes for all 3 of ahci,
usb1 and usb2 vbus. On some boards how ever we may only need the
usb regulators. So if you look in my current personal sunxi-devel
tree you will see separate dtsi files for both ahci and usb regulators,
another advantage of having these separate is that the gpio controlling
the regulator can be pre-populated with the reference design gpio which
is used in most boards, so that the ahci specific code in the dts
becomes only the ahci: sata at ... node.

Regards,

Hans
