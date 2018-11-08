From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 8 Nov 2018 09:29:46 +0100
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <20181106183609.207702-2-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
Message-ID: <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/11/2018 19:36, Stephen Boyd wrote:
> We have a handful of clk drivers that have a collection of slightly
> variant device support keyed off of the compatible string. In each of
> these drivers, we demux the variant and then call the "real" probe
> function based on whatever is stored in the match data for that
> compatible string. Let's generalize this function so that it can be
> re-used as the platform_driver probe function directly.
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/device.c       | 31 +++++++++++++++++++++++++++++++
>  include/linux/of_device.h |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0f27fad9fe94..8381f33ed2d8 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -195,6 +195,37 @@ const void *of_device_get_match_data(const struct device *dev)
>  }
>  EXPORT_SYMBOL(of_device_get_match_data);
>  
> +/**
> + * platform_driver_probe_by_of_match_data - Probe a platform device using match data
> + * @pdev: platform device to probe
> + *
> + * For use by device drivers that multiplex their probe function through DT
> + * match data. Drivers can use this function to call their platform
> + * device probe directly without having to implement a wrapper function.
> + *
> + * static const struct of_device_id probe_funcs[] = {
> + *      { .compatible = "compat,foo", .data = foo_probe },
> + *      {}
> + * };
> + *
> + * struct platform_driver foo_driver = {
> + *      .probe = platform_driver_probe_by_of_match_data,
> + *      .driver = {
> + *            of_match_table = probe_funcs,
> + *      },
> + * };
> + *
> + */
> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
> +{
> +	int (*probe_func)(struct platform_device *pdev);
> +
> +	probe_func = of_device_get_match_data(&pdev->dev);

Shouldn't we check if probe_func is not NULL?

> +
> +	return probe_func(pdev);
> +}
> +EXPORT_SYMBOL_GPL(platform_driver_probe_by_of_match_data);
> +
>  static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
>  {
>  	const char *compat;
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 8d31e39dd564..4de84691d1c6 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -33,6 +33,7 @@ extern int of_device_add(struct platform_device *pdev);
>  extern int of_device_register(struct platform_device *ofdev);
>  extern void of_device_unregister(struct platform_device *ofdev);
>  
> +extern int platform_driver_probe_by_of_match_data(struct platform_device *pdev);
>  extern const void *of_device_get_match_data(const struct device *dev);
>  
>  extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
> 
