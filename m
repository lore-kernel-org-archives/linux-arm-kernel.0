From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed, 9 Sep 2015 12:03:04 +0200
Subject: [PATCH v2 1/9] ARM: dts: imx6dql-nitrogen6x: add touchscreen
 support
In-Reply-To: <1441723760.3241.26.camel@pengutronix.de>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-2-git-send-email-gary.bisson@boundarydevices.com>
 <1441723760.3241.26.camel@pengutronix.de>
Message-ID: <CAAMH-ytWT12x8-h4zF7WfgxVPnZxq2hxkXC0MeP7ucTO-nYQbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 8, 2015 at 4:49 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Dienstag, den 08.09.2015, 16:34 +0200 schrieb Gary Bisson:
>> This patch adds the different touchscreens that can be connected using
>> the displays available for this board.
>> http://boundarydevices.com/product-category/displays/
>>
>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> index ad16dce..24b667d 100644
>> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> @@ -284,6 +284,22 @@
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_i2c3>;
>>       status = "okay";
>> +
>> +     egalax_ts at 04 {
>
> I'd prefer to use generic names for the nodes, such as "touchscreen at 04",
> and "touchscreen at 38" below.

Ok will do. Plus for the two new boards, I'll try to follow Russell comment.

>> +             compatible = "eeti,egalax_ts";
>> +             reg = <0x04>;
>> +             interrupt-parent = <&gpio1>;
>> +             interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
>> +             wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>> +     };
>> +
>> +     ft5x06_ts at 38 {
>> +             compatible = "edt,edt-ft5x06";
>> +             reg = <0x38>;
>> +             interrupt-parent = <&gpio1>;
>> +             interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
>> +             wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>
> This should be wake-gpios and GPIO_ACTIVE_HIGH according to the other
> users.

Actually I'm going to remove that line. First it should be wake-gpios
instead of wakeup-gpios. When I realized and changed it the driver
wouldn't work at all. Indeed looking at the source code and other
example it looks like it should be a different GPIO than the interrupt
one.

For the eGalax, the driver output a 1 and 0 to create the falling edge
that wakes the controller up and then releases the gpio as an input
for interrupts. But in the edt driver, the GPIO is kept as an output
which prevents from receiving any interrupt. Seems that the ft5x06
controllers on our display doesn't need any wake-up signal.

I'll submit a v3 very soon.

Regards,
Gary
