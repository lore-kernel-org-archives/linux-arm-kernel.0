From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 16:43:07 +0200
Subject: [PATCH 1/9] spi: sunxi: fix transfer timeout
In-Reply-To: <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820144307.GT30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:45PM -0000, Michal Suchanek wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 10 +++++++++-
>  drivers/spi/spi-sun6i.c | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index fbb0a4d..48532ec 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -170,6 +170,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  {
>  	struct sun4i_spi *sspi = spi_master_get_devdata(master);
>  	unsigned int mclk_rate, div, timeout;
> +	unsigned int start, end, tx_time;
>  	unsigned int tx_len = 0;
>  	int ret = 0;
>  	u32 reg;
> @@ -279,9 +280,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>  	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>  
> +	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
> +	start = jiffies;
>  	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(1000));
> +					      msecs_to_jiffies(tx_time));
> +	end = jiffies;
>  	if (!timeout) {
> +		dev_warn(&master->dev,
> +			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
> +			 dev_name(&spi->dev), tfr->len, speed,
> +			 jiffies_to_msecs(end - start), tx_time);

Timeout already contains the number of jiffies elapsed (and I'm not
sure anyone reading that message would get that the last number is
actually the maximum timeout).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/ca920d73/attachment.sig>
