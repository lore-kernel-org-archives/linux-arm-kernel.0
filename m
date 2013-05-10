From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 May 2013 10:37:44 -0600
Subject: [RFC 23/42] drivers/spi: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Message-ID: <518D2258.2090403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2013 02:17 AM, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c

> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "No IO memory resource\n");
> -		ret = -ENODEV;
> -		goto exit_free_master;
> -	}
>  	tspi->phys = r->start;
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

The tspi->phy assignment is broken there now.

> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c

> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "No IO memory resource\n");
> -		ret = -ENODEV;
> -		goto exit_free_master;
> -	}
>  	tspi->phys = r->start;
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Same here.
