From: david@lechnology.com (David Lechner)
Date: Wed, 21 Mar 2018 11:01:54 -0500
Subject: [PATCH 4/8] clk: davinci: add a reset lookup table for psc0
In-Reply-To: <20180321120807.18032-5-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl>
 <20180321120807.18032-5-brgl@bgdev.pl>
Message-ID: <4b985ed2-0db0-b4ad-8a9f-b8804e6d4db4@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2018 07:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to be able to use the reset framework in legacy boot mode as
> well, add the reset lookup table to the psc driver for da850 variant.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clk/davinci/psc-da850.c | 8 ++++++++
>   drivers/clk/davinci/psc.c       | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
> index ccc7eb17bf3a..395db4b2c0ee 100644
> --- a/drivers/clk/davinci/psc-da850.c
> +++ b/drivers/clk/davinci/psc-da850.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/reset-controller.h>
>   #include <linux/clk.h>
>   #include <linux/clkdev.h>
>   #include <linux/init.h>
> @@ -66,8 +67,15 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
>   				"fck",	"ecap.1",
>   				"fck",	"ecap.2");
>   
> +static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
> +	RESET_LOOKUP("davinci-rproc.0", NULL, 15),
> +};
> +
>   static int da850_psc0_init(struct device *dev, void __iomem *base)
>   {
> +	reset_controller_add_lookup("da850-psc0",
> +				    da850_psc0_reset_lookup_table,
> +				    ARRAY_SIZE(da850_psc0_reset_lookup_table));

Could there be a race condition here since you are adding the lookup *before*
you are adding the actual provider? It seems like reset_controller_add_lookup()
should be after davinci_psc_register_clocks().

>   	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
>   }
>   
> diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
> index 3b0e59dfbdd7..063df62381ea 100644
> --- a/drivers/clk/davinci/psc.c
> +++ b/drivers/clk/davinci/psc.c
> @@ -425,6 +425,7 @@ __davinci_psc_register_clocks(struct device *dev,
>   
>   	psc->rcdev.ops = &davinci_psc_reset_ops;
>   	psc->rcdev.owner = THIS_MODULE;
> +	psc->rcdev.dev = dev;
>   	psc->rcdev.of_node = dev->of_node;
>   	psc->rcdev.of_reset_n_cells = 1;
>   	psc->rcdev.of_xlate = davinci_psc_reset_of_xlate;
> 
