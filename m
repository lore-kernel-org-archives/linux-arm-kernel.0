From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 13 Apr 2017 22:37:27 +0800
Subject: [RFC PATCH 2/3] clk: add managed version of clk_bulk_get
In-Reply-To: <1491969809-20154-3-git-send-email-aisheng.dong@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170413143727.GE24254@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 12:03:28PM +0800, Dong Aisheng wrote:
> This patch introduces the managed version of clk_bulk_get.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Octavian Purdila <octavian.purdila@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/clk-devres.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      | 22 +++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 3a218c3..c7fb31d 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -34,6 +34,42 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
>  }
>  EXPORT_SYMBOL(devm_clk_get);
>  
> +struct clk_bulk_devres {
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +};
> +
> +static void devm_clk_bulk_release(struct device *dev, void *res)
> +{
> +	struct clk_bulk_devres *devres = res;
> +
> +	clk_bulk_put(devres->num_clks, devres->clks);
> +}
> +
> +int devm_clk_bulk_get(struct device *dev, int num_clks,
> +		      struct clk_bulk_data *clks)
> +{
> +	struct clk_bulk_devres *devres;
> +	int ret;
> +
> +	devres = devres_alloc(devm_clk_bulk_release,
> +			      sizeof(*devres), GFP_KERNEL);
> +	if (!devres)
> +		return -ENOMEM;
> +
> +	ret = clk_bulk_get(dev, num_clks, clks);


Another catch by 0day robot.

   drivers/built-in.o: In function `devm_clk_bulk_get':
>> (.text+0x1930e): undefined reference to `clk_bulk_get'
   drivers/built-in.o: In function `devm_clk_bulk_release':
>> clk-devres.c:(.text+0x19370): undefined reference to `clk_bulk_put'

clk_bulk_get is defined in clkdev.c which depends on CONFIG_CLKDEV_LOOKUP.
However, some platforms like m68k may not select CLKDEV_LOOKUP but
select HAVE_CLK. Thus compiling devm_clk_bulk_get may cause a undefined
reference to 'clk_bulk_get'.

Since clk_bulk_get is built upon the platform specific clk_get api,
clk_bulk_get can also be used by that platform accordingly.

Then we probably could move clk_bulk_get into clk-devres.c as well which
is controlled by common CONFIG_HAVE_CLK to benifit all platforms.

Regards
Dong Aisheng
