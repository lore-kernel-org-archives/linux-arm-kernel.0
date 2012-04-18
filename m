From: khilman@ti.com (Kevin Hilman)
Date: Tue, 17 Apr 2012 17:06:19 -0700
Subject: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
In-Reply-To: <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Mon, 16 Apr 2012 20:36:56 +0530")
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
 <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87bomprjic.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> In the error cases the clock cut is missed. This patch intends to fix the
> same.

Please change the references to 'cut clocks' in subject/changelog here
(and in other patches) to use runtime suspend instead.   First, runtime PM
calls do more than cut clocks, but they only do so when
usecounting/autosuspend timeouts permit.


> Cc: stable at vger.kernel.org

Please hold off on Cc'ing stable until your patches are reviewed and accepted.

> Cc: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index fe099bb..10e80bb 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -319,6 +319,8 @@ static void serial_omap_start_tx(struct uart_port *port)
>  
>  		if (ret < 0) {
>  			serial_omap_enable_ier_thri(up);
> +			pm_runtime_mark_last_busy(&up->pdev->dev);
> +			pm_runtime_put_autosuspend(&up->pdev->dev);

Why the autosuspend version here?

Kevin

>  			return;
>  		}
>  	}
> @@ -1029,8 +1031,10 @@ static int serial_omap_poll_get_char(struct uart_port *port)
>  
>  	pm_runtime_get_sync(&up->pdev->dev);
>  	status = serial_in(up, UART_LSR);
> -	if (!(status & UART_LSR_DR))
> +	if (!(status & UART_LSR_DR)) {
> +		pm_runtime_put(&up->pdev->dev);
>  		return NO_POLL_CHAR;
> +	}
>  
>  	status = serial_in(up, UART_RX);
>  	pm_runtime_put(&up->pdev->dev);
