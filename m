From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 5 Jun 2016 20:58:42 +0800
Subject: [PATCH] mmc: sunxi: Add support to the Allwinner A83T
In-Reply-To: <20160604100253.7141B2DE7D@muse.csie.ntu.edu.tw>
References: <20160604100253.7141B2DE7D@muse.csie.ntu.edu.tw>
Message-ID: <CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 4, 2016 at 6:01 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> The A83T has different clock delays.
> The values have been adapted from the Banana Pi M3 driver.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  3 ++-
>  drivers/mmc/host/sunxi-mmc.c                        | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 4bf41d8..45b8520 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -8,7 +8,8 @@ as the speed of SD standard 3.0.
>  Absolute maximum transfer rate is 200MB/s
>
>  Required properties:
> - - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
> + - compatible : "allwinner,sun4i-a10-mmc", "allwinner,sun5i-a13-mmc",
> +       "allwinner,sun8i-a83t-mmc" or "allwinner,sun9i-a80-mmc"
>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7fc8b7a..707e705 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -941,6 +941,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
>  static const struct of_device_id sunxi_mmc_of_match[] = {
>         { .compatible = "allwinner,sun4i-a10-mmc", },
>         { .compatible = "allwinner,sun5i-a13-mmc", },
> +       { .compatible = "allwinner,sun8i-a83t-mmc", },
>         { .compatible = "allwinner,sun9i-a80-mmc", },
>         { /* sentinel */ }
>  };
> @@ -962,10 +963,17 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
>         [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
>         [SDXC_CLK_50M]          = { .output =  90, .sample = 120 },
>         [SDXC_CLK_50M_DDR]      = { .output =  60, .sample = 120 },
> -       /* Value from A83T "new timing mode". Works but might not be right. */

Please don't remove this. It was how I found a working value. Until we figure
out an actual correct value, the warning should stay there.

>         [SDXC_CLK_50M_DDR_8BIT] = { .output =  90, .sample = 180 },
>  };
>
> +static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] = {
> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  50 },
> +       [SDXC_CLK_50M]          = { .output =  60, .sample =  50 },

These 2 don't look right.

> +       [SDXC_CLK_50M_DDR]      = { .output =  180, .sample = 90 },
> +       [SDXC_CLK_50M_DDR_8BIT] = { .output =  180, .sample = 90 },

Nor does this one. As explained in the comment from the clock driver:

    We can only outphase the clocks by multiple of the PLL's period.

    Since the MMC clock in only a divider, and the formula to get the
    outphasing in degrees is deg = 360 * delta / period

Now, for the fishy ones I mentioned, MMC clock = card clock (or card * 2
for DDR 8 bit), and parent clock is PLL6 @ 600 MHz. A step would be 15,
30 or 60 degrees. Thus you cannot get an outphasing of 50 degrees, or 90
degrees for 50M DDR 8bit.

Could you provide a link to the original driver? Or perhaps just the
original delay values?

The values do work better on my Cubietruck plus, giving a throughput
of 36 MB/s read, instead of 17 MB/s with the original values. However
that is still only half of what it should be capable of. I will test
my BPI M3 tomorrow.


Regards
ChenYu

> +};
> +
>  static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
>         [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
>         [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
> @@ -987,6 +995,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>
>         if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
>                 host->clk_delays = sun9i_mmc_clk_delays;
> +       else if (of_device_is_compatible(np, "allwinner,sun8i-a83t-mmc"))
> +               host->clk_delays = sun8i_a83t_mmc_clk_delays;
>         else
>                 host->clk_delays = sunxi_mmc_clk_delays;
>
> --
> 2.8.3
>
