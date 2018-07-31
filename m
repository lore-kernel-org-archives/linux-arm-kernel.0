From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 16:15:16 +0200
Subject: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
In-Reply-To: <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
 <20180730084519.iqyhvocxsfuopze7@flea>
 <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
Message-ID: <20180731141516.t67esj3dlatvm7gg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 11:17:44AM +0200, Diego Rondini wrote:
> >> +&uart1 {
> >> +     pinctrl-names = "default";
> >> +     pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >> +     status = "okay";
> >> +};
> >
> > I guess it is the BT chip? Which chip is it?
> 
> Yes, according to schematics Bluetooth is on uart1.
> It's an Ampak 6212A with a Broadcom 43438 chip. To my understanding
> it's the same chip in the Raspberry Pi 3 B / B+ and Raspberry Zero W.
> 
> I've tried to integrate support for Bluetooth with the following:
> 
> &uart1 {
>     pinctrl-names = "default";
>     pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>     status = "okay";
> 
>     bluetooth {
>         compatible = "brcm,bcm43438-bt";
>         max-speed = <2000000>;
>         shutdown-gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
>         device-wakeup-gpios = <&pio 9 2 GPIO_ACTIVE_HIGH>; /* PL2 */
>         host-wakeup-gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>; /* PA20 */
>     };
> };
> 
> but the hci_bcm driver doesn't load automatically and doesn't probe
> the device when loaded manually. I haven't investigated further.

I would expect to have a clock and psosibly a regulator needed to
before being able to power the BT chip properly. You probably want to
double check the polarity of the GPIOs too.

At this point, the driver and the bindings are there, so there's no
real excuse to not enable it in the DT.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/edaf9adb/attachment-0001.sig>
