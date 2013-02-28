From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Feb 2013 11:34:17 +0000
Subject: [PATCH] arm64: add support for uart earlyprintk
In-Reply-To: <1362049268-26822-1-git-send-email-apatel@apm.com>
References: <1362049268-26822-1-git-send-email-apatel@apm.com>
Message-ID: <512F40B9.6020105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/13 11:01, Anup Patel wrote:

Hi Anup,

> Signed-off-by: Anup Patel <apatel@apm.com>

A proper patch description would be nice.

> ---
>  arch/arm64/kernel/early_printk.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/kernel/early_printk.c b/arch/arm64/kernel/early_printk.c
> index 7e320a2..62953ed 100644
> --- a/arch/arm64/kernel/early_printk.c
> +++ b/arch/arm64/kernel/early_printk.c
> @@ -29,6 +29,21 @@ static void __iomem *early_base;
>  static void (*printch)(char ch);
>  
>  /*
> + * UART (8250/16550) single character TX.
> + */
> +static void uart_printch(char ch)
> +{
> +#define UART_LSR 	0x14
> +#define UART_TX 	0x0

Please use the constants defined in include/uapi/linux/serial_reg.h,
together with the proper shifts.

> +
> +	while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
> +		;

You may want to test both UART_LSR_TEMT and UART_LSR_THRE here.

> +	writeb_relaxed(ch, early_base + UART_TX);
> +	while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
> +		;

Why do you have to wait again here? It should be enough to do in only
once when entering the function.

> +}
> +
> +/*
>   * PL011 single character TX.
>   */
>  static void pl011_printch(char ch)
> @@ -47,6 +62,7 @@ struct earlycon_match {
>  
>  static const struct earlycon_match earlycon_match[] __initconst = {
>  	{ .name = "pl011", .printch = pl011_printch, },
> +	{ .name = "uart", .printch = uart_printch, },

"uart" is way too generic. pl011 is an UART too, and I suspect most of
the backends that are going to be added here over time will be UARTs.

"uart8250" would be a possibility (and actually consistent with the rest
of the kernel, see drivers/tty/serial/8250/8250_early.c.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
