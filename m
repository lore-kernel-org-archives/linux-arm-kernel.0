From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 8 Aug 2017 12:37:37 +0200
Subject: [PATCH v2] mmc: sunxi: fix support for new timings mode only SoCs
In-Reply-To: <20170808070903.16898-1-icenowy@aosc.io>
References: <20170808070903.16898-1-icenowy@aosc.io>
Message-ID: <CAPDyKFoddXKr19FZWs0ybxhDvEUnp357r3QEBJBEhDani3HR2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2017 at 09:09, Icenowy Zheng <icenowy@aosc.io> wrote:
> The A83T MMC support code introduces the timings mode switch, however
> such a switch doesn't exist on new SoCs with only new timings mode.
>
> Only execute the switch if the SoC really have the timings mode switch,
> to fix the regression shown on new timings mode only SoCs (A64, H5,
> etc).
>
> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>                       both old and new timings")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> - Slightly adjusted the format of the Fixes: line/
> - Added review tag from Chen-Yu.
>
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 020547e5fa45..7447d41833ee 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -789,7 +789,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 clock <<= 1;
>         }
>
> -       if (host->use_new_timings) {
> +       if (host->use_new_timings && host->cfg->has_timings_switch) {
>                 ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
>                 if (ret) {
>                         dev_err(mmc_dev(mmc),
> --
> 2.13.0
>
