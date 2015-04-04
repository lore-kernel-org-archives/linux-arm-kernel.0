From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 04 Apr 2015 15:21:41 +0200
Subject: [PATCH v2] ARM: dts: sun5i: Enable touchscreen on Utoo P66
In-Reply-To: <20150404124458.GI14618@lukather>
References: <1427902177-26526-1-git-send-email-hdegoede@redhat.com>
 <20150404124458.GI14618@lukather>
Message-ID: <551FE565.6050800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-04-15 14:44, Maxime Ripard wrote:
> Hi Hans,
>
> On Wed, Apr 01, 2015 at 05:29:37PM +0200, Hans de Goede wrote:
>> Add a node for the chipone-icn8318 touchscreen found on the Utoo P66 tablet.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Fix touchscreen node name
>> ---
>>   arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
>> index 9108ecd..00bdf28 100644
>> --- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
>> +++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
>> @@ -50,6 +50,7 @@
>>   #include "sunxi-common-regulators.dtsi"
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/pinctrl/sun4i-a10.h>
>>
>>   / {
>> @@ -93,6 +94,20 @@
>>   	pinctrl-0 = <&i2c1_pins_a>;
>>   	status = "okay";
>>
>> +	icn8318: touchscreen at 40 {
>> +		compatible = "chipone,icn8318";
>> +		reg = <0x40>;
>> +		interrupt-parent = <&pio>;
>> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
>
> I don't think you sent a reply to this comment, but this should really
> be in a pinctrl node so that no one else can request the pin and
> change its muxing and it shows up in debugfs.

I did reply to that comment on v1 of this patch:

"""
That is not necessary when specifying a gpio interrupt through the
irq chip (rather then through a gpios property), the mux is automatically
set to irq by the kernel when requesting the irq.

Also note that we must use the interrupts notation here as this is specified
by the i2c client bindings. None of the other boards using i2c + oob irq
pins specifies a pinmux for the irq pin either.
"""

I've just double checked and I cannot (quickly) find any existing devicetree
files using interrupts = <foo> combined with pinctrl for i2c clients.

If you look in e.g. arch/arm/boot/dts/exynos4210-trats.dts and
arch/arm/boot/dts/exynos4412-trats2.dts you will see the same pattern of
using interrupts = <foo> pointing to a gpio without using pinctrl

And we already to the same for sdio oob interrupts in sun7i-a20-cubietruck.dts
and arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts, so I vote for being consistent
here and not using pinctrl for the irq pin here either.

Regards,

Hans
