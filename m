From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Feb 2012 19:55:00 +0000
Subject: [PATCH] serial: samsung: disable irq before calling free_irq
In-Reply-To: <018301cce86a$ff609980$fe21cc80$@samsung.com>
References: <018301cce86a$ff609980$fe21cc80$@samsung.com>
Message-ID: <20120211195500.GW889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 12:12:33PM +0900, Huisung Kang wrote:
> From: Kisang Lee <kisang80.lee@samsung.com>
> 
> Pending UART irq may trigger spurious handling and may lead to
> softlockup. This patch will fix following softlockup.
> 
> Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>
> Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
> ---
>  drivers/tty/serial/samsung.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index c55e5fb..9067299 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -425,15 +425,19 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
>  
>  	if (ourport->tx_claimed) {
> -		if (!s3c24xx_serial_has_interrupt_mask(port))
> +		if (!s3c24xx_serial_has_interrupt_mask(port)) {
> +			disable_irq(ourport->tx_irq);
>  			free_irq(ourport->tx_irq, ourport);

Either genirq is broken or something else is going on.  Whatever, this is
not a valid bug fix.

Why?  If you have a pending IRQ at free_irq() time, then you may also have
a pending IRQ before disable_irq() time.  If the problem is that interrupt
causes a soft lockup, you're not really solving the issue.

Instead, if the problem is that free_irq() is removing the handler before
it masks the IRQ, then that's where the problem lies, but I doubt it -
the flow handlers are written such that if there isn't a handler in place,
they mask the interrupt themselves.

So, this needs much more explanation about the failure scenario.
