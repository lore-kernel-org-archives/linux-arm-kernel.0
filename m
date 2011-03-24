From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 23 Mar 2011 21:28:26 -0600
Subject: [PATCH 5/6] spi/pl022: Add loopback support for the SPI on 5500
In-Reply-To: <1300874717-14914-1-git-send-email-linus.walleij@stericsson.com>
References: <1300874717-14914-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110324032826.GB21846@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 11:05:16AM +0100, Linus Walleij wrote:
> From: Philippe Langlais <philippe.langlais@linaro.org>
> 
> Extend the vendor data with a loopback field, and add new
> amba-pl022 vendor data for the DB5500 pl023, as the pl023
> on db8500 and db5500 vary.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Prajadevi H <prajadevi.h@stericsson.com>
> Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 95e58c7..fe79773 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -324,6 +324,7 @@ struct vendor_data {
>  	bool unidir;
>  	bool extended_cr;
>  	bool pl023;
> +	bool loopback;
>  };
>  
>  /**
> @@ -1984,7 +1985,7 @@ static int pl022_setup(struct spi_device *spi)
>  
>  	SSP_WRITE_BITS(chip->cr0, clk_freq.scr, SSP_CR0_MASK_SCR, 8);
>  	/* Loopback is available on all versions except PL023 */
> -	if (!pl022->vendor->pl023) {
> +	if (pl022->vendor->loopback) {
>  		if (spi->mode & SPI_LOOP)
>  			tmp = LOOPBACK_ENABLED;
>  		else
> @@ -2228,6 +2229,7 @@ static struct vendor_data vendor_arm = {
>  	.unidir = false,
>  	.extended_cr = false,
>  	.pl023 = false,
> +	.loopback = true,
>  };
>  
>  
> @@ -2237,6 +2239,7 @@ static struct vendor_data vendor_st = {
>  	.unidir = false,
>  	.extended_cr = true,
>  	.pl023 = false,
> +	.loopback = true,
>  };
>  
>  static struct vendor_data vendor_st_pl023 = {
> @@ -2245,6 +2248,16 @@ static struct vendor_data vendor_st_pl023 = {
>  	.unidir = false,
>  	.extended_cr = true,
>  	.pl023 = true,
> +	.loopback = false,
> +};
> +
> +static struct vendor_data vendor_db5500_pl023 = {
> +	.fifodepth = 32,
> +	.max_bpw = 32,
> +	.unidir = false,
> +	.extended_cr = true,
> +	.pl023 = true,
> +	.loopback = true,
>  };
>  
>  static struct amba_id pl022_ids[] = {
> @@ -2278,6 +2291,11 @@ static struct amba_id pl022_ids[] = {
>  		.mask   = 0xffffffff,
>  		.data   = &vendor_st_pl023,
>  	},
> +	{
> +		.id	= 0x10080023,
> +		.mask	= 0xffffffff,
> +		.data	= &vendor_db5500_pl023,
> +	},
>  	{ 0, 0 },
>  };
>  
> -- 
> 1.7.3.2
> 
