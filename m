From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Jan 2017 13:13:22 +0100
Subject: [PATCH] iio: adc - Fix possible NULL derefrence.
In-Reply-To: <1485751634-28963-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130044724epcas3p444b23d43fed213511e6994ecb4ed0ef3@epcas3p4.samsung.com>
 <1485751634-28963-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <a4f4f5fc-5a00-5a39-8c2a-999686196a45@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2017 05:47 AM, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>

a) this should be two patches
b) same question as in case of the mmc patch -- The probe won't be
called if OF match doesn't happen in the first place, so this check is
redundant, no ?

> ---
>  drivers/iio/adc/mxs-lradc.c       |   14 ++++++++++----
>  drivers/iio/adc/rockchip_saradc.c |    4 ++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index b84d37c..4308a59 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1570,10 +1570,8 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>  
>  static int mxs_lradc_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *of_id =
> -		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> -	const struct mxs_lradc_of_config *of_cfg =
> -		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
> +	const struct of_device_id *of_id;
> +	const struct mxs_lradc_of_config *of_cfg;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
>  	struct mxs_lradc *lradc;
> @@ -1583,6 +1581,14 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	int i, s;
>  	u64 scale_uv;
>  
> +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}
> +
> +	of_cfg = &mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
> +
>  	/* Allocate the IIO device. */
>  	iio = devm_iio_device_alloc(dev, sizeof(*lradc));
>  	if (!iio) {
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 85d7012..08dfb43 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -224,6 +224,10 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	info = iio_priv(indio_dev);
>  
>  	match = of_match_device(rockchip_saradc_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}
>  	info->data = match->data;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 


-- 
Best regards,
Marek Vasut
