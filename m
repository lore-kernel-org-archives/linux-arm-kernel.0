From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Mon, 4 Feb 2013 12:09:45 +0530
Subject: [PATCH v5 06/10] clk: tegra: Workaround for Tegra114 MSENC problem
In-Reply-To: <1359713962-16822-7-git-send-email-pdeschrijver@nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-7-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <510F57B1.1050906@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013 03:48 PM, Peter De Schrijver wrote:
> Workaround a hardware bug in MSENC during clock enable.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>   drivers/clk/tegra/clk-periph-gate.c |    9 +++++++++
>   drivers/clk/tegra/clk.h             |    1 +
>   2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
> index 6dd5332..c9083fb 100644
> --- a/drivers/clk/tegra/clk-periph-gate.c
> +++ b/drivers/clk/tegra/clk-periph-gate.c
> @@ -43,6 +43,8 @@ static DEFINE_SPINLOCK(periph_ref_lock);
>   
>   #define periph_clk_to_bit(periph) (1 << (gate->clk_num % 32))
>   
> +#define LVL2_CLK_GATE_OVRE 0x554
> +
>   /* Peripheral gate clock ops */
>   static int clk_periph_is_enabled(struct clk_hw *hw)
>   {
> @@ -83,6 +85,13 @@ static int clk_periph_enable(struct clk_hw *hw)
>   		}
>   	}
>   
> +	if (gate->flags & TEGRA_PERIPH_WAR_1005168) {
> +		writel_relaxed(0, gate->clk_base + LVL2_CLK_GATE_OVRE);
> +		writel_relaxed(BIT(22), gate->clk_base + LVL2_CLK_GATE_OVRE);
> +		udelay(1);
> +		writel_relaxed(0, gate->clk_base + LVL2_CLK_GATE_OVRE);
> +	}
> +
>   	spin_unlock_irqrestore(&periph_ref_lock, flags);
>   
>   	return 0;
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 79f5e2a..8756d9f 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -371,6 +371,7 @@ struct tegra_clk_periph_gate {
>   #define TEGRA_PERIPH_NO_RESET BIT(0)
>   #define TEGRA_PERIPH_MANUAL_RESET BIT(1)
>   #define TEGRA_PERIPH_ON_APB BIT(2)
> +#define TEGRA_PERIPH_WAR_1005168 BIT(3)
>   

Comment for this flag, otherwise

Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>

>   void tegra_periph_reset(struct tegra_clk_periph_gate *gate, bool assert);
>   extern const struct clk_ops tegra_clk_periph_gate_ops;
>
