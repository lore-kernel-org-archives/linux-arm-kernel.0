From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 21 Aug 2012 16:12:11 +0530
Subject: [RFC/PATCH 10/13] serial: omap: stick to put_autosuspend
In-Reply-To: <1345540555-24359-11-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-11-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gzm4z8DbCiz4hOS2nKa2HzNofmp=SPORYEu2Z_H3+JN9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> Everytime we're done using our TTY, we want
> the pm timer to be reinitilized. By sticking
> to pm_runtime_pm_autosuspend() we make sure
> that this will always be the case.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 6ea24c5..458d77c 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -164,7 +164,8 @@ static void serial_omap_enable_ms(struct uart_port *port)
>         pm_runtime_get_sync(up->dev);
>         up->ier |= UART_IER_MSI;
>         serial_out(up, UART_IER, up->ier);
> -       pm_runtime_put(up->dev);
> +       pm_runtime_mark_last_busy(up->dev);
> +       pm_runtime_put_autosuspend(up->dev);
>  }
>
Can you please expand the change-log a bit ?
Didn't follow the time re-init part completely.

Regards
Santosh
