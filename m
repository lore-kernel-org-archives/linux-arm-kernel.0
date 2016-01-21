From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Jan 2016 11:49:21 +0100
Subject: [PATCH] soc: mediatek: PMIC wrap: Delete unused regmap support
In-Reply-To: <1453372919-15602-1-git-send-email-matthias.bgg@gmail.com>
References: <1453372919-15602-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <56A0B7B1.3080209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/01/16 11:41, Matthias Brugger wrote:
> PMIC wrapper does not use regmap support, although some regmap
> code slipped into the driver. This patch deletes this code parts.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Well no. Actually the mt6397 uses the regmap of its parent.
So forget about this patch...

>   drivers/soc/mediatek/mtk-pmic-wrap.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 105597a..83b22bf 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -18,7 +18,6 @@
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> -#include <linux/regmap.h>
>   #include <linux/reset.h>
>
>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
> @@ -366,7 +365,6 @@ static struct pmic_wrapper_type pwrap_mt8173 = {
>   struct pmic_wrapper {
>   	struct device *dev;
>   	void __iomem *base;
> -	struct regmap *regmap;
>   	int *regs;
>   	enum pwrap_type type;
>   	u32 arb_en_all;
> @@ -475,16 +473,6 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   	return 0;
>   }
>
> -static int pwrap_regmap_read(void *context, u32 adr, u32 *rdata)
> -{
> -	return pwrap_read(context, adr, rdata);
> -}
> -
> -static int pwrap_regmap_write(void *context, u32 adr, u32 wdata)
> -{
> -	return pwrap_write(context, adr, wdata);
> -}
> -
>   static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
>   {
>   	int ret, i;
> @@ -780,15 +768,6 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>
> -static const struct regmap_config pwrap_regmap_config = {
> -	.reg_bits = 16,
> -	.val_bits = 16,
> -	.reg_stride = 2,
> -	.reg_read = pwrap_regmap_read,
> -	.reg_write = pwrap_regmap_write,
> -	.max_register = 0xffff,
> -};
> -
>   static struct of_device_id of_pwrap_match_tbl[] = {
>   	{
>   		.compatible = "mediatek,mt8135-pwrap",
> @@ -904,10 +883,6 @@ static int pwrap_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_out2;
>
> -	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);
> -	if (IS_ERR(wrp->regmap))
> -		return PTR_ERR(wrp->regmap);
> -
>   	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
>   	if (ret) {
>   		dev_dbg(wrp->dev, "failed to create child devices at %s\n",
>
