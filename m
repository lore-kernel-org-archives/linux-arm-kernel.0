From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Aug 2015 17:08:29 +0100
Subject: [LINUX RFC 1/2] mtd: spi-nor: add dual parallel mode support
In-Reply-To: <1438592707-30713-2-git-send-email-ranjit.waghmode@xilinx.com>
References: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1438592707-30713-2-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150803160829.GX20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 02:35:06PM +0530, Ranjit Waghmode wrote:

>  drivers/mtd/devices/m25p80.c  |  1 +
>  drivers/mtd/spi-nor/spi-nor.c | 92 ++++++++++++++++++++++++++++++++++---------
>  include/linux/mtd/spi-nor.h   |  3 ++
>  include/linux/spi/spi.h       |  2 +
>  4 files changed, 79 insertions(+), 19 deletions(-)

You need to at least split this into two patches, one adding a new SPI
interface and another using it in MTD.  Probably the MTD core and driver
changes need splitting too.  Please see SubmittingPatches for discussion
of splitting things.

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d673072..8dec349 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -355,6 +355,8 @@ struct spi_master {
>  #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
>  #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
>  #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
> +#define SPI_MASTER_DATA_STRIPE		BIT(7)		/* support data stripe */
> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */

This is really not adequate description for a new API, I can't tell what
"data stripe" is supposed to mean at all and I've got at best a vague
idea what "both chips" really means.  This means other developers won't
be able to tell how to use or implement these flags either, and it means
I can't really review this.  You need to provide more information here,
both in the code and in the commit message.

I'd also expect some handling in the core for these, for example error
handling if they can't be supported.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/e21281f6/attachment.sig>
