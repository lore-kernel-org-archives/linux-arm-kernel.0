From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Sep 2016 17:39:52 +0100
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
In-Reply-To: <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
Message-ID: <20160916163952.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 03:23:57PM +0100, Sudeep Holla wrote:
> Hi Shawn, Russell,
> 
> I noticed this change is in linux-next and but I happen to hit an issue
> with this as I tested it with earlycon enabled today for the first time.
> 
> On 08/07/16 10:00, Shawn Guo wrote:
> >For some reason we do not really understand, ZTE hardware designers
> >choose to define PL011 Flag Register bit positions differently from
> >standard ones as below.
> >
> >	Bit		Standard	ZTE
> >	-----------------------------------
> >	CTS		0		1
> >	DSR		1		3
> >	BUSY		3		8
> >	RI		8		0
> >
> >Let's define these bits into vendor data and get ZTE PL011 supported
> >properly.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> [...]
> 
> >@@ -2303,13 +2325,16 @@ static struct console amba_console = {
> >
> > static void pl011_putc(struct uart_port *port, int c)
> > {
> >+	struct uart_amba_port *uap =
> >+		container_of(port, struct uart_amba_port, port);
> >+
> > 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
> > 		cpu_relax();
> > 	if (port->iotype == UPIO_MEM32)
> > 		writel(c, port->membase + UART01x_DR);
> > 	else
> > 		writeb(c, port->membase + UART01x_DR);
> >-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
> >+	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
> > 		cpu_relax();
> > }
> 
> The above hunk won't work for early console devices. The earlycon_device
> just has uart_port and is not uart_amba_port. I don't know how to fix
> this properly but I thought we could reuse private_data in uart_port for
> early_con devices. Something like below(incomplete for other vendors,
> works only for ARM)

Unfortunate - I'm getting rather annoyed with the way vendors create
these derivatives of ARM hardware which then cause problems for the
kernel, springing up all these vendor specific hacks all over the
place.

Maybe what we should've done with ZTE is insisted that they implement
a complete new driver, rather than trying to shoe-horn it into PL011
even though it is in theory PL011.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
