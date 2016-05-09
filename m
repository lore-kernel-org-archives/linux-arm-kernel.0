From: peng.fan@nxp.com (Peng Fan)
Date: Mon, 9 May 2016 12:20:26 +0000
Subject: [PATCH V2 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
References: <1461173177-11930-1-git-send-email-van.freenix@gmail.com>
 <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
Message-ID: <HE1PR0401MB18013281F282E19BCC378B3888700@HE1PR0401MB1801.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Kindly ping..
Any comments on this patch set?

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Peng Fan
> Sent: Thursday, April 21, 2016 1:26 AM
> To: shawnguo at kernel.org; srinivas.kandagatla at linaro.org;
> maxime.ripard at free-electrons.com
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; van.freenix at gmail.com
> Subject: [PATCH V2 3/3] nvmem: imx-ocotp: handling clock
> 
> Before access ocotp nvmem area, the clock should be enabled.
> Or, `hexdump nvmem` will hang the system. So, use such flow:
> "
>   1. clock_enable_prepare
>   2. read nvmem ocotp area
>   3. clock_disable_unprepare
> "
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
> 
> V2:
>  Follow Fabio's comments, check return value of clk_prepare_enable
> 
>  drivers/nvmem/imx-ocotp.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c index
> d7796eb..3f1dd9f 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -15,6 +15,7 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
> 
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -27,6 +28,7 @@
> 
>  struct ocotp_priv {
>  	struct device *dev;
> +	struct clk *clk;
>  	void __iomem *base;
>  	unsigned int nregs;
>  };
> @@ -37,7 +39,7 @@ static int imx_ocotp_read(void *context, const void *reg,
> size_t reg_size,
>  	struct ocotp_priv *priv = context;
>  	unsigned int offset = *(u32 *)reg;
>  	unsigned int count;
> -	int i;
> +	int i, ret;
>  	u32 index;
> 
>  	index = offset >> 2;
> @@ -46,11 +48,19 @@ static int imx_ocotp_read(void *context, const void
> *reg, size_t reg_size,
>  	if (count > (priv->nregs - index))
>  		count = priv->nregs - index;
> 
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to prepare/enable ocotp clk\n");
> +		return ret;
> +	}
> +
>  	for (i = index; i < (index + count); i++) {
>  		*(u32 *)val = readl(priv->base + 0x400 + i * 0x10);
>  		val += 4;
>  	}
> 
> +	clk_disable_unprepare(priv->clk);
> +
>  	return 0;
>  }
> 
> @@ -112,6 +122,10 @@ static int imx_ocotp_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> 
> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
>  	of_id = of_match_device(imx_ocotp_dt_ids, dev);
>  	priv->nregs = (unsigned int)of_id->data;
>  	imx_ocotp_regmap_config.max_register = 4 * priv->nregs - 4;
> --
> 2.6.6

Thanks,
Peng.
