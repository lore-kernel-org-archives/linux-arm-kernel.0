From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Apr 2017 22:54:01 +0200
Subject: [PATCH RFC] serial: imx: support an enable-gpio
In-Reply-To: <CAL_JsqL8EQWoqyeyVb5Uj9ZaoB3Uz3yzbo114OR-FRrMEu8s=A@mail.gmail.com>
References: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5A4e7H-6feNN-cTABOKv+CUCU9Em_yFMhorZwXfeA-h0w@mail.gmail.com>
 <CAL_JsqL8EQWoqyeyVb5Uj9ZaoB3Uz3yzbo114OR-FRrMEu8s=A@mail.gmail.com>
Message-ID: <20170403205401.jiahqjemq7lymlil@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 03, 2017 at 03:25:23PM -0500, Rob Herring wrote:
> On Mon, Apr 3, 2017 at 10:01 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Uwe,
> >
> > On Wed, Jul 13, 2016 at 6:01 AM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> A part of my machine looks as follows (simplified):
> >>
> >> ,------------------------.
> >> | ,---------.            |
> >> | |  imx25  o--RX----?---o---
> >> | |         o--GPIO--'   |
> >> | `---------'            |
> >> `------------------------'
> >>
> >> that is, there is a driver on the RX line that must be enabled before
> >> the UART can be used. (That is necessary because the default mux of the
> >> RX pad after reset is an output.)
> >>
> >> To represent this in the device tree I do:
> >>
> >>         pinctrl_uart5: uart5 {
> >>                 fsl,pins = <
> >>                         ...
> >>                         MX25_PAD_LBA__UART5_RXD         0x00000000
> >>                         MX25_PAD_CS5__GPIO_3_21         0x00002001
> >>                         ...
> >>         };
> >>
> >>         &uart5 {
> >>                 pinctrl-names = "default";
> >>                 pinctrl-0 = <&pinctrl_uart5>;
> >>
> >>                 enable-gpio = <&gpio3 21 GPIO_ACTIVE_LOW>;
> 
> enable-gpios

ack.

> I imagine you already know this needs documentation. Make it common please.

Sure, I first wanted to collect some feedback to get an idea if this
would be accepted at all.

The only candidate for common code to add this functionality would be
uart_add_one_port. I wonder if this is early enough in every case.

> >>                 ...
> >>         };
> >>
> >> This way it's ensured that the gpio is only enabled when the LBA pad is
> >> muxed as RX (together with the bootloader that sets the GPIO high).
> >>
> >> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> > Since this is not imx serial specific it could be made more generic.
> >
> > What about extending
> > Documentation/devicetree/bindings/serial/slave-device.txt to handle
> > this GPIO, or maybe a regulator?

I could add a regulator that would do the right thing, that would not
match the hardware though.

> This is more like a phy than a device you talk to. It could also be
> something like an RS-232 xcvr enable (no one has done that already?).
> I think it belongs in the uart's node. You could additionally have an
> enable-gpios for a slave device.

Yes, I agree here, it is better defined in the uart's node, not in the
slave node.

Is xcvr-enable-gpios or xceiver-enable-gpios a better name?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
