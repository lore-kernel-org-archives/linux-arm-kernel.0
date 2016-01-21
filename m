From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Jan 2016 12:13:24 +0100
Subject: [PATCH v2] soc: mediatek: PMIC wrap: clear the STAUPD_TRIG bit of
 WDT_SRC_EN
In-Reply-To: <1453374240-13495-1-git-send-email-henryc.chen@mediatek.com>
References: <1453374240-13495-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <56A0BD54.5050403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/01/16 12:04, Henry Chen wrote:
> Since STAUPD interrupts aren't handled on mt8173, disable watchdog timeout
> monitor of STAUPD to avoid WDT_INT triggered by STAUPD.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---

Applied with the reviewed-by from Daniel.

Thanks.

> Change since v1:
> Change the check condition to pwrap_is_mt8173.
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index af919b1..50bc0db 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -60,6 +60,15 @@
>   #define PWRAP_MAN_CMD_OP_OUTD		(0x9 << 8)
>   #define PWRAP_MAN_CMD_OP_OUTQ		(0xa << 8)
>
> +/* macro for Watch Dog Timer Source */
> +#define PWRAP_WDT_SRC_EN_STAUPD_TRIG		(1 << 25)
> +#define PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE	(1 << 20)
> +#define PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE	(1 << 6)
> +#define PWRAP_WDT_SRC_MASK_ALL			0xffffffff
> +#define PWRAP_WDT_SRC_MASK_NO_STAUPD	~(PWRAP_WDT_SRC_EN_STAUPD_TRIG | \
> +					  PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE | \
> +					  PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE)
> +
>   /* macro for slave device wrapper registers */
>   #define PWRAP_DEW_BASE			0xbc00
>   #define PWRAP_DEW_EVENT_OUT_EN		(PWRAP_DEW_BASE + 0x0)
> @@ -830,7 +839,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>
>   static int pwrap_probe(struct platform_device *pdev)
>   {
> -	int ret, irq;
> +	int ret, irq, wdt_src;
>   	struct pmic_wrapper *wrp;
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_id =
> @@ -920,7 +929,13 @@ static int pwrap_probe(struct platform_device *pdev)
>
>   	/* Initialize watchdog, may not be done by the bootloader */
>   	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> -	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
> +	/*
> +	 * Since STAUPD was not used on mt8173 platform,
> +	 * so STAUPD of WDT_SRC which should be turned off
> +	 */
> +	wdt_src = pwrap_is_mt8173(wrp) ?
> +			PWRAP_WDT_SRC_MASK_NO_STAUPD : PWRAP_WDT_SRC_MASK_ALL;
> +	pwrap_writel(wrp, wdt_src, PWRAP_WDT_SRC_EN);
>   	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>   	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
>
>
