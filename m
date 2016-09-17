From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 17 Sep 2016 13:26:05 +0800
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
In-Reply-To: <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
Message-ID: <20160917052605.GF7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 03:23:57PM +0100, Sudeep Holla wrote:
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

Hi Sudeep,

Thanks much for the report.  I think the best way to fix this is that we
revert the change for pl011_putc() function, and figure out a correct
approach adding earlycon support for ZTE hardware later.

I will send a patch to revert pl011_putc() changes shortly.

Thanks,
Shawn
