From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Dec 2012 00:26:46 +0000
Subject: [PATCH v4] usb: phy: samsung: Add support to set pmu isolation
In-Reply-To: <1356524912-4736-2-git-send-email-gautam.vivek@samsung.com>
References: <1356524912-4736-1-git-send-email-gautam.vivek@samsung.com>
 <1356524912-4736-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20121227002646.GC24604@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 26, 2012 at 05:58:32PM +0530, Vivek Gautam wrote:
> +	if (!ret)
> +		sphy->phyctrl_pmureg = ioremap(reg[0], reg[1]);
> +
> +	of_node_put(usbphy_pmu);
> +
> +	if (IS_ERR_OR_NULL(sphy->phyctrl_pmureg)) {

No.  Learn what the error return values are from functions.  Using the
wrong ones is buggy.  ioremap() only ever returns NULL on error.  You
must check against NULL, and not use the IS_ERR stuff.

> +/*
> + * Set isolation here for phy.
> + * SOCs control this by controlling corresponding PMU registers
> + */
> +static void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, int on)
> +{
> +	u32 reg;
> +	int en_mask;
> +
> +	if (!sphy->phyctrl_pmureg) {
> +		dev_warn(sphy->dev, "Can't set pmu isolation\n");
> +		return;
> +	}
> +
> +	reg = readl(sphy->phyctrl_pmureg);
> +
> +	en_mask = sphy->drv_data->devphy_en_mask;
> +
> +	if (on)
> +		writel(reg & ~en_mask, sphy->phyctrl_pmureg);
> +	else
> +		writel(reg | en_mask, sphy->phyctrl_pmureg);

What guarantees that this read-modify-write sequence of this register safe?
And, btw, this can't be optimised very well because of the barrier inside
writel().  This would be better:

	if (on)
		reg &= ~en_mask;
	else
		reg |= en_mask;

	writel(reg, sphy->phyctrl_pmureg);

> +static inline struct samsung_usbphy_drvdata
> +*samsung_usbphy_get_driver_data(struct platform_device *pdev)
>  {
>  	if (pdev->dev.of_node) {
>  		const struct of_device_id *match;
>  		match = of_match_node(samsung_usbphy_dt_match,
>  							pdev->dev.of_node);
> -		return (int) match->data;
> +		return (struct samsung_usbphy_drvdata *) match->data;

match->data is a const void pointer.  Is there a reason you need this
cast here?  What if you made the returned pointer from this function
also const and fixed up all its users (no user should modify this
data.)

>  #ifdef CONFIG_OF
>  static const struct of_device_id samsung_usbphy_dt_match[] = {
>  	{
>  		.compatible = "samsung,s3c64xx-usbphy",
> -		.data = (void *)TYPE_S3C64XX,
> +		.data = (void *)&usbphy_s3c64xx,

Why do you need this cast?

>  	}, {
>  		.compatible = "samsung,exynos4210-usbphy",
> -		.data = (void *)TYPE_EXYNOS4210,
> +		.data = (void *)&usbphy_exynos4,

Ditto.
