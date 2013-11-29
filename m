From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:26:19 +0100
Subject: [PATCH 07/31] clk: tegra: implement a reset driver
In-Reply-To: <1384548866-13141-8-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129132618.GT22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:02PM -0700, Stephen Warren wrote:
[...]
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
[...]
> -	clks = tegra_clk_init(TEGRA124_CLK_CLK_MAX, 6);
> +	clks = tegra_clk_init(clk_base, TEGRA124_CLK_CLK_MAX, 6);

This doesn't really concern this patch, but this is inconsistent with
the drivers for other generations. We should probably make that
consistent in a separate patch.

> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c

> +static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
> +		unsigned long id);
> +static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
> +		unsigned long id);

Can you reorder the code so that these forward-declarations can be
avoided?

>  /* Global data of Tegra CPU CAR ops */
>  static struct tegra_cpu_car_ops dummy_car_ops;
>  struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
> @@ -70,6 +77,17 @@ static struct clk **clks;
>  static int clk_num;
>  static struct clk_onecell_data clk_data;
>  
> +static struct reset_control_ops rst_ops = {
> +	.assert = tegra_clk_rst_assert,
> +	.deassert = tegra_clk_rst_deassert,
> +};
> +
> +static struct reset_controller_dev rst_ctlr = {
> +	.ops = &rst_ops,
> +	.owner = THIS_MODULE,
> +	.of_reset_n_cells = 1,
> +};

It looks like these can be moved further down (below the implementation
of tegra_clk_rst_assert() and tegra_clk_rst_deassert()). I rather like
not having to modify two locations when the signature changes, but it's
not that big a deal, so with or without that fixed up:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/3f8e4466/attachment.sig>
