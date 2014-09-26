From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Sep 2014 11:08:32 +0100
Subject: [PATCH] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
References: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
 <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
Message-ID: <20140926100832.GE27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 10:25:49AM -0700, Weike Chen wrote:

> +static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *drv_data)
> +{
> +	if (!is_quark_x1000_ssp(drv_data))
> +		return SSCR1_CHANGE_MASK;
> +
> +	return QUARK_X1000_SSCR1_CHANGE_MASK;
> +}

These functions would be much better written as switch statements -
think how they're going to look when we've got another controller which
needs custom values.  It might also be helpful for review to have two
patches, one splitting things out into the functions and another adding
the Quark support.

> +/*  see Quark SPI data sheet for implementation rationale */
> +static u32 quark_x1000_set_clk_regvals(u32 rate, u32 *dds, u32 *clk_div)
> +{

Please document this in the driver - I don't know if this datasheet is
public but even if it is it may not stay that way.

> @@ -613,6 +759,8 @@ static void pump_transfers(unsigned long data)
>  	u32 cr1;
>  	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
>  	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
> +	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
> +
>  

Extra blank line being added here.

> @@ -145,6 +147,9 @@ static inline int pxa25x_ssp_comp(struct driver_data *drv_data)
>  		return 1;
>  	if (drv_data->ssp_type == CE4100_SSP)
>  		return 1;
> +	if (drv_data->ssp_type == QUARK_X1000_SSP)
> +		return 1;
> +
>  	return 0;
>  }

Things like this should also be refactored into switch statements - in
general anything that's deciding what to do based on ssp_type probably
ought to be using switch statements.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/234a5096/attachment.sig>
