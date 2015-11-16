From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 17:52:17 +0000
Subject: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
In-Reply-To: <564A1628.9010900@codeaurora.org>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk>
 <564A1628.9010900@codeaurora.org>
Message-ID: <20151116175217.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 11:45:12AM -0600, Timur Tabi wrote:
> Russell King wrote:
> >Add support for 32-bit register accesses to the AMBA PL011 UART.  This
> >is needed for ZTE UARTs, which require 32-bit accesses as opposed to
> >the more normal 16-bit accesses.
> >
> >Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> >---
> >  drivers/tty/serial/amba-pl011.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> >index afa0de7d481f..3470a1e67bbc 100644
> >--- a/drivers/tty/serial/amba-pl011.c
> >+++ b/drivers/tty/serial/amba-pl011.c
> >@@ -93,6 +93,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
> >  struct vendor_data {
> >  	const u16		*reg_offset;
> >  	unsigned int		ifls;
> >+	bool			access_32b;
> 
> So no love for my suggestion to use port->iotype instead of this new field?
> 
> static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
>     unsigned int reg)
> {
>     void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> 
>     if (uap->port.iotype == UPIO_MEM32)
>         writel(val, addr);
>     else
>         writew(val, addr);
> }

Well, it looks a bit weird, because we use 16-bit accesses for other
values, and there isn't a UPIO_MEM16 type.  Although that could be
added, it's extending the scope of the patch to touching core files.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
