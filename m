From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 7 Apr 2011 14:01:29 +0800
Subject: [PATCH] spi: Fix race condition in stop_queue()
In-Reply-To: <1302101355-31187-1-git-send-email-anarsoul@gmail.com>
References: <201104061746.44134.anarsoul@gmail.com>
	<1302101355-31187-1-git-send-email-anarsoul@gmail.com>
Message-ID: <BANLkTiku8538Q9wabEeoXi7scQbmc0U7yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 10:49 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> There's a race condition in stop_queue() in some drivers -
> if drv_data->queue is empty, but drv_data->busy is still set
> (or opposite situation) stop_queue will return -EBUSY.
> So fix loop condition to check that both drv_data->queue is empty
> and drv_data->busy is not set.
>
> This patch affects following drivers:
> pxa2xx_spi
> spi_bfin5xx
> amba-pl022
> dw_spi
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> ?drivers/spi/amba-pl022.c ?| ? ?2 +-
> ?drivers/spi/dw_spi.c ? ? ?| ? ?2 +-
> ?drivers/spi/pxa2xx_spi.c ?| ? ?2 +-
> ?drivers/spi/spi_bfin5xx.c | ? ?2 +-
> ?4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 71a1219..23aaaa9 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1553,7 +1553,7 @@ static int stop_queue(struct pl022 *pl022)
> ? ? ? ? * A wait_queue on the pl022->busy could be used, but then the common
> ? ? ? ? * execution path (pump_messages) would be required to call wake_up or
> ? ? ? ? * friends on every SPI message. Do this instead */
> - ? ? ? while (!list_empty(&pl022->queue) && pl022->busy && limit--) {
> + ? ? ? while ((!list_empty(&pl022->queue) || pl022->busy) && limit--) {
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&pl022->queue_lock, flags);
> ? ? ? ? ? ? ? ?msleep(10);
> ? ? ? ? ? ? ? ?spin_lock_irqsave(&pl022->queue_lock, flags);
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index 22af77f..b53be4d 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -821,7 +821,7 @@ static int stop_queue(struct dw_spi *dws)
>
> ? ? ? ?spin_lock_irqsave(&dws->lock, flags);
> ? ? ? ?dws->run = QUEUE_STOPPED;
> - ? ? ? while (!list_empty(&dws->queue) && dws->busy && limit--) {
> + ? ? ? while ((!list_empty(&dws->queue) || dws->busy) && limit--) {
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&dws->lock, flags);
> ? ? ? ? ? ? ? ?msleep(10);
> ? ? ? ? ? ? ? ?spin_lock_irqsave(&dws->lock, flags);
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index 9592883..39cc10f 100644
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
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index 3f22351..0e14f40 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -1244,7 +1244,7 @@ static inline int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
> ? ? ? ? * friends on every SPI message. Do this instead
> ? ? ? ? */
> ? ? ? ?drv_data->running = false;
> - ? ? ? while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
> + ? ? ? while ((!list_empty(&drv_data->queue) || drv_data->busy) && limit--) {
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&drv_data->lock, flags);
> ? ? ? ? ? ? ? ?msleep(10);
> ? ? ? ? ? ? ? ?spin_lock_irqsave(&drv_data->lock, flags);
> --
> 1.7.4.1
>
>
