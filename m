From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Dec 2015 12:16:27 +0100
Subject: [PATCH v5 2/2] spi: sun4i: Add support for wait time between
 word transmissions
In-Reply-To: <1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
 <1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151218111627.GM30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 17, 2015 at 12:40:27PM +0100, Marcus Weseloh wrote:
> Modifies the sun4i SPI master driver to make use of the
> "spi-word-wait-ns" property. This specific SPI controller needs 3 clock
> cycles to set up the delay, which makes the minimum non-zero wait time
> on this hardware 4 clock cycles.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index f60a6d6..3b4f5f4 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  #include <linux/spi/spi.h>
>  
> @@ -173,6 +174,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	unsigned int tx_len = 0;
>  	int ret = 0;
>  	u32 reg;
> +	int wait_clk = 0;
> +	int clk_ns = 0;
>  
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> @@ -261,6 +264,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  
>  	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
>  
> +	/*
> +	 * Setup wait time between words.
> +	 *
> +	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
> +	 * additional cycles to setup the wait counter, so the minimum delay
> +	 * time is 4 cycles.
> +	 */
> +	if (spi->word_wait_ns) {
> +		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);

You should use the actual rate of the clock returned by clk_get_rate
(or probably just use mclk_rate).

The clock driver might round the frequency to something else than what
was set in clk_set_rate, which would make your calculation here a bit
off.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/45797bbe/attachment-0001.sig>
