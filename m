From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Nov 2010 11:25:16 +0100
Subject: [PATCH 3/3] ARM i.MX pcm037 eet: compile fixes
In-Reply-To: <1288888459-7293-4-git-send-email-s.hauer@pengutronix.de>
References: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
	<1288888459-7293-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20101105102516.GF16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 04, 2010 at 05:34:19PM +0100, Sascha Hauer wrote:
> The pcm037 eet extension currently does not compile if
> SPI_IMX is enabled. Fix it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mach-pcm037_eet.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
> index 99e0894..b93a2d0 100644
> --- a/arch/arm/mach-mx3/mach-pcm037_eet.c
> +++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
> @@ -14,6 +14,7 @@
>  
>  #include <mach/common.h>
>  #include <mach/iomux-mx3.h>
> +#include <mach/spi.h>
>  
>  #include <asm/mach-types.h>
>  
> @@ -59,14 +60,12 @@ static struct spi_board_info pcm037_spi_dev[] = {
>  };
>  
>  /* Platform Data for MXC CSPI */
> -#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
>  static int pcm037_spi1_cs[] = {MXC_SPI_CS(1), IOMUX_TO_GPIO(MX31_PIN_KEY_COL7)};
>  
>  static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
>  	.chipselect = pcm037_spi1_cs,
>  	.num_chipselect = ARRAY_SIZE(pcm037_spi1_cs),
>  };
> -#endif
I suggest adding (or squashing in) the following patch:

-------------->8-----------------
From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

ARM: mx3: enable SPI_IMX for better compile coverage

Note: SPI_IMX defaults to m for imx machines, so it doesn't occur
explicitly in the defconfig.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index f0c339f..e648ea3 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -84,6 +84,7 @@ CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
+CONFIG_SPI=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
