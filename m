From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 19 May 2011 19:04:29 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
In-Reply-To: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, May 19, 2011 at 6:05 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Magnus Templing <magnus.templing@stericsson.com>
>
> This adds the missing handling of polling timeouts and deletes
> our last todo.
>
> Signed-off-by: Magnus Templing <magnus.templing@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> [Fixups from review by Wolfram Sang]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?drivers/spi/amba-pl022.c | ? 23 +++++++++++++++--------
> ?1 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 08de58e..18667de 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -24,11 +24,6 @@
> ?* GNU General Public License for more details.
> ?*/
>
> -/*
> - * TODO:
> - * - add timeout on polled transfers
> - */
> -
> ?#include <linux/init.h>
> ?#include <linux/module.h>
> ?#include <linux/device.h>
> @@ -287,6 +282,8 @@
>
> ?#define CLEAR_ALL_INTERRUPTS ?0x3
>
> +#define SPI_POLLING_TIMEOUT 1000
> +
>
> ?/*
> ?* The type of reading going on on this chip
> @@ -1378,6 +1375,7 @@ static void do_polling_transfer(struct pl022 *pl022)
> ? ? ? ?struct spi_transfer *transfer = NULL;
> ? ? ? ?struct spi_transfer *previous = NULL;
> ? ? ? ?struct chip_data *chip;
> + ? ? ? unsigned long time, timeout;
>
> ? ? ? ?chip = pl022->cur_chip;
> ? ? ? ?message = pl022->cur_msg;
> @@ -1415,9 +1413,18 @@ static void do_polling_transfer(struct pl022 *pl022)
> ? ? ? ? ? ? ? ? ? ? ? SSP_CR1(pl022->virtbase));
>
> ? ? ? ? ? ? ? ?dev_dbg(&pl022->adev->dev, "polling transfer ongoing ...\n");
> - ? ? ? ? ? ? ? /* FIXME: insert a timeout so we don't hang here indefinitely */
> - ? ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
> +
> + ? ? ? ? ? ? ? timeout = jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
> + ? ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
> + ? ? ? ? ? ? ? ? ? ? ? time = jiffies;
> ? ? ? ? ? ? ? ? ? ? ? ?readwriter(pl022);
> + ? ? ? ? ? ? ? ? ? ? ? if (time_after(time, timeout)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_warn(&pl022->adev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "%s: timeout!\n", __func__);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? message->state = STATE_ERROR;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto out;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }

just out of curiosity: is it a busy wait? Looks like it is...

Thanks,
   Vitaly
