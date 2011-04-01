From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 1 Apr 2011 15:26:37 +0800
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
In-Reply-To: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
References: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
Message-ID: <AANLkTikyrfYn02yg3S9_4vBGfon+BNHbPiQkaHaq_Xaq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 6:27 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> There's a race condition in stop_queue(),
> if drv_data->queue is empty, but drv_data->busy is still set
> (or opposite situation) stop_queue will return -EBUSY.
> So fix loop condition to check that both drv_data->queue is empty
> and drv_data->busy is not set.

I think this is a good catch if the queue could be stopped only when
1) queue is empty AND 2) transfer is not in progress.

There are several other places you might need to change accordingly,
e.g. spi_bfin5xx.c

>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> ?drivers/spi/pxa2xx_spi.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index a429b01..3aa7820 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1493,7 +1493,7 @@ static int stop_queue(struct driver_data *drv_data)
> ? ? ? ? * execution path (pump_messages) would be required to call wake_up or
> ? ? ? ? * friends on every SPI message. Do this instead */
> ? ? ? ?drv_data->run = QUEUE_STOPPED;
> - ? ? ? while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
> + ? ? ? while ((!list_empty(&drv_data->queue) || drv_data->busy) && limit--) {
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&drv_data->lock, flags);
> ? ? ? ? ? ? ? ?msleep(10);
> ? ? ? ? ? ? ? ?spin_lock_irqsave(&drv_data->lock, flags);
> --
> 1.7.4.1
>
>
