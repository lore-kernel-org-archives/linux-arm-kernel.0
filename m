From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Mar 2015 12:03:31 +0100
Subject: [PATCH 1/5] soc: mediatek: Add SMI driver
In-Reply-To: <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150309110331.GG31289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 06:48:16PM +0800, yong.wu at mediatek.com wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
>     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> responsible to enable/disable iommu and control the clocks of each
> local arbiter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig      |   7 ++
>  drivers/soc/mediatek/Makefile     |   1 +
>  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mtk-smi.h           |  40 +++++++++++

I just posted the power domain driver for prividing the domains this
driver uses. You should base your code on that.

> +#include <linux/mm.h>
> +
> +#define SMI_LARB_MMU_EN                 (0xf00)
> +#define F_SMI_MMU_EN(port)              (1 << (port))
> +
> +struct mtk_smi_larb {
> +	void __iomem *larb_base;
> +	struct clk *larb_clk[3];/* each larb has 3 clk at most */
> +};
> +
> +static const char * const mtk_smi_clk_name[] = {
> +	"larb_sub0", "larb_sub1", "larb_sub2"
> +};
> +
> +static const struct of_device_id mtk_smi_of_ids[] = {
> +	{ .compatible = "mediatek,mt8173-smi-larb",
> +	},

Add a newline after the opening brace.

> +int mtk_smi_config_port(struct platform_device *plarbdev,
> +			unsigned int larbportid)
> +{
> +	struct mtk_smi_larb *larbpriv = dev_get_drvdata(&plarbdev->dev);
> +	int ret;
> +	u32 reg;
> +
> +	ret = mtk_smi_larb_get(plarbdev);
> +	if (ret)
> +		return ret;
> +
> +	reg = readl(larbpriv->larb_base + SMI_LARB_MMU_EN);
> +	reg &= ~F_SMI_MMU_EN(larbportid);
> +	reg |= F_SMI_MMU_EN(larbportid);

This sets the very same bits that are cleared one line above. This is
surely not what you want.

> +	writel(reg, larbpriv->larb_base + SMI_LARB_MMU_EN);
> +
> +	mtk_smi_larb_put(plarbdev);
> +
> +	return 0;
> +}
> +
> +static int mtk_smi_probe(struct platform_device *pdev)
> +{
> +	struct mtk_smi_larb *larbpriv;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	unsigned int i;
> +
> +	larbpriv = devm_kzalloc(dev, sizeof(struct mtk_smi_larb), GFP_KERNEL);

sizeof(*larbpriv)

> +	if (!larbpriv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	larbpriv->larb_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(larbpriv->larb_base)) {
> +		dev_err(dev, "larbbase %p err\n", larbpriv->larb_base);

You can print an error number with %ld and PTR_ERR(larbpriv->larb_base).
Printing the pointer is not that helpful.

> +/*
> + * Enable iommu for each port, it is only for iommu.
> + *
> + * Returns 0 if successfully, others if failed.
> + */
> +int mtk_smi_config_port(struct platform_device *pdev,
> +			unsigned int larbportid);
> +
> +/*
> + * The multimedia module should call the two function below
> + * which help open/close the clock of the larb.
> + * so the client dtsi should add the larb like "larb = <&larb0>"
> + * to get platform_device.
> + *
> + * mtk_smi_larb_get should be called before the multimedia h/w work.
> + * mtk_smi_larb_put should be called after h/w done.
> + *
> + * Returns 0 if successfully, others if failed.
> + */
> +int mtk_smi_larb_get(struct platform_device *plarbdev);
> +void mtk_smi_larb_put(struct platform_device *plarbdev);

The function documentation usually comes with the definition of a
function, not its declaration.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
