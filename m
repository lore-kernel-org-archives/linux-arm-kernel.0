From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 28 Apr 2018 16:07:54 +0100
Subject: [PATCH 7/7] iio: adc: stm32-dfsdm: add check on spi-max-frequency
In-Reply-To: <1519390261-25453-8-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
 <1519390261-25453-8-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180428160754.298afa0b@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 13:51:01 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> spi-max-frequency is requested for SPI master mode (only), to tune output
> clock. It may happen requested frequency isn't reachable.
> Add explicit check, so probe fails with error in this case. Otherwise,
> output clock may simply be silently turned off (conversions fail).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index e50efdc..1d0d823 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -227,6 +227,11 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  	}
>  
>  	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
> +	if (!priv->spi_clk_out_div) {
> +		/* spi_clk_out_div == 0 means ckout is OFF */
> +		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
> +		return -EINVAL;
> +	}
>  	priv->dfsdm.spi_master_freq = spi_freq;
>  
>  	if (rem) {
