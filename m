From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Apr 2016 15:04:09 +0200
Subject: [PATCH 02/11] clk: tegra: dfll: Move SoC specific data into
 of_device_id
In-Reply-To: <1461321071-6431-3-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-3-git-send-email-pchiu@nvidia.com>
Message-ID: <20160422130409.GK9047@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:31:02PM +0800, Penny Chiu wrote:
> Move all SoC specific fcpu data into of_device_id structure, and
> move SoC fcpu data assignments from init function to probe
> function.
> 
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 51 ++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 5e5958e..b577bc6 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <soc/tegra/fuse.h>
>  
> @@ -28,8 +29,15 @@
>  #include "clk-dfll.h"
>  #include "cvb.h"
>  
> +struct dfll_fcpu_data {
> +	const unsigned long *cpu_max_freq_table;
> +	unsigned int cpu_max_freq_table_size;
> +	const struct cvb_table *cpu_cvb_tables;
> +	unsigned int cpu_cvb_tables_size;
> +};
> +
>  /* Maximum CPU frequency, indexed by CPU speedo id */
> -static const unsigned long cpu_max_freq_table[] = {
> +static const unsigned long tegra124_cpu_max_freq_table[] = {
>  	[0] = 2014500000UL,
>  	[1] = 2320500000UL,
>  	[2] = 2116500000UL,
> @@ -79,18 +87,39 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>  	},
>  };
>  
> +static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
> +	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
> +	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
> +	.cpu_cvb_tables = tegra124_cpu_cvb_tables,
> +	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
> +};
> +
> +static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {

There's no need to prefix this with tegra124_ since obviously the goal
is to make this a table that works at least on Tegra210 as well.

> +	{
> +		.compatible = "nvidia,tegra124-dfll",
> +		.data = &tegra124_dfll_fcpu_data
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
> +
>  static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  {
>  	int process_id, speedo_id, speedo_value, ret;
>  	struct rail_alignment align;
>  	struct tegra_dfll_soc_data *soc;
>  	const struct cvb_table *cvb;
> +	const struct of_device_id *of_id;
> +	const struct dfll_fcpu_data *fcpu_data;
> +
> +	of_id = of_match_device(tegra124_dfll_fcpu_of_match, &pdev->dev);
> +	fcpu_data = of_id->data;

You should be using of_device_get_match_data() nowadays. That allows you
to do this in one step while at the same time allowing to keep the match
tables where they are.

>  
>  	process_id = tegra_sku_info.cpu_process_id;
>  	speedo_id = tegra_sku_info.cpu_speedo_id;
>  	speedo_value = tegra_sku_info.cpu_speedo_value;
>  
> -	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
> +	if (speedo_id >= fcpu_data->cpu_max_freq_table_size) {
>  		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=%d\n",
>  			speedo_id);
>  		return -ENODEV;
> @@ -121,12 +150,12 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	cvb = tegra_cvb_build_opp_table(tegra124_cpu_cvb_tables,
> -					ARRAY_SIZE(tegra124_cpu_cvb_tables),
> -					&align,
> -					process_id, speedo_id, speedo_value,
> -					cpu_max_freq_table[speedo_id],
> -					soc->dev);
> +	cvb = tegra_cvb_build_opp_table(fcpu_data->cpu_cvb_tables,
> +				fcpu_data->cpu_cvb_tables_size,
> +				&align,
> +				process_id, speedo_id, speedo_value,
> +				fcpu_data->cpu_max_freq_table[speedo_id],
> +				soc->dev);

This, and potentially other parts will conflict with some cleanup I
recently did to this code. You may want to rebase on some linux-next
earlier next week which should have those cleanup patches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/7606091c/attachment.sig>
