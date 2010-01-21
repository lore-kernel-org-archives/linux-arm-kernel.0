From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 21 Jan 2010 15:11:05 +0900
Subject: [PATCH] ARM: S3C64XX: Tidy up common code in
	s3c64xx_spi_set_info()
In-Reply-To: <1264051266-18754-2-git-send-email-ben-linux@fluff.org>
References: <1264051266-18754-1-git-send-email-ben-linux@fluff.org>
	<1264051266-18754-2-git-send-email-ben-linux@fluff.org>
Message-ID: <1b68c6791001202211m7ead63e8i82c186f2e3830241@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 2:21 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> The s3c64xx_spi_set_info() sets one of two platform data structures depending
> on which controller is being specified. Change to taking a pointer to the
> relevant platform data structure and then having one set of code to place
> the data into the area being pointed to.
>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
> ?arch/arm/plat-s3c64xx/dev-spi.c | ? 15 +++++++++------
> ?1 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-s3c64xx/dev-spi.c b/arch/arm/plat-s3c64xx/dev-spi.c
> index 6b6d7af..ca10388 100644
> --- a/arch/arm/plat-s3c64xx/dev-spi.c
> +++ b/arch/arm/plat-s3c64xx/dev-spi.c
> @@ -18,6 +18,7 @@
> ?#include <mach/gpio.h>
>
> ?#include <plat/spi-clocks.h>
> +
> ?#include <plat/s3c64xx-spi.h>
> ?#include <plat/gpio-bank-c.h>
> ?#include <plat/gpio-cfg.h>
> @@ -154,6 +155,8 @@ EXPORT_SYMBOL(s3c64xx_device_spi1);
>
> ?void __init s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
> ?{
> + ? ? ? struct s3c64xx_spi_info *pd;
> +
> ? ? ? ?/* Reject invalid configuration */
> ? ? ? ?if (!num_cs || src_clk_nr < 0
> ? ? ? ? ? ? ? ? ? ? ? ?|| src_clk_nr > S3C64XX_SPI_SRCCLK_48M) {
> @@ -163,18 +166,18 @@ void __init s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
>
> ? ? ? ?switch (cntrlr) {
> ? ? ? ?case 0:
> - ? ? ? ? ? ? ? s3c64xx_spi0_pdata.num_cs = num_cs;
> - ? ? ? ? ? ? ? s3c64xx_spi0_pdata.src_clk_nr = src_clk_nr;
> - ? ? ? ? ? ? ? s3c64xx_spi0_pdata.src_clk_name = spi_src_clks[src_clk_nr];
> + ? ? ? ? ? ? ? pd = &s3c64xx_spi0_pdata;
> ? ? ? ? ? ? ? ?break;
> ? ? ? ?case 1:
> - ? ? ? ? ? ? ? s3c64xx_spi1_pdata.num_cs = num_cs;
> - ? ? ? ? ? ? ? s3c64xx_spi1_pdata.src_clk_nr = src_clk_nr;
> - ? ? ? ? ? ? ? s3c64xx_spi1_pdata.src_clk_name = spi_src_clks[src_clk_nr];
> + ? ? ? ? ? ? ? pd = &s3c64xx_spi1_pdata;
> ? ? ? ? ? ? ? ?break;
> ? ? ? ?default:
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__, cntrlr);
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
> +
> + ? ? ? pd->num_cs = num_cs;
> + ? ? ? pd->src_clk_nr = src_clk_nr;
> + ? ? ? pd->src_clk_name = spi_src_clks[src_clk_nr];
> ?}
acked-by: Jassi Brar <jassi.brar@samsung.com>
