From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 5 Nov 2015 18:00:08 -0600
Subject: [PATCH 05/11] tty: amba-pl011: add register lookup table
In-Reply-To: <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
Message-ID: <563BED88.3040101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2015 08:51 AM, Russell King wrote:
>   enum {
> -	REG_DR = UART01x_DR,
> -	REG_ST_DMAWM = ST_UART011_DMAWM,
> -	REG_ST_TIMEOUT = ST_UART011_TIMEOUT,
> -	REG_FR = UART01x_FR,
> -	REG_ST_LCRH_RX = ST_UART011_LCRH_RX,
> -	REG_IBRD = UART011_IBRD,
> -	REG_FBRD = UART011_FBRD,
> -	REG_LCRH = UART011_LCRH,
> -	REG_ST_LCRH_TX = ST_UART011_LCRH_TX,
> -	REG_CR = UART011_CR,
> -	REG_IFLS = UART011_IFLS,
> -	REG_IMSC = UART011_IMSC,
> -	REG_RIS = UART011_RIS,
> -	REG_MIS = UART011_MIS,
> -	REG_ICR = UART011_ICR,
> -	REG_DMACR = UART011_DMACR,
> -	REG_ST_XFCR = ST_UART011_XFCR,
> -	REG_ST_XON1 = ST_UART011_XON1,
> -	REG_ST_XON2 = ST_UART011_XON2,
> -	REG_ST_XOFF1 = ST_UART011_XOFF1,
> -	REG_ST_XOFF2 = ST_UART011_XOFF2,
> -	REG_ST_ITCR = ST_UART011_ITCR,
> -	REG_ST_ITIP = ST_UART011_ITIP,
> -	REG_ST_ABCR = ST_UART011_ABCR,
> -	REG_ST_ABIMSC = ST_UART011_ABIMSC,
> +	REG_DR,
> +	REG_ST_DMAWM,
> +	REG_ST_TIMEOUT,
> +	REG_FR,
> +	REG_ST_LCRH_RX,
> +	REG_IBRD,
> +	REG_FBRD,
> +	REG_LCRH,
> +	REG_ST_LCRH_TX,
> +	REG_CR,
> +	REG_IFLS,
> +	REG_IMSC,
> +	REG_RIS,
> +	REG_MIS,
> +	REG_ICR,
> +	REG_DMACR,
> +	REG_ST_XFCR,
> +	REG_ST_XON1,
> +	REG_ST_XON2,
> +	REG_ST_XOFF1,
> +	REG_ST_XOFF2,
> +	REG_ST_ITCR,
> +	REG_ST_ITIP,
> +	REG_ST_ABCR,
> +	REG_ST_ABIMSC,
> +
> +	/* The size of the array - must be last */
> +	REG_ARRAY_SIZE,
>   };

This breaks early console because REG_DR and REG_FR are now enums 
instead of an actual register offset, and so

static void pl011_putc(struct uart_port *port, int c)
{
	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
		;
	writeb(c, port->membase + REG_DR);
	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
		;
}

is wrong.  I get alignment violations because REG_FR is equal to 3 
instead of 0x18.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
