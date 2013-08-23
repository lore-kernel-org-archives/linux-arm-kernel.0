From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Aug 2013 18:03:35 +0400
Subject: [PATCH v2 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <1377247417-27386-3-git-send-email-zonque@gmail.com>
References: <1377247417-27386-1-git-send-email-zonque@gmail.com>
 <1377247417-27386-3-git-send-email-zonque@gmail.com>
Message-ID: <52176BB7.3000405@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-08-2013 12:43, Daniel Mack wrote:

> At least the AM33xx SoC has a control module register to configure
> details such as the hardware ethernet interface mode.

> I'm not sure whether all SoCs which feature the cpsw block have such a
> register, so that third memory region is considered optional for now.

> Signed-off-by: Daniel Mack <zonque@gmail.com>
[...]

> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 1a91aac..bd0b664 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
[...]
> @@ -1999,6 +2000,21 @@ static int cpsw_probe(struct platform_device *pdev)
>   		goto clean_runtime_disable_ret;
>   	}
>
> +	/* If the control memory region is unspecified, continue without it.
> +	 * If it is specified, but we're unable to reserve it, bail.
> +	 */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	if (!res) {
> +		dev_err(priv->dev, "error getting control i/o resource\n");

    If the resource is optional, why use dev_err()?

> +		goto no_gmii_sel;
> +	}
> +	priv->gmii_sel_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (!priv->gmii_sel_reg) {

    devm_ioremap_resource() doesn't return NULL, it returns error, so you 
should check with IS_ERR() and propagate the error to the caller with PTR_ERR().

> +		dev_err(priv->dev, "unable to map control i/o region\n");

    devm_ioremap_resource() prints out the error messages itself, so you don't 
have to.

> +		goto clean_runtime_disable_ret;
> +	}
> +
> +no_gmii_sel:
>   	memset(&dma_params, 0, sizeof(dma_params));
>   	memset(&ale_params, 0, sizeof(ale_params));

WBR, Sergei
