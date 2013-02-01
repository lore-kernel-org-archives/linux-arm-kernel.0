From: rklein@nvidia.com (Rhyland Klein)
Date: Fri, 1 Feb 2013 14:40:30 -0500
Subject: [PATCH v5 04/10] clk: tegra: Add new fields and PLL types for
 Tegra114
In-Reply-To: <1359713962-16822-5-git-send-email-pdeschrijver@nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <510C1A2E.5010408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2013 5:18 AM, Peter De Schrijver wrote:
> Tegra114 introduces new PLL types. This requires new clocktypes as well
> as some new fields in the pll structure.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>   drivers/clk/tegra/clk-pll.c |  719 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/tegra/clk.h     |   47 +++
>   2 files changed, 766 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 87d2f34..50114b7 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> [snip]
> +struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
> +                         void __iomem *clk_base, void __iomem *pmc,
> +                         unsigned long flags, unsigned long fixed_rate,
> +                         struct tegra_clk_pll_params *pll_params,
> +                         u32 pll_flags,
> +                         struct tegra_clk_pll_freq_table *freq_table,
> +                         spinlock_t *lock)
> +{
> +       if (!pll_params->pdiv_tohw)
> +               return -EINVAL;
> +
This will cause the following warning:
warning: return makes pointer from integer without a cast

Same with occurrences in tegra_clk_register_pllm and 
tegra_clk_register_pllc.

Should this instead be returning NULL?

-rhyland

-- 
nvpublic
