From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 Jan 2012 06:14:30 -0700
Subject: [PATCH 1/1] of_mmc_spi: fix little endian support
In-Reply-To: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120130131430.GA28397@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:15:29AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> the voltage_ranges is supposed to switch from big endian to little endian
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux-mmc at vger.kernel.org

Applied, thanks.

g.

> ---
>  drivers/mmc/host/of_mmc_spi.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index ab66f24..ede2c64 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -109,12 +109,13 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  		goto err_ocr;
>  	}
>  
> +
>  	for (i = 0; i < num_ranges; i++) {
>  		const int j = i * 2;
>  		u32 mask;
>  
> -		mask = mmc_vddrange_to_ocrmask(voltage_ranges[j],
> -					       voltage_ranges[j + 1]);
> +		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> +					       be32_to_cpu(voltage_ranges[j + 1]));
>  		if (!mask) {
>  			ret = -EINVAL;
>  			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
> -- 
> 1.7.7
> 
