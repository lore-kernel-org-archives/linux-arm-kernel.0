From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Feb 2013 23:56:29 +0000
Subject: [RFC PATCH 7/9] thermal: tegra30: add tegra30 thermal driver
In-Reply-To: <1361187031-3679-8-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-8-git-send-email-wni@nvidia.com>
Message-ID: <20130219235629.GU17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 07:30:29PM +0800, Wei Ni wrote:
> +static struct tegra_thermal_data * __devinit thermal_tegra_dt_parse_pdata(

__dev* no longer exists.

> +	tdata = devm_kzalloc(&pdev->dev, sizeof(*tdata), GFP_KERNEL);
> +	if (!tdata) {
> +		dev_err(&pdev->dev, "Can't allocate platform data\n");
> +		return NULL;
> +	}
> +	memset(tdata, 0, sizeof(*tdata));

Useless memset.  k*z*alloc already zeros the memory before returning.

> +static int tegra30_thermal_probe(struct platform_device *pdev)
> +{
> +	struct tegra_thermal_data *pdata = pdev->dev.platform_data;

You read pdata here....

> +	struct thermal_zone *tz;
> +	struct thermal_sensor *ts;
> +	static struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	pdata = thermal_tegra_dt_parse_pdata(pdev);

and immediately overwrite it here.

> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Get platform data failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Create a thermal zone */
> +	tz = create_thermal_zone("tz_tegra", NULL);
> +	if (!tz) {
> +		dev_err(&pdev->dev, "Create thermal_zone failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	pdata->tz = tz;

This isn't how you deal with driver data.  Set driver data against a
platform device using platform_set_drvdata(pdev, tz).

> +static int tegra30_thermal_remove(struct platform_device *pdev)
> +{
> +	struct tegra_thermal_data *pdata = pdev->dev.platform_data;

and use platform_get_drvdata() here - and don't use pdata->tz.
	struct struct thermal_zone *tz = platform_get_drvdata(pdev);
