From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 29 Mar 2018 11:18:27 +0200
Subject: [PATCH] Allwinner SPI sun6i : add dual mode support.
In-Reply-To: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
References: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
Message-ID: <20180329091827.jfvrikkslavqms2n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maksims,

Thanks for your patch.

It looks pretty good, but there's a few things that you'll need to
adjust.

The prefix in your commit title should start with "spi: sun6i:
<title>", in this case "spi: sun6i: Add Dual Mode Support" would be
great.

On Tue, Mar 27, 2018 at 07:11:02PM +0300, Maksims Matjakubovs wrote:
> Added Dual mode half duplex Rx and Tx support to Allwinner sun6i/sun8i SPI driver.
> Main changes is related to SUN6I_BURST_CTL_CNT_REG register.
> SPI transmit is in Dual mode if STC (Master Single Mode Transmit Counter) is 0 and DRM (Master Dual Mode RX Enable) is not set.
> SPI receive is in Dual mode if DRM (Master Dual Mode RX Enable) is set.
> Tested on Allwinner V3s (sun8i) CPU.
> 
> Signed-off-by: Maksims Matjakubovs <maksims.matjakubovs@gmail.com>

This is mostly fine as well, but the commit log should be wrapped to
75 chars.

You'll find a tool to check for this kind of formatting and coding
style issues (and more) using scripts/checkpatch.pl (ideally with
--strict).

> ---
>  drivers/spi/spi-sun6i.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 8533f4e..2da52ed 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -84,6 +84,7 @@
>  
>  #define SUN6I_BURST_CTL_CNT_REG		0x38
>  #define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & SUN6I_MAX_XFER_SIZE)
> +#define SUN6I_BURST_CTL_CNT_DRM		BIT(28)
>  
>  #define SUN6I_TXDATA_REG		0x200
>  #define SUN6I_RXDATA_REG		0x300
> @@ -312,6 +313,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
>  	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
>  	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
> +			(tfr->tx_nbits == SPI_NBITS_DUAL) ? 0 :
> +			(tfr->rx_nbits == SPI_NBITS_DUAL) ? SUN6I_BURST_CTL_CNT_DRM :
>  			SUN6I_BURST_CTL_CNT_STC(tx_len));
>  
>  	/* Fill the TX FIFO */
> @@ -480,7 +483,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
>  	master->set_cs = sun6i_spi_set_cs;
>  	master->transfer_one = sun6i_spi_transfer_one;
>  	master->num_chipselect = 4;
> -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> +				SPI_RX_DUAL | SPI_TX_DUAL;

This feature was introduced with the A80, but the older designs (A31,
A23, A33) don't seem to support it, so we should set these flags
conditionally, using the compatible for example.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180329/031b5460/attachment-0001.sig>
