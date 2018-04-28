From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 28 Apr 2018 16:07:06 +0100
Subject: [PATCH 6/7] iio: adc: stm32-dfsdm: add check on max filter id
In-Reply-To: <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
 <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180428160706.2aafad5b@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 13:51:00 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> reg property should be checked against number of available filters.
> BTW, dfsdm->num_fls wasn't used. But it can be used for this purpose.
> This prevents using data out of allocated dfsdm->fl_list array.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 57bcb45..1b78bec 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1111,8 +1111,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, adc);
>  
>  	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
> -	if (ret != 0) {
> -		dev_err(dev, "Missing reg property\n");
> +	if (ret != 0 || adc->fl_id >= adc->dfsdm->num_fls) {
> +		dev_err(dev, "Missing or bad reg property\n");
>  		return -EINVAL;
>  	}
>  
