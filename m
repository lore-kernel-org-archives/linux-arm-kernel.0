From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 23 Oct 2015 11:31:00 +0100
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size
 in pl011_fifo_to_tty()"
In-Reply-To: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20151023103056.GI4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 06:00:00PM +0800, Huang Shijie wrote:
> The commit 71a5cd8a4 makes the console hang for some times.
> This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.

What hangs?  Input?  Output?  Both?

Is CREAD set on the terminal?  If only input hangs, it's possible CREAD
is not set and we were previously getting away with it, though I can't
easily see why it should be unset...

Cheers
---Dave

> 
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 899a771..fd27e98 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -191,8 +191,8 @@ struct uart_amba_port {
>   */
>  static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  {
> -	u16 status;
> -	unsigned int ch, flag, max_count = 256;
> +	u16 status, ch;
> +	unsigned int flag, max_count = 256;
>  	int fifotaken = 0;
>  
>  	while (max_count--) {
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
