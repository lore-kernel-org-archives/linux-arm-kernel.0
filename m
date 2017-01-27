From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Jan 2017 10:55:19 -0800
Subject: [PATCH] mmc: meson-gx: add support for HS400 mode
In-Reply-To: <f7f325ec-6099-7f51-5bb4-24ac24073ee7@gmail.com> (Heiner
 Kallweit's message of "Thu, 26 Jan 2017 23:12:38 +0100")
References: <f7f325ec-6099-7f51-5bb4-24ac24073ee7@gmail.com>
Message-ID: <m2fuk4uyco.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Add support for HS400 mode.
>
> Successfully tested on a Odroid C2 (S905 GXBB).
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Excellent!  Thanks for the patch.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Some folks on IRC had reported that eMMC wasn't working on some boards
(like Amlogic P200) and with this patch, it's working again for me on P200.

@Andreas: does this patch fix your R-box Pro?

Kevin

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 030425be..be45d57d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -83,6 +83,7 @@
>  #define   CFG_RC_CC_MASK 0xf
>  #define   CFG_STOP_CLOCK BIT(22)
>  #define   CFG_CLK_ALWAYS_ON BIT(18)
> +#define   CFG_CHK_DS BIT(20)
>  #define   CFG_AUTO_CLK BIT(23)
>  
>  #define SD_EMMC_STATUS 0x48
> @@ -412,6 +413,16 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
>  	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
>  
> +	val &= ~CFG_DDR;
> +	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> +	    ios->timing == MMC_TIMING_MMC_DDR52 ||
> +	    ios->timing == MMC_TIMING_MMC_HS400)
> +		val |= CFG_DDR;
> +
> +	val &= ~CFG_CHK_DS;
> +	if (ios->timing == MMC_TIMING_MMC_HS400)
> +		val |= CFG_CHK_DS;
> +
>  	writel(val, host->regs + SD_EMMC_CFG);
>  
>  	if (val != orig)
