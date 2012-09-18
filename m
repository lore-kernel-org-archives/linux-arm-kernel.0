From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Sep 2012 17:02:17 +0300
Subject: [RFT/PATCH] serial: omap: prevent resume if device is not
 suspended.
In-Reply-To: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120918140213.GA27463@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 06:10:50PM +0530, Sourav Poddar wrote:
> Greg's tty-next is not booting on 2420 based N800. The failure is
> observed at serial init itself. The reason might be that n800 tries to
> resume even though it is not suspended before.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

Paul does this fix the issue for you ? Note that it depends on a
previous patch Sourav sent [1]

[1] http://marc.info/?l=linux-omap&m=134796819607889&w=2

There's one thing that gets my attention, though, why only n800 would
fail here ?

I wonder if we should be using:

pm_runtime_set_active(dev);
pm_runtime_get_enable(dev);

to prevent our runtime_resume() to be called from probe, but Sourav
tested and it doesn't work on BeagleBoard, but it works on PandaBoard.

Does it ring any bell ??

> ---
> This patch is developed on top of greg's tty-next branch
> CommitId: e740d8f tty: serial: Samsung: Fix return value +
> the following patch which I have already posted to the mailing list.
> http://comments.gmane.org/gmane.linux.ports.arm.omap/84729
> 
>  drivers/tty/serial/omap-serial.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 3c05c5e..bc355f2 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -110,6 +110,7 @@ struct uart_omap_port {
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
>  	struct pinctrl		*pins;
> +	unsigned int		suspended:1;
>  };
>  
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> @@ -1545,14 +1546,20 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
>  	schedule_work(&up->qos_work);
>  
> +	up->suspended = true;
> +
>  	return 0;
>  }
>  
>  static int serial_omap_runtime_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> +	u32 loss_cnt;
> +
> +	if (!up->suspended)
> +		return 0;
>  
> -	u32 loss_cnt = serial_omap_get_context_loss_count(up);
> +	loss_cnt = serial_omap_get_context_loss_count(up);
>  
>  	if (up->context_loss_cnt != loss_cnt)
>  		serial_omap_restore_context(up);
> @@ -1560,6 +1567,8 @@ static int serial_omap_runtime_resume(struct device *dev)
>  	up->latency = up->calc_latency;
>  	schedule_work(&up->qos_work);
>  
> +	up->suspended = false;
> +
>  	return 0;
>  }
>  #endif
> -- 
> 1.7.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120918/c854c223/attachment-0001.sig>
