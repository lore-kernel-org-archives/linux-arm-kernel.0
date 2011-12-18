From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Dec 2011 21:41:43 -0800
Subject: [PATCH 1/3] i2c: tegra: Support DVC controller in device tree
In-Reply-To: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
References: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111218054143.GA20372@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 17, 2011 at 10:28:19PM -0700, Stephen Warren wrote:
> One of the Tegra I2C blocks is inside the DVC (Digital Voltage Controller)
> block. This block is identical to the rest of the I2C blocks, except that
> it only supports master mode, it has registers moved around, and it needs
> some extra init to get it into I2C mode.  The register moves are handled
> by i2c_readl and i2c_writel
> 
> This patch adds a new compatible value for controllers of this "DVC"
> type; I figured that this approach was reasonable, as opposed to adding
> an is-dvc property under the existing compatible value, since the HW
> truly is different.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Ben, it'd probably be simplest if you could ack this patch, and we
> could take it through the Tegra tree.
> 
>  drivers/i2c/busses/i2c-tegra.c |   37 +++++++++++++++++++++++++------------
>  1 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 46b6500..c264e8c 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -26,6 +26,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/i2c-tegra.h>
> +#include <linux/of_device.h>
>  #include <linux/of_i2c.h>
>  #include <linux/module.h>
>  
> @@ -558,6 +559,18 @@ static const struct i2c_algorithm tegra_i2c_algo = {
>  	.functionality	= tegra_i2c_func,
>  };
>  
> +#if defined(CONFIG_OF)
> +/* Match table for of_platform binding */
> +static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
> +	{ .compatible = "nvidia,tegra20-i2c",     .data = (void *)0},
> +	{ .compatible = "nvidia,tegra20-i2c-dvc", .data = (void *)1},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
> +#else
> +#define tegra_i2c_of_match NULL
> +#endif
> +
>  static int tegra_i2c_probe(struct platform_device *pdev)
>  {
>  	struct tegra_i2c_dev *i2c_dev;
> @@ -636,7 +649,18 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  			i2c_dev->bus_clk_rate = be32_to_cpup(prop);
>  	}
>  
> -	if (pdev->id == 3)
> +#if defined(CONFIG_OF)
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +
> +		match = of_match_device(tegra_i2c_of_match, &pdev->dev);
> +		if (!match)
> +			return -EINVAL;
> +
> +		i2c_dev->is_dvc = match->data;

I would rather see a:

		i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
						"nvidia,tegra20-i2c-dvc");

...instead of passing a flag through the match data.


-Olof
