From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Jun 2017 12:01:50 +0200
Subject: [PATCH v2 4/9] serial: atmel: Use common rs485 device tree
 parsing function
In-Reply-To: <CACQ1gAh3jpcyPLexNgEU7KV0qX1Wor2dsLRV8LJYpA-1Wmp9SA@mail.gmail.com>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
 <20170623094945.31908-5-u.kleine-koenig@pengutronix.de>
 <CACQ1gAh3jpcyPLexNgEU7KV0qX1Wor2dsLRV8LJYpA-1Wmp9SA@mail.gmail.com>
Message-ID: <20170623100150.6dxgr2rq5fmf3mtb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 11:58:37AM +0200, Richard Genoud wrote:
> 2017-06-23 11:49 GMT+02:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > We just got a common helper for parsing the rs485 specific
> > device tree properties. Use it and drop the open coded parser.
> >
> > Note that there is a small difference between the removed and the now
> > used implementation: The former cleared flags to 0 if rs485-rts-delay
> > was given, the common helper clears SER_RS485_RX_DURING_TX and
> > SER_RS485_ENABLED only but always which makes more sense.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > [ukleinek: point out semantic change in commit log]
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v1:
> >  - as I dropped my two atmel patches and used Alexandre Belloni's (that are
> >    already in next) instead, there are a few changes that are necessary to
> >    adapt to the new base.
> >
> >  drivers/tty/serial/atmel_serial.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index 937d67f22fba..357570a216ad 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -1689,22 +1689,7 @@ static void atmel_init_rs485(struct uart_port *port,
> >  {
> >         struct device_node *np = pdev->dev.of_node;
> >
> > -       struct serial_rs485 *rs485conf = &port->rs485;
> > -       u32 rs485_delay[2];
> > -
> > -       /* rs485 properties */
> > -       if (of_property_read_u32_array(np, "rs485-rts-delay",
> > -                                      rs485_delay, 2) == 0) {
> > -               rs485conf->delay_rts_before_send = rs485_delay[0];
> > -               rs485conf->delay_rts_after_send = rs485_delay[1];
> > -               rs485conf->flags = 0;
> > -       }
> > -
> > -       if (of_get_property(np, "rs485-rx-during-tx", NULL))
> > -               rs485conf->flags |= SER_RS485_RX_DURING_TX;
> > -
> > -       if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
> > -               rs485conf->flags |= SER_RS485_ENABLED;
> > +       of_get_rs485_mode(np, &port->rs485);
> >  }
> 
> as atmel_init_rs485() is only used once in the code, what do you think of
> getting rid of it and just have something like:
> of_get_rs485_mode(pdev->dev.of_node, &port->rs485);
> in atmel_init_port() ?
> (possibly with a little comment)

Right, that is something that I thought once, too, but then forgot on
the other changes I still had to do. Noted for v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
