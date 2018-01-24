From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Jan 2018 15:23:12 +0100
Subject: [PATCH 1/2] spi: a3700: Remove endianness swapping functions when
 accessing FIFOs
In-Reply-To: <1516803048-26942-2-git-send-email-maxime.chevallier@smile.fr>
 (Maxime Chevallier's message of "Wed, 24 Jan 2018 15:10:47 +0100")
References: <1516803048-26942-1-git-send-email-maxime.chevallier@smile.fr>
 <1516803048-26942-2-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <87k1w749pr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
 
 On mer., janv. 24 2018, Maxime Chevallier <maxime.chevallier@smile.fr> wrote:

> Fixes the following sparse warnings :
> line 504: warning: incorrect type in assignment (different base types)
> line 504:    expected unsigned int [unsigned] [usertype] val
> line 504:    got restricted __le32 [usertype] <noident>
> line 527: warning: cast to restricted __le32
>
> This is solved by removing endian-converson functions, since the
> converted values are going through readl/writel anyway, which take care
> of the conversion.
>

These changes look good for me:

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> Fixes: 6fd6fd68c9e2 ("spi: armada-3700: Fix padding when sending not 4-byte aligned data")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
> ---
>  drivers/spi/spi-armada-3700.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index a8576c89f713..43ee0b56fe1c 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -501,7 +501,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
>  	u32 val;
>  
>  	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
> -		val = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
> +		val = *(u32 *)a3700_spi->tx_buf;
>  		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
>  		a3700_spi->buf_len -= 4;
>  		a3700_spi->tx_buf += 4;
> @@ -524,9 +524,8 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
>  	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
>  		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
>  		if (a3700_spi->buf_len >= 4) {
> -			u32 data = le32_to_cpu(val);
>  
> -			memcpy(a3700_spi->rx_buf, &data, 4);
> +			memcpy(a3700_spi->rx_buf, &val, 4);
>  
>  			a3700_spi->buf_len -= 4;
>  			a3700_spi->rx_buf += 4;
> -- 
> 2.1.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
