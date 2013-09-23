From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:34:48 -0600
Subject: [PATCH 10/12] clk: tegra: move fixed clocks to common file
In-Reply-To: <1379515331-19427-11-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-11-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <524089C8.4010108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:41 AM, Peter De Schrijver wrote:
> Introduce a new file for fixed clocks common between several Tegra
> SoCs and move Tegra114 to this new infrastructure.

> diff --git a/drivers/clk/tegra/clk-tegra-fixed.c b/drivers/clk/tegra/clk-tegra-fixed.c

> +void __init tegra_fixed_clk_init(struct tegra_clk *tegra_clks)

> +	/* clk_m_div2 */
> +	dt_clk = tegra_lookup_dt_id(tegra_clk_clk_m_div2, tegra_clks);
> +	if (dt_clk) {
> +		clk = clk_register_fixed_factor(NULL, "clk_m_div2", "clk_m",
> +					CLK_SET_RATE_PARENT, 1, 2);
> +		clk_register_clkdev(clk, "clk_m_div2", NULL);
> +		*dt_clk = clk;
> +	}

I guess "fixed" means "fixed at run-time", not "identical rate in all
systems"? Since this is the crystal rate, it can vary between boards,
but I supposed if "fixed" means "fixed at run-time", considering this as
a fixed clock is fine.

But, isn't clk_m also a fixed clock then? I would expect one or two more
clocks in this file. What about clk_s, or is that known as clk_32k here?
