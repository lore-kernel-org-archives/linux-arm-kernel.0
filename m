From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Jun 2013 10:19:01 +0900
Subject: [PATCH 1/2] serial: sh-sci: HSCIF support
In-Reply-To: <201306171454.48936.arnd@arndb.de>
References: <1371440327-30512-1-git-send-email-horms+renesas@verge.net.au>
 <1371440327-30512-2-git-send-email-horms+renesas@verge.net.au>
 <201306171454.48936.arnd@arndb.de>
Message-ID: <20130618011901.GB2588@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 02:54:48PM +0200, Arnd Bergmann wrote:
> On Monday 17 June 2013, Simon Horman wrote:
> > -       if (likely(baud && port->uartclk))
> > -               t = sci_scbrr_calc(s->cfg->scbrr_algo_id, baud, port->uartclk);
> > +       if (likely(baud && port->uartclk)) {
> > +               if (s->cfg->scbrr_algo_id == SCBRR_ALGO_6) {
> > +                       sci_baud_calc_hscif(baud, port->uartclk, &t, &srr,
> > +                                           &cks);
> > +               } else {
> > +                       t = sci_scbrr_calc(s->cfg->scbrr_algo_id, baud,
> > +                                          port->uartclk);
> > +                       for (cks = 0; t >= 256 && cks <= 3; cks++)
> > +                               t >>= 2;
> > +               }
> > +       }
> 
> 
> This hunk causes build warnings in linux-next now:
> 
> /git/arm-soc/drivers/tty/serial/sh-sci.c: In function 'sci_set_termios':
> /git/arm-soc/drivers/tty/serial/sh-sci.c:1942:37: warning: 'srr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     serial_port_out(port, HSSRR, srr | HSCIF_SRE);
>                                      ^
> /git/arm-soc/drivers/tty/serial/sh-sci.c:1892:15: note: 'srr' was declared here
>   unsigned int srr;
>                ^
> /git/arm-soc/drivers/tty/serial/sh-sci.c:1938:47: warning: 'cks' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    serial_port_out(port, SCSMR, (smr_val & ~3) | cks);
>                                                ^
> /git/arm-soc/drivers/tty/serial/sh-sci.c:1890:40: note: 'cks' was declared here
>   unsigned int baud, smr_val, max_baud, cks;

Ulrich, could you please look into this?
