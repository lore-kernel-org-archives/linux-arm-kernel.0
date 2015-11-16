From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 16 Nov 2015 11:45:12 -0600
Subject: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
In-Reply-To: <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk>
Message-ID: <564A1628.9010900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> Add support for 32-bit register accesses to the AMBA PL011 UART.  This
> is needed for ZTE UARTs, which require 32-bit accesses as opposed to
> the more normal 16-bit accesses.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   drivers/tty/serial/amba-pl011.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index afa0de7d481f..3470a1e67bbc 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -93,6 +93,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>   struct vendor_data {
>   	const u16		*reg_offset;
>   	unsigned int		ifls;
> +	bool			access_32b;

So no love for my suggestion to use port->iotype instead of this new field?

static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
     unsigned int reg)
{
     void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);

     if (uap->port.iotype == UPIO_MEM32)
         writel(val, addr);
     else
         writew(val, addr);
}

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
