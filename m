From: jogo@openwrt.org (Jonas Gorski)
Date: Tue, 31 Mar 2015 20:59:28 +0200
Subject: [PATCH v2] spi: bitbang: only toggle bitchanges
In-Reply-To: <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
References: <20150331141321.GR2869@sirena.org.uk>
 <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CAOiHx=k_NhSgzUDNPGXLUWN9r9bJ1rbsv3vLg_gFKpuinEqKmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 4:35 PM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> The current implementation of bitbang_txrx_be_cpha0 and
> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> unnecessary calls into the gpiolib when the level of the GPIO actually
> has not to be changed.
>
> This patch changes the routines to remember the last GPIO level
> and only calls setmosi if an change has to be made. This
> way it improves the transfer throughput.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> v2: added missing braces
>
>  drivers/spi/spi-bitbang-txrx.h | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
> index c616e41..06b34e5 100644
> --- a/drivers/spi/spi-bitbang-txrx.h
> +++ b/drivers/spi/spi-bitbang-txrx.h
> @@ -49,12 +49,17 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  {
>         /* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
>
> +       bool oldbit = !(word & 1);

Is it intentional you check the first bit (word & 1) here? Everywhere
else you use (word & 31).

>         /* clock starts at inactive polarity */
>         for (word <<= (32 - bits); likely(bits); bits--) {
>
>                 /* setup MSB (to slave) on trailing edge */
> -               if ((flags & SPI_MASTER_NO_TX) == 0)
> -                       setmosi(spi, word & (1 << 31));
> +               if ((flags & SPI_MASTER_NO_TX) == 0) {
> +                       if ((word & (1 << 31)) != oldbit) {

You are comparing a bool to an int, and ((word & (1 << 31)) will
always be != true (== 1). Your condition needs to be !!(word & (1 <<
31)) != oldbit .

> +                               setmosi(spi, word & (1 << 31));
> +                               oldbit = word & (1 << 31);
> +                       }
> +               }
>                 spidelay(nsecs);        /* T(setup) */
>
>                 setsck(spi, !cpol);
> @@ -76,13 +81,18 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
>  {
>         /* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
>
> +       bool oldbit = !(word & (1 << 31));
>         /* clock starts at inactive polarity */
>         for (word <<= (32 - bits); likely(bits); bits--) {
>
>                 /* setup MSB (to slave) on leading edge */
>                 setsck(spi, !cpol);
> -               if ((flags & SPI_MASTER_NO_TX) == 0)
> -                       setmosi(spi, word & (1 << 31));
> +               if ((flags & SPI_MASTER_NO_TX) == 0) {
> +                       if ((word & (1 << 31)) != oldbit) {

Same issue here.

> +                               setmosi(spi, word & (1 << 31));
> +                               oldbit = word & (1 << 31);
> +                       }
> +               }
>                 spidelay(nsecs); /* T(setup) */
>
>                 setsck(spi, cpol);
> --

Regards
Jonas
