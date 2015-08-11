From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 11 Aug 2015 11:07:21 +0100
Subject: earlycon issues in -next with amba-pl011 updates
In-Reply-To: <55C94247.8020701@hurleysoftware.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <55C94247.8020701@hurleysoftware.com>
Message-ID: <20150811100721.GE10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Aug 10, 2015 at 08:31:03PM -0400, Peter Hurley wrote:
> > The issue only appears with earlycon on command line, for pl011
> > consoles.
> > 
> > Some investigation shows that the cause lies with
> > commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
> > and
> > commit 2c096a9eedc6 ("uart: pl011: Introduce register look up table")
> > 
> > Specifically, the changes to pl011_putc() are incorrect:
> > The new pl011_ accessors take a (struct uart_amba_port *) input, but
> > pl011_putc() directly uses the incoming (struct uart_port *) for this.
> > 
> > Apart from ending up with an unintended/incorrect UART base address,
> > the introduction of the lookup table for register offsets also means
> > the accessors try to dereference (struct uart_amba_port *)->reg_lut.
> 
> 
> Thanks for the bug report and bisect, and apologies for the breakage;
> I should have caught that on review.

I wouldn't have found it if I didn't have the boot failure to track
down, and I'm _not_ going to tell you how long I spent doing that.
 
> Would you please test the patch below and see if that resolves the
> problem for you?

Yeah, that's a more straightforward fix.

> PS - _NOT_ even compile-tested, sorry.
> 
> --- >% ---
> Subject: [PATCH] serial: pl011: Fix earlycon register LUT breakage
> 
> Commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
> mistakenly used the register LUT i/o accessors for the pl011
> earlycon. Since the port has not been probed at earlycon time,
> the struct uart_amba_port (and register LUTs) are uninitialized.
> 
> Use direct register addressing for pl011 earlycon; other h/w supported
> by the amba-pl011 driver should declare an alternate earlycon.
> 
> Cc: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2af09ab..fd54991 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2348,13 +2348,10 @@ static struct console amba_console = {
>  
>  static void pl011_putc(struct uart_port *port, int c)
>  {
> -	struct uart_amba_port *uap =
> -	    container_of(port, struct uart_amba_port, port);
> -
> -	while (pl011_readw(uap, REG_FR) & UART01x_FR_TXFF)
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>  		;
> -	pl011_writeb(uap, c, REG_DR);
> -	while (pl011_readw(uap, REG_FR) & uap->fr_busy)
> +	writeb(c, port->membase + UART01x_DR);
> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
>  		;
>  }
>  
> -- 
> 2.5.0

It works, but builds with:
drivers/tty/serial/amba-pl011.c:329:13: warning: ?pl011_writeb?
defined but not used [-Wunused-function]
 static void pl011_writeb(struct uart_amba_port *uap, u8 val, int
 index)
             ^
I was dithering about whether having _relaxed accessors in post boot
code and plain ones in earlycon was an issue, but I guess it doesn't
matter much.

/
    Leif
