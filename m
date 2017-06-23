From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Jun 2017 13:13:40 +0200
Subject: [PATCH 3/9] serial: atmel: Use common rs485 device tree parsing
 function
In-Reply-To: <8ab92dee-d9ba-0f7d-389c-e35a0f7f304c@gmail.com>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-4-u.kleine-koenig@pengutronix.de>
 <8ab92dee-d9ba-0f7d-389c-e35a0f7f304c@gmail.com>
Message-ID: <20170623111340.4osgybelqy5fzloz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 11:49:38AM +0200, Richard Genoud wrote:
> On 21/06/2017 12:21, Uwe Kleine-K?nig wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > We just got a common helper for parsing the rs485 specific
> > device tree properties. Use it and drop the open coded parser.
> > 
> > Note that the common function is more strict, so some device trees
> > needed fixing in the previous commit.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Cc: Richard Genoud <richard.genoud@gmail.com>
> > 
> >  drivers/tty/serial/atmel_serial.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index b753d2020068..a6b0c0087e2d 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -1706,22 +1706,7 @@ static void atmel_init_rs485(struct uart_port *port,
> >  	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
> >  
> >  	if (np) {
> > -		struct serial_rs485 *rs485conf = &port->rs485;
> > -		u32 rs485_delay[2];
> > -		/* rs485 properties */
> > -		if (of_property_read_u32_array(np, "rs485-rts-delay",
> > -					rs485_delay, 2) == 0) {
> > -			rs485conf->delay_rts_before_send = rs485_delay[0];
> > -			rs485conf->delay_rts_after_send = rs485_delay[1];
> > -			rs485conf->flags = 0;
> > -		}
> > -
> > -		if (of_get_property(np, "rs485-rx-during-tx", NULL))
> > -			rs485conf->flags |= SER_RS485_RX_DURING_TX;
> > -
> > -		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
> > -								NULL))
> > -			rs485conf->flags |= SER_RS485_ENABLED;
> > +		of_get_rs485_mode(np, &port->rs485);
> >  	} else if (pdata) {
> >  		port->rs485 = pdata->rs485;
> >  	} else {
> > 
> I don't kown if the serie will make it to 4.12, but as you may have
> noticed, this patch will break with tty-next.

I'm pretty sure it won't make it into 4.12 given we're already at -rc6.
And there is a v2 that should apply on top of tty-next. (I have it on
4.12-rc6 + the two patches by Alexandre Belloni.)

> In fact, you could get rid of atmel_init_rs485() and just replace it
> with of_get_rs485_mode() :)

As mentioned in the v2 thread I plan to do this for v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
