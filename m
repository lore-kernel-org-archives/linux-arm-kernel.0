From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 25 Feb 2012 12:27:41 +0100
Subject: [PATCH] Add poll_get_char & poll_put_char to uart_ops for the
 samsung UARTS.
In-Reply-To: <CAHQa92Vjwh3gtME2u19EZz57My3H7R=fQK4CoJR9s_ktpsy_Ww@mail.gmail.com>
References: <20120212182201.GA17975@debian>
 <CAHQa92X=9kiVhxCspcAR+dK-NbFqaUW2xTCjjDOAHGfDx_yMBQ@mail.gmail.com>
 <CAHQa92Vjwh3gtME2u19EZz57My3H7R=fQK4CoJR9s_ktpsy_Ww@mail.gmail.com>
Message-ID: <201202251227.42284.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag 25 Februar 2012, 12:05:56 schrieb Pichon Julien:
> > (please CC me in your replies as I am not suscribed to the ML)
> > 
> > The following patch allows users to use KGDB over serial console on
> > board based on Samsung SOC. It has been tested on a mini2440.
> > 
> > Signed-off-by: Julien Pichon <pichon.jln@gmail.com>
> > ---
> >  drivers/tty/serial/samsung.c |   50
> > ++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 50
> > insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index f96f37b..9f703ca 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -877,11 +877,24 @@ s3c24xx_serial_verify_port(struct uart_port *port,
> > struct serial_struct *ser)
> > 
> >  static struct console s3c24xx_serial_console;
> > 
> > +static int __init s3c24xx_serial_console_init(void)
> > +{
> > +     register_console(&s3c24xx_serial_console);
> > +     return 0;
> > +}
> > +console_initcall(s3c24xx_serial_console_init);
> > +
> >  #define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> >  #else
> >  #define S3C24XX_SERIAL_CONSOLE NULL
> >  #endif
> > 
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int s3c24xx_serial_get_poll_char(struct uart_port *port);
> > +static void s3c24xx_serial_put_poll_char(struct uart_port *port,
> > +                      unsigned char c);
> > +#endif
> > +
> >  static struct uart_ops s3c24xx_serial_ops = {
> >       .pm             = s3c24xx_serial_pm,
> >       .tx_empty       = s3c24xx_serial_tx_empty,
> > @@ -900,6 +913,10 @@ static struct uart_ops s3c24xx_serial_ops = {
> >       .request_port   = s3c24xx_serial_request_port,
> >       .config_port    = s3c24xx_serial_config_port,
> >       .verify_port    = s3c24xx_serial_verify_port,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +     .poll_get_char = s3c24xx_serial_get_poll_char,
> > +     .poll_put_char = s3c24xx_serial_put_poll_char,
> > +#endif
> >  };
> > 
> >  static struct uart_driver s3c24xx_uart_drv = {
> > @@ -1311,6 +1328,39 @@ s3c24xx_serial_console_txrdy(struct uart_port
> > *port, unsigned int ufcon) return (utrstat & S3C2410_UTRSTAT_TXE) ? 1 :
> > 0;
> >  }
> > 
> > +#ifdef CONFIG_CONSOLE_POLL
> > +/*
> > + * Console polling routines for writing and reading from the uart while
> > + * in an interrupt or debug context.
> > + */
> > +
> > +static int s3c24xx_serial_get_poll_char(struct uart_port *port)
> > +{
> > +     struct s3c24xx_uart_port *ourport = to_ourport(port);
> > +     unsigned int ufstat, count;
> > +
> > +     do {
> > +             ufstat = rd_regl(port, S3C2410_UFSTAT);
> > +             count = s3c24xx_serial_rx_fifocnt(ourport, ufstat);
> > +             if (!count)
> > +                     cpu_relax();
> > +     } while (!count);
> > +
> > +     return rd_regb(port, S3C2410_URXH);
> > +}
> > +
> > +static void s3c24xx_serial_put_poll_char(struct uart_port *port,
> > +             unsigned char c)
> > +{
> > +     unsigned int ufcon = rd_regl(cons_uart, S3C2410_UFCON);
> > +
> > +     while (!s3c24xx_serial_console_txrdy(port, ufcon))
> > +             cpu_relax();
> > +     wr_regb(cons_uart, S3C2410_UTXH, c);
> > +}
> > +
> > +#endif /* CONFIG_CONSOLE_POLL */
> > +
> >  static void
> >  s3c24xx_serial_console_putchar(struct uart_port *port, int ch)
> >  {
> > --
> > 1.7.2.5
> 
> (CC maintainers)
> Someone has time to review this patch ?

It might be goot to included the linux-arm-kernel list to get a wider 
audience. I always felt, that the samsung ml isn't read by many.

Heiko
