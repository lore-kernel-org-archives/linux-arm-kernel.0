From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 23 Sep 2015 12:02:15 +0200
Subject: [PATCH v4 1/8] clk: imx: add common logic to detect early UART
 usage
In-Reply-To: <CAOMZO5CDnRjxzcnxCDgXKN5SVkCxGqR5dMaectdPvVzpsb9=bQ@mail.gmail.com>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
 <1442854444-4460-2-git-send-email-l.stach@pengutronix.de>
 <CAOMZO5CDnRjxzcnxCDgXKN5SVkCxGqR5dMaectdPvVzpsb9=bQ@mail.gmail.com>
Message-ID: <1443002535.25479.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 21.09.2015, 14:56 -0300 schrieb Fabio Estevam:
> On Mon, Sep 21, 2015 at 1:53 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Both earlycon and eralyprintk depend on the bootloader setup UART
> 
> s/eralyprintk/earlyprintk
> 
> > clocks being retained. This patch adds the common logic to detect such
> > situations and make the information available to the clock drivers, as
> > well as adding the facilities to disable those clocks at the end of
> > the kernel init.
> 
> > +void __init imx_register_uart_clocks(struct clk ** const clks[])
> > +{
> > +       if (imx_keep_uart_clocks) {
> > +               int i;
> > +
> > +               imx_uart_clocks = clks;
> > +               for (i = 0; imx_uart_clocks[i]; i++)
> > +                       clk_prepare_enable(*imx_uart_clocks[i]);
> 
> It would be better to check the return value from clk_prepare_enable()
> and propagate it in the case of error.
> 
I don't see any value of that. We certainly don't want to abort probing
of the clock driver just because keeping the debug UART clocks enabled
did not work. Everything in this series is about improving the debug
experience, so I'm not a fan of adding code that makes it more likely to
break (possibly unrelated) things.

> > +
> > +static int __init imx_clk_disable_uart(void)
> > +{
> > +       if (imx_keep_uart_clocks && imx_uart_clocks) {
> > +               int i;
> > +
> > +               for (i = 0; imx_uart_clocks[i]; i++)
> > +                       clk_disable_unprepare(*imx_uart_clocks[i]);
> > +       }
> > +
> > +       return 0;
> 
> This function could be made 'void' instead.

This is an initcall, which have a fixed function prototype.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
