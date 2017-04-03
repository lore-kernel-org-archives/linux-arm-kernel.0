From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 3 Apr 2017 12:01:11 -0300
Subject: [PATCH RFC] serial: imx: support an enable-gpio
In-Reply-To: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5A4e7H-6feNN-cTABOKv+CUCU9Em_yFMhorZwXfeA-h0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jul 13, 2016 at 6:01 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> A part of my machine looks as follows (simplified):
>
> ,------------------------.
> | ,---------.            |
> | |  imx25  o--RX----?---o---
> | |         o--GPIO--'   |
> | `---------'            |
> `------------------------'
>
> that is, there is a driver on the RX line that must be enabled before
> the UART can be used. (That is necessary because the default mux of the
> RX pad after reset is an output.)
>
> To represent this in the device tree I do:
>
>         pinctrl_uart5: uart5 {
>                 fsl,pins = <
>                         ...
>                         MX25_PAD_LBA__UART5_RXD         0x00000000
>                         MX25_PAD_CS5__GPIO_3_21         0x00002001
>                         ...
>         };
>
>         &uart5 {
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_uart5>;
>
>                 enable-gpio = <&gpio3 21 GPIO_ACTIVE_LOW>;
>                 ...
>         };
>
> This way it's ensured that the gpio is only enabled when the LBA pad is
> muxed as RX (together with the bootloader that sets the GPIO high).
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Since this is not imx serial specific it could be made more generic.

What about extending
Documentation/devicetree/bindings/serial/slave-device.txt to handle
this GPIO, or maybe a regulator?
