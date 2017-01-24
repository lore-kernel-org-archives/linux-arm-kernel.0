From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 24 Jan 2017 09:14:31 +0100
Subject: [PATCH v3 2/13] mmc: sunxi: Gate the clock when rate is 0
In-Reply-To: <1f006fd86d1d9ad5eab0c0c9e435003055466a54.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <1f006fd86d1d9ad5eab0c0c9e435003055466a54.1484585798.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAPDyKFrbg=SAGsTt3BoDSrfZGvOfu3sMxMfDy1n_w2xnnQ3-ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2017 at 17:56, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The MMC core assumes that the code will gate the clock when the bus
> frequency is set to 0, which we've been ignoring so far.
>
> Handle that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Looks good!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index ab4324e6eb74..019f95e8e7c5 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -765,6 +765,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>         if (ret)
>                 return ret;
>
> +       if (!ios->clock)
> +               return 0;
> +
>         /* 8 bit DDR requires a higher module clock */
>         if (ios->timing == MMC_TIMING_MMC_DDR52 &&
>             ios->bus_width == MMC_BUS_WIDTH_8)
> @@ -882,7 +885,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         mmc_writel(host, REG_GCTRL, rval);
>
>         /* set up clock */
> -       if (ios->clock && ios->power_mode) {
> +       if (ios->power_mode) {
>                 host->ferror = sunxi_mmc_clk_set_rate(host, ios);
>                 /* Android code had a usleep_range(50000, 55000); here */
>         }
> --
> git-series 0.8.11
