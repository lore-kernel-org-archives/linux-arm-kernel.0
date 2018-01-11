From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Jan 2018 14:27:29 +0000
Subject: [PATCH] IIO: ADC: stm32-dfsdm: avoid unused-variable warning
In-Reply-To: <20180111103510.1408292-1-arnd@arndb.de>
References: <20180111103510.1408292-1-arnd@arndb.de>
Message-ID: <866335ff-d9a8-99c0-0946-82b3f207f266@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/18 10:34, Arnd Bergmann wrote:
> Building with CONFIG_OF disabled produces a compiler warning:
> 
> drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
> drivers/iio/adc/stm32-dfsdm-core.c:245:22: error: unused variable 'pnode' [-Werror=unused-variable]
> 
> This removes the variable and open-codes it in the only place
> it gets used to avoid that warning.
> 
> Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 72427414db7f..6cd655f8239b 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>   static int stm32_dfsdm_probe(struct platform_device *pdev)
>   {
>   	struct dfsdm_priv *priv;
> -	struct device_node *pnode = pdev->dev.of_node;
>   	const struct of_device_id *of_id;
>   	const struct stm32_dfsdm_dev_data *dev_data;
>   	struct stm32_dfsdm *dfsdm;
> @@ -254,7 +253,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
>   
>   	priv->pdev = pdev;
>   
> -	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
> +	of_id = of_match_node(stm32_dfsdm_of_match, pdev->dev.of_node);
>   	if (!of_id->data) {
>   		dev_err(&pdev->dev, "Data associated to device is missing\n");
>   		return -EINVAL;

FWIW, it looks like this whole lot could be cleaned up by using 
of_device_get_match_data().

Robin.
