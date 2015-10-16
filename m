From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 16 Oct 2015 13:48:03 +0100
Subject: [PATCH] serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()
In-Reply-To: <1444249636-25661-1-git-send-email-timur@codeaurora.org>
References: <1444249636-25661-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151016124733.GA4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 03:27:16PM -0500, Timur Tabi wrote:
> The UART_DUMMY_DR_RX status bit is equal to (1 << 16), so a u16 is too small
> to hold that value.  The result is that UART_DUMMY_DR_RX is never passed
> to uart_insert_char().  This means that we're always accepting characters,
> even when CREAD (in termios) is not set.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index fd27e98..899a771 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -191,8 +191,8 @@ struct uart_amba_port {
>   */
>  static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  {
> -	u16 status, ch;
> -	unsigned int flag, max_count = 256;
> +	u16 status;
> +	unsigned int ch, flag, max_count = 256;
>  	int fifotaken = 0;

FWIW,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

I guess this tells us something about how often !CREAD is used...

Cheers
---Dave
