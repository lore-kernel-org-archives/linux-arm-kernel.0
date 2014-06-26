From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Jun 2014 22:32:23 +0400
Subject: [PATCH] clk: tegra: export clock names for debugging
In-Reply-To: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
References: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53AC6737.5010507@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/26/2014 07:48 PM, Peter De Schrijver wrote:

> When writing a module for testing or debugging purposes, there is no way to
> get hold of clk handles. This patch solves this by exposing all valid clocks
> as clkdev's for the virtual device tegra-clk-debug.

> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>   drivers/clk/tegra/clk.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)

> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index c0a7d77..3315fca 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -277,6 +277,12 @@ void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
>   	for (i = 0; i < num; i++, dev_clks++)
>   		clk_register_clkdev(clks[dev_clks->dt_id], dev_clks->con_id,
>   				dev_clks->dev_id);
> +
> +	for (i = 0; i < clk_num; i++) {
> +		if (!IS_ERR(clks[i]) || !clks[i])

    Are you sure it should be || here, not &&? The following code doesn't seem 
to make much sense this way... Perhaps you meant !IS_ERR_OR_NULL(clks[i])?

> +			clk_register_clkdev(clks[i], __clk_get_name(clks[i]),
> +				"tegra-clk-debug");
> +	}
>   }

WBR, Sergei
