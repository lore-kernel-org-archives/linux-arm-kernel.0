From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 23 Oct 2018 11:48:44 +0200
Subject: [PATCH v3 1/7] spi: add support for octo mode I/O data transfer
In-Reply-To: <1540287311-1572-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1540287311-1572-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181023114844.7adfa054@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 09:37:06 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add flags for Octo mode I/O data transfer
> Required for the SPI controller which can do the data transfer (TX/RX)
> on 8 data lines e.g. NXP FlexSPI controller.
>  SPI_TX_OCTO: transmit with 8 wires
>  SPI_RX_OCTO: receive with 8 wires
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes for v3:
> - Modified string 'octal' with 'octo'.
> - Add octo mode support in spi_setup().
> Changes for v2:
> - Incorporated review comments of Boris.
> 
>  drivers/spi/spi.c       | 12 ++++++++++--
>  include/linux/spi/spi.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ec395a6..6d57fa7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_TX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_TX_OCTO;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-tx-bus-width %d not supported\n",
> @@ -1591,6 +1594,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		case 4:
>  			spi->mode |= SPI_RX_QUAD;
>  			break;
> +		case 8:
> +			spi->mode |= SPI_RX_OCTO;
> +			break;
>  		default:
>  			dev_warn(&ctlr->dev,
>  				"spi-rx-bus-width %d not supported\n",
> @@ -2770,14 +2776,16 @@ int spi_setup(struct spi_device *spi)
>  	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
>  	 */
>  	if ((spi->mode & SPI_3WIRE) && (spi->mode &
> -		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
> +		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
> +		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO)))
>  		return -EINVAL;
>  	/* help drivers fail *cleanly* when they need options
>  	 * that aren't supported with their current controller
>  	 */
>  	bad_bits = spi->mode & ~spi->controller->mode_bits;
>  	ugly_bits = bad_bits &
> -		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
> +		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO |
> +		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO);
>  	if (ugly_bits) {
>  		dev_warn(&spi->dev,
>  			 "setup: ignoring unsupported mode bits %x\n",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a64235e..cea4e49 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -163,6 +163,8 @@ struct spi_device {
>  #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> +#define	SPI_TX_OCTO	0x1000			/* transmit with 8 wires */
> +#define	SPI_RX_OCTO	0x2000			/* receive with 8 wires */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;
