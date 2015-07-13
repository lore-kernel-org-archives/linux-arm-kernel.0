From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 13 Jul 2015 16:41:51 +0300
Subject: [PATCH V3 06/19] clk: tegra: remove TEGRA_PLL_USE_LOCK for
 PLLD/PLLD2
In-Reply-To: <1436791197-32358-7-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-7-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:44PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted when
> the DIS power domain is during up-powergating process but the clamp to this

I think there is missing 'off' in this sentence?

ie. ... 'the DIS power domain is off?during up-powergating process'

Also 'un-powergating sequence' would be nicer.

> domain is not removed yet. That causes a timeout and aborts the power
> sequence, although the PLLD/PLLD2 has already locked. To remove the false
> alarm, we don't use the lock for PLLD/PLLD2. Just wait 1ms and treat the
> clocks as locked.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra114.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index 8237d16b4075..2e5c20c7c088 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -456,8 +456,7 @@ static struct tegra_clk_pll_params pll_d_params = {
>  	.lock_delay = 1000,
>  	.div_nmp = &pllp_nmp,
>  	.freq_table = pll_d_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
> -		 TEGRA_PLL_USE_LOCK,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
>  };
>  
>  static struct tegra_clk_pll_params pll_d2_params = {
> @@ -474,8 +473,7 @@ static struct tegra_clk_pll_params pll_d2_params = {
>  	.lock_delay = 1000,
>  	.div_nmp = &pllp_nmp,
>  	.freq_table = pll_d_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON |
> -		 TEGRA_PLL_USE_LOCK,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_LFCON,
>  };
>  
>  static struct pdiv_map pllu_p[] = {
> -- 
> 2.1.4
> 
