From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 14:50:51 +0200
Subject: [PATCH 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
Message-ID: <1530327.jvk44KuFQA@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

This patch looks good overall, but I have some minor comments inline.

On Friday 20 of September 2013 14:13:52 Andrew Bresticker wrote:
> The Exynos AudioSS clock controller will later be modified to allow
> input clocks to be specified via device-tree in order to support
> multiple Exynos SoCs.  This will introduce a dependency on the core
> SoC clock controller being initialized first so that the AudioSS driver
> can look up its input clocks, but the order in which clock providers
> are probed in of_clk_init() is not guaranteed.  Since deferred probing
> is not supported in of_clk_init() and the AudioSS block is not the core
> controller, we can initialize it later as a platform device.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 71
> +++++++++++++++++++++++++++------- 1 file changed, 58 insertions(+), 13
> deletions(-)
[snip]
> +static int exynos_audss_clk_remove(struct platform_device *pdev)
> +{
> +	of_clk_del_provider(pdev->dev.of_node);
> +
> +	return 0;
>  }

Don't we need to unregister all the registered clocks in remove? This also 
leads to another question: Do we even need removal support for this 
driver?

> -CLK_OF_DECLARE(exynos4210_audss_clk, "samsung,exynos4210-audss-clock",
> -		exynos_audss_clk_init);
> -CLK_OF_DECLARE(exynos5250_audss_clk, "samsung,exynos5250-audss-clock",
> -		exynos_audss_clk_init);
> +
> +static const struct of_device_id exynos_audss_clk_of_match[] = {
> +	{ .compatible = "samsung,exynos4210-audss-clock", },
> +	{ .compatible = "samsung,exynos5250-audss-clock", },
> +	{},
> +};
> +
> +static struct platform_driver exynos_audss_clk_driver = {
> +	.driver	= {
> +		.name = "exynos-audss-clk",
> +		.owner = THIS_MODULE,
> +		.of_match_table = exynos_audss_clk_of_match,
> +	},
> +	.probe = exynos_audss_clk_probe,
> +	.remove = exynos_audss_clk_remove,
> +};
> +
> +static int __init exynos_audss_clk_init(void)
> +{
> +	return platform_driver_register(&exynos_audss_clk_driver);
> +}
> +core_initcall(exynos_audss_clk_init);

Does it need to be core_initcall? Drivers depending on clocks provided by 
this driver should be able to defer probing if they are probed before this 
driver.

Then you would be able to simply use module_platform_driver() below.

> +static void __init exynos_audss_clk_exit(void)
> +{
> +	platform_driver_unregister(&exynos_audss_clk_driver);
> +}
> +module_exit(exynos_audss_clk_exit);
> +
> +MODULE_AUTHOR("Padmavathi Venna <padma.v@samsung.com>");
> +MODULE_DESCRIPTION("Exynos AudioSS Clock Controller");

nit: IMHO Audio Subsystem instead of AudioSS would be more meaningful.

> +MODULE_LICENSE("GPL");

This should be GPL v2.

Best regards,
Tomasz
