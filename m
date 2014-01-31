From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jan 2014 20:04:35 +0000
Subject: [RFC/PATCH] base: platform: add generic clock handling for
 platform-bus
In-Reply-To: <1391191965-31102-1-git-send-email-balbi@ti.com>
References: <1391191965-31102-1-git-send-email-balbi@ti.com>
Message-ID: <20140131200434.GR27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 12:12:45PM -0600, Felipe Balbi wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 3a94b79..86aeb5b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -484,6 +484,21 @@ static int platform_drv_probe(struct device *_dev)
>  	if (ACPI_HANDLE(_dev))
>  		acpi_dev_pm_attach(_dev, true);
>  
> +	dev->fck = devm_clk_get(_dev, "fck");
> +	dev->ick = devm_clk_get(_dev, "ick");
> +
> +	if (!IS_ERR(dev->fck))
> +		clk_prepare_enable(dev->fck);
> +	else
> +		dev->fck = NULL;
> +
> +	if (!IS_ERR(dev->ick))
> +		clk_prepare_enable(dev->ick);
> +	else
> +		dev->ick = NULL;

If people are going to continue doing this (converting error values to
NULL) can we please have a check in devm_clk_get() which prevents it
returning NULL if the implementation happens to do so?

It's either that or we force all users to conform to the API which
specifies that the error values are defined by IS_ERR() returning
true and everything else must be considered as a potential valid return.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
