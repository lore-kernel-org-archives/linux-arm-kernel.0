From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 24 Aug 2016 11:32:26 +0200
Subject: [PATCH RESEND] mmc: sunxi: Check the value returned by
 clk_round_rate
In-Reply-To: <57bc12b2.9be81c0a.1246a.9f47SMTPIN_ADDED_MISSING@mx.google.com>
References: <57bc12b2.9be81c0a.1246a.9f47SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <CAPDyKFpQ2b=0aAWUcGjFDnea3K2W+zxH5Xk0fyhOzM8MADBubg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2016 at 10:51, Jean-Francois Moine <moinejf@free.fr> wrote:
> clk_round_rate() may return an error. Check it.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, applied for next!

For some reason this patch didn't go into the mmc patchtracker,
probably because you have several lists on cc. Future wise I guess
it's better if you have linux-mmc on the *to* list.

Kind regards
Uffe

> ---
> Rebase on linux-next
> ---
>  drivers/mmc/host/sunxi-mmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ec91ce..142ab3f 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -692,7 +692,8 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                                   struct mmc_ios *ios)
>  {
> -       u32 rate, rval, clock = ios->clock;
> +       long rate;
> +       u32 rval, clock = ios->clock;
>         int ret;
>
>         /* 8 bit DDR requires a higher module clock */
> @@ -701,13 +702,18 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
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
> 2.9.3
>
