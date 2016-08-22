From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 22 Aug 2016 15:53:00 +0200
Subject: [PATCH RESEND] mmc: sunxi: Check the value returned by
 clk_round_rate
In-Reply-To: <57af4930.2866c20a.efdbe.7721SMTPIN_ADDED_MISSING@mx.google.com>
References: <57af4930.2866c20a.efdbe.7721SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <CAPDyKFp0Wsf68jupHov_DxafXRhP9xyqyU-4Hiinm1MNMpyA8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2016 at 18:01, Jean-Francois Moine <moinejf@free.fr> wrote:
> clk_round_rate() may return an error. Check it.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Please re-spins this as it doesn't apply cleanly due to recent new
sunxi changes.

Kind regards
Uffe

> ---
> This patch was initially sent in a patch series about the MMC new mode,
> but it may be applied independently.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ee4c21..ba647b7 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -656,7 +656,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                                   struct mmc_ios *ios)
>  {
> -       u32 rate, oclk_dly, rval, sclk_dly;
> +       long rate;
> +       u32 oclk_dly, rval, sclk_dly;
>         u32 clock = ios->clock;
>         int ret;
>
> @@ -666,13 +667,18 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 clock <<= 1;
>
>         rate = clk_round_rate(host->clk_mmc, clock);
> -       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
> +       if (rate < 0) {
> +               dev_err(mmc_dev(host->mmc), "error rounding clk to %d: %ld\n",
> +                       clock, rate);
> +               return rate;
> +       }
> +       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
>                 clock, rate);
>
>         /* setting clock rate */
>         ret = clk_set_rate(host->clk_mmc, rate);
>         if (ret) {
> -               dev_err(mmc_dev(host->mmc), "error setting clk to %d: %d\n",
> +               dev_err(mmc_dev(host->mmc), "error setting clk to %ld: %d\n",
>                         rate, ret);
>                 return ret;
>         }
> --
> 2.9.2
>
