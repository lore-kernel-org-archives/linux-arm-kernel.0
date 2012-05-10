From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 10 May 2012 17:45:25 +0800
Subject: [alsa-devel] [PATCH 4/6] ASoC: mxs: add device tree support
 for mxs-saif
In-Reply-To: <1336639333-11561-5-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120510094525.GJ6622@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 04:42:11PM +0800, Shawn Guo wrote:
> Add device tree probe for mxs-saif driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/sound/mxs-saif.txt         |   36 ++++++++++
>  sound/soc/mxs/mxs-saif.c                           |   74 +++++++++++++++-----
>  2 files changed, 93 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mxs-saif.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/mxs-saif.txt b/Documentation/devicetree/bindings/sound/mxs-saif.txt
> new file mode 100644
> index 0000000..c37ba61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mxs-saif.txt
> @@ -0,0 +1,36 @@
> +* Freescale MXS Serial Audio Interface (SAIF)
> +
> +Required properties:
> +- compatible: Should be "fsl,<chip>-saif"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain ERROR and DMA interrupts
> +- fsl,saif-dma-channel: APBX DMA channel for the SAIF
> +
> +Optional properties:
> +- fsl,saif-master: phandle to the master SAIF.  It's only required for
> +  the slave SAIF.
> +
> +Note: Each SAIF controller should have an alias correctly numbered
> +in "aliases" node.
> +
> +Example:
> +
> +aliases {
> +	saif0 = &saif0;
> +	saif1 = &saif1;
> +};
> +
> +saif0: saif at 80042000 {
> +	compatible = "fsl,imx28-saif";
> +	reg = <0x80042000 2000>;
> +	interrupts = <59 80>;
> +	fsl,saif-dma-channel = <4>;
> +};
> +
> +saif1: saif at 80046000 {
> +	compatible = "fsl,imx28-saif";
> +	reg = <0x80046000 2000>;
> +	interrupts = <58 81>;
> +	fsl,saif-dma-channel = <5>;
> +	fsl,saif-master = <&saif0>;
> +};
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index fa80ee6..ca1e77c 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -18,6 +18,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> @@ -623,35 +625,58 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
>  
>  static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct resource *iores, *dmares;
>  	struct mxs_saif *saif;
>  	struct mxs_saif_platform_data *pdata;
>  	struct pinctrl *pinctrl;
>  	int ret = 0;
>  
> -	if (pdev->id >= ARRAY_SIZE(mxs_saif))
> +
> +	if (!np && pdev->id >= ARRAY_SIZE(mxs_saif))
>  		return -EINVAL;
>  
>  	saif = devm_kzalloc(&pdev->dev, sizeof(*saif), GFP_KERNEL);
>  	if (!saif)
>  		return -ENOMEM;
>  
> -	mxs_saif[pdev->id] = saif;
> -	saif->id = pdev->id;
> -
> -	pdata = pdev->dev.platform_data;
> -	if (pdata && !pdata->master_mode) {
> -		saif->master_id = pdata->master_id;
> -		if (saif->master_id < 0 ||
> -			saif->master_id >= ARRAY_SIZE(mxs_saif) ||
> -			saif->master_id == saif->id) {
> -			dev_err(&pdev->dev, "get wrong master id\n");
> -			return -EINVAL;
> +	if (np) {
> +		struct device_node *master;
> +		saif->id = of_alias_get_id(np, "saif");
> +		if (saif->id < 0)
> +			return saif->id;
> +		/*
> +		 * If there is no "fsl,saif-master" phandle, it's a saif
> +		 * master.  Otherwise, it's a slave and its phandle points
> +		 * to the master.
> +		 */
> +		master = of_parse_phandle(np, "fsl,saif-master", 0);
> +		if (!master) {
> +			saif->master_id = saif->id;
> +		} else {
> +			saif->master_id = of_alias_get_id(master, "saif");
> +			if (saif->master_id < 0)
> +				return saif->master_id;
>  		}
>  	} else {
> -		saif->master_id = saif->id;
> +		saif->id = pdev->id;
> +
> +		pdata = pdev->dev.platform_data;
> +		if (pdata && !pdata->master_mode) {
> +			saif->master_id = pdata->master_id;
> +			if (saif->master_id < 0 ||
> +				saif->master_id >= ARRAY_SIZE(mxs_saif) ||
> +				saif->master_id == saif->id) {
> +				dev_err(&pdev->dev, "get wrong master id\n");
> +				return -EINVAL;
Maybe we could put the master_id validation code out to below since for dt case
it also needs it.

Otherwise the code looks ok to me.

Regards
Dong Aisheng
