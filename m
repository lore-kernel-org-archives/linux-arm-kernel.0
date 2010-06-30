From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 30 Jun 2010 17:03:22 -0600
Subject: [PATCH] spi: davinci: Added support for chip select using gpio
In-Reply-To: <1277707655-3468-1-git-send-email-lamiaposta71@gmail.com>
References: <1277707655-3468-1-git-send-email-lamiaposta71@gmail.com>
Message-ID: <AANLkTilnVxNfsfJ4nCWITM_DhOb6BDGZQC8cMiM0RkiF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 28, 2010 at 12:47 AM, Raffaele Recalcati
<lamiaposta71@gmail.com> wrote:
> From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
>
> ? ?It is not everytime possible, due to hardware constraints,
> ? ?to use the hw chip select available on spi port.
> ? ?So I add this possibility using a gpio as chip select.
> ? ?If controller_data variable is not null it is
> ? ?the gpio to be used as chip select.
> ? ?The default case is compatible with evmdm365.
> ? ?This patch has been developed against the
> ? ?http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> ? ?git tree and has been tested on bmx board (similar to dm365 evm but with
> ? ?gpio as spi chip select).
>
> Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
> Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>

The davinci SPI driver is getting completely replaced (as soon as I
receive the respun patches), and I assume this patch will no longer
apply after the fact, so I'm not going to pick this patch up.  You
should coordinate with Brian Niebuhr to get this feature into his new
driver.

Cheers,
g.

> ---
> ?arch/arm/mach-davinci/dm365.c | ? 10 ++++++----
> ?drivers/spi/davinci_spi.c ? ? | ? 27 ++++++++++++++++++---------
> ?2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index a146849..42fd4a4 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -677,10 +677,12 @@ void __init dm365_init_spi0(unsigned chipselect_mask,
> ? ? ? ?davinci_cfg_reg(DM365_SPI0_SDO);
>
> ? ? ? ?/* not all slaves will be wired up */
> - ? ? ? if (chipselect_mask & BIT(0))
> - ? ? ? ? ? ? ? davinci_cfg_reg(DM365_SPI0_SDENA0);
> - ? ? ? if (chipselect_mask & BIT(1))
> - ? ? ? ? ? ? ? davinci_cfg_reg(DM365_SPI0_SDENA1);
> + ? ? ? if ?(!((unsigned long) info->controller_data)) {
> + ? ? ? ? ? ? ? if (chipselect_mask & BIT(0))
> + ? ? ? ? ? ? ? ? ? ? ? davinci_cfg_reg(DM365_SPI0_SDENA0);
> + ? ? ? ? ? ? ? if (chipselect_mask & BIT(1))
> + ? ? ? ? ? ? ? ? ? ? ? davinci_cfg_reg(DM365_SPI0_SDENA1);
> + ? ? ? }
>
> ? ? ? ?spi_register_board_info(info, len);
>
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 95afb6b..621ae46 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -29,6 +29,7 @@
> ?#include <linux/spi/spi_bitbang.h>
> ?#include <linux/slab.h>
>
> +#include <mach/gpio.h>
> ?#include <mach/spi.h>
> ?#include <mach/edma.h>
>
> @@ -270,18 +271,26 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
> ? ? ? ?pdata = davinci_spi->pdata;
>
> ? ? ? ?/*
> - ? ? ? ?* Board specific chip select logic decides the polarity and cs
> - ? ? ? ?* line for the controller
> - ? ? ? ?*/
> + ? ? ? * Board specific chip select logic decides the polarity and cs
> + ? ? ? * line for the controller
> + ? ? ? */
> ? ? ? ?if (value == BITBANG_CS_INACTIVE) {
> - ? ? ? ? ? ? ? set_io_bits(davinci_spi->base + SPIDEF, CS_DEFAULT);
> -
> - ? ? ? ? ? ? ? data1_reg_val |= CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
> - ? ? ? ? ? ? ? iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> -
> + ? ? ? ? ? ? ? if ?((unsigned long) spi->controller_data) {
> + ? ? ? ? ? ? ? ? ? ? ? gpio_set_value(spi->controller_data, \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? !(spi->mode & SPI_CS_HIGH));
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? set_io_bits(davinci_spi->base + SPIDEF, CS_DEFAULT);
> +
> + ? ? ? ? ? ? ? ? ? ? ? data1_reg_val |= CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
> + ? ? ? ? ? ? ? ? ? ? ? iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
> + ? ? ? ? ? ? ? }
> ? ? ? ? ? ? ? ?while ((ioread32(davinci_spi->base + SPIBUF)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? & SPIBUF_RXEMPTY_MASK) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? & SPIBUF_RXEMPTY_MASK) == 0)
> ? ? ? ? ? ? ? ? ? ? ? ?cpu_relax();
> + ? ? ? } else {
> + ? ? ? ? ? ? ? if ?((unsigned long) spi->controller_data)
> + ? ? ? ? ? ? ? ? ? ? ? gpio_set_value(spi->controller_data, \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (spi->mode & SPI_CS_HIGH));
> ? ? ? ?}
> ?}
>
> --
> 1.7.0.4
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
