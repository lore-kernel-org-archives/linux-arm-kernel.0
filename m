From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jan 2012 10:13:15 +0100
Subject: [PATCH 5/6] ARM: mxc: add dt support for audmux-v2
In-Reply-To: <1325820343-11875-6-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-6-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120106091315.GG5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:25:42AM +0800, Richard Zhao wrote:
> If CONFIG_OF, we create a audmux device driver.
> 
> For other platforms that don't set CONFIG_OF, it still initialize
> everything in postcore_initcall. I didn't create device driver for
> them, because it would be big change and one day the platforms will
> convert to device tree too.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/plat-mxc/audmux-v2.c |   59 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
> index 8cced35..87e05e2 100644
> --- a/arch/arm/plat-mxc/audmux-v2.c
> +++ b/arch/arm/plat-mxc/audmux-v2.c
> @@ -20,7 +20,9 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <mach/audmux.h>
>  #include <mach/hardware.h>
>  
> @@ -184,8 +186,64 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
>  }
>  EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
>  
> +#ifdef CONFIG_OF
> +
> +static int audmux_v2_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	if (!request_mem_region(res->start, resource_size(res), "audmux_v2")) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
> +	}
> +
> +	audmux_base = ioremap(res->start, resource_size(res));
> +	if (!audmux_base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENODEV;
> +		goto failed_ioremap;
> +	}
> +
> +	audmux_clk = clk_get(NULL, "audmux");
> +	if (IS_ERR(audmux_clk)) {
> +			dev_warn(&pdev->dev, "%s: cannot get clock: %d\n",
> +				__func__, ret);
> +			audmux_clk = NULL;
> +	}
> +
> +	audmux_debugfs_init();
> +	return 0;
> +
> +failed_ioremap:
> +	release_mem_region(res->start, resource_size(res));
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id audmux_v2_dt_ids[] = {
> +	{ .compatible = "fsl,audmux-v2", },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver audmux_v2_driver = {
> +	.probe = audmux_v2_probe,
> +	.driver = {
> +		.name = "audmux_v2",
> +		.of_match_table = audmux_v2_dt_ids,
> +	},
> +};
> +
> +#endif
> +
>  static int mxc_audmux_v2_init(void)
>  {
> +#ifdef CONFIG_OF
> +	return platform_driver_register(&audmux_v2_driver);
> +#else

Don't do this. Just because CONFIG_OF is enabled does not mean that this
kernel is only used for OF. This #else breaks starting the kernel the
traditional machid way.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
