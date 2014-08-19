From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Aug 2014 13:57:02 -0500
Subject: [RFC PATCH 3/4] tty: omap-serial: use threaded interrupt handler
In-Reply-To: <1408450488-4083-4-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-4-git-send-email-frans.klaver@xsens.com>
Message-ID: <20140819185701.GC22003@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 02:14:47PM +0200, Frans Klaver wrote:
> At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
> rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
> this to about 170 overflows in 10 minutes.

Can you try Sebastian Siewior's patches for 8250_omap and 8250 dma
support ? That should help you a lot.

> In practice this therefore reduces the need for hardware flow control,
> meaning the sending side doesn't have to buffer as much either.
> 
> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> ---
>  drivers/tty/serial/omap-serial.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 14a0167..57664b9 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -575,6 +575,21 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
>  }
>  
>  /**
> + * serial_omap_fast_irq() - schedule interrupt handling
> + */
> +static irqreturn_t serial_omap_fast_irq(int irq, void *dev_id)
> +{
> +	struct uart_omap_port *up = dev_id;
> +	unsigned int iir = serial_in(up, UART_IIR);
> +
> +	if (iir & UART_IIR_NO_INT)
> +		return IRQ_NONE;
> +
> +	disable_irq_nosync(up->port.irq);

NAK. Either use IRQF_ONESHOT or actually mask the IRQs at the device's
registers (basically clearing IER).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140819/4ef11b5a/attachment.sig>
