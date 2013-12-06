From: quozl@laptop.org (James Cameron)
Date: Fri, 6 Dec 2013 13:42:11 +1100
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
Message-ID: <20131206024211.GK16425@us.netrek.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.

[...]

> +/* Uart divisor latch write */
> +static void serial_pxa_dl_write(struct uart_8250_port *up, int value)
> +{
> +	serial_out(up, UART_DLL, value & 0xff);
> +	serial_out(up, UART_DLM, value >> 8 & 0xff);
> +}

This is a change.  drivers/tty/serial/pxa.c did read back UART_DLL as
an errata work around:

> -	/*
> -	 * work around Errata #75 according to Intel(R) PXA27x Processor Family
> -	 * Specification Update (Nov 2005)
> -	 */
> -	dll = serial_in(up, UART_DLL);
> -	WARN_ON(dll != (quot & 0xff));

If this is no longer needed, serial_pxa_dl_write can be removed
because it is same as default_serial_dl_write.

I did not check the other errata work arounds.

--
James Cameron
http://quozl.linux.org.au/
