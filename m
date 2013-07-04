From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 15:36:45 +0100
Subject: SPI: DUAL/QUAD support
In-Reply-To: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
Message-ID: <20130704143645.GA27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 07:36:48PM +0800, yuhang wang wrote:
> Hi Mark,
> 
> Thanks for your reply.
> I have added the kerneldoc into the patch below to explain the "DUAL"
> and "QUAD" modes.
> Hope for your suggestions.

Please submit things in the form covered in SubmittingPatches -
especially you need to sign off anything you're submitting to the
standard kernel.

> +Description
> +----------------------
> +DUAL/QUAD means spi can transfer in 2bits/4bits at the same time.
> +These spi controllers provide 8 data lines(4-tx and 4-rx). User can
> +choose tranfer mode(SINGLE/DUAL/QUAD) by setting the certain register.
> +Though SPI is a serial interface, some spi controllers can support
> +transmitting and receiving in DUAL and QUAD modes aimed to improve
> +the performance. Also as spi slave lots of flashes do support this attribute,
> +such as serial-norflash in spansion company.

OK, so all this is about is devices that have extra data lines.  Please
don't invent terms like "DUAL" and "QUAD", it makes things much less
clear.  Just describe it as support for multiple data lines.

> +struct spi_transfer {
> ++       u8     bitwidth;
> ++#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
> ++#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
> ++#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */

Calling this "bandwidth" is really unclear - I would expect a bandwidth
to be expressed in bits per second or similar.  This would be much
clearer if it was just the number of data signals.

> +       t[0].rx_buf = buf;
> +       t[0].len = len;
> +       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
> +       spi_message_add_tail(&t[0], &m);

This interface won't work for bidirectional transfers with asymmetric
numbers of data lines - we need separate fields for rx and rx.

> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -354,6 +354,7 @@ static int m25p80_read(struct mtd_info *mtd,
> loff_t from, size_t len,
> 
>         t[1].rx_buf = buf;
>         t[1].len = len;
> +       t[1].bitwidth = flash->spi->rx_bitwidth;
>         spi_message_add_tail(&t[1], &m);
> 
>         mutex_lock(&flash->lock);

This is going to fail in cases where the extra data lines aren't
available.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/3999b302/attachment.sig>
