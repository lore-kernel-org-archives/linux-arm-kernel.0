From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 14 Aug 2014 13:09:36 -0700
Subject: [PATCH] spi: rockchip: return 0 if tx_buf and rx_buf are NULL
In-Reply-To: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
References: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140814200936.GA13458@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

On Thu, Aug 14, 2014 at 08:52:24AM +0800, Addy Ke wrote:
> To do so, spi communication can use an empty buf to pull up CS.
> 
> This patch merged from ChromiumOS tree.
> Cros_ec use this function to turn off CS and add a delay to ensure
> the rising edge doesn't come too soon after the end of the data.
> 
> Tested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/spi/spi-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 72fb287..1e3bcfa 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -511,8 +511,8 @@ static int rockchip_spi_transfer_one(struct spi_master *master,
>  	WARN_ON((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
>  
>  	if (!xfer->tx_buf && !xfer->rx_buf) {
> -		dev_err(rs->dev, "No buffer for transfer\n");
> -		return -EINVAL;
> +		dev_dbg(rs->dev, "No buffer for transfer\n");
> +		return 0;
>  	}

Maybe we should only return 0 if xfer->len is also 0, otherwise keep
complaining loudly?

	if (!xfer->tx_buf && !xfer->rx_buf) {
		if (xfer->len == 0)
			return 0;

		dev_err(rs->dev, "Missing transfer buffer\n");
		return -EINVAL;
	}

Thanks.

-- 
Dmitry
