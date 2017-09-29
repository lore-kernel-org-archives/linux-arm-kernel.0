From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Sep 2017 15:48:21 -0700
Subject: [PATCH V4 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <1506415441-4435-1-git-send-email-aisheng.dong@nxp.com>
References: <1506415441-4435-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170929224821.GM457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26, Dong Aisheng wrote:
> 'clock-names' property is optinal in DT, so of_clk_bulk_get() is introduced

s/optinal/optional/

> here to handle this for DT users without 'clock-names' specified.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> Changes since v3:
>  * fix build warning on the SH platform
> 
> Changes since v2:
>  * of_clk_bulk_get should return -ENOENT;
> 
> Changes since v1:
>  * using %pOF instead of full_name
> ---
>  drivers/clk/clk-bulk.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/clk.h    |  8 ++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> index c834f5a..896aa3b 100644
> --- a/drivers/clk/clk-bulk.c
> +++ b/drivers/clk/clk-bulk.c
> @@ -19,6 +19,37 @@
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> +int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> +				 struct clk_bulk_data *clks)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < num_clks; i++)
> +		clks[i].clk = NULL;
> +
> +	for (i = 0; i < num_clks; i++) {
> +		clks[i].clk = of_clk_get(np, i);
> +		if (IS_ERR(clks[i].clk)) {
> +			ret = PTR_ERR(clks[i].clk);
> +			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
> +			       np, i, ret);
> +			clks[i].clk = NULL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	clk_bulk_put(i, clks);
> +
> +	return ret;
> +}

Export the symbol?

> +#endif
>  
>  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
>  {
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 12c96d9..073cb3b 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -680,10 +680,18 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
>  }
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> +int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> +				 struct clk_bulk_data *clks);
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
> +static inline int of_clk_bulk_get(struct device_node *np, int num_clks,

Do we need __must_check here too? We should do the same for the
other bulk get APIs. Seems we missed that part last time.

I'll fix all these things up when applying.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
