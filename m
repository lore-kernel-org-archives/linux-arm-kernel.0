From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2016 16:19:14 +0100
Subject: [PATCH v8 4/4] serial: pl011: add console matching function
In-Reply-To: <fd9443e7-67f1-93e7-834b-445f9c29d876@linaro.org>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
 <c37d62c7-1e1b-0b10-a083-c5207fbbb820@gmail.com>
 <fd9443e7-67f1-93e7-834b-445f9c29d876@linaro.org>
Message-ID: <20160620151913.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 03:26:39PM +0300, Aleksey Makarov wrote:
> 
> On 06/02/2016 09:02 PM, Aleksey Makarov wrote:
> > 
> > On 05/20/2016 04:03 PM, Aleksey Makarov wrote:
> 
> Hi Russell,
> 
> Can you review this patch please?
> 
> Thank you
> Aleksey Makarov
> 
> >> This patch adds function pl011_console_match() that implements
> >> method match of struct console.  It allows to match consoles against
> >> data specified in a string, for example taken from command line or
> >> compiled by ACPI SPCR table handler.
> >>
> >> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> >> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> > 
> > Hi Greg, Russell,
> > 
> > Can you review this patch and consider ACKing it please?
> > It had an ACK from Greg in v7 but since then I changed it a bit.
> > 
> > The patch by Christopher Covington [1] specifies that SBSA uart 
> > does 32-bit access to registers and this breaks the match function.  
> > In this series the function was changed to match when SPCR specifies
> > both mmio32 and mmio access.  I removed Acked-by: Greg from this
> > patch because of these changes.
> > 
> > The difference between v7 and v8:
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 4139b64..388edc8 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2328,10 +2329,10 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
> >  
> >                 port = &amba_ports[i]->port;
> >  
> > -               if (port->iotype != iotype)
> > +               if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
> >                         continue;
> > -               if ((iotype == UPIO_MEM || iotype == UPIO_MEM32) &&
> > -                   (port->mapbase != addr))
> > +
> > +               if (port->mapbase != addr)
> >                         continue;
> >  
> >                 co->index = i;

I'm looking at this change, and I don't know what effect it ultimately
has.  This is kind of a problem, because I've zero knowledge of ACPI,
and so I can't say whether this change is appropriate or not.  I have
no ARM server platforms (yet), nor any access to them, so I can't even
try it out.

In short, I've no idea.  I guess it's up to those who have come up
with SBSA to decide whether this is an appropriate change or not.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
