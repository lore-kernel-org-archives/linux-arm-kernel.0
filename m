From: diego.rondini@kynetics.com (Diego Rondini)
Date: Mon, 30 Jul 2018 11:17:44 +0200
Subject: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
In-Reply-To: <20180730084519.iqyhvocxsfuopze7@flea>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
 <20180730084519.iqyhvocxsfuopze7@flea>
Message-ID: <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, Jul 30, 2018 at 10:45 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Jul 27, 2018 at 02:57:39PM +0200, Diego Rondini wrote:
>> +/dts-v1/;
>> +
>> +#include "sun8i-h3.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "OrangePi Zero Plus2 H3";
>> +     compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";
>
> The H5 version doesn't make that easy, and it's unfortunate, but we
> should have a different compatible for the H3 and H5 versions.
>
> What about something like xunlong,orangepi-zero-plus2-h3?

Yes, I think this is the only reasonable option. I'll send v2.

>
>> +&uart1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>> +     status = "okay";
>> +};
>
> I guess it is the BT chip? Which chip is it?

Yes, according to schematics Bluetooth is on uart1.
It's an Ampak 6212A with a Broadcom 43438 chip. To my understanding
it's the same chip in the Raspberry Pi 3 B / B+ and Raspberry Zero W.

I've tried to integrate support for Bluetooth with the following:

&uart1 {
    pinctrl-names = "default";
    pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
    status = "okay";

    bluetooth {
        compatible = "brcm,bcm43438-bt";
        max-speed = <2000000>;
        shutdown-gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
        device-wakeup-gpios = <&pio 9 2 GPIO_ACTIVE_HIGH>; /* PL2 */
        host-wakeup-gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>; /* PA20 */
    };
};

but the hci_bcm driver doesn't load automatically and doesn't probe
the device when loaded manually. I haven't investigated further.


Diego Rondini
Sr. Embedded Engineer

Kynetics
www.kynetics.com
