From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 14 Apr 2016 07:39:40 -0700
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
In-Reply-To: <20160414133237.GE2092@tarshish>
References: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
 <20160414133237.GE2092@tarshish>
Message-ID: <CAJ+vNU3-Ht7mVUn+T6n1YmYMwxzAW7X-ryccCZw0U_uNiGv2=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 6:32 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Tim,
>
> On Thu, Apr 14, 2016 at 06:19:09AM -0700, Tim Harvey wrote:
>> The GW52xx/GW53xx/GW54xx have an on-board RS485 transceiver for half-duplex
>> RS485 using uart1. The active-high TXEN is GPIO7__IO1 which we can configure
>> as the rts-gpio as long as we specify it as active-low to invert the polarity
>> managed by mctrl_gpio helpers. This allows for RS485 to be used from
>> userspace by setting flags to SER_RS485_RTS_ON_SEND in the serial_rs485
>> struct when using the TIOCGRS485 ioctl.
>
> Do you use http://article.gmane.org/gmane.linux.ports.arm.kernel/482641 for
> that?

Baruch,

No - that wasn't in my tree, but I will test it and respond to that thread.

>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 +++
>>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 +++
>>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 +++
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> index 8cccc4a..50d6039 100644
>> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
>> @@ -315,6 +315,8 @@
>>  &uart1 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_uart1>;
>> +     fsl,uart-has-rtscts;
>> +     rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;
>
> See http://marc.info/?l=linux-serial&m=146063601520851&w=2.

Thanks - I didn't see this one yet. I will change the prop and re-submit.

Does my model of defining rts-gpio active-low in dts because I'm using
this as an active-high TXEN make sense?

For reference, we use the MAX14840 transceiver and its DE (active high
transmit enable) is connected directly to GPIO7_IO1. If I define
rts-gpio as active-high and set SER_RS485_RTS_AFTER_SEND the polarity
is also correct on the scope during transmit but there is a funny high
pulse before transmit.

I honestly don't quite understand where there is a
SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND in
serial_rs485.flags as I would assume those are mutually exclusive and
there could have been just a single bit. Perhaps I'm missing something
there.

I'm also not sure if there is a desire to define the prop as
'rts-gpios' or 'rts-gpio' - both are picked up and there are many dts
props that use -gpios for a single gpio and I didn't see any
devicetree binding documentation for SERIAL_MCTRL_GPIO.

Regards,

Tim
