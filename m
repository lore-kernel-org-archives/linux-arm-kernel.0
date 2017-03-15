From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 15 Mar 2017 17:19:11 +0100
Subject: [RFC PATCH] tty/serial: atmel: fix TX path in
 atmel_console_write()
In-Reply-To: <20170315152948.10978-1-nicolas.ferre@microchip.com>
References: <CACQ1gAgW4aGJSxSAXDWL7td9eV12UV=Xv=PZR58BqqHxEeRH0g@mail.gmail.com>
 <20170315152948.10978-1-nicolas.ferre@microchip.com>
Message-ID: <074d057e-4971-a325-e985-3f5046536225@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/2017 16:29, Nicolas Ferre wrote:
> A side effect of 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA
> from transmitting in stop_tx") is that the console can be called with
> TX path disabled. Then the system would hang trying to push charecters
> out in atmel_console_putchar().
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Fixes: 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA from transmitting
> in stop_tx")
> Cc: stable <stable@vger.kernel.org> # 4.4+
> ---
> Hi Richard,
> 
> I found this to fix the problem with system hang in my linux-4.4-at91 branch
> (in the atmel_console_putchar() waiting loop actually). I'm open to more
> insignt.
> As we cannot figure out if this bit is set or not, I didn't preserve the
> current status...
> 
> Regards,

So, I'm guessing that you may see some lines/characters printed twice on
the screen, don't you ?


>  drivers/tty/serial/atmel_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index dcebb28ffbc4..7372dbdb7a4c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2483,6 +2483,9 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
>  	pdc_tx = atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN;
>  	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>  
> +	/* Make sure that tx path is actually able to send characters */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
> +
>  	uart_console_write(port, s, count, atmel_console_putchar);
>  
>  	/*
> 

Richard.
