From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 01:40:46 +0900
Subject: [PATCH 08/33] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368702961-4325-9-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
 <1368702961-4325-9-git-send-email-wsa@the-dreams.de>
Message-ID: <519A520E.3060801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/13 20:15, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang<wsa@the-dreams.de>

For i2c-s3c2410:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

> ---
>   drivers/i2c/busses/i2c-s3c2410.c |    5 -----
>   drivers/i2c/busses/i2c-sirf.c    |    6 ------
>   drivers/i2c/busses/i2c-tegra.c   |    5 -----
>   3 files changed, 16 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 6e8ee92..cab1c91 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1082,11 +1082,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>   	/* map the registers */
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res == NULL) {
> -		dev_err(&pdev->dev, "cannot find IO resource\n");
> -		return -ENOENT;
> -	}
> -
>   	i2c->regs = devm_ioremap_resource(&pdev->dev, res);
>
>   	if (IS_ERR(i2c->regs))
> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
> index 5a7ad24..a63c7d5 100644
> --- a/drivers/i2c/busses/i2c-sirf.c
> +++ b/drivers/i2c/busses/i2c-sirf.c
> @@ -303,12 +303,6 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
>   	adap->class = I2C_CLASS_HWMON;
>
>   	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (mem_res == NULL) {
> -		dev_err(&pdev->dev, "Unable to get MEM resource\n");
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
>   	siic->base = devm_ioremap_resource(&pdev->dev, mem_res);
>   	if (IS_ERR(siic->base)) {
>   		err = PTR_ERR(siic->base);
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index b60ff90..9aa1b60 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -714,11 +714,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>   	int ret = 0;
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no mem resource\n");
> -		return -EINVAL;
> -	}
> -
>   	base = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
